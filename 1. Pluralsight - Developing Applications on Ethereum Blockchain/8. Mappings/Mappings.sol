pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

// same as dictionary in C# (key-value pairs)
// mapping ([key-type] => [value-type]) mapName; 
contract Mappings {
    mapping (string => uint) scoreFor; 

    function addMapping(string memory key, uint value) public {
        scoreFor[key] = value;  
    } 

    function getMapping(string memory key) public view returns (uint) {
        return scoreFor[key]; // will not throw an error if key doesn't exist, will return default
    }

    

}