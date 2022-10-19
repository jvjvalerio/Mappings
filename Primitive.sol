pragma solidity >=0.8.0 <0.9.0;

//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract Primitive {
    // Make owner a state variable with value type address and make it public
    address public owner;

    // Have a mapping of address to students, you can give the mapping any name of your choice
    mapping(address => Student) Students;

    // Have a constructor that ensures that owner is equal to the msg.sender
    constructor() {
        owner == msg.sender;
    }

    // Have a modifier called onlyOwner and require that msg.sender = owner
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Have a struct to contain details of students
    struct Student {
        string firstName;
        string lastName;
        bool registered; // Make sure that student cannot register twice
    }

    // To hold structs of our registered students
    Student[] registeredStudents;

    // Have a function to register students and it should be onlyOwner

    /* function register(address studentID) then add all the rest details 
    of the student from your struct to the argument of this function */

    Student firstStudent;

    function registerStudents(
        address studentID,
        string memory _firstName,
        string memory _lastName
    ) external onlyOwner {
        Student storage newStudent = Students[studentID];

        newStudent.firstName = _firstName;
        newStudent.lastName = _lastName;
        newStudent.registered = true;

        registeredStudents.push(newStudent);
    }

    // Have a function to get student details and it accepts one argument
    function getStudentDetails() external view returns (Student[] memory) {
        return registeredStudents;
    }
}
