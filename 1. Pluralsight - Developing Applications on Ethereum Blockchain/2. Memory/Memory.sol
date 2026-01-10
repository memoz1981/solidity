pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Memory {
    // 3 types of memory in solidity
    // 1. Memory -> for fuction memory (low cost, temporary variables, for duration of call)
    // 2. Storage -> Contract Stage (High cost, persistent between calls)
    // 3. Calldata -> function parameters (cheapest, immutable)

    uint[] arr; //storage by default - cannot be other type

    function update() public {
        // Solidity requires explicit `memory` or `storage` for local array variables.
        // uint[] array = arr; -> invalid

        // cannot declare type as calldata
        //uint calldata cArray = arr; 

        uint[] memory mArray = arr; // when memory is specified -> it copies storage array into memory
        mArray[0] = 1; // storage array arr is not updates as above just copies storage array 

        uint[] storage sArray = arr; // now this is a reference assignment
        sArray[0] = 1; // this will in turn mutate the original arr...  
    } 

    // reference parameters in functions need to be specified as
    // either memory or calldata -> the latter being immutable
    // function method(uint[] memory arr)
    // function method(uint[] calldata arr)

    // reference return values in functions same - either memory or calldata
    // function method returns(uint[] memory)
    // function method returns(uint[] calldata)
}