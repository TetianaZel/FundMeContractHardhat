// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract ToDoList {
    struct ToDo {
        string taskDescription;
        bool status;
    }

    ToDo[] todos;

    function create(string calldata _taskDescription) external {
        todos.push(ToDo(_taskDescription, false));
    }

    function updateDescription(
        string calldata _newDescription,
        uint _id
    ) external {
        todos[_id].taskDescription = _newDescription;
    }

    function get(
        uint _id
    ) external view returns (string memory description, bool status) {
        ToDo storage todo = todos[_id];
        return (todo.taskDescription, todo.status);
    }

    function changeStatus(uint _id) external {
        todos[_id].status = !todos[_id].status;
    }
}
