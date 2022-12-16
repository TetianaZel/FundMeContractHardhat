// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint256 amount);
    event Submit(uint256 indexed txId);
    event Approve(address indexed owner, uint256 indexed txId);
    event Revoke(address indexed owner, uint256 indexed txId);
    event Execute(uint256 indexed txId);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public requiredApprovals;

    struct Transaction {
        address to;
        uint256 value;
        bytes data;
        bool executed;
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public approved;

    constructor(address[] memory _owners, uint256 _requiredApprovals) {
        require(_owners.length > 0, "owners required");
        require(
            _requiredApprovals > 0 && _requiredApprovals <= _owners.length,
            "invalid required number of owners"
        );

        for (uint256 i; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }
        requiredApprovals = _requiredApprovals;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(
        address _to,
        bytes calldata _data,
        uint256 _value
    ) external onlyOwner {
        transactions.push(
            Transaction({to: _to, value: _value, data: _data, executed: false})
        );
        emit Submit(transactions.length - 1);
    }

    function approve(
        uint _txId
    ) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovalsCount(uint _txId) private view returns (uint count) {
        for (uint i; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                count += 1;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(
            _getApprovalsCount(_txId) >= requiredApprovals,
            "not enough approvals to execute"
        );
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "tx failed");
        emit Execute(_txId);
    }

    function revoke(
        uint _txId
    ) external onlyOwner notExecuted(_txId) txExists(_txId) {
        require(
            approved[_txId][msg.sender],
            "tx was not approved by this owner"
        );
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}
