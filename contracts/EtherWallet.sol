// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function widthdraw(uint256 _amount) external {
        require(msg.sender == owner, "caller is not the owner");
        payable(msg.sender).transfer(_amount);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
