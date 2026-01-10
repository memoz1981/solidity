pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Interactions
    - Deploy smart contracts
    - Send payments
    - Call methods

CALLING METHOD IN A DEPLOYED contracts
import "./ShopItem.sol"

contract OnlineShop
{
    address itemAddress ="0xA..."; 
    function sellItem() {
        ShopItem shopItem = ShopItem(itemAddress); //new keyword not there... 
        itemAddress.Sell(); 
    }
}

DEPLOYING ANOTHER SMART contract
import "./ShopItem.sol"

contract OnlineShop
{
    function sellItem(string memory name, uint price) {
        ShopItem shopItem = new ShopItem(name, price); //new keyword used...
        shopItem.Sell(); 
        
        //we can retrieve the address of new smart contract
        address shopItemAddress = address(shopItem);
    }
}

TRY/CATCH -> Important to include try catch block when interacting with other smart contracts

Limitations: 
    - Only for external calls and contract creations
    - Supports limited error types

When calling another contract functions
function handleError() returns(uint value) {
    try contract.getValue() returns(uint v)
    {
        // error didn't occur
        return v; 
    }
    catch {
        // error occured
        return 0; 
    }
}

When creating a new smart contract
function handleError() public {
    try new Foo() returns(Foo foo) {
        foo.setValue(1); 
    }
    catch {}
}

CATCH statements (can be combined under one try statement)
function handleError() returns(uint value) {
    try contract.getValue() returns(uint v)
    {
        // error didn't occur
        return v; 
    }
    catch Error(string memory reason) {} // Error from revert("str") or require("str")
    catch Panic(uint errorCode) {} // Error from assert()
    catch (bytes memory lowLevelData) // Any other type error
    catch {} // any error
}
*/