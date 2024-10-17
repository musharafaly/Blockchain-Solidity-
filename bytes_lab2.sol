// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract bytess {
 
    //   question2
    uint256[] myarray;

    function addtoarray(uint256 number) public returns (uint256, uint256) {
        myarray.push(number);
        return (number, myarray.length);
    }

    function ViewMyarray() public view returns (uint256[] memory, uint256) {
        return (myarray, myarray.length);
    }

    function getarrayvalue(uint256 index) public view returns (uint256) {
        return myarray[index];
    }

    function popValue() public {
        myarray.pop();
    }

    function deleteItem(uint256 index) public {
        delete myarray[index];
    }

}
