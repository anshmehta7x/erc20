// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ERC20 {
    string private name;
    string private symbol;
    uint private decimals;
    uint256 private totalSupply;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;


    function getName() public view returns(string memory){
        return name;
    }

    function getSymbol() public view returns(string memory){
        return symbol;
    }

    function getDecimals() public view returns(uint){
        return decimals;
    }

    function getTotalSupply() public view returns(uint256){
        return totalSupply;
    }

    function balanceOf(address _owner) public view returns(uint256){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns(bool){
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool){
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;

        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool){
        allowed[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) public view returns(uint256){
        return allowed[_owner][_spender];
    }

    constructor(string memory _name, string memory _symbol, uint _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

}
