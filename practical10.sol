
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;
    uint public totalDonation;

    constructor() {
        owner = msg.sender;
    }

    // Modifier to allow only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Modifier to check minimum donation
    modifier minimumDonation() {
        require(msg.value >= 5 gwei, "Minimum donation is 5 gwei");
        _;
    }

    // Accept donation
    function donate()
        public
        payable
        minimumDonation
    {
        totalDonation += msg.value;
    }

    // Withdraw balance
    function withdraw()
        public
        onlyOwner
    {
        payable(owner).transfer(address(this).balance);
    }

    // Get contract balance
    function getBalance()
        public
        view
        returns (uint)
    {
        return address(this).balance;
    }
}
