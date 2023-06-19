// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Vault {
    mapping(address => uint256) private balances;
    address private owner;
    
    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() external payable {
        require(msg.value > 0, "Amount should be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount should be greater than zero");
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }
    
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
    
    function contractBalance() external view returns (uint256) {
        require(msg.sender == owner, "Only the contract owner can check the contract balance");
        return address(this).balance;
    }
}
