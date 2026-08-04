# Practical 3: Student Marks Smart Contract using Solidity (Pure and View Functions)

## Aim

To create a Solidity smart contract that stores a student's total marks and committee status (NSS/DLLE). If the student is a member of the committee, 10 bonus marks are added to the total. The contract demonstrates the use of **pure** and **view** functions.

---

# Code Explanation

## 1. SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

Specifies the software license of the smart contract.

- `MIT` is an open-source license.
- Indicates how the contract can be used and distributed.

---

## 2. Solidity Version

```solidity
pragma solidity ^0.8.20;
```

Specifies that the contract should be compiled using Solidity version **0.8.20** or any compatible higher version below 0.9.0.

---

## 3. Contract Declaration

```solidity
contract Student {
```

Creates a smart contract named **Student**.

A smart contract is a program that executes automatically on the Ethereum blockchain.

---

# 4. State Variables

## Total Marks

```solidity
uint public totalMarks;
```

Stores the student's total marks.

The keyword `public` automatically creates a getter function that allows anyone to read its value.

Example:

```
75
```

---

## Committee Status

```solidity
bool public isCommitteeMember;
```

Stores whether the student is a member of the NSS or DLLE committee.

Possible values:

```
true
```

or

```
false
```

Like `totalMarks`, it is declared as `public`, so Solidity automatically generates a getter function.

---

# 5. Function to Store Student Details

```solidity
function setStudentDetails(uint _marks, bool _committee) public
```

Stores the student's marks and committee status.

Parameters:

- `_marks` → Student's total marks.
- `_committee` → Committee membership status.

---

## Store Marks

```solidity
totalMarks = _marks;
```

Stores the marks entered by the user.

Example:

```
75
```

---

## Store Committee Status

```solidity
isCommitteeMember = _committee;
```

Stores whether the student belongs to the NSS/DLLE committee.

Example:

```
true
```

---

# 6. Pure Function

```solidity
function bonusMarks() public pure returns (uint)
```

This is a **pure function**.

A pure function:

- Does not read blockchain data.
- Does not modify blockchain data.
- Always returns the same output for the same logic.

---

## Returning Bonus Marks

```solidity
return 10;
```

Returns a constant bonus of **10 marks**.

Example Output:

```
10
```

---

# 7. View Function

```solidity
function getUpdatedMarks() public view returns (uint)
```

This is a **view function**.

A view function:

- Reads blockchain data.
- Cannot modify blockchain data.

---

## Checking Committee Membership

```solidity
if (isCommitteeMember)
```

Checks whether the student is a member of NSS/DLLE.

---

### If Student is a Committee Member

```solidity
return totalMarks + bonusMarks();
```

Calls the pure function `bonusMarks()` and adds 10 marks.

Example:

```
Original Marks = 75

Bonus = 10

Updated Marks = 85
```

---

### If Student is Not a Committee Member

```solidity
return totalMarks;
```

Returns the original marks without any changes.

Example:

```
Marks = 75
```

---

# 8. Display Student Details

```solidity
function getStudentDetails()
```

Returns all student information.

---

## View Function

```solidity
view
```

Since it only reads data, it is declared as a `view` function.

---

## Return Values

```solidity
returns(
    uint,
    bool,
    uint
)
```

Returns:

- Total Marks
- Committee Status
- Updated Marks

---

## Returning Student Details

```solidity
return (
    totalMarks,
    isCommitteeMember,
    getUpdatedMarks()
);
```

Returns all three values together.

Example Output:

```
75

true

85
```

or

```
68

false

68
```

---

# Program Flow

```
Start
   │
   ▼
Deploy Smart Contract
   │
   ▼
Enter Student Marks
   │
   ▼
Enter NSS/DLLE Status
   │
   ▼
Store Details
   │
   ▼
Call bonusMarks() (Pure Function)
   │
   ▼
Is Student a Committee Member?
   │
 ┌───────────────┐
 │               │
 ▼               ▼
Yes             No
 │               │
 ▼               ▼
Add 10 Marks   Keep Original Marks
 │               │
 └───────┬───────┘
         ▼
Display Student Details
         │
         ▼
End
```

---

# Key Concepts Used

- Smart Contract
- State Variables
- Functions
- `public`
- `pure` Function
- `view` Function
- Boolean (`bool`)
- Conditional (`if-else`)
- Return Values

---

# Difference Between Pure and View Functions

| Pure Function | View Function |
|--------------|---------------|
| Does not read blockchain data | Reads blockchain data |
| Does not modify blockchain data | Does not modify blockchain data |
| Returns constant or calculated values | Returns stored blockchain values |
| Example: `bonusMarks()` | Example: `getUpdatedMarks()` |

---

# Conclusion

This smart contract demonstrates how to store and retrieve student information using Solidity. It uses state variables to store marks and committee status, a **pure** function to return a constant bonus of 10 marks, and **view** functions to calculate and display the updated marks without modifying the blockchain state. The practical illustrates the difference between **pure** and **view** functions while implementing conditional logic in a smart contract.
