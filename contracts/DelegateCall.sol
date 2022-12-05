// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract TestDelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    //     function setVars(address _test, uint256 _num) external payable {
    // (bool success, ) = _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
    // require (success, "delegatecall failed");

    function setVars(address _test, uint256 _num) external payable {
        (bool success, ) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}
