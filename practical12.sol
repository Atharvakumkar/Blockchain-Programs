
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GanacheDemo {

    address public owner;
    uint256 public storedValue;

    constructor() {
        owner = msg.sender;
    }

    // Store a value in the smart contract
    function setValue(uint256 _value) public {
        storedValue = _value;
    }

    // Retrieve the stored value
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    // Send Ether to the contract
    function deposit() public payable {
    }

    // Check the Ether balance of the contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Withdraw Ether from the contract
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        payable(owner).transfer(address(this).balance);
    }
}
