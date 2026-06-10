// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Eventlogger} from "../src/eventlogger.sol";

contract EventLoggerTest is Test {
    Eventlogger public logger;
    event NewAnnouncement(uint indexed announcementId, address indexed announcer, string message);

    function setUp() public {
        logger = new Eventlogger();
    }

    function test_broadcast() public {
        vm.expectEmit(true, true, false, true);
        emit NewAnnouncement(1, address(this), "hello");
        logger.broadcast("hello");
        assertEq(logger.totalAnnouncement(), 1);
    }
}
