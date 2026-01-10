pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Operations with Ethereum API
    - Query state of a node
    = Get state of an Ethereum network (may be stale at the time of checking)
    - Send transactions, deploy contracts
    - Manage accounts

Note: When sending trasnactions 2 options:
- we can sign a transaction adn send to client
- we can send unsigned transaction to a client for signing

JSON-RPC API
web3_clientVersion -> Get a client's version
net_peerCount -> Get number of connected peers
eth_getBlockByHash -> as name implies
eth_getBlockByNumber -> as name implies
eth_sendTransaction 

Note: Normally using geth or other local client requires 50GB + space even with testnets. 

Note: Instead infura (metamask developer) APIs used -> which manage the node for you, and allows
interaction with web3 api of the node.

Note: The way the API is called thru infura is -> we need an execution client library to 
communicate to the client as below: 
    - Web3.js -> javascript
    - Netherium -> .net 

We need to compile the solidity project to bytecode and abi -> and then use raw files thru client 
libraries to connect. Also we need to have secret key exported from metamask, which will be used
to sign transactions locally... 



*/