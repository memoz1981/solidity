pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Loops {
    uint initial = 0; 

    function whileLoop() public {
        while(initial < 5)
        {
            initial = initial + 1; 
        }
    }

    function doWhileLoop() public {
        do 
        {
            initial = initial + 1; 
        }
        while(initial < 5); 
    }

    function forLoop() public {
        for(uint i = 0; i < 5; i = i + 1)
        {
            if(i == 6)
            {
                break; //same as other languages
            }

            if(i == 2)
            {
                continue; //same as other languages
            }
            
            initial = i; 
        }
    }


}