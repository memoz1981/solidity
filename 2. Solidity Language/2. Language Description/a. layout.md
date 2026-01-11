### Layout of a Solidity File

#### SPDX License Identifier 
May be placed anywhere -> best practice on the top of the file
Most common: 
- MIT -> free use, modificatione etc
- Apache-2.0 -> similar to MIT but with explicit patent/trademark protections
- UNLICENSED -> Proprietary code
- SEE LICENSE IN <filename> -> A custom/non standard license

#### Pragmas
- Local to files -> imported files don't import the pragmas
- To enable certain compiler features/checks

##### Version Pragma
Ensures compilation with the "right" version compiler. 
- ^0.8.0 -> any 0.8.x version
- >=0.8.0 <0.9.0 -> range
- 0.8.19 -> exact version

##### ABI Coder Pragma
v2 is default starting 0.8.0

- pragma abicoder v1
- pragma abicoder v2

#### Importing other source files
-- import "fileName" -> imports all symbols from the fileName including imported there -> Not recommended
-- import * as symbolName from "fileName" -> functionally similar to above -> but this time symbols are available with symbolName.symbol
-- import "fileName" as symbolName -> same as above
-- import symbol from "fileName" -> to import a specific symbol
-- import {symbol1 as alias1, symbol2} from "fileName" -> if symbol1 exists here, it can be important with an alias. 

**Note:** Symbol above refers to any named entity: struct, library, enum, event, function etc. 

**Note:** To resolve the file path, the compiler keeps a virtual filesystem (VFS):
- "./Token.sol" -> relative path, same directory
- "../interfaces/IER20.sol" -> relative path
- "@openzeppelin/contracts/token/ERC20/ERC20.sol" -> direct imports using remappings
- "contracts/Token.sol" -> absolute paths
- "https://..." -> URL style importa
- "hardhat/console.sol" -> node module style
- etc.

#### Comments
- // -> Single Line
- /* ... */ -> Multi line
**Note:** A single-line comment is terminated by any unicode line terminator (LF, VF, FF, CR, NEL, LS or PS) in UTF-8 encoding.  



