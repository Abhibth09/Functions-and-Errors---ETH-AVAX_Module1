# Functions-and-Errors---ETH-AVAX_Module1

This Solidity smart contract demonstrates error handling techniques using the require, assert, and revert statements. The contract allows the admin to mint and burn tokens, ensuring certain conditions are met before executing the actions.

# Getting Started
To get started with this project, follow the steps below to set up, deploy, and interact with the smart contract using the Remix IDE.

# Setting up Remix
Open Remix IDE: Open your web browser and navigate to Remix IDE.

Create a New File: In Remix, create a new file with a .sol extension, for example, OwnershipSupplyExample.sol.

# solidity

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

# Compiling the Contract
Compile the Contract:
Go to the "Solidity Compiler" tab in Remix.
Ensure the compiler version matches pragma solidity ^0.8.0;.
Click the "Compile OwnershipSupplyExample.sol" button.

# Deploying the Contract
Deploy the Contract:
Switch to the "Deploy & run transactions" tab.
Ensure the correct environment is selected (e.g., JavaScript VM, Injected Web3, etc.).
Click the "Deploy" button.

# Interacting with the Smart Contract
Interacting with the Deployed Contract:

After deployment, the contract will appear in the "Deployed Contracts" section. Expand the deployed contract to see the available functions.
Execute Functions:

createTokens() Function: Input the address to mint tokens to and the amount of tokens to mint. Click the createTokens button.
destroyTokens() Function: Input the amount of tokens to burn. Click the destroyTokens button.
validateInvariant() Function: Click the validateInvariant button to assert the total supply is non-negative.
triggerRevert() Function: Click the triggerRevert button to trigger a revert.

# Error Handling Overview
require(): Used to validate input conditions or contract preconditions. If the condition is not met, it throws an error and reverts the transaction.
assert(): Used to check for internal errors. It should only be used for conditions that should never be false. If the condition is false, it indicates a bug in the contract.
revert(): Explicitly reverts the transaction, usually due to a requirement violation or an exceptional condition.
These error-handling mechanisms help ensure the contract's integrity and provide meaningful feedback to users interacting with the contract.

# Author
Kumar Abhishek Anand
