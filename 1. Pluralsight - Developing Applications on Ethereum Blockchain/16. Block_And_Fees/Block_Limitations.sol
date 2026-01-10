pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
- Blocks don't include all transactions from the pool
- Limited to 30_000_000 gas total 
- Above limit was increased multiple times and is set by the architecture

Note: Minors (previously) and now validators decide: 
- Which transactions to include
- The order of the transactions -> so it's not a repeatable process... 

*/