pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
- Re-Entrancy attacks are (were) associated with call function

function withdraw() public {
uint balance = getBalance(msg.sender); 
require(balance > 0);
msg.sender.call{value: balance}(""); 
setBalance(msg.sender, 0); 
}

A malicious smart contract does followings: 
1st call -> balance is available -> transfer is called
- when transferring -> malicious smart contract sees this, and send another request
- since balance is not zeroed (and there's no gas limit and also balance not set yet)
it's processed second, third, fourth... 

See DAO Hack (60 Million of ETH)
Read:"The Infinite Machine" by Camila Russo

To protect from above: 
- Pre-conditions (check if balance exist)
- Change state (set balance to zero first)
- Interactions (transfer the money)

Note: Since send/transfer had a 2300 gas limit, it was barely enough to send only once, not 
talking about second, third time. Call doesn't require a limit which is why it's more 
vulnerable to this attack. 

*/