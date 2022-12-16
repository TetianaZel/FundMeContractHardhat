// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract CallTestContract {
    function setX(address _test, uint _x) external {
        TestContract(_test).setX(_x);
    }

    function getX(address _test) external view returns (uint) {
        return TestContract(_test).getX();
    }

    function setXAndReceiveEther(address _test, uint _x) external payable {
        TestContract(_test).setXAndReceiveEther{value: msg.value}(_x);
    }

    function getXAndValue(
        TestContract _test
    ) external view returns (uint x, uint value) {
        (x, value) = _test.getXAndValue();
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXAndReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXAndValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
