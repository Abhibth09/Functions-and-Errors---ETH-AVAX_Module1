# Functions-and-Errors---ETH-AVAX_Module1

This Solidity smart contract demonstrates error handling techniques using the require, assert, and revert statements. The contract allows the admin to mint and burn tokens, ensuring certain conditions are met before executing the actions.

# Getting Started
To get started with this project, follow the steps below to set up, deploy, and interact with the smart contract using the Remix IDE.

# Setting up Remix
Open Remix IDE: Open your web browser and navigate to Remix IDE.

Create a New File: In Remix, create a new file with a .sol extension, for example, ErrorHandling.sol.

# solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandling {
    uint256 public balance;

    // Event declarations
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);
    event ValueChecked(address indexed user, uint256 value, bool valid);
    event RevertTriggered(string reason);

    // Constructor to set the initial balance
    constructor(uint256 _initialBalance) {
        balance = _initialBalance;
    }

    // Function to deposit funds
    function deposit(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero.");
        balance += amount;
        emit Deposit(msg.sender, amount);
    }

    // Function to withdraw funds
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than zero.");
        require(amount <= balance, "Insufficient balance.");

        balance -= amount;
        emit Withdrawal(msg.sender, amount);

        // Using assert to ensure balance is never negative
        assert(balance >= 0);
    }

    // Function to check a value and potentially revert based on multiple conditions
    function checkValueAndRevert(uint256 value) public {
        // Revert if the input value is less than 50
        if (value < 50) {
            emit RevertTriggered("Input value must be at least 50.");
            revert("Input value must be at least 50 to proceed.");
        }
        // Revert if the input value is greater than 1000
        if (value > 1000) {
            emit RevertTriggered("Input value must not exceed 1000.");
            revert("Input value must not exceed 1000.");
        }

        // Emit an event indicating the value was valid
        emit ValueChecked(msg.sender, value, true);
    }

    // Function to simulate an unexpected situation
    function unexpectedCondition() public pure {
        uint256 a = 1;
        uint256 b = 2;
        
        // Assert is used to check for conditions that should never be false
        assert(a + b == 3);
        
        // This will trigger an assert failure
        assert(a + b == 4);
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

Deposit() Function:Emitted when a user deposits funds.
Withdrawl() Function: Emitted when a user withdraws funds.
ValueChecked() Function: Emitted when a user checks a value and it is valid.
RevertTriggered() Function: Emitted when a revert is triggered, with the reason for the revert.

# Error Handling Overview
require(): Used to validate input conditions or contract preconditions. If the condition is not met, it throws an error and reverts the transaction.
assert(): Used to check for internal errors. It should only be used for conditions that should never be false. If the condition is false, it indicates a bug in the contract.
revert(): Explicitly reverts the transaction, usually due to a requirement violation or an exceptional condition.
These error-handling mechanisms help ensure the contract's integrity and provide meaningful feedback to users interacting with the contract.

# Author
Kumar Abhishek Anand
