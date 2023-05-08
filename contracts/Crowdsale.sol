// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import './Token.sol';

/**
 * @title Crowdsale
 * @dev Crowdsale is a contract for managing a token crowdsale.
 */
contract Crowdsale {
    address public owner;
    Token public token;
    uint256 public price;
    uint256 public maxTokens;
    uint256 public tokensSold;
    uint256 public minPurchase;
    uint256 public maxPurchase;

    mapping(address => bool) public whitelist;
    mapping(address => uint256) public purchased;

    event Buy(uint256 amount, address buyer);
    event Finalize(uint256 tokensSold, uint256 ethRaised);

    /**
     * @notice Initialize the Crowdsale contract
     * @param _token Address of the token to be sold
     * @param _price Price of each token in wei
     * @param _maxTokens Maximum number of tokens to be sold in the crowdsale
     * @param _minPurchase Minimum amount of tokens that can be purchased
     * @param _maxPurchase Maximum amount of tokens that can be purchased
     */
    constructor(Token _token, uint256 _price, uint256 _maxTokens, uint256 _minPurchase, uint256 _maxPurchase) {
        owner = msg.sender;
        token = _token;
        price = _price;
        maxTokens = _maxTokens;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, 'caller is not the owner');
        _;
    }

    /**
     * @notice Fallback function to buy tokens using Ether directly
     */
    receive() external payable {
        uint256 amount = msg.value / price;
        buyTokens(amount * 1e18);
    }

    /**
     * @notice Add an address to the whitelist
     * @param _address Address to be added to the whitelist
     */
    function whitelistUser(address _address) public onlyOwner {
        whitelist[_address] = true;
    }

    /**
     * @notice Buy tokens in the crowdsale
     * @param _amount Number of tokens to buy
     */
    function buyTokens(uint256 _amount) public payable {
        require(whitelist[msg.sender], "Address not whitelisted");
        require(msg.value == (_amount / 1e18) * price, "Incorrect Ether value");
        require(token.balanceOf(address(this)) >= _amount, "Not enough remaining tokens");
        require(purchased[msg.sender] + _amount <= maxPurchase, "Cumulative purchase amount exceeds maximum purchase amount");
        require(_amount >= minPurchase, "Purchase amount is less than minimum purchase amount");

        require(token.transfer(msg.sender, _amount), "Failed to transfer tokens");

        tokensSold += _amount;
        purchased[msg.sender] += _amount;

        emit Buy(_amount, msg.sender);
    }

    /**
     * @notice Set the price of tokens in the crowdsale
     * @param _price New price of each token in wei
     */
    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    /**
     * @notice Finalize the crowdsale, transfer unsold tokens and Ether to the owner
     */
    function finalize() public onlyOwner {
        require(token.transfer(owner, token.balanceOf(address(this))));

        uint256 value = address(this).balance;
        (bool sent, ) = owner.call{ value: value }("");
        require(sent, "Failed to send Ether");

        emit Finalize(tokensSold, value);
    }
}
