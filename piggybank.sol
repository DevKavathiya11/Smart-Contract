//SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.0;


/*   The contract owner can deposit and withdraw funds.
     Other users can deposit funds.
     The contract owner can lock or unlock the piggy bank.
     The contract emits events for deposit and withdrawal actions.*/

contract PiggyBank {
    address public owner;
    uint public balance;
    bool public locked;

    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier notLocked() {
        require(!locked, "The piggy bank is locked");
        _;
    }

    constructor() {
        owner = msg.sender;
        locked = false;
    }

    function deposit() public payable notLocked {
        balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public onlyOwner notLocked {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function lock() public onlyOwner {
        locked = true;
    }

    function unlock() public onlyOwner {
        locked = false;
    }
}
