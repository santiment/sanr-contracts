pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@opengsn/contracts/src/ERC2771Recipient.sol";

contract RelayRecipient is ERC2771Recipient, Ownable {

  constructor ()
  Ownable(msg.sender)
  {}

  function setTrustedForwarder(address forwarder) external onlyOwner {
    _setTrustedForwarder(forwarder);
  }

  function getTrustedForwarder() public override view returns (address){
    return ERC2771Recipient.getTrustedForwarder();
  }

  function isTrustedForwarder(address forwarder) public override view returns (bool) {
    return ERC2771Recipient.isTrustedForwarder(forwarder);
  }


  function _msgSender() internal override(Context, ERC2771Recipient) virtual view returns (address ret) {
    return ERC2771Recipient._msgSender();
  }

  function _msgData() internal override(Context, ERC2771Recipient) virtual view returns (bytes calldata ret) {
    return ERC2771Recipient._msgData();
  }
}
