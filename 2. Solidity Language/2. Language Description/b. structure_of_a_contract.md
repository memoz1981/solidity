### Structure of a Contract

- Contracts are similar to classes in OOL

**State Variables**
```solidity
contract SimpleStorage {
    uint storedData; // state variable
}
```
- Can be permanent or transient

**Functions**
- Don't have to be inside a contract
```solidity
contract SimpleAuction {
    function bid() public payable {...}
}

// Helper function defined outside of a contract
function helper(uint x) pure returns (uint) {
    return x * 2;
}

```

**Function Modifiers**
```solidity
contract Purchase {
    modifier onlyOwner() {
        require(msg.sender == owner, "only owner"); 
        _; -> this will ensure the function is proceeded...
    }

    function setPrice() public onlyOwner {...}
}
```

**Events**
- For EVM logging
```solidity
event HighestBid(address bidder, uint amount); 
contract Auction {
    function bid() public {
        if(....)
            emit HighestBid(msg.Sender, msg.Value);  
    }
}
```

**Errors**
- Can be used in revert statements
- Allow descriptive names/data for users
- Cheaper than string descriptions

```solidity
error NotEnoughFunds(uint requested, uint available); 

contract Token {
    function transfer(...) {
        if(...)
            revert NotEnoughFunds(requested, available); 
    }
}

```

**Struct Types**
- To group data
```solidity
struct Voter {
    uint weight; 
    address delegate;
}
```

**Enum Types**
```solidity
enum State {Created, Locked, Inactive}
```