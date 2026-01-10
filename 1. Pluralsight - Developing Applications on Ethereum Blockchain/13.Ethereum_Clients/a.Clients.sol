pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*

Note: We need an ethereum client to interact with ethereum

Definitions: 

Ethereum Client: A software program that implements Ethereum protocol. 
It has: 
    - transactions
    - optionally private key(s) (of the owner of the client to sign transactions)
    - web3 api interface for communication

Note: Network users can use Etherum clients to interact with an (not the) Ethereum network
thru Web3 API.    

Ethereum Node: A computer that runs ethereum client. 

Note: Ethereum network is a set of ethereum clients -> Note that there's no server -> all clients
since it's a distributed ownerless system. 

Node Types: 
a) Full Node:
    - Stores full blockchain data
    - Verifies all blocks
    - Provides data (current state of the network)
b) Light Node
    - Don't download full blocks, instead download block headers
    - Don't verify blocks
c) Archive Node
    - Stores everything full node stores + Stores historical data
    - Importantly it doesn't take part in verifications/validations

To run your own ethereum node, you need to run 2 types of clients: 
    - Execution client (before the merge only this was required)
    - Consensus client (added after the merge)

Note: Light nodes don't have consensus clients and for archive nodes it's optional. 

Ethereum client implementations
Note: There's no single implementation -> both for consensus and execution

Execution Clients: 
    - Geth (Go) -> most popular
    - Erigon (Go), etc. 
    - Nethermind (C#)

Consensus Clients: 
    - Prysm (Go) -> most popular
    - Lighthouse (Rust)
    - There's no C# implemtation (widespread, production)

Note: All clients above implement Ethereum specification
Note: Having client diversity helps to have better robustness. 
*/