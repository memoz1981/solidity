pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract DynamicArrays {
    // anything declared here is storage arrays -> and copy doesn't copy full array, just adds 
    // new element and references the new location
    // to access the respective index of the array 
    // slot = keccak256(slot_number) + index
    // is called ... 

    // on the other hand anything that lives only in functions are memory arrays
    // which are just like c#, full array is copied when pushed a new element... 
    uint[] dynamic1; //empty array
    uint[] dynamic2 = new uint[](2); // dynamic array with initial size of 2

    // operations

    // length
    function getDynamic1Length() public view returns (uint) {
        return dynamic1.length; 
    }

    // get
    function getDynamic1(uint index) public view returns (uint) {
        // require can the be try catched (Error rather than Exception) by caller...
        require(index < dynamic1.length, "index out of bounds"); 
        return dynamic1[2]; 
    }
    
    // set
    function setDynamic2(uint index, uint value) public {
        require(index < dynamic2.length, "same as above"); 
        dynamic2[index] = value; 
    }

    // push new element and get new size. 
    function pushToDynamic1(uint value) public returns(uint) {
        dynamic1.push(value); 
        return dynamic1.length; 
    }

    // pop the last element from the array -> doesn't return anything
    function popFromDynamic2() public returns (uint) {
        require(dynamic2.length > 0, "Array should not be empty"); 
        dynamic2.pop(); 
        return dynamic2.length; 
    }
}