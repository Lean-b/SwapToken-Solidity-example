// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract swaToken {
  
  address public owner;
  address public tokenOne;
  address public tokenTwo;

  constructor(address _owner,address _tokenOne, address _tokenTwo){
    tokenOne =_tokenOne;
    tokenTwo =_tokenTwo;
    owner = _owner;
  }

  function swatToken(uint256 amount) external {
    require(IERC20(tokenOne).balanceOf(msg.sender) >= amount,"Insuficiente saldo");
    IERC20(tokenOne).transferFrom(msg.sender, address(this), amount);
    IERC20(tokenTwo).transfer(msg.sender, amount);
  }

  function withdraw() external {
    require(msg.sender == owner,"Only owner can withdraw");
    IERC20(tokenOne).transfer(owner, IERC20(tokenOne).balanceOf(address(this)));
    IERC20(tokenTwo).transfer(owner, IERC20(tokenTwo).balanceOf(address(this)));
  }

  function getBalance() view public returns (uint256,uint256) {
   
    uint256 tokenOneBalance = IERC20(tokenOne).balanceOf(address(this));
    uint256 tokenTwoBalance = IERC20(tokenTwo).balanceOf(address(this));
    
     return (tokenOneBalance, tokenTwoBalance);
  }
}
