
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Accept donation
    function donate() public payable {

        // Using require to check minimum donation
        require(msg.value >= 5 gwei, "Minimum donation is 5 gwei");
    }

    // Withdraw contract balance
    function withdraw() public {

        // Using require to check owner
        require(msg.sender == owner, "Only owner can withdraw");

        uint balance = address(this).balance;

        // Using revert to check contract balance
        if (balance == 0) {
            revert("No balance available to withdraw");
        }

        (bool success, ) = payable(owner).call{value: balance}("");

        // Using require to check transfer
        require(success, "Transfer failed");
    }

    // View contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

