// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {ERC20_1} from "../src/Library/ERC20_1.sol";

contract ERC20_1_Tests is Test {

    function test_should_initialize_contract_correctly() public
    {
        //arrange
        

        //act
        ERC20_1 erc = new ERC20_1("My Token", "TKN", 18);
        
        //assert
        assert(keccak256(abi.encodePacked(erc.name())) == keccak256(abi.encodePacked("My Token"))); 
        assert(keccak256(abi.encodePacked(erc.symbol())) == keccak256(abi.encodePacked("TKN")));
        assert(erc.decimals() == 18);
        assert(erc.totalSupply() == 0);
    }
}