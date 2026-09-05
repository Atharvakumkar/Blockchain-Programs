// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to allow only owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Accept donations
    function donate() public payable {
    }

    // View contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Withdraw contract balance
    function withdraw() public onlyOwner {
        (bool success, ) = payable(owner).call{
            value: address(this).balance
        }("");

        require(success, "Transfer failed");
    }
}
