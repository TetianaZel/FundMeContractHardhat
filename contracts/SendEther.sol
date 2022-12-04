// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SendEther {
    constructor() payable {}

    receive() external payable {}

    function sendByTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendBySend(address payable _to) external payable {
        bool sent = _to.send(123);
        require(sent, "Send failed");
    }

    function sendByCall(address payable _to) external payable {
        (bool success, ) = _to.call{value: 123}("");
        require(success, "Call failed");
    }
}

contract EthReceiver {
    event Log(uint amount, uint gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
