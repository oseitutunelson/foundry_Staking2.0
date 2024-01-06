//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

/**
 * @title Decentralized Staking contract
 * @author Owusu Nelson Osei Tutu
 * @notice This contract contains the functions for staking , unstaking , depositing and rewarding users
 */

import {Cheddar} from './Cheddar.sol';
import {RewardToken} from './RewardToken.sol';

contract DecentralizedStaking{
   Cheddar public cheddar;
   RewardToken public rwd;
   address public owner;

   /** Events */
   event Deposited(address indexed _from,uint256 _value);

   address [] public stakers;

  //keep track of user balances and whether they have staked or not
   mapping (address => uint) private stakingBalance;
   mapping (address => bool) hasStaked;
   mapping (address => bool) isStaked;

   constructor(Cheddar _cheddar,RewardToken _rwd){
      cheddar = _cheddar;
      rwd = _rwd;
      //owner = msg.sender;
   }

   //depositng
   function deposit(uint256 _amount) public{
    //require(_amount > 0,"Deposited amount must be greater than zero");
    cheddar.transferFrom(msg.sender,address(this),_amount);

    stakingBalance[msg.sender] += _amount;

    if(!hasStaked[msg.sender]){
        stakers.push(msg.sender);
    }
    //update staking balance
    hasStaked[msg.sender] = true;
    isStaked[msg.sender] = true;

    emit Deposited(msg.sender,_amount);
   }

   //unstaking
   function unstakeDeposit() public{
    uint256 balance = stakingBalance[msg.sender];
    require(balance > 0,'Balance must be greater than zero');

    cheddar.transfer(msg.sender,balance);

    stakingBalance[msg.sender] = 0;

    isStaked[msg.sender] = false;
   }

   //issue Rewards
   function issueTokens() public{
      require(msg.sender == owner);
      for(uint i = 0;i < stakers.length;i++){
        address recipient = stakers[i];
        uint256 balance = stakingBalance[recipient] / 9;
        if (balance > 0){
            rwd.transfer(recipient,balance);
        }
      }
   }

   /** Getter functions */
   function getStakingBalance(address _user) external view returns (uint256){
     return stakingBalance[_user];
   }
}