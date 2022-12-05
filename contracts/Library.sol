// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint256 x, uint256 y) external pure returns (uint256) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(
        uint256[] storage arr,
        uint256 a
    ) internal view returns (uint256) {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == a) {
                return i;
            }
        }

        revert("Element not found");
    }
}

contract TestArray {
    using ArrayLib for uint256[];
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256 i) {
        return arr.find(2);
    }
}
