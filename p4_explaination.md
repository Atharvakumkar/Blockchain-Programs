# Practical 4: Donation Smart Contract using Solidity (Payable Functions)

## Aim

To create a Solidity smart contract that accepts Ether as donations and allows only the contract owner to transfer the accumulated contract balance to their account.

---

# Code Explanation

## 1. SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

Specifies the software license of the smart contract.

- `MIT` is an open-source license.
- Indicates the terms under which the contract can be used.

---

## 2. Solidity Version

```solidity
pragma solidity ^0.8.20;
```

Specifies that the smart contract should be compiled using Solidity version **0.8.20** or any compatible version below **0.9.0**.

---

## 3. Contract Declaration

```solidity
contract Donation {
```

Creates a smart contract named **Donation**.

This contract performs two main tasks:

- Accepts Ether as donations.
- Transfers the entire contract balance to the owner.

---

# 4. Owner Variable

```solidity
address public owner;
```

Creates a state variable named `owner`.

- Stores the Ethereum address of the contract owner.
- The keyword `public` automatically creates a getter function.

Example:

```
0xAbC123....
```

---

# 5. Constructor

```solidity
constructor() {
```

A constructor is a special function.

It executes only once when the smart contract is deployed.

---

```solidity
owner = msg.sender;
```

Stores the address of the account that deployed the contract.

### `msg.sender`

Represents the Ethereum address of the user who called the function.

Since the constructor is executed during deployment,

the deployer's address becomes the contract owner.

Example:

```
Owner

↓

0x1234ABC...
```

---

# 6. Donation Function

```solidity
function donate() public payable {
}
```

Allows users to send Ether to the smart contract.

---

## `payable`

The keyword `payable` allows the function to receive Ether.

Without `payable`, the contract cannot accept any Ether.

Example:

```
User

↓

Sends

↓

1 Ether

↓

Contract Balance Increases
```

---

## Empty Function Body

The function body is empty because Solidity automatically stores the Ether received by the contract.

No additional code is required.

---

# 7. View Contract Balance

```solidity
function getBalance() public view returns (uint)
```

Returns the total amount of Ether stored inside the contract.

---

## View Function

```solidity
view
```

A view function only reads blockchain data.

It cannot modify blockchain data.

---

## Contract Balance

```solidity
address(this).balance
```

### `address(this)`

Represents the address of the current smart contract.

---

### `.balance`

Returns the amount of Ether stored in the contract.

Example:

```
2 Ether
```

is internally represented as

```
2000000000000000000 Wei
```

---

```solidity
return address(this).balance;
```

Returns the contract balance.

---

# 8. Transfer Balance to Owner

```solidity
function transferToOwner() public
```

Transfers the complete contract balance to the owner's wallet.

---

# Owner Verification

```solidity
require(msg.sender == owner, "Only owner can withdraw");
```

Checks whether the person calling the function is the owner.

### `require`

Used for access control and validation.

If the condition is false,

the transaction is immediately cancelled.

---

### `msg.sender`

Represents the caller's Ethereum address.

---

### Condition

```
Caller == Owner
```

If true,

execution continues.

Otherwise,

the transaction fails with the message:

```
Only owner can withdraw
```

---

# Transfer Ether

```solidity
payable(owner).transfer(address(this).balance);
```

Transfers the entire contract balance to the owner's account.

---

### `payable(owner)`

Converts the owner's address into a payable address.

Only payable addresses can receive Ether.

---

### `transfer()`

Transfers Ether from the contract to another Ethereum address.

---

### `address(this).balance`

Retrieves the total Ether stored inside the smart contract.

The complete balance is transferred to the owner.

---

# Program Flow

```
Start
   │
   ▼
Deploy Smart Contract
   │
   ▼
Constructor Executes
   │
   ▼
Store Owner Address
   │
   ▼
User Sends Ether
   │
   ▼
Contract Receives Donation
   │
   ▼
Contract Balance Increases
   │
   ▼
Owner Calls transferToOwner()
   │
   ▼
Is Caller the Owner?
   │
 ┌───────────────┐
 │               │
 ▼               ▼
Yes             No
 │               │
 ▼               ▼
Transfer Ether  Transaction Reverted
 │
 ▼
Contract Balance Becomes Zero
 │
 ▼
End
```

---

# Key Concepts Used

- Smart Contract
- Constructor
- State Variable
- Ethereum Address
- `msg.sender`
- `payable`
- `view`
- `address(this).balance`
- `transfer()`
- `require()`
- Ether Transfer
- Access Control

---

# Working of the Smart Contract

1. The smart contract is deployed.
2. The deployer's Ethereum address becomes the contract owner.
3. Users send Ether using the `donate()` function.
4. The Ether is stored in the contract balance.
5. Anyone can check the balance using `getBalance()`.
6. Only the owner can withdraw the accumulated Ether.
7. If a non-owner tries to withdraw, the transaction fails.

---

# Conclusion

This smart contract demonstrates how to receive Ether using a **payable** function and securely transfer the contract balance to the contract owner. It uses a constructor to initialize the owner, `msg.sender` to identify the caller, `require()` for access control, and `address(this).balance` to retrieve the contract's balance. The practical introduces the fundamental concepts of handling cryptocurrency transactions in Solidity.
