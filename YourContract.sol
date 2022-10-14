pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {
    mapping(address => uint256) balance;
    address addr = msg.sender;

    // This function accepts one argument and it saves the amount a user is depositing into a mapping
    function deposit(uint256 amount) public {
        balance[addr] = amount;
    }

    // This function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract
    function checkBalance() public view returns (uint256) {
        return balance[addr];
    }
}
