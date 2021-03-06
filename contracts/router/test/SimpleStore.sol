pragma solidity ^0.4.19;


contract SimpleStore {
  address resolver;
  uint n;

  function store(uint _n) public {
    n = _n;
  }

  function getStored() view public returns (uint) {
    return n;
  }
}
