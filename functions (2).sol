// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OwnershipSupplyExample {
    address public admin;
    uint256 public supply;
    mapping(address => uint256) public accountBalances;

    event TokensTransferred(address indexed from, address indexed to, uint256 value);
    event TokensMinted(address indexed to, uint256 value);
    event TokensBurned(address indexed from, uint256 value);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Caller is not the admin");
        _;
    }

    function createTokens(address recipient, uint256 amount) public onlyAdmin {
        require(recipient != address(0), "Cannot mint to the zero address");
        supply += amount;
        accountBalances[recipient] += amount;
        emit TokensMinted(recipient, amount);
        emit TokensTransferred(address(0), recipient, amount);
    }

    function destroyTokens(uint256 amount) public onlyAdmin {
        require(amount <= accountBalances[msg.sender], "Insufficient balance to burn");
        supply -= amount;
        accountBalances[msg.sender] -= amount;
        emit TokensBurned(msg.sender, amount);
        emit TokensTransferred(msg.sender, address(0), amount);
    }

    function validateInvariant() public view {
        assert(supply >= 0);
    }

    function triggerRevert() public pure {
        revert("This function always reverts");
    }
}