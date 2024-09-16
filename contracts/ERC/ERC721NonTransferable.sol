pragma solidity ^0.8.20;

import "../RelayRecipient.sol";

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";


contract ERC721NonTransferable is RelayRecipient, ERC721, ERC721Pausable {
  using Strings for uint256;

  string baseURI = "";
  uint256 public totalSupply;

  mapping(address => string) public tokenURIs;
  mapping(address => uint256) public tokenOfOwnerByIndex;

  event NewBaseURI(string newBaseURI);
  event NewIssuerBaseURI(string newBaseURI, address indexed issuer);

  constructor (
    string memory name,
    string memory symbol,
    string memory uri,
    address forwarder
  )
  ERC721(name, symbol)
  {
    _setBaseURI(uri);
    _setTrustedForwarder(forwarder);
  }

  function _baseURI() internal override view returns (string memory) {
    return baseURI;
  }

  function _setBaseURI(string memory newBaseURI) private {
    baseURI = newBaseURI;
    emit NewBaseURI(newBaseURI);
  }

  function setBaseURI(string memory newBaseURI) public onlyOwner {
    _setBaseURI(newBaseURI);
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }


  function safeMint(address to) internal {
    uint256 tokenId = ++totalSupply;
    tokenOfOwnerByIndex[to]++;
    _safeMint(to, tokenId);
  }


  function _increaseBalance(address account, uint128 value) internal override {
    super._increaseBalance(account, value);
  }

  function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Pausable) returns (address) {
    require(_ownerOf(tokenId) == address(0), "You can't transfer this token");
    return super._update(to, tokenId, auth);
  }

  function tokenByIndex(uint256 index) external pure returns (uint256) {
    return index;
  }

  function setIssuerBaseURI(string calldata newBaseURI) external {
    address issuer = _msgSender();
    tokenURIs[issuer] = newBaseURI;
    emit NewIssuerBaseURI(newBaseURI, issuer);
  }

  function tokenURI(uint256 tokenId) public override view returns (string memory) {
    string memory issuerBaseURI = tokenURIs[ownerOf(tokenId)];
    return bytes(issuerBaseURI).length > 0 ? string.concat(issuerBaseURI, tokenId.toString()) :
    (bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString()) : "");
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
    return interfaceId == type(IERC721Enumerable).interfaceId || super.supportsInterface(interfaceId);
  }


  function _msgSender() internal override(Context, RelayRecipient) view returns (address ret) {
    return RelayRecipient._msgSender();
  }

  function _msgData() internal override(Context, RelayRecipient) view returns (bytes calldata ret) {
    return RelayRecipient._msgData();
  }
}
