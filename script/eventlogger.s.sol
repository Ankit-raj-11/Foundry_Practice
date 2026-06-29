// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Eventlogger} from "../src/eventlogger.sol";

contract DeployEventlogger is Script {
    function run() external {
        uint deployedPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployedPrivateKey);

        Eventlogger logger = new Eventlogger();

        logger.broadcast("hello its my first deployment script");

        vm.stopBroadcast();
        
    }
}



