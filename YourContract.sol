pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {
    mapping(address => uint256) balance;
    address addr = msg.sender;

    //<!--MAPPING TASK-->
    // This function accepts one argument and it saves the amount a user is depositing into a mapping
    function deposit(uint256 amount) public {
        balance[addr] = amount;
    }

    // This function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract
    function checkBalance() public view returns (uint256) {
        return balance[addr];
    }

    //<!--STRUCT TASK-->

    // Struct Initialization
    struct Person {
        string name;
        uint256 age;
    }

    Person user;
    Person[] public people;

    // This function accepts 2 arguments that represent the details of the user calling the smart contract and it saves them into a defined struct
    function setUserDetails(string calldata name, uint256 age) public {
        people.push(user = Person(name, age));
    }

    // This function retrieves and returns the details saved for the user calling the contract
    function getUserDetail() public view returns (Person memory) {
        return user;
    }
}
