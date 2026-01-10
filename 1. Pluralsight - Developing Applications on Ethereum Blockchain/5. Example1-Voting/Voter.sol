pragma solidity ^0.8.30;
// SPDX-License-Identifier: UNLICENSED

struct Option {
    uint position; 
    bool exists;
}

contract Voter {
    uint[] private votes; //to track the votes
    mapping(address => bool) private hasVoted; // to track the voters
    mapping(string => Option) private options; // to track the options


    constructor(string[] memory _options)
    {
        require(_options.length > 1, "Two or more options should be available");

        for(uint i = 0; i < _options.length; i++)
        {
            Option memory optionItem = Option(i, true); 
            options[_options[i]] = optionItem; 
        }
        votes = new uint[](_options.length); 
    } 

    function vote(uint optionIndex) public {
        require(optionIndex < votes.length, "Invalid option index"); 
        require(!hasVoted[msg.sender], "You have already voted"); 
        recordVote(optionIndex);
    }

    function vote(string memory optionName) public {
        require(!hasVoted[msg.sender], "You have already voted"); 
        Option memory optionVoted = options[optionName]; 
        require(optionVoted.exists, "provided option doesn't exist"); 

        recordVote(optionVoted.position);
    }

    function compare(string memory name1, string memory name2) private pure returns (bool)
    {
        if(keccak256(bytes(name1)) == keccak256(bytes(name2)))
        {
            return true; 
        }

        return false; 
    }

    function recordVote(uint optionIndex) private {
        hasVoted[msg.sender] = true; 
        votes[optionIndex] = votes[optionIndex] + 1; 
    }

    function getVotes() public view returns(uint[] memory)
    {
        return votes;
    }
}