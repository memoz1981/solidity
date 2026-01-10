pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Geth - one of the most popular Ethereum clients (execution - for consensus it's probably Lighthouse).

geth \
--goerli \ -> connect to goerli network (probably obsolete)
--http \ -> enable http rpc server
--syncmode light \ -> light mode
-http api "personal, net, eth, debug" -> APis to enable

Note: above geth command starts get on port 8545

Note: There are multiple ways to interact with Geth -> programmatically, thru CLI (+ maybe postman?)

Geth CLI Commands
geth accounts -> manage geth accounts
geth init -> new genesis block
geth help
geth attach -> interactive JS session

After running geth attach -> JS console->
- admin -> controls client node
- personal -> manage accouns
- txpool -> information about transaction pool
- debug -> used for geth debugging

Note: Infura is a node provider. What is a node provider? 
- runs the node for us
- there are others like Alchemy etc. 
- provides us with a URL (similar to running a client locally)

Note: Normally it's expensive to use geth (a lot of space is required)
instead we may use Infura... 










 */