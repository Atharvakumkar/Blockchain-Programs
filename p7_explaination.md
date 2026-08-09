
# Practical: Large Donation Notification using Solidity

## Aim

To modify a donation smart contract so that when a donor contributes more than **10 Ether**, the contract emits an event to notify the contract owner and thank the donor.

## Code Explanation

### 1. SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

Specifies the license of the smart contract.

### 2. Solidity Version

```solidity
pragma solidity ^0.8.20;
```

Specifies the Solidity compiler version used for the contract.

### 3. Contract Declaration

```solidity
contract Donation {
```

Creates a smart contract named `Donation`.

### 4. Owner Variable

```solidity
address public owner;
```

Stores the Ethereum address of the contract owner. Because it is `public`, Solidity automatically provides a getter function.

### 5. Event Declaration

```solidity
event LargeDonation(
    address indexed donor,
    address indexed owner,
    uint amount,
    string message
);
```

Creates an event named `LargeDonation`.

The event records:
- `donor` — address of the donor.
- `owner` — address of the contract owner.
- `amount` — amount donated.
- `message` — thank-you message.

The `indexed` keyword makes the donor and owner addresses searchable in event logs.

### 6. Constructor

```solidity
constructor() {
    owner = msg.sender;
}
```

Runs once when the contract is deployed. `msg.sender` is the address that deploys the contract, so the deployer becomes the owner.

### 7. Donation Function

```solidity
function donate() public payable {
```

Creates a function that accepts Ether donations. The `payable` keyword allows Ether to be sent with the function call.

### 8. Checking Donation Amount

```solidity
if (msg.value > 10 ether) {
```

Checks whether the donation is greater than 10 Ether.

- 5 ETH → condition is false
- 10 ETH → condition is false
- 11 ETH → condition is true

### 9. Emitting the Event

```solidity
emit LargeDonation(
    msg.sender,
    owner,
    msg.value,
    "Thank you for your generous donation!"
);
```

Generates the `LargeDonation` event. The transaction logs contain the donor address, owner address, donation amount, and thank-you message.

### 10. Checking Contract Balance

```solidity
function getBalance() public view returns (uint) {
    return address(this).balance;
}
```

Returns the Ether balance of the smart contract.

`view` means the function only reads blockchain data.

`address(this).balance` represents the Ether stored in the contract.

### 11. Withdraw Function

```solidity
function withdraw() public {
```

Allows the owner to withdraw the contract balance.

```solidity
require(msg.sender == owner, "Only owner can withdraw");
```

Ensures that only the owner can withdraw.

```solidity
payable(owner).transfer(address(this).balance);
```

Transfers the entire contract balance to the owner.

## Working of the Contract

### Normal Donation

If a donor sends:

```text
5 ETH
```

The donation is accepted, but no `LargeDonation` event is generated.

### Large Donation

If a donor sends:

```text
11 ETH
```

The donation is accepted and the following event is generated:

```text
LargeDonation
    Donor: Account 2
    Owner: Account 1
    Amount: 11 ETH
    Message: Thank you for your generous donation!
```

The event can be viewed in the transaction logs in Remix.

## Program Flow

```text
Start
   |
   v
Deploy Donation Contract
   |
   v
Deployer becomes Owner
   |
   v
Donor calls donate()
   |
   v
Ether is sent to Contract
   |
   v
Check donation amount
   |
   v
Donation > 10 ETH?
   |
   +-------- Yes --------> Emit LargeDonation Event
   |                         |
   |                         v
   |                    Notify Owner
   |                         |
   |                         v
   |                    Thank Donor
   |
   +-------- No ----------> Accept Donation
                              |
                              v
                    Contract Balance Updated
                              |
                              v
                         Owner can Withdraw
                              |
                              v
                             End
```

## How to Test in Remix

### Test 1: Normal Donation

Set the transaction value to:

```text
5 ETH
```

Call:

```text
donate()
```

The donation is accepted and no `LargeDonation` event is generated.

### Test 2: Large Donation

Set the transaction value to:

```text
11 ETH
```

Call:

```text
donate()
```

The transaction is successful and the transaction logs should contain `LargeDonation` with the donor address, owner address, donation amount, and thank-you message.

### Test 3: Check Balance

Call:

```text
getBalance()
```

The returned value represents the total Ether stored in the contract, in Wei.

### Test 4: Withdraw

Call:

```text
withdraw()
```

using the owner account. The entire contract balance is transferred to the owner.

## Key Concepts Used

- Smart Contract
- Events
- `emit`
- `payable`
- `msg.sender`
- `msg.value`
- `address(this).balance`
- `view`
- `require()`
- Ether Transfer
- Transaction Logs
- Conditional Statements

## Conclusion

This smart contract demonstrates how Solidity events can be used to record important activities. When a donation exceeds **10 Ether**, the contract emits a `LargeDonation` event containing the donor, owner, donation amount, and a thank-you message. The event can be viewed in Remix transaction logs, demonstrating how smart contracts can communicate important events to external applications and users.
