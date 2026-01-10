pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

// Solidity has overflow protection starting version 0.8.0
// previously there was safemath library 
// after above version, it's embedded into the language
contract Overflow {
    uint8 v = 255; 
    function shouldThrowError() public {
        v = v + 1; //this should throw an overflow error (exception)
        // was returning 0 in earlier versions
    }

    function overflowDisabled() public {
        unchecked {
            v = v + 1; // will allow the overflow...
        }
    }
}