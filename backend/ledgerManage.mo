// Motoko base
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Nat64 "mo:base/Nat64";

// Ext standard
import Hex "mo:ext/util/Hex";
import ExtCore "mo:ext/Core";
import SHA224 "mo:ext/util/SHA224";
import AID "mo:ext/util/AccountIdentifier";

// Local
// import Types "types";


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

  public type TransferError = {
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

  // WARNING: need to change this to ledger for prod.
  let ledger : Interface = actor("rrkah-fqaaa-aaaaa-aaaaq-cai");

  /* For installer */
  public func refoundToInstaller({kinic : Principal; to : Text; category: Text}) : async TransferResult {
    let fromSubAccount = toSubAccount_fromText(category);
    let amount : Tokens = await ledger.account_balance({
      account = Blob.fromArray(Hex.decode(AID.fromPrincipal(kinic, ?fromSubAccount)))
    });
    if (10_000 > amount.e8s) return #Err(#InsufficientFunds({ balance=amount; }));
    let toAId  = Blob.fromArray(Hex.decode(to));
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = {e8s=amount.e8s-10_000};
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = toAId;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  /* For content sites */
  public func contentBalance({kinic : Principal; canisterId : Principal}) : async Tokens {
    let subAccount = toSubAccount_fromPrincipal(canisterId);
    let aId  = toAccountIdentifer(kinic, subAccount);
    await ledger.account_balance({
        account = aId;
    });
  };
  public func sendToContent({kinic : Principal; canisterId : Principal; amount : Tokens; to : AccountIdentifier}) : async TransferResult {
    if (10_000 > amount.e8s) return #Err(#InsufficientFunds({ balance=amount; }));
    let fromSubAccount = toSubAccount_fromPrincipal(canisterId);
    // let aId  = toAccountIdentifer(kinic, subAccount);
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = {e8s=amount.e8s-10_000};
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = to;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  /* For category */
  public func categoryBalance({kinic : Principal; category : Text}) : async Tokens {
    let subAccount = toSubAccount_fromText(category);
    let aId = toAccountIdentifer(kinic, subAccount);
    await ledger.account_balance({
        account = aId;
    });
  };

  public func sendToCategory({kinic : Principal; canisterId : Principal; amount : Tokens; category : Text}) : async TransferResult {
    let fromSubAccount = toSubAccount_fromPrincipal(canisterId);
    let toSubAccount = toSubAccount_fromText(category);
    let toAId  = toAccountIdentifer(kinic, toSubAccount);
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = {e8s=amount.e8s-10_000};
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = toAId;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  public func refoundToUser({kinic : Principal; canisterId : Principal; to : Text}) : async TransferResult {
    let amount : Tokens = await contentBalance({kinic; canisterId});
    if (10_000 > amount.e8s) return #Err(#InsufficientFunds({ balance=amount; }));
    let fromSubAccount = toSubAccount_fromPrincipal(canisterId);
    let toAId  = Blob.fromArray(Hex.decode(to));
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = {e8s=amount.e8s-10_000};
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = toAId;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  public func sendFee({kinic : Principal; canisterId : Principal; amount : Tokens;}) : async TransferResult {
    if (10_000 > amount.e8s) return #Err(#InsufficientFunds({ balance=amount; }));
    let fromSubAccount = toSubAccount_fromPrincipal(canisterId);
    let toAId  = Blob.fromArray(Hex.decode(AID.fromPrincipal(kinic, null)));
    let args : TransferArgs = {
      memo: Memo = 0;
      amount: Tokens = {e8s=amount.e8s-10_000};
      fee: Tokens = {e8s=10_000};
      from_subaccount: ?SubAccount = ?Blob.fromArray(fromSubAccount);
      to: AccountIdentifier = toAId;
      created_at_time: ?TimeStamp = null;
    };
    await ledger.transfer(args);
  };

  // Get the address to send ICP to for bidding.
  public func getContentAccountIdentifier({kinic : Principal; canisterId : Principal}) : Text {
    let subAccount = toSubAccount_fromPrincipal(canisterId);
    let aId = toAccountIdentifer(kinic, subAccount);
    Hex.encode(Blob.toArray(aId));
  };

  // The address where ICP goes after bidding is complete and a winner is selected.
  public func getCategoryAccountIdentifier({kinic : Principal; category : Text}) : Text {
    let subAccount = toSubAccount_fromText(category);
    let aId = toAccountIdentifer(kinic, subAccount);
    Hex.encode(Blob.toArray(aId));
  };

  /* Helper */

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
