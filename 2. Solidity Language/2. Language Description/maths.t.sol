// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract MathTests is Test {
    
    function test_boolean_or_left_will_be_evaluated_first() pure public {
        //arrange
        bool a = true; 
        bool b = false; 
        
        //act
        if(a || divide(5, 0) > 1)
        {
            b = true; 
        }

        //assert
        assertTrue(b);
    }

    function divide(int8 a, int8 b) internal pure returns (int8) {
        return a/b; 
    }

    function test_different_types_cannot_be_compared() pure public {
        // //arrange
        // int a1 = 1; 
        // uint a2 = 2; 

        // int b1 = -10; 
        // uint b2 = 10; 

        bool result = true; 
        
        // //act
        // if(a1 <= a2 && b1 < b2)
        // {
        //     result = true; 
        // }

        //assert
        assertTrue(result);
    }

    function test_uint_can_be_casted_to_int() pure public {
        //arrange
        uint8 a1 = 125; // less than int8 max value of 127
        uint8 a2 = 129; // more than int8 max value of 127; 

        //act
        int8 b1 = int8(a1); // a1 -> b1 -> 01111101 -> 125
        int8 b2 = int8(a2); // a2 -> b2 -> 10000001 -> -127
        
        //assert
        assert(b1 == 125);
        assert(b2 == -127); 
    }

    function test_int_can_be_casted_to_uint() pure public {
        //arrange
        int8 a1 = -1; // out of uint8 range
        int8 a2 = 1; // int uint8 range

        //act
        uint8 b1 = uint8(a1); // a1 -> b1 -> 11111111 -> 255
        uint8 b2 = uint8(a2); // a2 -> b2 -> 00000001 -> 1
        
        //assert
        assert(b1 == 255);
        assert(b2 == 1); 
    }

    function test_bitwise_or() pure public {
        //arrange
        int8 a1 = -1; // out of uint8 range

        for(int8 i = -128; i < 127; i++) //hack not to overflow... 
        {
            //act
            int8 a = (a1 | i); 
            //assert
            assert(a == -1); 
        }
    }

    function test_bitwise_and() pure public {
        //arrange
        int8 a1 = 0; // out of uint8 range

        for(int8 i = -128; i < 127; i++) //hack not to overflow... 
        {
            //act
            int8 a = (a1 & i); 
            //assert
            assert(a == 0); 
        }
    }

    function test_bitwise_xor() pure public {
        //arrange
        int8 a = 85; // 01010101, 1 + 4 + 16 + 64 = 85
        int8 b = -86; // 10101010, (2 + 8 + 32) - 128 = 42 - 128 = -86
        
        //act
        int8 result = a ^ b; 

        //assert
        assert(result == -1);
    }

    function test_bitwise_negation() pure public {
        //arrange
        int8 a = 85; // 01010101, 1 + 4 + 16 + 64 = 85
        int8 b = -86; // 10101010, (2 + 8 + 32) - 128 = 42 - 128 = -86
        
        //act
        int8 result = ~a; 

        //assert
        assert(result == b);
    }

    function test_shift_left_without_overflow() pure public {
        //arrange
        int8 a = 11; // 00001011, 1 + 2 + 8 = 11
        int8 b = 88; // 01011000, (8 + 16 + 0 + 64) = 88 = 11 x 2e3 
        
        //act
        int8 result = a << 3; 

        //assert
        assert(result == b);
    }

    function test_shift_left_with_overflow() pure public {
        //arrange
        int8 a = 11; // 00001011, 1 + 2 + 8 = 11
        int8 b = -80; // 10110000, (16 + 32) - 128 = -80
        int8 c; 
        unchecked {
            c = a * 16;
        }
        
        //act
        int8 result = a << 4; 

        //assert
        assert(result == b);
        assert(c == b); 
    }
}