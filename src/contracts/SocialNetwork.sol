pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name;
    uint public noOfPosts = 0;
    mapping(uint => Post) public posts;

    struct Post {
        uint add;
        string content;
        uint tipAmount;
        address payable author;
    }

    event PostCreated(
        uint add,
        string content,
        uint tipAmount,
        address payable author
    );

    event PostTipped(
        uint add,
        string content,
        uint tipAmount,
        address payable author
    );

    constructor() public {
        name = "IBC Final Project";
    }

    function createPost(string memory _content) public {
        require(bytes(_content).length > 0);
        noOfPosts ++;
        posts[noOfPosts] = Post(noOfPosts, _content, 0, msg.sender);
        emit PostCreated(noOfPosts, _content, 0, msg.sender);
    }

    function tipPost(uint _add) public payable {
        require(_add > 0 && _add <= noOfPosts);
        Post memory _post = posts[_add];
        address payable _author = _post.author;
        address(_author).transfer(msg.value);
        _post.tipAmount = _post.tipAmount + msg.value;
        posts[_add] = _post;
        emit PostTipped(noOfPosts, _post.content, _post.tipAmount, _author);
    }
}
