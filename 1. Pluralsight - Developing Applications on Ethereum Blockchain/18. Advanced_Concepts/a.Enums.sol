pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

enum AuctionState {
    NotStarted, 
    Ongoing, 
    Finished
}

contract Enums {
    AuctionState state = AuctionState.NotStarted; 

    function checkState() public view returns(AuctionState)
    {
        return state; 
    }
}