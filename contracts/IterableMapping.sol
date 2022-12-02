// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract IterableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint256 _value) external {
        balances[_key] = _value;
        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() public view returns (uint256) {
        return keys.length;
    }

    function first() external view returns (uint256) {
        return balances[keys[0]];
    }

    function last() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }

    function get(uint256 _i) public view returns (uint256) {
        return balances[keys[_i]];
    }

    function getAll() external view returns (uint256[] memory) {
        uint size = getSize();
        uint[] memory bal = new uint[](size);
        for (uint256 i = 0; i < size; i++) {
            bal[i] = get(i);
        }
        return bal;
    }
}
