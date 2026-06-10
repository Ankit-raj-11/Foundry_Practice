// SPDX-License-Identifier: UNLICENSEDdvfs
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Guestbook} from "../src/Guestbook.sol";

contract GuestBookTest is Test {
    Guestbook public guest;

    function setUp() public {
        guest = new Guestbook();
    }
    function test_name() public {
        vm.expectRevert("Name cannot be empty");
        guest.sign("", "hello");
    }
    function test_Entry() public {
        guest.sign("Ankit", "Hello jii");

        (
            address actualSigner,
            string memory actualName,
            string memory actualMessage
        ) = guest.entries(0);

        assertEq(actualSigner, address(this));
        assertEq(actualName, "Ankit");
        assertEq(actualMessage, "Hello jii");
    }

    function test_count() public{
        assertEq(guest.getEntryCount(), 0);
        guest.sign("Ankit", "Hello jii");
        assertEq(guest.getEntryCount(), 1);
        address dev = address(0x778);
        vm.prank(dev);
        guest.sign("Dev", "i am dev");
        assertEq(guest.getEntryCount(), 2);
    }
}