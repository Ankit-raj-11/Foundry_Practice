// SPDX-License-Identifier: UNLICENSEDdvfs
pragma solidity ^0.8.13;

contract Todo {
    struct TodoItem{
        string text;
        bool isCompleted;
    }
    mapping(uint256 => TodoItem) public todo;
    uint256 public todoCount;

    function addTodo(string memory _text) public {
        todoCount +=1;
        todo[todoCount] = TodoItem({
            text: _text,
            isCompleted: false
        });
    }
    function toggleComplete(uint256 _id) public {
        require(bytes(todo[_id].text).length > 0, "Todo does not exist");
        todo[_id].isCompleted = !todo[_id].isCompleted;
    }
}
