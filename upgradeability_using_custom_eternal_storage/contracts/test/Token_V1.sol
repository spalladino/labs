pragma solidity ^0.4.18;

import '../UpgradeableTokenStorage.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

/**
 * @title Token_V1
 * @dev Version 1 of a token to show upgradeability.
 * The idea here is to extend a token behaviour providing a burn function as opposed to version 0
 */
contract Token_V1 is UpgradeableTokenStorage {
  using SafeMath for uint256;

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address owner) public view returns (uint256) {
    return _balances[owner];
  }

  function mint(address to, uint256 value) public {
    _balances[to] = _balances[to].add(value);
    _totalSupply = _totalSupply.add(value);
    Transfer(0x0, to, value);
  }

  function burn(uint256 value) public {
    require(value <= _balances[msg.sender]);
    _balances[msg.sender] = _balances[msg.sender].sub(value);
    _totalSupply = _totalSupply.sub(value);
    Transfer(msg.sender, 0x0, value);
  }

  function transfer(address to, uint256 value) public {
    require(_balances[msg.sender] >= value);
    _balances[msg.sender] = _balances[msg.sender].sub(value);
    _balances[to] = _balances[to].add(value);
    Transfer(msg.sender, to, value);
  }

  function transferFrom(address from, address to, uint256 value) public {
    require(_allowances[from][msg.sender] >= value);
    _allowances[from][msg.sender] = _allowances[from][msg.sender].sub(value);
    _balances[from] = _balances[from].sub(value);
    _balances[to] = _balances[to].add(value);
    Transfer(from, to, value);
  }

  function approve(address spender, uint256 value) public {
    _allowances[msg.sender][spender] = value;
    Approval(msg.sender, spender, value);
  }
}
