// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Owner {
    address public owner;
    string public message;

    constructor() {
        owner = msg.sender;
        message = "Hello world";
    }

    function updateMessage(string memory _message) public {
        require(msg.sender == owner, "Not the owner");
        message = _message;
    }
     
}