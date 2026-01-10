pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Constructors {
    // similar to other OO languages
    // except it can have only 1 constructor in solidity... 

    string value; 
    constructor (string memory _value) {
        value = _value; 
    }

    // Immutable variables
    uint constant MAX_VAL = 10; // cannot change in contructor
    uint immutable maxVal; // can be ONLY changed within a constructor
}