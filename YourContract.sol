pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YourContract is ERC20 {
    constructor() ERC20("CoolToken", "CTK") {
        _mint(_msgSender(), 10000 * (10**uint256(decimals())));
    }

    mapping(address => uint256) balance;

    //<!--MAPPING TASK-->
    // This function accepts one argument and it saves the amount a user is depositing into a mapping

    // <!--PAYABLE TASK (MODIFIES DEPOSIT FUNCTION)-->
    address addr = payable(msg.sender);

    function deposit() external payable {}

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

    modifier canWithdraw(address _owner) {
        require(owner == _owner, "You are not the owner");
        _;
    }

    function withdraw(uint256 _amount) public canWithdraw(msg.sender) {
        payable(msg.sender).transfer(_amount);
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

    uint256 private constant fee = 5;

    modifier valueAcceptance(uint256 _amount) {
        require(_amount < fee, "Amount is too small");
        _;
    }

    function addFund(address _addr, uint256 _amount)
        external
        onlyAllow(_addr)
        valueAcceptance(_amount)
    {
        forDeposit[_addr]._amount = forDeposit[_addr]._amount + _amount;
    }

    // <!--EVENT TASK-->

    /* Extend the previous task to use blockchain events. 
    The contact should emit the following events when a user 
    deposits and updates their profile information respectively: */

    event FundsDeposited(address user, uint256 amount);

    function emitFundsDeposited(address _user, uint256 _amount) external {
        emit FundsDeposited(_user, _amount);
    }

    event ProfileUpdated(address user);

    function emitProfileUpdated(address _user) external {
        emit ProfileUpdated(_user);
    }

    // <!--FALLBACK TASK-->
    /* To ensure that our smart contract can receive ETH sent to it via transfers, 
    we will create a fallback or receive payable function. 
    The task is to create the fallback function and make sure when a user transfers 
    ETH to the smart contract, the transaction does not get reverted */

    fallback() external payable {}

    receive() external payable {}
}
