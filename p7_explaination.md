# Practical 7: Donation Smart Contract with Large Donation Event

## Aim

To create a Solidity smart contract that accepts donations and generates an event to notify the contract owner and thank the donor when the donation amount is greater than 10 Ether.

---

# Code Explanation

## 1. SPDX License Identifier

    // SPDX-License-Identifier: MIT

Specifies the license of the smart contract.

`MIT` is an open-source license.

---

## 2. Solidity Version

    pragma solidity ^0.8.20;

Specifies the Solidity compiler version used for the contract.

---

## 3. Contract Declaration

    contract Donation {

Creates a smart contract named `Donation`.

The contract is designed to:

- Accept Ether donations.
- Detect donations greater than 10 Ether.
- Generate an event for large donations.
- Display the contract balance.
- Allow only the owner to withdraw the contract balance.

---

## 4. Owner Variable

    address public owner;

Stores the Ethereum address of the contract owner.

The `public` keyword automatically creates a getter function to view the owner's address.

---

## 5. Large Donation Event

    event LargeDonation(
        address indexed donor,
        address indexed owner,
        uint amount,
        string message
    );

Creates an event named `LargeDonation`.

The event stores four pieces of information:

- `donor` → Address of the person making the donation.
- `owner` → Address of the contract owner.
- `amount` → Amount donated.
- `message` → Thank-you message.

The `indexed` keyword allows the `donor` and `owner` addresses to be searched and filtered in event logs.

---

## 6. Constructor

    constructor() {
        owner = msg.sender;
    }

The constructor executes only once when the contract is deployed.

`msg.sender` represents the address that deploys the contract.

Therefore, the account that deploys the contract automatically becomes the owner.

---

# 7. Donation Function

    function donate() public payable {

Creates a function named `donate()`.

The `payable` keyword allows the function to receive Ether.

---

## 8. Checking Donation Amount

    if (msg.value > 10 ether) {

Checks whether the amount of Ether sent with the transaction is greater than 10 Ether.

`msg.value` represents the amount of Ether sent with the current transaction.

Examples:

    5 ETH > 10 ETH → False

    10 ETH > 10 ETH → False

    11 ETH > 10 ETH → True

Therefore, the event is generated only when the donation is **greater than 10 Ether**.

---

# 9. Generating the Event

    emit LargeDonation(
        msg.sender,
        owner,
        msg.value,
        "Thank you for your generous donation!"
    );

The `emit` keyword generates the `LargeDonation` event.

The following information is recorded:

    Donor → msg.sender

    Owner → owner

    Amount → msg.value

    Message → Thank you for your generous donation!

The event can be viewed in the transaction logs in Remix.

---

# 10. Checking Contract Balance

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

Returns the amount of Ether currently stored in the smart contract.

### `view`

The `view` keyword means the function only reads blockchain data and does not modify the contract.

### `address(this).balance`

Represents the current Ether balance of the smart contract.

The returned value is in Wei.

---

# 11. Withdraw Function

    function withdraw() public {

Allows the contract owner to withdraw the entire contract balance.

---

## Owner Verification

    require(msg.sender == owner, "Only owner can withdraw");

Checks whether the caller is the contract owner.

If a different account tries to withdraw, the transaction is reverted with:

    Only owner can withdraw

---

# 12. Transfer Ether Using `call`

    (bool success, ) = payable(owner).call{
        value: address(this).balance
    }("");

Transfers the entire contract balance to the owner's address.

### `payable(owner)`

Converts the owner's address into a payable address so that it can receive Ether.

### `address(this).balance`

Gets the complete Ether balance stored inside the contract.

### `call{value: ...}("")`

Sends the Ether to the owner's address.

The result of the transfer is stored in:

    success

`success` is `true` if the transfer succeeds and `false` if it fails.

---

# 13. Transfer Verification

    require(success, "Transfer failed");

Checks whether the Ether transfer was successful.

If `success` is `false`, the transaction is reverted with:

    Transfer failed

---

# Working of the Contract

## Normal Donation

If the donor sends:

    5 ETH

The donation is accepted.

The condition:

    msg.value > 10 ether

is false.

Therefore, no `LargeDonation` event is generated.

---

## Donation of Exactly 10 ETH

If the donor sends:

    10 ETH

The condition is:

    10 ETH > 10 ETH

which is false.

Therefore, no event is generated.

---

## Large Donation

If the donor sends:

    11 ETH

The condition:

    11 ETH > 10 ETH

is true.

The contract generates:

    LargeDonation

The event contains:

    Donor: Account making the donation
    Owner: Contract owner
    Amount: 11 ETH
    Message: Thank you for your generous donation!

The event can be viewed in the transaction logs.

---

# How to Perform the Practical in Remix

## Step 1: Create the File

Create a new Solidity file:

    Donation.sol

Paste the contract code into the file.

---

## Step 2: Compile

Open the **Solidity Compiler** tab.

Select:

    0.8.20

Click:

    Compile Donation.sol

Make sure compilation is successful.

---

## Step 3: Deploy

Open:

    Deploy & Run Transactions

For simple testing, select:

    Remix VM

Select the `Donation` contract and click:

    Deploy

The account used for deployment becomes the owner.

---

## Step 4: Check Owner

Under **Deployed Contracts**, click:

    owner()

The displayed address should be the account that deployed the contract.

---

## Step 5: Make a Normal Donation

Set the transaction value to:

    5 Ether

Select:

    Ether

Then click:

    donate()

The transaction should succeed.

No `LargeDonation` event should be generated.

---

## Step 6: Check Balance

Click:

    getBalance()

The contract balance should contain the donated amount.

For example:

    5000000000000000000

represents:

    5 ETH

---

## Step 7: Make a Large Donation

Set:

    Value = 11 Ether

Select:

    Ether

Click:

    donate()

The transaction should succeed.

Because:

    11 ETH > 10 ETH

the `LargeDonation` event will be generated.

---

## Step 8: View the Event

Open the transaction details or logs for the `donate()` transaction.

You should see:

    LargeDonation

The event contains:

    donor
    owner
    amount
    message

The message should be:

    Thank you for your generous donation!

---

## Step 9: Withdraw the Balance

Make sure the selected account is the same account that deployed the contract.

Click:

    withdraw()

The complete contract balance will be transferred to the owner.

---

## Step 10: Verify the Balance

Click:

    getBalance()

The result should be:

    0

This confirms that the entire contract balance has been withdrawn.

---

# Program Flow

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
    Ether received by Contract
       |
       v
    Check Donation Amount
       |
       v
    Donation > 10 ETH?
       |
       +--------- No ---------> Accept Donation
       |
      Yes
       |
       v
    Emit LargeDonation Event
       |
       v
    Notify Owner / Thank Donor
       |
       v
    Contract Balance Updated
       |
       v
    Owner Calls withdraw()
       |
       v
    Verify Owner
       |
       v
    Transfer Balance using call()
       |
       v
    Contract Balance = 0
       |
       v
    End

---

# Key Concepts Used

- Smart Contract
- Constructor
- State Variable
- Events
- `emit`
- `indexed`
- `payable`
- `msg.sender`
- `msg.value`
- `view`
- `require()`
- `address(this).balance`
- `call()`
- Ether Transfer
- Access Control
- Transaction Logs
- Conditional Statements

---

# Important Conditions

| Condition | Result |
|---|---|
| Donation < 10 ETH | Donation accepted, no event |
| Donation = 10 ETH | Donation accepted, no event |
| Donation > 10 ETH | Donation accepted + `LargeDonation` event |
| Non-owner calls `withdraw()` | Transaction reverted |
| Owner calls `withdraw()` | Entire balance transferred |

---

# Conclusion

This smart contract demonstrates how Solidity can handle Ether donations and generate events for large donations. When a donation exceeds 10 Ether, the `LargeDonation` event records the donor, owner, amount, and thank-you message in the transaction logs. The contract also provides a function to check its balance and allows only the owner to withdraw the complete balance using `call()`. This practical demonstrates payable functions, events, conditional statements, access control, Ether transfers, and transaction logs.
