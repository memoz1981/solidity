pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

// msg variable provides information about transaction that was sent to the smart contract
// like caller in c#
contract MsgVariable {

    function getValueSent() private view returns (uint) {
        return msg.value; // number of wei sent
    }

    function getSender() private view returns (address) {
        return msg.sender; // address of the sender
    }

    function getData() private pure returns (bytes memory) {
        return msg.data; // complete transsaction data
    }

    function getIdentifier() private pure returns (bytes4) {
        return msg.sig; // identifier
    }
}