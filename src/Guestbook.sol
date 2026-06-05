// SPDX-License-Identifier: UNLICENSEDd
pragma solidity ^0.8.13;

contract Guestbook {

    struct Entry {
        address signer;
        string name;
        string message;
    }
    Entry[] public entries;
    function sign(string memory _name, string memory _message) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        entries.push(Entry({
            signer: msg.sender,
            name: _name,
            message: _message
        }));
    }
    function getEntryCount() public view returns (uint256) {
        return entries.length;
    }
}