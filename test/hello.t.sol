// SPDX-License-Identifier: UNLICENSEDdvfs
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {HelloWorld} from "../src/hello.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloworld;

    function setUp() public {
        helloworld = new HelloWorld();
    }

    function test_greeting() public view {
        assertEq(helloworld.greet(), "hellow ji");
    }
}