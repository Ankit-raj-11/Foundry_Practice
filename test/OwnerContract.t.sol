// SPDX-License-Identifier: UNLICENSEDdvfs
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Owner} from "../src/OwnerContract.sol";

contract OwnerContractTest is Test {
    Owner public ownerContract;

    function setUp() public {
        ownerContract = new Owner();
    }

    function test_initialStat() public view{
        assertEq(ownerContract.owner(), address(this));
        assertEq(ownerContract.message(), "Hello world");
    }

    function test_CanOwnerUpdateMessage() public {
        ownerContract.updateMessage("I am Ankit");
        assertEq(ownerContract.message(),"I am Ankit");
    }

    function test_notOwnerChecking() public {
        address hacker = address(0x2566);
        vm.prank(hacker);
        vm.expectRevert("Not the owner");
        ownerContract.updateMessage("I hacked you ");
    }

}