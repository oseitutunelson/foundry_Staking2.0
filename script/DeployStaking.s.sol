//SPDX-License-Idnetifier:MIT

pragma solidity ^0.8.18;

import {Script} from 'forge-std/Script.sol';
import {DecentralizedStaking} from '../src/DecentralizedStaking.sol';
import {Cheddar} from '../src/Cheddar.sol';
import {RewardToken} from '../src/RewardToken.sol';

contract DeployStaking is Script{
    DecentralizedStaking decStake;
    RewardToken rwd = new RewardToken();
    Cheddar cheddar = new Cheddar();

    function run() external returns (DecentralizedStaking){
       vm.startBroadcast();
       decStake = new DecentralizedStaking(cheddar,rwd);
       vm.stopBroadcast();
       return decStake;
    }
}