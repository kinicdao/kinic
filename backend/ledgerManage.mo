// motoko base
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";

// ext standard
import Hex "mo:ext/util/Hex";
import ExtCore "mo:ext/Core";
import SHA224 "mo:ext/util/SHA224";
import AID "mo:ext/util/AccountIdentifier";

module {
  /* Ledger Types */
  type Tokens = {
    e8s: Nat64;
  };
  type TimeStamp =  {
    timestamp_nanos:  Nat64;
  };
  public type AccountIdentifier = Blob;
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

  /*
  # memo deploy ledger on local
dfx identity use minter
export MINT_ACC=$(dfx ledger account-id)
dfx identity use clankpan
export LEDGER_ACC=$(dfx ledger account-id)
dfx deploy ledger --argument '(record {minting_account = "'${MINT_ACC}'"; initial_values = vec { record { "'${LEDGER_ACC}'"; record { e8s=100_000_000_000 } }; }; send_whitelist = vec {}})'

  # send 
dfx identity use minter
dfx canister call ledger send_dfx \
'(
    record {
        memo = 1 : nat64;
        amount = record {e8s = 1_000 : nat64};
        fee = record {e8s = 0 : nat64};
        to =  "7ff40651c81d2e39e64751f3e157e4bf75c927a0b0172ea4da32b5dcecfcaa08"
    }
)'
dfx identity use clankpan

dfx identity use alice
export ALICE_AID=$(dfx ledger account-id)
dfx identity use bob
export BOB_AID=$(dfx ledger account-id)


dfx identity use minter
dfx canister call ledger send_dfx \
'(
    record {
        memo = 1 : nat64;
        amount = record {e8s = 1_000 : nat64};
        fee = record {e8s = 0 : nat64};
        to =  "'${MINT_ACC}'"
    }
)'
dfx identity use clankpan


  */
  // type SubAccount = ExtCore.SubAccount;


  let ledger : Interface = actor("rrkah-fqaaa-aaaaa-aaaaq-cai");

  /* for content */
  public func contentBalance({icme : Principal; canisterID : Principal}) : async Tokens {
    let subAccount = toSubAccount_fromPrincipal(canisterID);
    let aId  = toAccountIdentifer(icme, subAccount);
    await ledger.account_balance({
        account = aId;
    });
  };
  public func sendToContent({icme : Principal; canisterID : Principal; amount : Tokens; to : AccountIdentifier}) : async TransferResult {
    let fromSubAccount = toSubAccount_fromPrincipal(canisterID);
    // let aId  = toAccountIdentifer(icme, subAccount);
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = amount;
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = to;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };
  
  /* for category */
  public func categoryBalance({icme : Principal; category : Text}) : async Tokens {
    let subAccount = toSubAccount_fromText(category);
    let aId = toAccountIdentifer(icme, subAccount);
    await ledger.account_balance({
        account = aId;
    });
  };

  public func sendToCategory({icme : Principal; canisterID : Principal; amount : Tokens; category : Text}) : async TransferResult {
    let fromSubAccount = toSubAccount_fromPrincipal(canisterID);
    let toSubAccount = toSubAccount_fromText(category);
    let toAId  = toAccountIdentifer(icme, toSubAccount);
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = amount;
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = toAId;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  public func getTextAccountIdentifier({icme : Principal; canisterId : Principal}) : Text {
    let subAccount = toSubAccount_fromPrincipal(canisterId);
    let aId = toAccountIdentifer(icme, subAccount);
    Hex.encode(Blob.toArray(aId));
  };


  /* helpler */

  public func toSubAccount_fromPrincipal(principal : Principal) : [Nat8] {
    let sub_nat32byte : [Nat8] = Blob.toArray(Text.encodeUtf8(Principal.toText(principal)));
    let sub_hash_28 : [Nat8] = SHA224.sha224(sub_nat32byte);
    let sub_hash_32 = Array.append(sub_hash_28, Array.freeze(Array.init<Nat8>(4, 0)));
    sub_hash_32
  };
  func toSubAccount_fromText(subText : Text) : [Nat8] {
    let sub_nat32byte : [Nat8] = Blob.toArray(Text.encodeUtf8(subText));
    let sub_hash_28 : [Nat8] = SHA224.sha224(sub_nat32byte);
    let sub_hash_32 = Array.append(sub_hash_28, Array.freeze(Array.init<Nat8>(4, 0)));
    sub_hash_32
  };

  public func toAccountIdentifer(p : Principal, subAccount :  [Nat8]) : AccountIdentifier {
    return Blob.fromArray(Hex.decode(AID.fromPrincipal(p, ?subAccount)));
  };

}