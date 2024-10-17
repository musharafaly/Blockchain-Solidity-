// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Operation {
    // Boolean variable
    bool public a = false;

    // Function to perform a logical AND operation using the boolean 'a'
    function logicalAND() public view returns (bool) {
        return a && !a;
    }

    // Two unsigned integers
    uint public A;
    uint public B;

    // Function to perform AND operation on two integers
    function andOperation(uint _aa, uint _bb) public returns (uint) {
        A = _aa;
        B = _bb;
        return A & B;
    }

    // View function to return the result of the AND operation on A and B
    function viewAnd() public view returns (uint) {
        return A & B;
    }

    // Pure function to perform AND operation on two integers without state modification
    function pureAndOperation(uint _aa, uint _bb) public pure returns (uint) {
        return _aa & _bb;
    }
}
