pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

contract Payments {
    address payable add1; 
    // the difference between "address" and "address payable" is that payable one can receive ETH, 
    // first one cannot. it's added just to precent user mistakes

    address payable add2 = payable(msg.sender); // you cannot send funds to msg.sender, but can
    // send to add2 now. 

// Note: Above does't mutate the address -> so if the address cannot receive any money, that
// will not be prevented by defining it as payable -> it's JUST to prevent user mistakes. 

    // reverts execution if fails (Deprecated)
    function transfer(address payable addr, uint amount) external {
        addr.transfer(amount); 
    }

    // returns false if fails (Deprecated)
    function send(address payable addr, uint amount) external returns(bool) {
        return addr.send(amount); 
    }

    // call is a generic method that can be used to call a method from the smart contract
    // when sent with empty string -> just sends money
    function sendNew(address payable addr, uint amount) external returns(bool) {
        (bool ok, bytes memory data) = addr.call{value: amount}("");
        require(ok, "ETH transfer failed");
    }

    // call example to call a method from toAddress
    function callExample(address addr, uint parameter) public {
        (bool ok, ) = addr.call( //with optional parameter
            abi.encodeWithSignature("foo(unit)", parameter)
        );
        require(ok, "ETH transfer failed");
    }

    // Note: There are 2 ways to send a payment to a smart contract
    // a) By directly sending to the contract address -> for this contract should either
    // have receive() external payable {} or fallback() external payable {} functions
    receive() external payable {
        require(msg.value > 1000); 
    }

    // Note: fallback is a general function called when the called function is not found
    // has special purpose to receive funds (called with funds are sent with calldata)

    // b) Calling an available method in smart contract (calling a payable function)
    function buyGadgets(uint gadgetCount) external payable 
    {
        require(msg.value == gadgetCount * 10); 
        // if not reverted -> payment will be accepted by default
    }

    // Balance of any ethereum address can be obtained by calling addr.balance field (in wei)
    function getMyBalance() public view returns(uint) {
        return address(this).balance; 
    }

    function getAnyBalance(address addr) public view returns(uint) {
        return addr.balance;
    }
    

}