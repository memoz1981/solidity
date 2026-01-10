### General

- There are two kinds of accounts in Ethereum which share the same address space: **Externally-owned accounts** that are controlled by public-private key pairs (i.e. humans) and **contract accounts** which are controlled by the code stored together with the account.

### Storage, Transient Storage, Memory and the Stack

- 4 Places to store data -> Storage, Transient Storage, Memory and the Stack

#### Storage

- persistent between function calls and transactions
- key-value store that maps 256-bit words to 256-bit words
- costly

#### Transient Storage

- Similar to storage -> but persists only within the tranaction, and then resets
- cost lower than storage

#### Memory

- Allocates for each function call
- Linear
- Reads are limited to 1 word = 256 bits = 32 bytes
- Writes -> either 8 bit or 256 bits wide
- Memory is expanded by words (256 bits) for read/write 
- Gas should be paid for each memory expansion
- cost of memory increases quadratically as it increases

#### Stack

- All calculations happen in stack
- Max size of 1024 elements
- Contains words of 256 bits

#### Other Storage Locations

##### Calldata

- any function call including the constructor
- any parameter of external function is first stored in calldata (as ABI encoded form) and then decoded into the location specified in the declaration. 
**Note:** Value types and storage points are directly decoded onto the stack

##### Returndata

- Return data of the functions

##### Code

- Stored code that's to be run by EVM
- Includes constants
- Includes immutable variables

### Message Calls

- A contract calling other contract 
- A transaction has top level message call + other message calls (which are performance in scope of same transaction)
- Limitations
a) maximum depth: 1024
b) only 63/64 of the gas can be forwarded in the message calls

#### Delegatecalls

- A special variant of message calls 
- Contract uses other contracts code in runtime using its own resources

### Logs

- Logs are low level (EVM Level), events are higher level construct creating logs
- Can be accessed from outside of blockchain but not by contracts

### Deactivate and Self-destruct

- The only way to remove code from the blockchain is when a contract at that address performs the `selfdestruct` operation. The remaining Ether stored at that address is sent to a designated target and then the storage and code is removed from the state. 
**Note:** Even if a contract’s code does not contain a call to selfdestruct, it can still perform that operation using delegatecall or callcode.

- To de-activate the contract a state variable can be added to set / reset for that. 

### Precompiled Contracts
- Some specific range of contracts (currently between address 1 and 0x0a) -> execution of which are not defined by their code (they are empty) but EVM Execution environment
- Typically provide cryptographic etc. functionality for better performance. 