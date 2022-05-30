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


actor class Auction() =  this {
  /* ---- new implements ---- */

  /*types*/
  type Result<T, E> = Result.Result<T, E>;

  type Price = Nat64; //e8s 
  type Category = Text; // game, nft, ...etc
  type CanisterId = Principal; // canister hosting content site
  type UserId = Principal; // content site owner
  type Bid = (CanisterId,Price);
  type ContentProps = {
    #Unknown : { // not be verified canister by content site owner
      var clickRecord : Nat;
    };
    #Verified : {
      var clickRecord : Nat;
      owner : UserId;
      var balance : {
        #unlock; // can withdrawn
        #locked : {
          category : Category; // for check being heighest bid
          bidPrice : Price;
        };
      }
    }
  };
  type Auction = {
    status : {
      #open : {
        var bids : List.List<Bid>;
        start : Time.Time;
        end : Time.Time;
      };
      #close;
    };
    lastWinner : CanisterId;
    // bidHistory
  };
  // type Contents = HashMap<CanisterId, ContentProps>;
  // type Categories = HashMap<Category, Auction>;

  /*variavles*/

  // const vars
  let sec = 1_000_000_000;
  let minutes =  60 * sec;
  let hour = 60 * minutes;
  let day = 24 * hour;
  let week =  7 * day;

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

  /* init */
  system func preupgrade() {
    _upgradeProps := {
      contents = Iter.toArray(_contents.entries());
      categories = Iter.toArray(_categories.entries());
    };
    Debug.print("end preupgrade()")
  };

  /*functions*/
  // for debug
  /*
  Record click count. Only ICME can use this.
  */
  public shared ({caller}) func recordClick_for_debug(canisterId : CanisterId) : async Result<Text, Text> {
    Debug.print("[WIP] This is Debug function !!!");
    switch (_contents.get(canisterId)) {
      case (?#Unknown(v))  {
        v.clickRecord +=1;
        return #ok "added record to Unknown Canister";
      };
      case (?#Verified(v)) {
        v.clickRecord +=1;
        return #ok "added record to Verified Canister";
      };
      case (_) { // if there is no the caanister, add new one as unknown.
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
    Debug.print("[WIP] This is Debug function !!!");
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

  /*
  add category. Only ICME can use this.
  */
  public func addCategory_for_debug(category : Category) : async Result<Text, Text> {
    switch (_categories.get(category)) {
      case (null) {
        _categories.put(category, {
          status = #close;
          lastWinner : CanisterId = Principal.fromActor(this);
        });
        return #ok "add category, init winner is this canister";
      };
      case (?_) return #err "The category is not exsiting";
    }
  };

  /*
  start category ad acution. Only ICME can use this.
  */
  public func startAuction_for_debug(category : Category) : async Result<Text, Text> {
    switch (_categories.get(category)) {
      case null return #err "The category is not exsiting";
      case (?auction) switch (auction.status) {
        case (#open _) return #err "The category is already opened";
        case (#close) {
            _categories.put(category, {
              status = #open({
                var bids = List.nil<Bid>();
                start = Time.now();
                end = Time.now() + 4 * minutes; // auction term is 3 minutes for debug
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

  public shared({caller}) func offerBid_for_debug({category : Category; canisterId : CanisterId}) : async Result<Text, Text> {
    /* notify  ledger balance */
    let bidPrice = (await Ledger.contentBalance({icme=Principal.fromActor(this); canisterID=canisterId})).e8s;
    if (10_000 >= bidPrice) return #err  "your bid prince is under ledger transfer fee";
    
    // auth owner
    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          // if (v.owner != caller) return #err "you are not owner"; // 後でコメントアウトを戻す
          switch (v.balance) {

            // 既にどこかへ入札している場合，それが最高額のbidなら拒否する,それ以外は通す
            // ??? bidPrice=bpも比較してしまうとよくない？
            case (#locked({category=c;bidPrice=bp})) switch (_categories.get(c)) {
              case null assert(false); 
              case (?auction) switch (auction.status) {
                case (#close) assert(false); 
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) assert(false); 
                  case (?(ad, p)) {
                    if (ad == canisterId and p == bp) return #err("you are height bidder in category: " # c);
                  }
                }
              }
            };

            case (#unlock) {}
          }
        }
      };
      case (_) return #err "the canister is not registred";
    };

    // add bid
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
    switch (_contents.get(canisterId)) {
      case (?props) switch (props) {
        case (#Unknown(_)) return #err "the canister is not verified";
        case (#Verified(v)) {
          // if (v.owner != caller) return #err "you are not owner"; // WIP 本番はコメントアウトを解く
          switch (v.balance) {

            // 既にどこかへ入札している場合，それが最高額のbidなら拒否する,それ以外は通す
            case (#locked({category=c;bidPrice=bp})) switch (_categories.get(c)) {
              case null return #err "assert(false)";
              case (?auction) switch (auction.status) {
                case (#close) return #err "assert(false)";
                case (#open(_v)) switch (List.get<Bid>(_v.bids, 0)) {
                  case (null) return #err "assert(false)";
                  case (?(ad, p)) {
                    if (ad == canisterId and p == bp) return #err("you are height bidder in category: " # c);
                    v.balance := #unlock;
                    return #ok("your balnce is unlocked, since you are not height bidder in category" # c);
                  }
                }
              };
            };

            case (#unlock) {
              return #ok("your balnce is alrady unlocked");
            }
          }
        }
      };
      case (_) return #err "the canister is not registred";
    };
  };

  // public shared ({caller}) func refound({to : Text}) : async () {

  // };

  public func AutoSelectWinner_for_debug(category : Category) : async Result<Text, Text> {
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
              let ledgerResult = await Ledger.sendToCategory({icme=Principal.fromActor(this); canisterID=ad; amount={e8s=p}; category=category});

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




  // public func initCategory_for_debug(category : Category) {
  //   _categories.put(category, {
  //     status = #close;
  //   })
  // };
  // public func startAuction_for_debug(category : Category) :  async Result<Text, Text> {
  //   switch (_categories.get(category)) {
  //     case null #err "The category is not exsiting";
  //     case (?auction) switch (auction.status) {
  //       case (#open _) #err "The category is already opened";
  //       case (#close) {
  //         openAuction(category);
  //         #ok "ok";
  //       }
  //     }
  //   };
  // };

  // //WIP
  // public func getLedgerbalance(from : UserId) : async {e8s:Nat64} {
  //   let test_value = {
  //     e8s : Nat64 = 10_000_000; // 1ICP
  //   };
  //   test_value
  // };

  // // helper
  // func openAuction(category : Category) {
  //   _categories.put(category, {
  //     status = #open (List.nil<Bid>());
  //   })
  // };

  


};