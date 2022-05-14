//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


contract BuyMeACoffee {
    //Event to emit when a function is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo Struct
    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos recieved
    Memo[] memos;

    //address of contract deployer
    address payable owner;

    //Deply logic
    constructor() {
        owner = payable(msg.sender);

    }

    event Approval(address indexed tokenOwner, address indexed spender,
 uint tokens);

    /**
     * @dev buy a coffee for owner (sends an ETH tip and leaves a memo)
     * @param _name name of the coffee purchaser
     * @param _message a nice message from the purchaser
     */

    function buyLargeCoffee(string memory _name, string memory _message)public payable {
        require (msg.value > 0, "Not enough ETH to buy coffee");

        memos.push (Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function buyCoffee(string memory _name, string memory _message)public payable {
        require (msg.value > 0, "Not enough ETH to buy coffee");

        memos.push (Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    function withdrawTips() public{
        require(owner.send(address(this).balance));
    }

    mapping(address => mapping (address => uint256)) allowed;


    function approve(address delegate,
                uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}
