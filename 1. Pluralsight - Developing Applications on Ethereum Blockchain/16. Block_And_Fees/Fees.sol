pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
Old fee model was like Auction model -> each user decides on the gas prices based on past prices. 
So if the user included very high gas price -> inclusion of their transaction was almost guaranteed. 

Issues with old auction model: 
- Long wait time (if the gas price specified was low)
- Poor UX -> Unpredictable gas prices
- Overpay -> cost of guaranteeing execution of your transaction

To solve above -> EIP-1559 (Ethereum Improvement Proposal) was proposed:
- Increase block size limit
- Automatically change gas price
    a) If the Block Usage < 50% of max size -> decrease gas price by 12.5 %
    b) Otherwise (if greater only) increase gas price by 12.5%
- Split fee structure
    a) Base fee (which will be burned) -> calculated as above
    b) tip (validators get it) -> user may decide to include it

Note: After implementation of above -> tips are normally included 

maxPriorityFeePerGas -> tips in gwei (10e9 wei)
maxFeePerGas -> base + maxPriorityFeePerGas

Note: max priority fee is tip limit -> 
*/  