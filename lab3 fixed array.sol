// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract fixedarray
{
    uint256[2] public arr2 = [1, 2];
    function get2() public view returns (uint256[2] memory) {
        return arr2;
    }
}