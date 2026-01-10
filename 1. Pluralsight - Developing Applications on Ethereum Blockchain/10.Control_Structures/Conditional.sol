pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Conditional {
    bool isTrue; 
    uint value; 

    uint result; 

    function check() public {
        if(isTrue) // only boolean expressions 
        {
            result = 1; 
        }
        else if(value > 1)
        {
            result = 0; 
        }
        else if(value == 1)
        {
            result = 2; 
        }
        else
        {
            result = 3; 
        }
    }

    // Note: str1 == str2 is not supported
    // instead can/should use hash functions (keccak)
    // note that keccak accepts bytes 
    string name1 = "name1";
    string name2 = "name2";
    string name3 = "name3";
    string name4 = "name4"; 
    function compareStrings() public view returns (bool) {
       
        if(keccak256(abi.encodePacked(name1)) == keccak256(abi.encodePacked(name2)))
        {
            return true; 
        }
        
        if(keccak256(bytes(name3)) == keccak256(bytes(name4)))
        {
            return true; 
        }

        return false; 
    }
}

