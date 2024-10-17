// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract IDToAddressMapping {
    mapping(uint => address) public idToAddress;
    function setIDToAddress(uint _id, address _address) public {
        idToAddress[_id] = _address;
    }
    function getAddressByID(uint _id) public view returns (address) {
        return idToAddress[_id];
    }
}
