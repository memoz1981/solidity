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

    function test_transfer_happyPath_when_to_not_exists() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);
        erc.mint(address(this), 200);

        //act
        bool result = erc.transfer(to, 199);

        //assert
        assert(result);

        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 1); 

        uint256 balanceTo = erc.balanceOf(to);
        assert(balanceTo == 199);
    }

    function test_transfer_happyPath_whenFullHoldings() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);
        erc.mint(address(this), 200);

        //act
        bool result = erc.transfer(to, 200);

        //assert
        assert(result);

        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 0); 

        uint256 balanceTo = erc.balanceOf(to);
        assert(balanceTo == 200);
    }


    function test_transfer_happyPath_when_to_already_exists() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        erc.mint(to, 1);

        //act
        bool result = erc.transfer(to, 199);

        //assert
        assert(result);

        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 1); 

        uint256 balanceTo = erc.balanceOf(to);
        assert(balanceTo == 200);
    }

    function test_approve_notAllowed_forZeroAddress() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);

        //act - assert
        vm.expectRevert();
        erc.approve(address(0), 10);
    }

    function test_approve_shouldBeAbleToApproveMoreThanHoldings() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act
        bool success = erc.approve(to, 300);

        //assert
        assert(success);
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

        //assert
        assert(success);
        uint256 balance = erc.balanceOf(address(this));
        assert(balance == 200); 
    }

    function test_allowance_shouldReturnZero_whenOwnerHasNoFunds() public
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        address to = address(1);

        //act
        uint256 allowance = erc.allowance(address(this), to);

        //assert
        assert(allowance == 0);
    }

    function test_allowance_shouldReturnZero_whenOwnerHasntApproved() public
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act
        uint256 allowance = erc.allowance(address(this), to);

        //assert
        assert(allowance == 0);
    }

    function test_allowance_happyPath() public
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act
        erc.approve(to, 199);
        uint256 allowance = erc.allowance(address(this), to);

        //assert
        assert(allowance == 199);
    }

    function test_transferFrom_shouldRevert_whenFromZeroAddress() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);

        //act - assert
        vm.expectRevert("Zero from address");
        erc.transferFrom(address(0), address(this), 100);
    }

    function test_transferFrom_shouldRevert_whenToZeroAddress() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);

        //act - assert
        vm.expectRevert("Zero to address");
        erc.transferFrom(address(this), address(0), 100);
    }

    function test_transferFrom_shouldRevert_whenNotApproved() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        erc.mint(address(this), 200);
        address to = address(1);

        //act - assert
        vm.expectRevert("Provided amount not delegated");
        erc.transferFrom(address(this), to, 100);
    }

    function test_transferFrom_shouldRevert_whenEnoughAmountNotApproved() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);

        vm.prank(from);
        erc.approve(address(this), 99);

        //act - assert
        vm.expectRevert("Provided amount not delegated");
        erc.transferFrom(from, to, 100);
    }

    function test_transferFrom_shouldReturnFalseWhenEnoughBalanceNotExists() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);

        vm.prank(from);
        erc.approve(address(this), 300);

        //act
        bool result = erc.transferFrom(from, to, 250);

        //assert
        assertEq(result, false, "returned true");
        assertEq(erc.totalSupply(), 1200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 200, "from balance");
        assertEq(erc.balanceOf(to), 0, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 300, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }

    function test_transferFrom_happyPath_whenToNotExists() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);

        vm.prank(from);
        erc.approve(address(this), 150);

        //act
        bool result = erc.transferFrom(from, to, 80);

        //assert
        assertEq(result, true, "returned false");
        assertEq(erc.totalSupply(), 1200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 120, "from balance");
        assertEq(erc.balanceOf(to), 80, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 70, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }

    function test_transferFrom_happyPath_whenToExists() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);
        erc.mint(to, 1000);

        vm.prank(from);
        erc.approve(address(this), 150);

        //act
        bool result = erc.transferFrom(from, to, 80);

        //assert
        assertEq(result, true, "returned false");
        assertEq(erc.totalSupply(), 2200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 120, "from balance");
        assertEq(erc.balanceOf(to), 1080, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 70, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }

    function test_transferFrom_happyPath_whenAmountSameAsApprovedAmount() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);
        erc.mint(to, 1000);

        vm.prank(from);
        erc.approve(address(this), 150);

        //act
        bool result = erc.transferFrom(from, to, 150);

        //assert
        assertEq(result, true, "returned false");
        assertEq(erc.totalSupply(), 2200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 50, "from balance");
        assertEq(erc.balanceOf(to), 1150, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 0, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }

    function test_transferFrom_happyPath_whenAmountSameAsHoldingsAmount() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);
        erc.mint(to, 1000);

        vm.prank(from);
        erc.approve(address(this), 300);

        //act
        bool result = erc.transferFrom(from, to, 200);

        //assert
        assertEq(result, true, "returned false");
        assertEq(erc.totalSupply(), 2200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 0, "from balance");
        assertEq(erc.balanceOf(to), 1200, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 100, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }

    function test_transferFrom_happyPath_whenAmountSameAsHoldingsAndApprovedAmount() public 
    {
        //arrange
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        erc.addSupply(1000);
        address from = address(1);
        address to = address(2); 
        erc.mint(from, 200);
        erc.mint(to, 1000);

        vm.prank(from);
        erc.approve(address(this), 200);

        //act
        bool result = erc.transferFrom(from, to, 200);

        //assert
        assertEq(result, true, "returned false");
        assertEq(erc.totalSupply(), 2200, "total supply"); 
        assertEq(erc.balanceOf(address(this)), 0, "this balance");
        assertEq(erc.balanceOf(from), 0, "from balance");
        assertEq(erc.balanceOf(to), 1200, "to balance"); 
        assertEq(erc.allowance(address(this), to), 0, "allowance this-to");
        assertEq(erc.allowance(from, address(this)), 0, "allowance from-this");
        assertEq(erc.allowance(from, to), 0, "allowance from-to");
    }
}