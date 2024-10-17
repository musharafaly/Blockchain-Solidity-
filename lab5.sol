// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LedgerBalance{
    mapping (address => uint) public balances;
    
    function updateBalance(uint newBalance) public {
        balances[msg.sender] = newBalance;
    }
}
contract Updater{
    function updateBalance() public returns (uint) {
        LedgerBalance LedgerBalancee = new LedgerBalance();
        LedgerBalancee.updateBalance(10);
        return LedgerBalancee.balances(address(this));
    }
}