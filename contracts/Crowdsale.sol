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

    event Buy(uint256 amount, address buyer);
    event Finalize(uint256 tokensSold, uint256 ethRaised);

    /**
     * @notice Initialize the Crowdsale contract
     * @param _token Address of the token to be sold
     * @param _price Price of each token in wei
     * @param _maxTokens Maximum number of tokens to be sold in the crowdsale
     */
    constructor(Token _token, uint256 _price, uint256 _maxTokens) {
        owner = msg.sender;
        token = _token;
        price = _price;
        maxTokens = _maxTokens;
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
     * @notice Buy tokens in the crowdsale
     * @param _amount Number of tokens to buy
     */
    function buyTokens(uint256 _amount) public payable {
        require(msg.value == (_amount / 1e18) * price);
        require(token.balanceOf(address(this)) >= _amount);
        require(token.transfer(msg.sender, _amount));

        tokensSold += _amount;

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
