pragma solidity ^0.8.17;

import "./ERC/ERC721NonTransferable.sol";

contract Signals is ERC721NonTransferable {
  uint256 dataTypesTotalCount;

  struct Signal {
    uint256 dataTypeID;
    uint256 timestamp;
    bytes32 dataHash; // ERC712
    address issuer;
  }

  mapping(uint256 => Signal) public signals; // starts at 1
  mapping(uint256 => string) public dataTypes; // starts at 1

  event SignalCreated(
    uint256 indexed dataTypeID,
    bytes32 indexed dataHash
  );
  event DataTypeCreated(
    uint256 indexed newDataTypeID,
    address indexed issuer
  );

  constructor(
    string memory name,
    string memory symbol,
    string memory uri,
    address forwarder
  )
  ERC721NonTransferable(name, symbol, uri, forwarder)
  {}

  function createSignals(uint256[] calldata dataTypeID, bytes32[] calldata dataHash) external {
    require(dataTypeID.length == dataHash.length, "Arrays lengths not same");

    address issuer = _msgSender();
    for (uint256 i; i < dataTypeID.length; i++) {
      _createSignal(dataTypeID[i], dataHash[i], issuer);
    }
  }

  function createSignal(uint256 dataTypeID, bytes32 dataHash) external {
    address issuer = _msgSender();
    _createSignal(dataTypeID, dataHash, issuer);
  }

  function _createSignal(uint256 dataTypeID, bytes32 dataHash, address issuer) private {
    require(bytes(dataTypes[dataTypeID]).length != 0, "Non-existent dataTypeID");

    super.safeMint(issuer);
    signals[totalSupply] = Signal(
      dataTypeID,
      block.timestamp,
      dataHash,
      issuer
    );
    emit SignalCreated(dataTypeID, dataHash);
  }

  function createDataType(string calldata newDataType) external {
    dataTypesTotalCount++;
    dataTypes[dataTypesTotalCount] = newDataType;
    emit DataTypeCreated(dataTypesTotalCount, _msgSender());
  }
}
