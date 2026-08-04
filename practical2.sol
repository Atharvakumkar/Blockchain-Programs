// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Employee {

    struct EmployeeDetails {
        uint emp_id;
        string emp_name;
        uint emp_salary;
        string emp_dept;
    }

    EmployeeDetails[] public employees;

    // Function to add employee
    function addEmployee(
        uint _id,
        string memory _name,
        uint _salary,
        string memory _dept
    ) public {

        employees.push(
            EmployeeDetails(
                _id,
                _name,
                _salary,
                _dept
            )
        );
    }

    // Function to display employee details
    function getEmployee(uint index)
        public
        view
        returns(
            uint,
            string memory,
            uint,
            string memory
        )
    {
        EmployeeDetails memory emp = employees[index];

        return (
            emp.emp_id,
            emp.emp_name,
            emp.emp_salary,
            emp.emp_dept
        );
    }

    // Function to add Rs.5000 bonus
    function addBonus(uint index) public {

        if (employees[index].emp_salary < 10000) {
            employees[index].emp_salary += 5000;
        }
    }

    // Returns total employees
    function totalEmployees() public view returns(uint){
        return employees.length;
    }
}

