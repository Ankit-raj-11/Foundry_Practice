// SPDX-License-Identifier: UNLICENSEDdvfs
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Todo} from "../src/todo.sol";

contract TodoTest is Test {
    Todo public ntodo;
    function setUp() public {
        ntodo = new Todo();
    }
    function test_addTodo() public {
        ntodo.addTodo("this is a task");
        assertEq(ntodo.todoCount(), 1);

        (string memory text, bool isCompleted) = ntodo.todo(1);
        assertEq(text, "this is a task");
        assertEq(isCompleted, false);
    }
    function test_toggling() public {
        ntodo.addTodo("clean my mess");
        ntodo.toggleComplete(1);
        (string memory text, bool isCompleted) = ntodo.todo(1);
        assertEq(text, "clean my mess");
        assertEq(isCompleted, true);
    }
    function test_InvalidId() public {
        vm.expectRevert("Todo does not exist");
        ntodo.toggleComplete(99);
    }
}