
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Accept donations
    function donate() public payable {
    }

    // View contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Transfer entire balance to owner
    function transferToOwner() public {
        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }
}

