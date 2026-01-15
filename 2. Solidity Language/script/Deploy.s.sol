// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Library/ERC20_1.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
        
        vm.startBroadcast(deployerPrivateKey);
        
        ERC20_1 token = new ERC20_1("My Token", "TKN", 18);
        
        console.log("Token deployed at:", address(token));
        
        vm.stopBroadcast();
    }
}