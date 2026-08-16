// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Donation {

    address public owner;

    error InsufficientBalance(uint availableBalance);
    error MinimumDonation(uint sentAmount);

    constructor() {
        owner = msg.sender;
    }

    function donate() public payable {

        if (msg.sender.balance < 100000) {
            revert InsufficientBalance(msg.sender.balance);
        }

        if (msg.value < 5 gwei) {
            revert MinimumDonation(msg.value);
        }
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}
