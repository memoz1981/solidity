pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Forks -> Temporary disagreements between peers

Node a ->   Block3 -> Block 2 -> Block 1
Node b -> Block4 -> Block3 -> Block2 -> Block1
Node c -> ... 

above different chains are called forks (just like branches in git)

Note: The "main" chain is called canonical chain, and determination is different between systems. 

Note: Convention was to treat longest chain as canonical chain pre-Merge in Ethereum. 

Note: It's important to "know" the canonical chain -> new block will be added to that chain.

Double Spend Attack
- Generate a longer chain undoing your last expendures by adding empty blocks... 

To overcome that -> there are consensus mechanisms to "select a leader" that will generate
the block(s) as below: 
    - Proof of Work
    - Proof of Stake

*/