pragma solidity ^0.4.19;
import "./Resolver.sol";


// solium-disable security/no-inline-assembly
contract Router {
  Resolver resolver;

  function Router(Resolver _resolver) public {
    resolver = _resolver;
  }

  function lookup(bytes4 sig, bytes data) public returns (address, uint) {
    return resolver.lookup(sig, data);
  }

  function() payable public {
    uint r;
    // Get routing information for the called function
    address destination;
    uint outsize;
    
    (destination, outsize) = lookup(msg.sig, msg.data);

    // Make the call
    assembly {
      calldatacopy(mload(0x40), 0, calldatasize)
      r := delegatecall(sub(gas, 700), destination, mload(0x40), calldatasize, mload(0x40), outsize)
    }

    // Throw if the call failed
    if (r != 1) { 
      revert();
    }

    // Pass on the return value
    assembly {
      return(mload(0x40), outsize)
    }
  }
}
