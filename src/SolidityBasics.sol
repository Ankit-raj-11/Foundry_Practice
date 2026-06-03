// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Interfaces describe external function signatures (like an API definition)
interface IHelper {
    function getStatus() external view returns (bool);
}

// Libraries allow reusable code that can be called across contracts
library MathLib {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
}

contract SolidityBasics {
    // 1. STATE VARIABLES & DATA TYPES
    // State variables are stored permanently in contract storage on the blockchain.
    
    // Booleans
    bool public isReady = true;
    
    // Integers (unsigned: positive numbers, signed: positive/negative)
    uint256 public u256 = 123; // uint is an alias for uint256 (0 to 2**256 - 1)
    int256 public i256 = -456; // int is an alias for int256 (-2**255 to 2**255 - 1)
    uint8 public u8 = 255;     // 8-bit unsigned integer (0 to 255)
    
    // Address (stores a 20-byte Ethereum address)
    address public owner;
    address payable public ownerPayable; // payable address can receive Ether via transfer/send/call
    
    // Strings (UTF-8 encoded dynamic array of characters)
    string public greeting = "Hello, Solidity!";
    
    // Bytes (fixed-size bytes1 to bytes32, or dynamic bytes)
    bytes32 public hashData = 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef;
    bytes public dynamicBytes;

    // 2. CONSTANTS & IMMUTABLES
    // Constants cannot be changed and are defined at compile time. Saves a lot of gas!
    uint256 public constant MY_CONSTANT = 999;
    // Immutables can be set once in the constructor and cannot be changed after. Saves gas!
    address public immutable CREATION_TIME_OWNER;

    // 3. ENUMS
    // User-defined types for representing a set of discrete choices or states.
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    Status public status;

    // 4. STRUCTS
    // Custom structures to group related data.
    struct User {
        uint256 id;
        string name;
        bool isActive;
    }
    
    User public primaryUser;
    User[] public users; // Array of structs

    // 5. MAPPINGS
    // Key-value store (similar to hash maps or dictionaries in other languages)
    // Syntax: mapping(KeyType => ValueType)
    mapping(address => uint256) public balances;
    // Nested mapping (e.g. owner allows a spender to spend their tokens)
    mapping(address => mapping(address => bool)) public isApproved;

    // 6. ARRAYS
    // Can have dynamic or fixed size
    uint256[] public dynamicArray;
    uint256[5] public fixedArray = [1, 2, 3, 4, 5];

    // 7. EVENTS & CUSTOM ERRORS
    // Events allow logging to the Ethereum blockchain transaction logs. Good for off-chain monitoring.
    event UserAdded(uint256 indexed id, string name);
    event EtherReceived(address indexed sender, uint256 amount);
    
    // Custom errors are gas-efficient alternatives to require strings
    error Unauthorized(address caller);
    error InvalidValue(uint256 sent, uint256 expected);

    // 8. MODIFIERS
    // Modifiers are reusable code blocks that can run before and/or after a function call
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
        _; // The "_" represents the rest of the function body where modifier is applied
    }

    // 9. CONSTRUCTOR
    // Executed only once when the contract is first deployed
    constructor() {
        owner = msg.sender;
        ownerPayable = payable(msg.sender);
        CREATION_TIME_OWNER = msg.sender;
        status = Status.Pending;
    }

    // 10. FUNCTIONS & MUTABILITY
    
    // Write function (modifies contract state)
    function setGreeting(string memory _greeting) public {
        greeting = _greeting;
    }
    
    // View function (reads state, does not modify state)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    // Pure function (does not read or modify state)
    function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
        return MathLib.add(a, b);
    }
    
    // Payable function (can receive Ether along with the transaction call)
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit EtherReceived(msg.sender, msg.value);
    }

    // 11. ARRAY & STRUCT OPERATIONS
    function registerUser(uint256 _id, string memory _name) public {
        // Create struct in memory
        User memory newUser = User({
            id: _id,
            name: _name,
            isActive: true
        });
        
        users.push(newUser);
        emit UserAdded(_id, _name);
    }

    // 12. CONTROL STRUCTURES & ERROR HANDLING
    function processStatus(uint256 _value) public onlyOwner {
        // Require check (good for validating user input, reverts with string)
        require(_value > 0, "Value must be positive");

        // Custom error check (reverts and saves gas compared to require strings)
        if (_value > 1000) {
            revert InvalidValue(_value, 1000);
        }

        // Loop demonstration (for loops and while loops exist in Solidity)
        uint256 sum = 0;
        for (uint256 i = 0; i < 5; i++) {
            sum += i;
        }

        // Conditional statement (if/else)
        if (_value < 10) {
            status = Status.Pending;
        } else if (_value < 50) {
            status = Status.Shipped;
        } else {
            status = Status.Accepted;
        }
        
        // Assert (used for checking invariants; if assert fails, something is wrong with contract code)
        assert(status != Status.Rejected);
    }

    // 13. SENDING ETHER
    // Function to withdraw Ether from contract mapping balances
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        
        // Recommended method: call (returns success status and data)
        (bool sent, ) = payable(msg.sender).call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    // 14. RECEIVING ETHER (Special functions)
    // Called when msg.data is empty
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // Called when msg.data is not empty or no other function matches
    fallback() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
}
