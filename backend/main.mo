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

// Local
import Types "types";


shared ({caller=installer}) actor class Auction() =  this {
  /* ---- new implements ---- */

  /*types*/
  type Result<T, E> = Result.Result<T, E>;

  type Price = Types.Price; //e8s 
  type Category = Types.Category; // game, nft, ...etc
  type CanisterId = Types.CanisterId; // canister hosting content site
  type UserId = Types.UserId; // content site owner
  type Bid = Types.Bid; //(CanisterId,Price)
  type ContentProps = Types.ContentProps;
  type Auction = Types.Auction;

  /*variavles*/

  // const 
  let sec = 1_000_000_000;
  let minutes =  60 * sec;
  let hour = 60 * minutes;
  let day = 24 * hour;
  let week =  7 * day;
  let defaultAuctionTime = 3 * minutes;

  let IC0 = actor("aaaaa-aa") : 
    actor {
      canister_status : shared { canister_id : Principal } -> 
        async {
          module_hash : ?[Nat8];
          status : { #stopped; #stopping; #running };
          cycles : Nat;
        };
  };

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

  /* system */
  system func preupgrade() {
    _upgradeProps := {
      contents = Iter.toArray(_contents.entries());
      categories = Iter.toArray(_categories.entries());
    };
    Debug.print("end preupgrade()")
  };
  system func postupgrade() {
    _upgradeProps := {
      contents = [];
      categories = [];
    };
  };

  /*functions*/

  /*
  Record click count. Only ICME can use this.
  */
  public shared ({caller}) func recordClick(canisterId : CanisterId) : async Result<Text, Text> {
    // assert(caller != "2vxsx-fae");
    Debug.print("this funciton is WIP !!! anyone can use this function");

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

  /*
  Verify content site owner. This is debug funciton.
  */
  public shared ({caller}) func verifyContentOwner_for_debug({canisterId : CanisterId; owner : UserId}) : async Result<Text, Text> {
    // assert(caller != "2vxsx-fae");
    Debug.print("this funciton is WIP !!! anyone can use this function");
    
    switch (_contents.get(canisterId)) {
      case (?#Unknown(v))  {
        _contents.put(canisterId, #Verified({
          var clickRecord : Nat = v.clickRecord;
          owner : UserId = owner;
          var balance = #unlock;
        }));
        return #ok "Verified Owner";
      };
      case (?#Verified(v)) {
        return #err "Alrady Verified";
      };
      case (_) { // if there is no the caanister,  add new one as verified.
        _contents.put(canisterId, #Verified({
          var clickRecord : Nat = 0;
          owner : UserId = owner;
          var balance = #unlock;
        }));
        return #ok "Verified Owner";
      }
    }
  };

  // public shared ({caller}) func verifyContentOwner{canisterId : CanisterId) : async () {
  //   let ic0 = actor
  // };

  /*
  add category. Only ICME can use this.
  */
  public shared({caller}) func addCategory(category : Category) : async Result<Text, Text> {
    assert(caller != installer); // only use icme
    // assert(caller != "2vxsx-fae");
    // assert(not Principal.isAnonymous(caller)); // error because we use dfx-0.7.2 via vessel

    switch (_categories.get(category)) {
      case (null) {
        _categories.put(category, {
          status = #close; // auction status
          lastWinner : CanisterId = Principal.fromActor(this);
        });
        return #ok "add category, init winner is this canister";
      };
      case (?_) return #err "The category is already exsiting";
    }
  };

  /*
  start category ad acution. Only ICME can use this.
  */
  public shared({caller}) func startAuction(category : Category) : async Result<Text, Text> {
    assert(caller != installer); // only use icme
    // assert(caller != "2vxsx-fae");

    switch (_categories.get(category)) {
      case null return #err "The category is not exsiting";
      case (?auction) switch (auction.status) {
        case (#open _) return #err "The category is already opened";
        case (#close) {
            _categories.put(category, {
              status = #open({
                var bids = List.nil<Bid>();
                start = Time.now();
                end = Time.now() + defaultAuctionTime;
              });
              lastWinner : CanisterId = auction.lastWinner; // category's first winner is ICME's canister
            });
          return #ok "started auction";
        }
      }
    }
  };

  public func getAccountIdentifier(canisterId : CanisterId) : async Text {
    Ledger.getTextAccountIdentifier({icme=Principal.fromActor(this); canisterId=canisterId});
  };

  public shared({caller}) func offerBid({category : Category; canisterId : CanisterId}) : async Result<Text, Text> {
    // assert(caller != "2vxsx-fae");

    // get ledger balance 
    let bidPrice = (await Ledger.contentBalance({icme=Principal.fromActor(this); canisterId=canisterId})).e8s;
    if (10_000 >= bidPrice) return #err  "your bid prince is under ledger transfer fee";
    
    // auth owner
    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          if (v.owner != caller) return #err "you are not owner"; // auth content site owner
          switch (v.balance) {
            case (#unlock) {};
            // if this bidder have alrady bided, it is need to check the bid is highest bid
            case (#locked({category=c;bidPrice=_})) switch (_categories.get(c)) {
              case null assert(false); 
              case (?auction) switch (auction.status) {
                case (#close) assert(false); 
                //check highest bid
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) assert(false); 
                  case (?(ad, p)) { // (canisterId, Price)
                    if (ad == canisterId) return #err("you are height bidder in category: " # c);
                  }
                }
              }
            };
          }
        }
      };
      case (_) return #err "the canister is not registred";
    };

    /* bid手数料をここで引く */

    // add bid to _categories
    switch (_categories.get(category)) {
      case null return #err "The category is not exsiting";
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

    // lock balance
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

  public shared({caller}) func cancelBid_for_debug({category : Category; canisterId : CanisterId}) : async Result<Text, Text> {
    // assert(caller != "2vxsx-fae");

    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          if (v.owner != caller) return #err "you are not owner";
          switch (v.balance) {
            case (#unlock) return #ok("your balnce is alrady unlocked");
            // if this bidder have alrady bided, it is need to check the bid is highest bid
            case (#locked({category=c;bidPrice=_})) switch (_categories.get(c)) {
              case null return #err "assert(false)";
              case (?auction) switch (auction.status) {
                case (#close) return #err "assert(false)";
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) return #err "assert(false)";
                  //check highest bid
                  case (?(ad, p)) { // (canisterId, Price)
                    if (ad == canisterId) return #err("you are height bidder in category: " # c);
                    v.balance := #unlock;
                    return #ok("your balnce is unlocked, since you are not height bidder in category" # c);
                  }
                }
              };
            };
          }
        }
      };
      case (_) return #err "the canister is not registred";
    };
  };

  public shared ({caller}) func refound({canisterId : CanisterId; to : Text}) : async Result<Text, Text> {
    // assert(caller != "2vxsx-fae");

    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          if (v.owner != caller) return #err "you are not owner";
          switch (v.balance) {
            case (#locked(_)) return #err "your balnce is locked";
            case (#unlock) {
              switch (await Ledger.refoundToUser({icme=Principal.fromActor(this); canisterId=canisterId; to=to})) {
                case (#Err(_)) return #err "ledger transfer error";
                case (#Ok(_)) return #ok "ok";
              }
            }
          }
        }
      };
      case (_) return #err "the canister is not registred";
    }
  };

  public shared({caller}) func AutoSelectWinner_for_debug(category : Category) : async Result<Text, Text> {
    assert(caller != installer); // only use icme
    // assert(caller != "2vxsx-fae");

    switch (_categories.get(category)) {
      case null return #err "The category is not exsiting";
      case (?auction) switch (auction.status) {
        case (#close) return #err "The category is already closed";
        case (#open(v)) {
          if (v.end >= Time.now()) return #err "The category is still in auction";

          switch (List.get<Bid>(v.bids, 0)) {
            case (null) {
              _categories.put(category, {
                status = #close;
                lastWinner = auction.lastWinner; // 前回のwinnerにする
              });
              return #err "There are no bid";
            };
            case (?(ad, p)) { // (canister_id, bid_price)

              // send winner's bid price to category 
              let ledgerResult = await Ledger.sendToCategory({icme=Principal.fromActor(this); canisterId=ad; amount={e8s=p}; category=category});

              switch (ledgerResult) {
                case (#Err(_)) return #err "ledger transfer error";
                case (#Ok(_)) {}
              };
              // close auction
              _categories.put(category, {
                status = #close;
                lastWinner = ad; 
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

  /* query */
  type FreezedContentProps = {
    #Unknown : { // not be verified canister
      clickRecord : Nat;
    };
    #Verified : {
      clickRecord : Nat;
      owner : UserId;
      balance : {
        #unlock; // can withdrawn
        #locked : {
          category : Category; // for check being heighest bid
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
                  category : Category; // for check being heighest bid
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

};