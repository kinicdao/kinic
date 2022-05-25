// motoko base
import Blob "mo:base/Blob";

// ext standard
import Hex "mo:ext/util/Hex";

module {
  /* Ledger Types */
  type Tokens = {
    e8s: Nat64;
  };
  type TimeStamp =  {
    timestamp_nanos:  Nat64;
  };
  type AccountIdentifier = Blob;
  type SubAccount = Blob;
  type BlockIndex = Nat64;
  type Memo = Nat64;

  type TransferArgs = {
    memo: Memo;
    amount: Tokens;
    fee: Tokens;
    from_subaccount: ?SubAccount;
    to: AccountIdentifier;
    created_at_time: ?TimeStamp;
  };

  type TransferError = {
    #BadFee : { expected_fee : Tokens; };
    #InsufficientFunds : { balance: Tokens; };
    #TxTooOld : { allowed_window_nanos: Nat64 };
    #TxCreatedInFuture;
    #TxDuplicate : { duplicate_of: BlockIndex; }
  };

  type TransferResult = {
    #Ok : BlockIndex;
    #Err : TransferError;
  };

  type AccountBalanceArgs = {
    account: AccountIdentifier;
  };

  public type Interface = actor {
    transfer        : TransferArgs       -> async TransferResult;
    account_balance : AccountBalanceArgs -> async Tokens;
  };


  let ledger : Interface = actor("rrkah-fqaaa-aaaaa-aaaaq-cai");

  public func balance() : async Tokens {
    ledger.account_balance({
        account = Blob.fromArray(Hex.decode(lbAId));
    });
  }

}