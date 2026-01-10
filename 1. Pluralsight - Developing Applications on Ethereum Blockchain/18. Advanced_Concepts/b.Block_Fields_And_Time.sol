pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
TIME
Time in smart contracts is a bit tricky: 
- Smart contracts need to be deterministic (repeatable)
- Every node will have a slightly different time

Instead it's possible to get time from the block.
uint currentTime = block.timestamp;  (Unix Epoch - seconds from 1 Jan 1970)

OTHER BLOCK FIELDS

block.timestamp -> 
block.gaslimit -> 
block.number -> 
block.coinbase -> Validator's address

Note: block time is controlled by the block creator -> may be misused -> note that the protocol 
imposes certain limits to prevent this to a degree, but smart contracts need to take this into
account... 

Time Units in Solidity: 
uint oneSecond = 1 seconds; 
uint oneHour = 60 minutes; 
uint oneWeek = 7 days; 

ETHEREUM UNITS
uint v1 = 10 wei; 
uint v2 = 20 szabo; (szabo = 10e-6 ETH)
uint v3 = 30 finney; (finney = 10e-3 ETH)
uint v4 = 40 ether; 

*/