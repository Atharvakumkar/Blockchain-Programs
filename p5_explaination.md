# Practical 5: Donation Smart Contract using Custom Errors

## Aim

To create a Solidity smart contract to accept donations using a payable function, validate the donor's balance and minimum donation amount using custom errors, and allow the contract owner to withdraw the complete contract balance.

---

# Code Explanation

## 1. SPDX License Identifier

The following line specifies the license of the smart contract.

    // SPDX-License-Identifier: MIT

`MIT` is an open-source license.

---

## 2. Solidity Version

    pragma solidity ^0.8.20;

This specifies the Solidity compiler version used for the smart contract.

---

## 3. Contract Declaration

    contract Donation {

Creates a smart contract named `Donation`.

The contract is designed to:

- Accept Ether donations.
- Check the donor's minimum balance.
- Check the minimum donation amount.
- Store the donated Ether.
- Allow only the owner to withdraw the contract balance.

---

## 4. Owner Variable

    address public owner;

Stores the Ethereum address of the contract owner.

The `public` keyword automatically creates a getter function that allows the owner address to be viewed.

---

## 5. Custom Error: Insufficient Balance

    error InsufficientBalance(uint availableBalance);

Defines a custom error named `InsufficientBalance`.

This error is triggered when the donor's account balance is below the required minimum of 100,000 Wei.

The donor's available balance is passed as an error parameter.

---

## 6. Custom Error: Minimum Donation

    error MinimumDonation(uint sentAmount);

Defines a custom error named `MinimumDonation`.

This error is triggered when the donation amount is less than 5 Gwei.

The amount sent by the donor is passed as an error parameter.

---

## 7. Constructor

    constructor() {
        owner = msg.sender;
    }

The constructor executes only once when the contract is deployed.

`msg.sender` represents the address that deploys the contract.

Therefore, the account that deploys the contract automatically becomes the owner.

---

## 8. Donation Function

    function donate() public payable {

Creates a payable function named `donate()`.

The `payable` keyword allows the function to receive Ether.

---

## 9. Donor Balance Check

    if (msg.sender.balance < 100000) {
        revert InsufficientBalance(msg.sender.balance);
    }

Checks whether the donor's account balance is less than 100,000 Wei.

The value `100000` is interpreted as Wei.

If the donor's balance is less than this amount, the transaction is rejected.

The `InsufficientBalance` custom error is triggered.

---

## 10. Minimum Donation Check

    if (msg.value < 5 gwei) {
        revert MinimumDonation(msg.value);
    }

Checks whether the amount sent with the donation transaction is less than 5 Gwei.

`msg.value` represents the amount of Ether sent with the current transaction.

If the amount is less than 5 Gwei, the donation is rejected.

The `MinimumDonation` custom error is triggered.

---

## 11. Checking Contract Balance

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

Returns the amount of Ether currently stored in the smart contract.

### `view`

The `view` keyword means the function only reads blockchain data and does not modify the contract state.

### `address(this).balance`

Represents the Ether balance of the current smart contract.

The returned value is in Wei.

---

## 12. Withdraw Function

    function withdraw() public {

Allows the contract owner to withdraw the entire contract balance.

### Owner Verification

    require(msg.sender == owner, "Only owner can withdraw");

Checks whether the caller is the contract owner.

If another account calls the function, the transaction is reverted with:

    Only owner can withdraw

---

## 13. Transfer Ether using `call`

    (bool success, ) = payable(owner).call{value: address(this).balance}("");

Transfers the complete contract balance to the owner.

### `payable(owner)`

Converts the owner's address into a payable address so that it can receive Ether.

### `address(this).balance`

Gets the complete Ether balance stored in the contract.

### `call{value: ...}("")`

Sends the Ether to the owner's address.

The returned Boolean value is stored in:

    success

It indicates whether the Ether transfer succeeded.

---

## 14. Transfer Verification

    require(success, "Transfer failed");

Checks whether the Ether transfer was successful.

If `success` is `false`, the transaction is reverted with:

    Transfer failed

---

# Practical Execution in Remix

## Step 1: Create the Contract

Open Remix IDE and create:

    Donation.sol

Paste the Solidity code into the file.

---

## Step 2: Compile

Open the **Solidity Compiler** tab.

Select compiler version:

    0.8.20

Click:

    Compile Donation.sol

---

## Step 3: Deploy

Open **Deploy & Run Transactions**.

You can use Remix VM for testing or connect MetaMask using:

    Injected Provider - MetaMask

Deploy the contract.

The account that deploys the contract becomes the owner.

---

## Step 4: Test Donation

Set the transaction value to at least:

    5 Gwei

Then call:

    donate()

The donation should succeed if the donor's balance is at least 100,000 Wei.

---

## Step 5: Check Contract Balance

Click:

    getBalance()

The returned value represents the amount stored in the contract in Wei.

For example:

    5000000000

represents:

    5 Gwei

---

## Step 6: Test Minimum Donation Error

Set the transaction value to less than:

    5 Gwei

For example:

    1 Gwei

Call:

    donate()

The transaction should revert with the `MinimumDonation` custom error.

---

## Step 7: Withdraw the Balance

Switch to the account that deployed the contract.

Call:

    withdraw()

The contract transfers its entire balance to the owner.

---

## Step 8: Verify Balance

Call:

    getBalance()

After a successful withdrawal, the result should be:

    0

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
    Check Donor Balance
       |
       v
    Balance >= 100000 Wei?
       |
       +-------- No --------> InsufficientBalance Error
       |
      Yes
       |
       v
    Check Donation Amount
       |
       v
    Donation >= 5 Gwei?
       |
       +-------- No --------> MinimumDonation Error
       |
      Yes
       |
       v
    Accept Donation
       |
       v
    Ether Stored in Contract
       |
       v
    Owner Calls withdraw()
       |
       v
    Verify Owner
       |
       v
    Transfer Contract Balance using call()
       |
       v
    Check Transfer Success
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
- Custom Errors
- `payable`
- `msg.sender`
- `msg.value`
- `msg.sender.balance`
- `view`
- `require()`
- `revert`
- `address(this).balance`
- `call()`
- Ether Transfer
- Access Control

---

# Important Values

| Requirement | Value |
|---|---:|
| Minimum donor balance | 100,000 Wei |
| Minimum donation | 5 Gwei |
| Withdrawal permission | Contract owner only |

### Unit Conversion

    1 Gwei = 1,000,000,000 Wei

    5 Gwei = 5,000,000,000 Wei

---

# Conclusion

This smart contract demonstrates how to create a donation system using Solidity. The `donate()` function accepts Ether and uses custom errors to validate the donor's minimum account balance and minimum donation amount. The `getBalance()` view function displays the contract balance, while the owner-only `withdraw()` function transfers the complete balance using `call()`. The practical demonstrates payable functions, custom errors, validation, access control, Ether transfers, and Solidity's `view` functions.
