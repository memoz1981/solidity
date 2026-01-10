pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

//custom error are just like exceptions in c#. 

error DuplicateError(uint pos, uint val); 

error CustomError(); 

contract HashStorage {
    uint[] array; 

    function store(uint val) public pure {
        revert DuplicateError({
            pos: 0, 
            val: val
        });
    }
}

// Note: old solidity code had throw; just like C#  