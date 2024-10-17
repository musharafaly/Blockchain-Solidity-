// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract array {
    uint256[] public arr;
    function pushh(uint256 _x) public {
        arr.push(_x);
    }
    function popp() public {
        arr.pop();
    }
    function deletee(uint256 _index) public {
        delete arr[_index];
    }
    function getlength() public view returns (uint256) {
        return arr.length;
    }
    function getFullArray() public view returns (uint256[] memory) {
        return arr;
    }
    function udelete1() public {
        delete arr;
    }
}