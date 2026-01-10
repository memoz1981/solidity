pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

// structs are just like classes but don't define any functions
// only data storage
// can be nested
// no inheritance
struct User {
    string name; 
    uint8 age; 
}

contract Structs {

    // structs can be initialized either like below
    User user1 = User("John", 35); 

    // or like below
    User user2 = User(
        {
            name: "John", 
            age: 35
        }); 

    function getStructValue() public view returns(uint) {
        return user1.age; 
    }

    function setStructValue() public {
        user2.name = "Malkovich"; 
    }
}