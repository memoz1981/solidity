// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/CanReceive.sol";
import "../src/CannotReceive.sol";

contract AddressTests is Test {
    function test_conversions_to_address() public
    {
        //arrange
        address payable addrp1 = payable(msg.sender); 
        uint160 number = 1234567890;
        bytes20 bytesAdd = bytes20(0x1234567890123456789012345678901234567890); //length 40
        CanReceive c1 = new CanReceive(); 
        CannotReceive c2 = new CannotReceive(); 

        //act
        address addr1 = addrp1; //implicit conversion
        address addr2 = address(number); 
        address addr3 = address(bytesAdd); 
        address addr4 = address(0x1234567890123456789012345678901234567890); // integer literal
        address addr5 = address(c1); 
        address addr6 = address(c2); 
        
        //assert
        assert(addr1.balance == addrp1.balance);
        assert(addr2.balance == 0);
        assert(addr3.balance == 0); 
        assert(addr4.balance == 0); 
        assert(addr5.balance == 0); 
        assert(addr6.balance == 0); 
    }

    function test_conversions_to_address_payable() public
    {
        //arrange
        address addr1 = msg.sender; 
        CanReceive c1 = new CanReceive(); 
        CannotReceive c2 = new CannotReceive(); 

        // act - convert to address payable
        address payable addrp1 = payable(addr1); //implicit conversion
        address payable addrp2 = payable(address(c1)); 
        address payable addrp3 = payable(address(c2)); //transfer to this will fail
        
        //assert
        assert(addr1.balance == addrp1.balance);
        assert(addrp2.balance == 0);
        assert(addrp3.balance == 0); 

        //act - send ether
        vm.deal(address(this), 5 ether);
        addrp2.transfer(0.5 ether);
        assert(addrp2.balance == 0.5 ether);

        vm.expectRevert();
        addrp1.transfer(0.5 ether);
    }
}