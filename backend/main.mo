//  ______   _______     ____________    _____    _____       ____________           _____
// |\     \  \      \   /            \  |\    \   \    \     /            \     _____\    \_
//  \\     \  |     /| |\___/\  \\___/|  \\    \   |    |   |\___/\  \\___/|   /     /|     |
//   \|     |/     //   \|____\  \___|/   \\    \  |    |    \|____\  \___|/  /     / /____/|
//    |     |_____//          |  |         \|    \ |    |          |  |      |     | |____|/
//    |     |\     \     __  /   / __       |     \|    |     __  /   / __   |     |  _____
//   /     /|\|     |   /  \/   /_/  |     /     /\      \   /  \/   /_/  |  |\     \|\    \
//  /_____/ |/_____/|  |____________/|    /_____/ /______/| |____________/|  | \_____\|    |
// |     | / |    | |  |           | /   |      | |     | | |           | /  | |     /____/|
// |_____|/  |____|/   |___________|/    |______|/|_____|/  |___________|/    \|_____|    ||
//                                                                                   |____|/
//
// By ClankPan and Wyatt 2022 June ~


// Motoko base
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Hex "mo:ext/util/Hex";
import Iter "mo:base/Iter";
import Ledger "ledgerManage";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Nat64 "mo:base/Nat64";

// Local
import Types "types";


shared ({caller=installer}) actor class Auction() =  this {

  /*types*/
  type Result<T, E> = Result.Result<T, E>;

  type Price = Types.Price; //e8s
  type Category = Types.Category; // game, nft, ...etc
  type CanisterId = Types.CanisterId; // canister hosting content site
  type UserId = Types.UserId; // content site owner
  type Bid = Types.Bid; //(CanisterId,Price)
  type ContentProps = Types.ContentProps;
  type Auction = Types.Auction;

  /*variables*/

  // const
  let sec = 1_000_000_000;
  let minutes =  60 * sec;
  let hour = 60 * minutes;
  let day = 24 * hour;
  let week =  7 * day;
  stable var defaultAuctionTime = 1 * minutes;

  let bidFeePercent = 1; // [%]

  // let IC0 = actor("aaaaa-aa") :
  //   actor {
  //     canister_status : shared { canister_id : Principal } ->
  //       async {
  //         module_hash : ?[Nat8];
  //         status : { #stopped; #stopping; #running };
  //         cycles : Nat;
  //       };
  // };

  stable var _upgradeProps = {
    contents : [(CanisterId, ContentProps)] = [];
    categories : [(Category, Auction)] = [];
  };
  let _contents = HashMap.fromIter<CanisterId, ContentProps>(
    _upgradeProps.contents.vals(), 0, Principal.equal, Principal.hash
  );
  let _categories = HashMap.fromIter<Category, Auction>(
    _upgradeProps.categories.vals(), 0, Text.equal, Text.hash
  );

  // For verifying content site owner using web2 API.
  stable var _upgradeOwnerVerifyRequests : [(CanisterId, List.List<UserId>)] = [];
  let _ownerVerifyRequests = HashMap.fromIter<CanisterId, List.List<UserId>>(
    _upgradeOwnerVerifyRequests.vals(), 0, Principal.equal, Principal.hash
  );

  /* System */
  system func preupgrade() {
    _upgradeProps := {
      contents = Iter.toArray(_contents.entries());
      categories = Iter.toArray(_categories.entries());
    };
    _upgradeOwnerVerifyRequests := Iter.toArray(_ownerVerifyRequests.entries());
    Debug.print("end preupgrade()")
  };

  system func postupgrade() {
    _upgradeProps := {
      contents = [];
      categories = [];
    };
    _upgradeOwnerVerifyRequests := [];
  };

  /* Owner functions */

  /*
    Verify site owner.
  */
  public shared ({caller}) func acceptVerifyRequest({canisterId : CanisterId; owner : UserId}) : async Result<Text, Text> {
    assert(caller == installer); // Installer only.
    assert(isNotAnonymous(caller));

    switch (_contents.get(canisterId)) {
      case (?#Unknown(v))  {
        _contents.put(canisterId, #Verified({
          var clickRecord : Nat = v.clickRecord;
          owner : UserId = owner;
          var balance = #unlock;
        }));
      };
      case (?#Verified(v)) {
        return #err "Already verified.";
      };
      case (_) { // If there is no the canister, add new one as verified.
        _contents.put(canisterId, #Verified({
          var clickRecord : Nat = 0;
          owner : UserId = owner;
          var balance = #unlock;
        }));
      }
    };

    _ownerVerifyRequests.delete(canisterId);
    return #ok "Verified Owner.";
  };

  public query func getVerifyRequests() : async [(CanisterId, [UserId])] {
    Array.map<(CanisterId, List.List<UserId>), (CanisterId, [UserId])>(Iter.toArray(_ownerVerifyRequests.entries()), func((canisterId, list)) {
      (canisterId, List.toArray<UserId>(list))
    })
  };

  /*
    Add category.
  */
  public shared({caller}) func addCategory(category : Category) : async Result<Text, Text> {
    assert(caller == installer); // Installer only.
    assert(isNotAnonymous(caller));

    switch (_categories.get(category)) {
      case (null) {
        _categories.put(category, {
          status = #close; // auction status
          lastWinner : CanisterId = Principal.fromActor(this);
          auctionHistory = List.nil<(Time.Time, List.List<Bid>)>();
        });
        return #ok "Category added.";
      };
      case (?_) return #err "This category already exists.";
    }
  };

  /*
    Start category ad auction.
    This is a first price auction.
  */
  public shared({caller}) func startAuction(category : Category) : async Result<Text, Text> {
    assert(caller == installer); // Installer only.
    assert(isNotAnonymous(caller));

    switch (_categories.get(category)) {
      case null return #err "The category does not exist.";
      case (?auction) switch (auction.status) {
        case (#open _) return #err "The category is already opened for bidding.";
        case (#close) {
            _categories.put(category, {
              status = #open({
                var bids = List.nil<Bid>();
                start = Time.now();
                end = Time.now() + defaultAuctionTime;
              });
              lastWinner : CanisterId = auction.lastWinner; // The category's first winner is KINIC's canister
              auctionHistory : List.List<(Time.Time, List.List<Bid>)> = auction.auctionHistory;
            });
          return #ok "started auction";
        }
      }
    }
  };

  public shared ({caller}) func getCategoryAccountIdentifier(category : Category) : async Text {
    assert(caller == installer); // Installer only.
    assert(isNotAnonymous(caller));

    Ledger.getCategoryAccountIdentifier({kinic=Principal.fromActor(this); category=category});
  };

  public shared({caller}) func AutoSelectWinner(category : Category) : async Result<Text, {#main:Text;#ledger:Ledger.TransferError}> {
    assert(caller == installer); // Installer only
    assert(isNotAnonymous(caller));

    switch (_categories.get(category)) {
      case null return #err(#main( "The category does not exist."));
      case (?auction) switch (auction.status) {
        case (#close) return #err(#main("The category is already closed."));
        case (#open(v)) {
          if (v.end >= Time.now()) return #err(#main( "The category is still in auction mode."));

          switch (List.get<Bid>(v.bids, 0)) {
            case (null) {
              _categories.put(category, {
                status = #close;
                lastWinner = auction.lastWinner; // continue last winner
                auctionHistory = List.push<(Time.Time, List.List<Bid>)>((Time.now(), v.bids), auction.auctionHistory);
              });
              return #err(#main("There are no bid"));
            };
            case (?(ad, p)) { // (canister_id, bid_price)

              // send winner's bid price to category
              let ledgerResult = await Ledger.sendToCategory({kinic=Principal.fromActor(this); canisterId=ad; amount={e8s=p}; category=category});

              switch (ledgerResult) {
                case (#Err(e)) return #err(#ledger(e));
                case (#Ok(_)) {}
              };
              // close auction
              _categories.put(category, {
                status = #close;
                lastWinner = ad;
                auctionHistory = List.push<(Time.Time, List.List<Bid>)>((Time.now(), v.bids), auction.auctionHistory);
              });

              /* bidderのbalanceを全部unlockに変更する */
              List.iterate<Bid>(v.bids, func (bidedAd,_) {
                switch (_contents.get(bidedAd)) {
                  case (null) {};
                  case (?props) switch (props) {
                    case (#Unknown(_)) {};
                    case (#Verified(v)) v.balance := #unlock;
                  }
                }
              });

              return #ok "ok";

            }
          }
        }
      }
    }
  };


  /* Public user functions */

  /*
    Record click count.
  */
  public shared ({caller}) func recordClick(canisterId : CanisterId) : async Result<Text, Text> {

    switch (_contents.get(canisterId)) {
      case (?#Unknown(v))  {
        v.clickRecord +=1;
        return #ok "added record to Unknown Canister";
      };
      case (?#Verified(v)) {
        v.clickRecord +=1;
        return #ok "added record to Verified Canister";
      };
      case (_) { // if there is no the canister, add new one as unknown.
        _contents.put(canisterId, #Unknown({
          var clickRecord : Nat = 1; // init 1 count
        }));
        return #ok "added record to new Canister";
      }
    }
  };

  public shared ({caller}) func requestVerifyContentOwner(canisterId : CanisterId) : async Result<Text, Text> {
    assert(isNotAnonymous(caller));

    switch (_contents.get(canisterId)) {
      case (?#Unknown(v))  {};
      case (?#Verified(v)) {
        return #err("Already verified by " # Principal.toText(v.owner));
      };
      case (_) {};
    };

    // add _ownerVerifyRequests
    switch (_ownerVerifyRequests.get(canisterId)) {
      case (null) {
        _ownerVerifyRequests.put(canisterId, List.push<UserId>(caller, List.nil<UserId>()))
      };
      case (?v) {
        _ownerVerifyRequests.put(canisterId, List.push<UserId>(caller, v))
      }
    };
    return #ok "ok";

  };

  public func getContentAccountIdentifier(canisterId : CanisterId) : async Text {
    Ledger.getContentAccountIdentifier({kinic=Principal.fromActor(this); canisterId=canisterId});
  };

  public shared({caller}) func offerBid({category : Category; canisterId : CanisterId}) : async Result<Text, Text> {
    assert(isNotAnonymous(caller));

    // get ledger balance
    let ledgerBalance = Nat64.toNat((await Ledger.contentBalance({kinic=Principal.fromActor(this); canisterId=canisterId})).e8s);
    if (10_000 >= ledgerBalance) return #err  "Your bid price is under ledger transfer fee & the Kinic bid fee";

    // auth owner
    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "The canister is not verified.";
        case (#Verified(v)) {
          if (v.owner != caller) return #err "you are not owner"; // auth content site owner
          switch (v.balance) {
            case (#unlock) {};
            // If this bidder has already bided, we must check that the bid is higher.
            case (#locked({category=c;bidPrice=_})) switch (_categories.get(c)) {
              case null assert(false);
              case (?auction) switch (auction.status) {
                case (#close) assert(false);
                //check highest bid
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) assert(false);
                  case (?(ad, p)) { // (canisterId, Price)
                    if (ad == canisterId) return #err("You are the highest bidder in category: " # c);
                  }
                }
              }
            };
          }
        }
      };
      case (_) return #err "This canister is not registered.";
    };

    let bidPrice = Nat64.fromNat((ledgerBalance * 100 - ledgerBalance * bidFeePercent)/100);
    let fee = Nat64.fromNat(ledgerBalance) - bidPrice;
    if (10_000 >= bidPrice) return #err  "your bid prince is under ledger transfer fee after paying the Kinic bid fee.";
    switch (await Ledger.sendFee({kinic=Principal.fromActor(this); canisterId=canisterId; amount={e8s=fee}})) {
      case (#Err(e)) return #err "ledger transfer error";
      case (#Ok(_)) {}
    };

    // add bid to _categories
    switch (_categories.get(category)) {
      case null return #err "The category does not exist";
      case (?auction) switch (auction.status) {
        case (#close) return #err "The category is closed";
        case (#open(v)) {
          if (Time.now() > v.end) return #err "The auction is over";
          switch (List.get<Bid>(v.bids, 0)) {
            case (null) {
              v.bids := List.push<Bid>((canisterId, bidPrice), v.bids);
            };
            case (?(_, p)) {
              if (p >= bidPrice) return #err "your bid price is under lataet bid";
              v.bids := List.push<Bid>((canisterId, bidPrice), v.bids);
            }
          }
        }
      }
    };

    // Lock balance
    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) assert(false);
        case (#Verified(v)) {
          v.balance := #locked({
            category = category;
            bidPrice = bidPrice;
          })
        }
      };
      case (_) assert(false);
    };

    return #ok "ok";
  };

  public shared({caller}) func cancelBid(canisterId : CanisterId) : async Result<Text, Text> {
    assert(isNotAnonymous(caller));

    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          if (v.owner != caller) return #err "You are not the owner.";
          switch (v.balance) {
            case (#unlock) return #ok("Your balance is already unlocked.");
            // If this bidder has already bided, we must check the bid is the highest bid.
            case (#locked({category=c;bidPrice=_})) switch (_categories.get(c)) {
              case null return #err "assert(false)";
              case (?auction) switch (auction.status) {
                case (#close) return #err "assert(false)";
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) return #err "assert(false)";
                  //check highest bid
                  case (?(ad, p)) { // (canisterId, Price)
                    if (ad == canisterId) return #err("You are highest bidder in category: " # c);
                    v.balance := #unlock;
                    return #ok("your balance is unlocked, since you are not highest bidder in category: " # c);
                  }
                }
              };
            };
          }
        }
      };
      case (_) return #err "This canister is not registered.";
    };
  };

  // Used to return funds.
  public shared ({caller}) func refound({canisterId : CanisterId; to : Text}) : async Result<Text, {#main:Text;#ledger:Ledger.TransferError}> {
    assert(isNotAnonymous(caller));

    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err(#main("The canister is not verified."));
        case (#Verified(v)) {
          if (v.owner != caller) return #err(#main("You are not owner."));
          switch (v.balance) {
            case (#locked(_)) return #err(#main("Your balance is locked."));
            case (#unlock) {
              switch (await Ledger.refoundToUser({kinic=Principal.fromActor(this); canisterId=canisterId; to=to})) {
                case (#Err(e)) return #err(#ledger(e));
                case (#Ok(_)) return #ok "ok";
              }
            }
          }
        }
      };
      case (_) return #err(#main("This canister is not registered."));
    }
  };

  /* query */
  type FreezedContentProps = {
    #Unknown : { // A non-verified canister
      clickRecord : Nat;
    };
    #Verified : {
      clickRecord : Nat;
      owner : UserId;
      balance : {
        #unlock; // can withdrawn
        #locked : {
          category : Category; // For checking highest bid.
          bidPrice : Price;
        };
      }
    }
  };
  public query func getContentsAll() : async [(CanisterId, FreezedContentProps)] {
    Array.map<(CanisterId, ContentProps), (CanisterId, FreezedContentProps)>(
      Iter.toArray(_contents.entries()), func((_canister, _props)) {
        let props = switch (_props) {
          case (#Unknown(v)) {
            #Unknown{
              clickRecord : Nat = v.clickRecord;
            }
          };
          case (#Verified(v)) {
            #Verified {
              clickRecord : Nat = v.clickRecord;
              owner : UserId = v.owner;
              balance = v.balance : {
                #unlock; // can withdrawn
                #locked : {
                  category : Category; // For checking highest bid.
                  bidPrice : Price;
                };
              }
            }
          }
        };
        (_canister, props)
      }
    )
  };

  type FreezedAuciton = {
    status : {
      #open : {
        bids : List.List<Bid>;
        start : Time.Time;
        end : Time.Time;
      };
      #close;
    };
    lastWinner : CanisterId;
  };

  public query func getCategoryAll() : async [(Category, FreezedAuciton)] {
    Array.map<(Category, Auction), (Category, FreezedAuciton)>(
      Iter.toArray(_categories.entries()), func((_category, _auction)) {
        let status = switch (_auction.status) {
          case (#close) {
            #close
          };
          case (#open(v)) {
            #open{
              bids = v.bids;
              start = v.start;
              end = v.end;
            }
          }
        };
        (_category, {status=status; lastWinner=_auction.lastWinner} : FreezedAuciton)
      }
    )
  };

  // Principal.isAnonymous() will cause an error because we use dfx-0.7.2 via vessel
  func isNotAnonymous(principal : Principal) : Bool {
    principal != Principal.fromText("2vxsx-fae")
  };
};
