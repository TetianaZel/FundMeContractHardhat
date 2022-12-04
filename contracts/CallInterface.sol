// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

interface ICounter {
    function count() external view returns (uint);

    function increment() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).increment();
        count = ICounter(_counter).count();
    }
}
