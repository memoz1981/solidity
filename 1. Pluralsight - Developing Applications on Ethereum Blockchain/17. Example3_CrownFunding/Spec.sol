pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

/*
The purpose: Collect funds for a specific purpose -> desired amount/by desired deadline

Functionality: 
- Deadline
- Pre-deter mined amount
- If successful -> money is transferred to a beneficiary
- If fails -> refund money

Note: A new smart contract needs to be deployed for each campaign including below info: 
- Constructor: amound, deadline, beneficiary
- Users -> contribute, getrefund(when failed)
- Beneficiary -> get the amount if successful

*/