pragma solidity ^0.4.19;


contract One {
  address resolver;
  uint one;
  
  function setOne(uint _one) public {
    one = _one;
  }

  function getOne() view public returns(uint) {
    return one;
  }
}
