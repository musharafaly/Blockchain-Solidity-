// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract A {
    string public hello;

    constructor() {
        hello = "hello raweel";
    }
    function setHello(string memory _Set) public {
        hello = _Set;
    }
}
