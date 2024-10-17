// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract WalletAddress {
    
    // Define the wallet address
    address public myAddress = 0xfA6139F37BC7113ac1437d113BF3c57A08C7698c;

    // Members of address
    // Get the balance of the address
    uint256 public balance = myAddress.balance;
}
