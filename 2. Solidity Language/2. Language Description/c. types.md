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

**Division** 
- by zero -> panic error
- rounded towards zero
a) -5/2 = -4/2 = 2
b) 5/2 = 4/2 = 2
- int.min / -1 -> checked reverted, unchecked results in incorrect result int.min

**Modulo**

