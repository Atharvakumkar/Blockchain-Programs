
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    uint public totalMarks;
    bool public isCommitteeMember;

    // Function to store student details
    function setStudentDetails(uint _marks, bool _committee) public {
        totalMarks = _marks;
        isCommitteeMember = _committee;
    }

    // Pure function
    function bonusMarks() public pure returns (uint) {
        return 10;
    }

    // View function to calculate updated marks
    function getUpdatedMarks() public view returns (uint) {
        if (isCommitteeMember) {
            return totalMarks + bonusMarks();
        } else {
            return totalMarks;
        }
    }

    // View function to display student details
    function getStudentDetails()
        public
        view
        returns (
            uint,
            bool,
            uint
        )
    {
        return (
            totalMarks,
            isCommitteeMember,
            getUpdatedMarks()
        );
    }
}
