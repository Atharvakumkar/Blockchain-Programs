# Practical 5: Donation Smart Contract using MetaMask with Custom Errors

## Aim

To create a Solidity smart contract that accepts Ether as donations using a payable function. The contract uses **custom errors** to validate the donor's account balance and the minimum donation amount. Only the contract owner can withdraw the contract balance.

---

# Code Explanation

## 1. SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

Specifies the software license of the smart contract.

- `MIT` is an open-source license.
- Indicates the terms under which the contract can be used and distributed.

---

## 2. Solidity Version

```solidity
pragma solidity ^0.8.20;
```

Specifies that the contract should be compiled using Solidity version **0.8.20** or any compatible version below **0.9.0**.

---

## 3. Contract Declaration

```solidity
contract Donation {
```

Creates a smart contract named **Donation**.

This contract performs the following operations:

- Accepts Ether donations.
- Checks donor eligibility using custom errors.
- Stores donations inside the contract.
- Allows only the owner to withdraw funds.

---

# 4. Owner Variable

```solidity
address public owner;
```

Stores the Ethereum address of the contract owner.

The keyword `public` automatically creates a getter function.

Example:

```
0x8Ab34C....
```

---

# 5. Custom Errors

## Insufficient Balance Error

```solidity
error InsufficientBalance(uint availableBalance);
```

This custom error is generated when the donor's account balance is less than the required minimum balance.

The available balance is returned as an error parameter.

---

## Minimum Donation Error

```solidity
error MinimumDonation(uint sentAmount);
```

This custom error is generated when the donation amount is less than **5 Gwei**.

The donated amount is returned as an error parameter.

---

# 6. Constructor

```solidity
constructor() {
```

A constructor is a special function that executes only once when the smart contract is deployed.

---

```solidity
owner = msg.sender;
```

Stores the deployer's Ethereum address as the contract owner.

### `msg.sender`

Represents the Ethereum address that called the constructor.

Since the constructor executes during deployment,

the deployer becomes the owner.

---

# 7. Donation Function

```solidity
function donate() public payable
```

Allows users to donate Ether to the smart contract.

---

## Payable Function

```solidity
payable
```

The `payable` keyword allows the smart contract to receive Ether.

Without `payable`, the contract cannot accept Ether.

---

# 8. Donor Balance Validation

```solidity
if (msg.sender.balance < 100000)
```

Checks whether the donor's remaining wallet balance is less than **100000 Wei**.

If the condition is true,

the transaction is cancelled.

---

```solidity
revert InsufficientBalance(msg.sender.balance);
```

Throws the custom error

```
InsufficientBalance
```

and returns the donor's current balance.

---

# 9. Minimum Donation Validation

```solidity
if (msg.value < 5 gwei)
```

Checks whether the amount sent is less than **5 Gwei**.

### `msg.value`

Represents the amount of Ether sent with the transaction.

---

```solidity
revert MinimumDonation(msg.value);
```

Throws the custom error

```
MinimumDonation
```

if the donation is below 5 Gwei.

---

# 10. View Contract Balance

```solidity
function getBalance() public view returns(uint)
```

Returns the total Ether stored inside the smart contract.

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

Returns the amount of Ether stored inside the contract.

Example:

```
5000000000 Wei
```

---

```solidity
return address(this).balance;
```

Returns the contract balance.

---

# 11. Withdraw Function

```solidity
function withdraw() public
```

Transfers the entire contract balance to the owner's wallet.

---

# Owner Verification

```solidity
require(msg.sender == owner, "Only owner can withdraw");
```

Checks whether the caller is the contract owner.

If the condition is false,

the transaction is cancelled.

---

## `require()`

Used to validate conditions before executing the remaining code.

---

## `msg.sender`

Represents the Ethereum address calling the function.

Only the owner's address is allowed.

---

# Transfer Contract Balance

```solidity
payable(owner).transfer(address(this).balance);
```

Transfers the complete contract balance to the owner's Ethereum account.

---

## `payable(owner)`

Converts the owner's address into a payable address.

Only payable addresses can receive Ether.

---

## `transfer()`

Transfers Ether from the contract to another address.

---

## `address(this).balance`

Returns the complete Ether balance stored in the smart contract.

---

# Practical Execution Steps

## Step 1

Create two MetaMask accounts.

```
Account 1
```

```
Account 2
```

Both accounts should have more than **0.1 ETH**.

---

## Step 2

Open Remix IDE.

Create a new file.

```
Donation.sol
```

Paste the smart contract code.

---

## Step 3

Compile the contract.

---

## Step 4

Connect Remix with MetaMask.

Select

```
Injected Provider - MetaMask
```

---

## Step 5

Select **Account 1**.

Deploy the smart contract.

Account 1 automatically becomes the owner.

---

## Step 6

Switch MetaMask to **Account 2**.

---

## Step 7

Enter a donation amount greater than or equal to **5 Gwei**.

Call

```
donate()
```

The Ether is stored inside the smart contract.

---

## Step 8

Call

```
getBalance()
```

The contract displays the donated Ether balance.

---

## Step 9

Switch MetaMask back to **Account 1**.

Call

```
withdraw()
```

The complete contract balance is transferred to the owner's account.

---

## Step 10

Call

```
getBalance()
```

Output:

```
0
```

The contract balance is now empty.

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
Account 2 Sends Donation
   │
   ▼
Check Donor Balance
   │
   ▼
Balance ≥ 100000 Wei ?
   │
 ┌───────────────┐
 │               │
 ▼               ▼
Yes             No
 │               │
 ▼               ▼
Check Donation  Custom Error
Amount
 │
 ▼
Donation ≥ 5 Gwei ?
 │
 ┌───────────────┐
 │               │
 ▼               ▼
Yes             No
 │               │
 ▼               ▼
Accept Donation Custom Error
 │
 ▼
Store Ether in Contract
 │
 ▼
Owner Calls withdraw()
 │
 ▼
Verify Owner
 │
 ▼
Transfer Contract Balance
 │
 ▼
Contract Balance = 0
 │
 ▼
End
```

---

# Key Concepts Used

- Smart Contract
- Constructor
- State Variable
- Custom Errors
- `payable`
- `view`
- `msg.sender`
- `msg.value`
- `address(this).balance`
- `require()`
- `transfer()`
- Ether Transfer
- Access Control
- MetaMask Integration

---

# Conclusion

This smart contract demonstrates secure donation handling on the Ethereum blockchain using **payable functions** and **custom errors**. It validates the donor's wallet balance and minimum donation amount before accepting Ether. The contract stores all donations securely and allows only the contract owner to withdraw the accumulated balance. The practical introduces important Solidity concepts such as custom errors, Ether transfers, access control, payable functions, and MetaMask interaction.
