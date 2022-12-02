// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Event {
    event Log(string message, uint256 value);
    event IndexedLog(address indexed sender, uint256 value);

    function example() external {
        emit Log("log", 123);
        emit IndexedLog(msg.sender, 345);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata _message) external {
        emit Message(msg.sender, _to, _message);
    }
}
