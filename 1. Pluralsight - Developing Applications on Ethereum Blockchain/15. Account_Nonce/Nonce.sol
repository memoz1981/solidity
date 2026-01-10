pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Nonce -> Unique ID of the transaction from an Account. 
    - Prevents double spend
    - set a new nonce to send a new transaction

Note: Ethereum network stores the next expected nonce for each account. 
When a transaction is received from that account: 
    - If expected nonce -> Execute
    - If higher than expected -> held until the expected nonce is received
    - If lower than expected -> 
        a) If the transaction is pending + new one has a higher gas price -> Execute
        b) If the transaction is executed -> throw an error

Note: When nonce is not provided with requests (like thru Nethereum, geth etc.) associated client 
software retreives it from the Ethereum network callin geth_getTransactionCount. 

Note: Nonce management can get complicated -> getTransactionCount may return outdated data or multiple machines can send request 
at the same time (didn't get second one well though) -> as a solution above -> keep track nonce in a local database and increment 
with each transaction... 
*/