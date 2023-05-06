// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/**
 * @title ERC-20 Token Contract
 * @dev This contract implements the basic functionality of an ERC-20 token.
 */
contract Token {
    string public name;
    string public symbol;
    uint256 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    /**
     * @notice Constructor to set the initial values of the token
     * @param _name The name of the token
     * @param _symbol The symbol of the token
     * @param _totalSupply The total supply of the token
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply * (10 ** decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    /**
     * @notice Transfer tokens from the sender to a specified address
     * @param _to The recipient address
     * @param _value The amount of tokens to be transferred
     * @return success A boolean indicating the success of the transfer
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Not enough tokens");

        _transfer(msg.sender, _to, _value);

        return true;
    }

    /**
     * @notice Internal function to transfer tokens between addresses
     * @param _from The sender address
     * @param _to The recipient address
     * @param _value The amount of tokens to be transferred
     */
    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) internal {
        require(_to != address(0));

        balanceOf[_from] = balanceOf[_from] - _value;
        balanceOf[_to] = balanceOf[_to] + _value;

        emit Transfer(_from, _to, _value);
    }

    /**
     * @notice Approve a specified address to spend tokens on behalf of the sender
     * @param _spender The address allowed to spend tokens
     * @param _value The amount of tokens allowed to be spent
     * @return success A boolean indicating the success of the approval
     */
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        require(_spender != address(0));

        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @notice Transfer tokens from one address to another on behalf of the sender
     * @param _from The address to transfer tokens from
     * @param _to The address to transfer tokens to
     * @param _value The amount of tokens to be transferred
     * @return success A boolean indicating the success of the transfer
     */
    function transferFrom(
        address _from,
        address _to,
        uint _value
    )
        public
        returns (bool success)
    {
        require(_value <= balanceOf[_from], "Not enough tokens");
        require(_value <= allowance[_from][msg.sender], "Not enough allowance");

        allowance[_from][msg.sender] = allowance[_from][msg.sender] - _value;

        _transfer(_from, _to, _value);

        return true;
    }
}
