// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BegToInvestSimple {
    
    mapping(address => uint256) public balanceOf;

    
    event Invested(address indexed investor, address indexed beggar, uint256 amount);
    event Withdrawn(address indexed beggar, uint256 amount);

    function invest(address beggar) external payable {
        require(msg.value > 0, "No ETH sent");
        require(beggar != address(0), "Invalid beggar address");

        balanceOf[beggar] += msg.value;
        emit Invested(msg.sender, beggar, msg.value);
    }

    
    function withdraw() external {
        uint256 amount = balanceOf[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        balanceOf[msg.sender] = 0;
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }
}