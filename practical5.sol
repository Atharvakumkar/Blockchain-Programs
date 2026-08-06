
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    // Custom Errors
    error InsufficientBalance(uint availableBalance);
    error MinimumDonation(uint sentAmount);

    constructor() {
        owner = msg.sender;
    }

    // Accept Donation
    function donate() public payable {

        // Donor must have at least 100000 Wei after sending transaction
        if (msg.sender.balance < 100000) {
            revert InsufficientBalance(msg.sender.balance);
        }

        // Minimum donation should be 5 Gwei
        if (msg.value < 5 gwei) {
            revert MinimumDonation(msg.value);
        }
    }

    // View Contract Balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Withdraw Contract Balance
    function withdraw() public {

        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }
}
