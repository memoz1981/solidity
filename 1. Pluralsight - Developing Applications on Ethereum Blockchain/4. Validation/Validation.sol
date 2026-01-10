pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Validation {
    // need to reject invalid transactions

    uint value; 

    // below will check and revert the transaction including gas fee 
    // remaining gas fee is refunded
    function requireDemo(uint _value) public {
        require(value > _value, "Optional message"); 

        value = value - _value; 
    }

    // works similar to require but will will use all remaining gas
    // gas not refunded
    // protection against malicious attemps
    function assertDemo(uint _value) public {
        assert(value > _value); 
        value = value - _value; 
    }

    // unconditional revert of the transaction 
    // partial refund of remaining gas only
    // transaction reverted... 
    function revertDemo(uint _value) public {
        if(value < _value)
            revert();

        value = value - _value; 
    }
}