// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ownable{
    address public owner;
    event Ownershiptranferred(address indexed perviousOwner,address indexed newOwner);
    constructor() {
        owner=msg.sender;
        emit Ownershiptranferred(address(0), owner);
    }
    modifier onlyowner(){
        require(msg.sender==owner,"Ownable: caller is not owner");
        _;
    }
    function ownershiptransfer(address newOwner)public onlyowner{
        require(newOwner!=address(0),"new owner is zero address");
        emit Ownershiptranferred(owner, newOwner);
        owner=newOwner;
    }
}