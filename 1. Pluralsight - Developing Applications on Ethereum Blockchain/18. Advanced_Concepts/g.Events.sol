pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Events:
    - Clients can subscribe to events
    - Stored (permanently) in transaction log
    - Contracts cannot subscribe to events

Note: Events are not stored in contract storage, they are stored as logs...
 */

 

 contract Events {
    event ItemForSale(uint id, uint price); 

    //to be able to filter by attributes, add indexed 
    event ItemForSaleIndexed(uint id, uint price, uint indexed eventType); 

    function saleItem(uint id, uint price) public {
        emit ItemForSale(id, price); 
        emit ItemForSaleIndexed(id, price, 0);
    }
 }

 // to subscribe to an event (from Web3.js or Nethereum) -> need to provide a call back function
