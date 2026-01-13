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

    function test_shift_right_without_underflow() pure public {
        //arrange
        int8 a = 88; // 01011000, (8 + 16 + 0 + 64) = 88 = 11 x 2e3 
        int8 b = 11; // 00001011, 1 + 2 + 8 = 11
        
        //act
        int8 result = a >> 3;
        int8 result2 = a / 8;  

        //assert
        assert(result == b);
        assert(result2 == b);
    }

    function test_shift_right_with_underflow() pure public {
        //arrange
        int8 a = 88; // 01011000, (8 + 16 + 0 + 64) = 88 = 11 x 2e3 
        int8 b = 5; // 00000101, 1 + 4 = 5
        
        //act
        int8 result = a >> 4;
        int8 result2 = a / 16;  

        //assert
        assert(result == b);
        assert(result2 == b);
    }

    function test_arithmetic_signed_not_overflow_when_carry_out_same_with_carry_in() pure public
    {
        //arrange
        int8 a = -1; // 11111111
        int8 b = 1; // 00000001
        
        //act
        int8 result = a + b; //100000000 -> carry out 1, carry in 1 -> no overflow

        //assert
        assert(result == 0);
    }

    function test_arithmetic_unchecked_may_cause_overflow() pure public
    {
        //arrange
        int8 a = 127; // 01111111
        int8 b = 1; // 00000001
        int8 result;
        
        //act
        unchecked {result = a + b;} //10000000 -> carry out 1, carry in 1 -> no overflow

        //assert
        assert(result == -128);
    }

    function test_arithmetic_division_should_round_towards_zero() pure public
    {
        //arrange
        int8 a = 5; 
        int8 b = -5; 
        
        //act
        int8 resulta = a / 2; 
        int8 resultb = b / 2; 

        //assert
        assert(resulta == 2);
        assert(resultb == -2);
    }

    function test_arithmetic_module_has_same_sign_as_left_operand() pure public
    {
        //arrange
        int8 a = 5; 
        int8 b = -5; 
        
        //act
        int8 resulta = a % 3; 
        int8 resultb = b % 3; 

        //assert
        assert(resulta == 2);
        assert(resultb == -2);
    }

    function test_arithmetic_zero_exp_zero_is_one() pure public
    {
        //arrange
        
        //act
        int8 result = 0**0; 

        //assert
        assert(result == 1);
    }

    function test_arithmetic_exp_results_in_same_type_as_base() pure public
    {
        //arrange
        int8 a = 2; 
        
        //act
        unchecked {
            assert(a ** 8 == 0); // results in overflow to 100000000 -> 0 for int8
        }
    }
}