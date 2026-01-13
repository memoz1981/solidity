// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {ERC20_1} from "../src/Library/ERC20_1.sol";

contract ERC20_1_Tests is Test {

    function test_should_initialize_contract_correctly() public
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        
        //act
        
        //assert
        assert(keccak256(abi.encodePacked(erc.name())) == keccak256(abi.encodePacked("My Token"))); 
        assert(keccak256(abi.encodePacked(erc.symbol())) == keccak256(abi.encodePacked("TKN")));
        assert(erc.decimals() == 18);
        assert(erc.totalSupply() == 0);
        assert(erc.owner() == address(this));
    }

    function test_should_show_the_balance_correctly() public
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address owner = address(0x123);

        // assert - initial state
        uint256 balance = erc.balanceOf(owner);
        assert(balance == 0);

        // act -> add balance
        erc.addSupply(1000);

        // assert - total supply
        assert(erc.totalSupply() == 1000);
        balance = erc.balanceOf(owner);
        assert(balance == 0);

        //act -> mint to balance
        erc.mint(owner, 200);
        
        //assert -> final balances
        assert(erc.totalSupply() == 1200);
        balance = erc.balanceOf(owner);
        assert(balance == 200);
    }

    function test_transfer_shouldRevert_whenSendingToZeroAddress() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(0);
        erc.addSupply(1000);
        erc.mint(address(this), 200);

        //act - assert
        vm.expectRevert();
        erc.transfer(to, 100);
    }

    function test_transfer_shouldRevert_whenUserDoesntHoldAnyBalance() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);

        //act - assert
        vm.expectRevert();
        erc.transfer(to, 100);
    }

    function test_transfer_shouldRevert_whenUserDoesntHoldEnoughBalance() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);
        erc.mint(address(this), 200);

        //act - assert
        vm.expectRevert();
        erc.transfer(to, 201);
    }

    function test_transfer_happyPath() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);
        erc.mint(address(this), 200);

        //act - assert
        bool result = erc.transfer(to, 199);
        assert(result);

        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 1); 
    }

    function test_approve_notAllowed_forZeroAddress() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);

        //act - assert
        vm.expectRevert();
        erc.approve(address(0), 10);
    }

    function test_approve_shouldReturnFalse_whenNotEnoughBalance() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act
        bool success = erc.approve(to, 201);
        assert(!success);
        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 200); 
    }

    function test_approve_happyPath() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act
        bool success = erc.approve(to, 199);
        assert(success);
        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 200); 
    }


}