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

module {

  public type Price = Nat64; //e8s
  public type Category = Text; // game, nft, ...etc
  public type CanisterId = Principal; // Canister hosting content site.
  public type UserId = Principal; // content site owner
  public type Bid = (CanisterId,Price);
  public type ContentProps = {
    #Unknown ; // A non-verified site.
    #Verified : {
      owner : UserId;
      var balance : {
        #unlock; // can withdrawn
        #locked : {
          category : Category; // To check highest bid.
          bidPrice : Price;
        };
      }
    }
  };
  public type Auction = {
    status : {
      #open : {
        var bids : List.List<Bid>;
        start : Time.Time;
        end : Time.Time;
      };
      #close;
    };
    lastWinner : CanisterId;
    auctionHistory : List.List<(Time.Time, List.List<Bid>)>;
  };
}
