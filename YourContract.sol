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

    /* This function accepts 2 arguments that represent 
    the details of the user calling the smart contract 
    and it saves them into a defined struct */
    function setUserDetails(string calldata name, uint256 age) public {
        people.push(user = Person(name, age));
    }

    // This function retrieves and returns the details saved for the user calling the contract
    function getUserDetail() public view returns (Person memory) {
        return user;
    }

    // <!--MODIFIER TASK-->

    // Deposit mapping
    mapping(address => input) forDeposit;

    struct input {
        uint256 _amount;
        bool deposited;
    }

    // Create a deposit function that allows anybody to send funds
    function deposit(address _addr, uint256 _amount) public {
        forDeposit[_addr] = input(_amount, true);
    }

    // Add a withdraw function and create a modifier that only allows the owner of the contract to withdraw the funds.
    address owner = msg.sender;

    modifier canWithdraw(_owner) {
        require(owner == _owner, "You are not the owner");
        _;
    }

    function withdraw() public canWithdraw(_owner) {
        YourContract.transfer(_owner, _amount);
    }

    /* Add an addFund function and create a modifier that only allows users that have 
    deposited using the deposit function, to increase their balance on the mapping. 
    The function should accept the amount to be added and update the mapping to 
    have the new balance */

    modifier onlyAllow(address _addr) {
        require(!forDeposit[_addr].deposited, "Please make a deposit first!");
        _;
    }

    // Create a modifier that accepts a value(uint256 _amount)

    uint256 constant private fee = 5;

    modifier valueAcceptance(uint256 _amount) {
        require(_amount < fee, "Amount is too small");
            _;
        }
    function addFund(address _addr, uint256 _amount) external onlyAllow(_addr) valueAcceptance(uint256 _amount) {
        forDeposit[_addr]._amount = forDeposit[_addr]._amount + _amount;
    }
}
