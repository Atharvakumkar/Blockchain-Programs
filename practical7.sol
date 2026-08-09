// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    // Event to notify owner and thank donor
    event LargeDonation(
        address indexed donor,
        address indexed owner,
        uint amount,
        string message
    );

    constructor() {
        owner = msg.sender;
    }

    // Accept donations
    function donate() public payable {

        // Check if donation is more than 10 Ether
        if (msg.value > 10 ether) {

            emit LargeDonation(
                msg.sender,
                owner,
                msg.value,
                "Thank you for your generous donation!"
            );
        }
    }

    // View contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Withdraw contract balance
    function withdraw() public {

        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }
}
