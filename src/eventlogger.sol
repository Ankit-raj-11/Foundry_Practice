// SPDX-License-Identifier: UNLICENSEDd
pragma solidity ^0.8.13;

contract Eventlogger{
    event NewAnnouncement(uint indexed announcementId, address indexed announcer, string message);
    uint public totalAnnouncement;

    function broadcast(string memory _message) public {
        require(bytes(_message).length > 0, "message cannot be empty");
        totalAnnouncement += 1;
        
        emit NewAnnouncement(
            totalAnnouncement,
            msg.sender,
            _message
        );
    }
}