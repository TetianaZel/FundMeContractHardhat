// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function fund() external payable {}
}
