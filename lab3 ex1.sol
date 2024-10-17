 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.18;
 contract arrayy
 {
    uint[4] public arr1 = [1,2,3,4];
   // Constructor to initialize the 0th and 3rd element
    constructor() {
        arr1[0] = 2;
        arr1[3] = 10;
    }
    function convert_ind_0and3() public {
        arr1[0]=2;
        arr1[3]=10;
    }
    // c) Make a getter function for arr1
    function getArr1() public view returns (uint[4] memory) {
        return arr1;
    }
 }