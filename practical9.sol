// Calculator.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Calculator {

    // Function to add two numbers
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    // Function to subtract two numbers
    function subtract(uint a, uint b) public pure returns (uint) {
        return a - b;
    }
}



//MainContract.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Calculator.sol";

contract MainContract {

    Calculator public calculator;

    constructor() {
        calculator = new Calculator();
    }

    // Use add function from Calculator contract
    function calculateSum(uint a, uint b)
        public
        view
        returns (uint)
    {
        return calculator.add(a, b);
    }

    // Use subtract function from Calculator contract
    function calculateDifference(uint a, uint b)
        public
        view
        returns (uint)
    {
        return calculator.subtract(a, b);
    }
}


