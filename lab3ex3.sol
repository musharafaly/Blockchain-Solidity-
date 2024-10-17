// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract arrayy
    //There are 4 errors in the code given below, correct them and then run the updated version of the code.
{
    int256[4] public array;

    function ipush() public {
        //we do not use push and pop function with fixed size array
        // dont initialize two elements at once
        array[0] = -5;
        array[1] = 0;
        array[2] = 5;
        array[3] = 10;
    }

    //mention array size in return of fixed size and use memory/calldata keyword
    function get() public view returns (int256[4] memory) {
        return array;
    }

    // array datatype is uint
    function getlength() public view returns (uint256) {
        return array.length;
    }
}