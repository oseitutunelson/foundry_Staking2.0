// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title Decentralized Staking
 * @author Owusu Nelson Osei Tutu
 * @notice A decentralized staking and rewarding contract 
 * @notice This contract is the main token for staking and follows the ERC20 token standard
 */

contract Cheddar{
   string public name = 'Cheddar';
   string public symbol = 'mUSDC';
   uint8 public decimals = 18;
   uint256 public totalSupply = 1000000000000000000000000;

   event Transfer(address indexed from,address indexed to,uint256 indexed amount);
   event Approve(address indexed from,address indexed to,uint256 indexed amount);

   //keep track of user balances
   mapping (address => uint256) public balanceOf;
   mapping (address => mapping (address => uint256)) public allowance;

   constructor(){
     balanceOf[msg.sender] = totalSupply;
   }

   function transfer(address _to,uint256 _amount) public returns (bool sucess){
    require(balanceOf[msg.sender] >= _amount);
    require(_amount > 0,"Amount cannot be zero or less");
    balanceOf[msg.sender] -= _amount;
    balanceOf[_to] += _amount;
   // allowance[_to][_to] += _amount;
    emit Transfer(msg.sender, _to, _amount);
    return true;
   }

   function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
    require(_amount <= balanceOf[_from], "Insufficient balance");
    //require(_amount <= allowance[_from][msg.sender], "Insufficient allowance");
    require(_amount > 0, "Amount must be greater than zero");

    balanceOf[_from] -= _amount;
    balanceOf[_to] += _amount;
   // allowance[_from][msg.sender] -= _amount;

    emit Transfer(_from, _to, _amount);

    return true;
}

   function approve(address _spender,uint256 _amount) public returns (bool sucess){
    allowance[msg.sender][_spender] = _amount;
    emit Approve(msg.sender, _spender, _amount);
    return true;
   }


}