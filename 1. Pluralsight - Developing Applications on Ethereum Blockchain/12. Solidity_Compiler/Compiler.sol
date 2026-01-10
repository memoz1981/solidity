pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Compiler's output: 
    - Bytecode -> which will then be deployed to Ethereum
    - Application Binary Interface (ABI) -> a json file showing the methods the contract has...
ABI seems to be like Open API. 

Installation using npm
npm install -g solc

How to compile
solcjs
    --bin \ -> generate bytecode
    --abi / -> generate ABI
    --base-path . \ -> path where the contracts are located
    Voter.sol -> contracts to compile

Note: from power shell use npx solcjs instead to bypass 
Note: from bin -> we will get files fileName_sol_contractName.bin -> for each contract under the file
Note: From abi -> we will get same with abi extension

*/