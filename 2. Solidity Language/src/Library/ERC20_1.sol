// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "./IERC20.sol";

// My first implementation of ERC20 - no AI, just learning, and no need to get it right first time
// now assuming if the balance has been approved for use for third party -> I can still use it??? 
// first implementation -> have fun :)
// Note: normally I prefer _ for private fields...but for the sake of interface consistency using it for parameters instead
struct Balance
{
    uint256 totalBalance;
    mapping(address => uint256) approvals; 
    bool exists;
}

/* My first ERC20 Implementation*/
contract ERC20_1 is IERC20 {
    string public name; 
    string public symbol; 
    uint8 public decimals; 
    uint256 public totalSupply; 
    address public owner;

    mapping(address => Balance) balanceSheet;

    constructor(string memory _name, string memory _symbol, uint8 _decimals)
    {
        name = _name; 
        symbol = _symbol;
        decimals = _decimals; 
        owner = msg.sender;
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance)
    {
        return balanceSheet[_owner].totalBalance;
    }

    function transfer(address _to, uint256 _value) public returns (bool success)
    {
        require(_to != address(0), "Cannot transfer to zero address");
        
        // not sure if a check to see if the dictionary contains the value (or zero) is required here...
        // also when does it need to return false???
        require(balanceSheet[msg.sender].totalBalance > _value, "Not enough funds...");

        balanceSheet[msg.sender].totalBalance -= _value;
        if(balanceSheet[msg.sender].totalBalance == 0)
        {
            delete balanceSheet[msg.sender];
        }

        Balance storage to = balanceSheet[_to];
        to.exists = true;
        to.totalBalance += _value; 

        emit Transfer(msg.sender, _to, _value);
        return true; 
    }

    // since interface definition doesn't specify any reverts, will just return false on validations (except for zero address)
    function approve(address _spender, uint256 _value) public returns (bool success)
    {
        require(_spender != address(0), "Address zero not allowed");
        if(balanceSheet[msg.sender].totalBalance < _value)
        {
            return false;
        }

        balanceSheet[msg.sender].approvals[_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) external view returns (uint256 remaining)
    {
        return balanceSheet[_owner].approvals[_spender];
    }

    // the interface definition of approval is vauge -> so assuming above approve method is the right one
    // to approve transfer from functionality
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    {
        require(_from != address(0), "Zero from address");
        require(_to != address(0), "Zero to address");
        require(balanceSheet[_from].approvals[msg.sender] >= _value, "Provided amount not delegated");
        
        // again having an ambiguity on if the total balance should be deducted on approvals, or still to use total balance
        // also not sure if to revert on below or return false. 
        if(balanceSheet[_from].totalBalance < _value)
        {
            return false; 
        }

        balanceSheet[_from].totalBalance -= _value; 
        balanceSheet[_from].approvals[msg.sender] -= _value; 

        if(balanceSheet[_from].approvals[msg.sender] == 0)
        {
            delete balanceSheet[_from].approvals[msg.sender];
        }

        Balance storage to = balanceSheet[_to];
        to.exists = true;
        to.totalBalance += _value; 

        emit Transfer(_from, _to, _value);
    }

    /* FUNCTIONS TO BE ABLE TO TEST THE CONTRACT */
    modifier ownerOnly()  
    {
        require(msg.sender == owner);
        _;
    }

    function addSupply(uint256 amount) public ownerOnly
    {
        totalSupply += amount; 
    } 

    function mint(address to, uint256 amount) public ownerOnly {
        require(to != address(0));
        Balance storage b = balanceSheet[to];
        b.exists = true; 
        b.totalBalance += amount;

        totalSupply += amount;

        emit Transfer(address(0), to, amount);
    }
}