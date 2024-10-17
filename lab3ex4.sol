// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract darrayy{
    uint[] public DynamicArray;

    function AddElement(uint element) public {
        DynamicArray.push(element);
    } 
    function RetriveFromIndex(uint index) public view returns(uint) {
        return DynamicArray[index];
    }
    function DeleteFromIndex(uint index) public {
        delete  DynamicArray[index];
    }
    function popDynamicArray() public {
        DynamicArray.pop();
    }
    function RetriveAllArray() public view returns(uint[] memory) {
        return DynamicArray;
    }
}
