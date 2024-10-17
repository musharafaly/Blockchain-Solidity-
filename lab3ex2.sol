// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract arrayy{
    string[] public nameArrayarr2;
    function push_Name_in_Arr(string memory Fname) public {
        nameArrayarr2.push(Fname);
    }
    function getlenofarr2() public view returns(uint){
        return  nameArrayarr2.length;
    }
    function pop_Name_in_Arr() public {
        nameArrayarr2.pop();
    }
    function returnFirstName() public view returns(string memory) {
        return nameArrayarr2[0];
    }
    function returnFullArray() public view returns(string[] memory) {
        return nameArrayarr2;
    }
}