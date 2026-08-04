# Practical 2: Employee Management Smart Contract using Solidity

## Aim

To create a Solidity smart contract for managing employee records. The contract stores employee details, retrieves employee information, and provides a bonus of ₹5000 to employees whose salary is less than ₹10,000.

---

# Code Explanation

## 1. SPDX License Identifier

```solidity
// SPDX-License-Identifier: MIT
```

Specifies the software license under which the smart contract is released.

- `MIT` is an open-source license.
- Helps identify the licensing information of the contract.

---

## 2. Solidity Version

```solidity
pragma solidity ^0.8.20;
```

Specifies the Solidity compiler version.

- The contract can be compiled using version **0.8.20** or any compatible higher version below 0.9.0.

---

## 3. Contract Declaration

```solidity
contract Employee {
```

Creates a smart contract named **Employee**.

A smart contract is a self-executing program deployed on the Ethereum blockchain.

---

# 4. Employee Structure

```solidity
struct EmployeeDetails {
```

A `struct` is a user-defined data type that groups multiple variables together.

Each employee contains:

- Employee ID
- Employee Name
- Employee Salary
- Employee Department

---

### Employee ID

```solidity
uint emp_id;
```

Stores the unique ID of an employee.

Example:

```
101
```

---

### Employee Name

```solidity
string emp_name;
```

Stores the employee's name.

Example:

```
Rahul
```

---

### Employee Salary

```solidity
uint emp_salary;
```

Stores the employee's salary.

Example:

```
9000
```

---

### Employee Department

```solidity
string emp_dept;
```

Stores the employee's department.

Example:

```
IT
```

---

# 5. Dynamic Employee Array

```solidity
EmployeeDetails[] public employees;
```

Creates a dynamic array named `employees`.

- Stores multiple employee records.
- The array size increases whenever a new employee is added.

Example:

```
Employee 1
Employee 2
Employee 3
Employee 4
...
```

---

# 6. Function to Add Employee

```solidity
function addEmployee(
```

Creates a function for inserting employee records.

Parameters:

- Employee ID
- Employee Name
- Employee Salary
- Employee Department

---

```solidity
uint _id
```

Receives employee ID.

---

```solidity
string memory _name
```

Receives employee name.

`memory` indicates that the string is stored temporarily during function execution.

---

```solidity
uint _salary
```

Receives employee salary.

---

```solidity
string memory _dept
```

Receives employee department.

---

## Adding Employee to the Array

```solidity
employees.push(
```

Adds a new employee object to the `employees` array.

---

```solidity
EmployeeDetails(
    _id,
    _name,
    _salary,
    _dept
)
```

Creates an EmployeeDetails object using the provided values.

Example:

```
ID = 101

Name = Rahul

Salary = 9000

Department = IT
```

---

# 7. Function to Retrieve Employee Details

```solidity
function getEmployee(uint index)
```

Retrieves employee details using the array index.

Example:

```
getEmployee(0)
```

returns the first employee.

---

## View Function

```solidity
view
```

A `view` function only reads blockchain data.

It cannot modify the blockchain state.

---

## Return Values

```solidity
returns(
    uint,
    string memory,
    uint,
    string memory
)
```

Returns

- Employee ID
- Employee Name
- Employee Salary
- Employee Department

---

## Reading Employee Data

```solidity
EmployeeDetails memory emp = employees[index];
```

Copies the selected employee into a temporary memory variable.

---

## Returning Employee Details

```solidity
return (
    emp.emp_id,
    emp.emp_name,
    emp.emp_salary,
    emp.emp_dept
);
```

Returns all details of the selected employee.

Example Output:

```
101

Rahul

9000

IT
```

---

# 8. Function to Add Bonus

```solidity
function addBonus(uint index) public
```

Adds a bonus to an employee.

The employee is selected using the array index.

---

## Conditional Statement

```solidity
if (employees[index].emp_salary < 10000)
```

Checks whether the employee's salary is less than ₹10,000.

If true,

the employee becomes eligible for the bonus.

---

## Bonus Addition

```solidity
employees[index].emp_salary += 5000;
```

Adds ₹5000 to the employee's salary.

Example:

```
Before Bonus

Salary = 9000
```

After execution

```
Salary = 14000
```

If salary is already ₹10,000 or more,

no bonus is added.

---

# 9. Function to Count Employees

```solidity
function totalEmployees() public view returns(uint)
```

Returns the total number of employees stored in the contract.

---

```solidity
return employees.length;
```

Returns the size of the employee array.

Example:

```
5
```

indicates that five employees have been added.

---

# Program Flow

```
Start
   │
   ▼
Deploy Smart Contract
   │
   ▼
Create Employee Structure
   │
   ▼
Initialize Employee Array
   │
   ▼
Add Employee Details
   │
   ▼
Store Employee in Blockchain
   │
   ▼
Retrieve Employee Details
   │
   ▼
Check Salary
   │
   ▼
Salary < ₹10000 ?
   │
 ┌─Yes───────────────┐
 │                   │
 ▼                   ▼
Add ₹5000 Bonus    No Bonus
 │                   │
 └──────────┬────────┘
            ▼
Display Updated Details
            │
            ▼
Return Total Employees
            │
            ▼
End
```

---

# Key Concepts Used

- Smart Contract
- Struct
- Dynamic Array
- Functions
- `public` Visibility
- `view` Function
- Conditional (`if`) Statement
- `push()` Method
- Return Values

---

# Conclusion

This smart contract demonstrates a simple employee management system on the Ethereum blockchain. It stores employee records using a structure and a dynamic array, retrieves employee details through a view function, updates salaries by adding a ₹5000 bonus to employees earning less than ₹10,000, and returns the total number of employees stored. The practical illustrates the use of Solidity data structures, arrays, functions, and conditional logic for managing decentralized data.
