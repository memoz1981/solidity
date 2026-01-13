### Types

- The concept of 'undefined' or 'null' value doesn't exist in solidity -> every declared variable is assigned its default value

#### Value Types
- Always passed by value
- Unlike ref types -> declarations don't specify a storage location, stack by default, except for state variables which are stored in storage by default. (can also be marked as transient, constant or immutable)

**Booleans**
```solidity
bool a; 
```
- Operators are just like C# (or other languages): !, &&, ||, ==, != 
**Note:** a = b || f(x) -> f(x) will not be evaluated if b is true (short circuiting rules)

**Integers**
- int8 to int256 in increments of 8 (int 8 -> [-2e7 -> 2e7 - 1])
- uint8 to uint256 in increments of 8 (uint256 -> [0 to 2e256 - 1])

Operators:
- Comparison (>, <, , >=, <=, ==, !=) -> bool
- Bit Operations (& -> Bitwise AND, | -> Bitwise OR, ^ -> Bitwise XOR, ~ -> Bitwise Negation)
- Shift Operations (<< -> left shift, >> -> right shift)
- Arithmetic Operations (+,-,*,/, % (modulo), ** (exp), (unary - for signed int (-5)))
- Additionally -> for integer type X -> type(X).min / type(X).max -> returns min/max values

**Note:** For arithmetic -> checked/unchecked -> By default the arithmetic is checked -> so overflow will revert. 

**Note**: Solidity uses two-completement representation -> for uint it doesn't matter -> it starts with 0 goes till last. But for int -> first bit represents sign 1 for minus 0 for plus. Imagine a uint9 type, then: 
0x100 -> -256
0x1FF -> -1
0x000 -> 0
0x001 -> 1
0x0FF -> 255

**Convert negative number to bits**
abs(number) -> ~ -> +1 
(int8)(-1) -> 00000001 -> 11111110 -> 11111111 = 0xFF

**Convert bits to numbers for signed**
value = bits - 2^n; 
1111111 -> 127 - 128 = -1

**Note:** Shift is allowed only bu unsigned types -> the left operand will be truncated to match the type (limits). 

x << y = x * 2ey + truncated to the type of x. 
x >> y = x / 2ey + rounded towards negative infinity (i.e. down) (before version 0.5.0 it was being rounded up rather than down)

Overflow checks are not done for shifts -> instead the result is being truncated. 

(uint8)5 << 4 = 00000101 << 4 = 01010000 = 2e6 + 2e4 = 80 = 5 * 2e4
(uint8)81 >> 4 = 01010001 >> 4 = 00000101 = 5 = 81 / 5 rounded down = 16

**Note:** When using unary - -> i.e. -5 or -(-5) = 5 -> it's only allowed for signed integers. 
x = type(int8).min -> unchecked {-x} -> this will cause overflow

**Note:** Arithmetic operations for signed integers in two-complement system will assess overflow by carry-in and carry-out from most significant bit. 
For example for int8s -> 11111111 (-1) + 00000001 (1) = 100000000 -> but it's not overflow as carry in bit = 1 and carry out bit = 1
But 01111111 (127) + 00000001 (1) = 11111111 -> carry-in = 1, carry-out not there so default 0 -> overflow. 
Note: Tricky to test checked overflow...

**Note:** For unsigned integers -> overflow detected if the size is exceeded (anything carried out -> overflow)

**Division** 
- by zero -> panic error
- rounded towards zero
a) -5/2 = -4/2 = 2
b) 5/2 = 4/2 = 2
- int.min / -1 -> checked reverted, unchecked results in incorrect result int.min

**Modulo**
- follows the same size as its left operand

**Exponent**
- type of result = type of base
- exponent -> only unsigned integers are allowed
- 0**0 = 1

**Fixed Point Numbers**
- Similar to float/double
- Limited support -> can be declared but cannot be assigned to / from (how)
- ufixedMxN (unsigned) and fixedMxN (signed)
- M -> number of bits taken by the type, 8-256 in increments of 8
- N -> how many decimal points are supported -> 0-80

**Address**
- Two subtypes: 'address' and 'address payable'
- address: 20 byte value (cannot send ether)
- address payable -> similar to address + transfer/send members (can send ether)
- Conversion to address implicit, to address payable explicit. 

**Members of Addresses**
- balance -> address.balance
- 3 methods to send funds: 
a) transfer -> (address payable).transfer(0.5 ether) -> fixed to 2300 GAS -> will revert on failure. deprecated as most operations required > 2300 GAS
b) send -> similar to above with one difference -> it doesn't revert -> but return false
c) call -> modern method -> doesn't revert -> can optionally provide gas limit. 
(bool success, bytes memory data) = recipient.call{value: amount}(""); 

**Note:** 2300 was for re-entrancy protection
**Note:** EIP-150 rule -> when making an external call -> can only forward 63/64 of remaining gas.  

- transfer -> (address payable).transfer(0.5 ether);
Note that if not enough balance or the address rejects -> the transaction reverts. Gas is used for reverted transactions. 



