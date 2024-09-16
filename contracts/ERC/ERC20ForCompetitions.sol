pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../RelayRecipient.sol";


contract ERC20ForCompetitions is RelayRecipient, ERC20 {
  uint256 public cap = 83336999999999999999999000;
  uint256 public gasPriceFactor = 1 ether;
  uint256 public minGasAmount = 0.001 ether;

  mapping(address => bool) public isApprovedContract;

  event Received(address indexed sender, uint256 amount);
  event SetApprovedContract(address approvedContract, bool authorized);
  event GasPriceFactorChanged(uint256 indexed newGasPriceFactor);
  event MinGasAmountChanged(uint256 indexed newMinGasAmount);

  constructor(
    string memory _name,
    string memory _symbol,
    address forwarder
  )
  ERC20(_name, _symbol)
  {
    _setTrustedForwarder(forwarder);
  }


  function getGas(uint256 amount) external {
    uint256 gasAmount = amount * gasPriceFactor / 1 ether;
    require(gasAmount > minGasAmount, "gas amount less then min");

    _transfer(_msgSender(), address(this), amount);

    (bool success,) = _msgSender().call{value : gasAmount}('');
    require(success, 'transfer failed');
  }

  function transferFrom(address from, address to, uint value) public override returns (bool) {
    if (!_isUnlimitedAllowance(from)) {
      _spendAllowance(from, _msgSender(), value);
    }
    _transfer(from, to, value);
    return true;
  }

  function _isUnlimitedAllowance(address from) private view returns (bool) {
    return allowance(from, _msgSender()) == type(uint256).max || isApprovedContract[_msgSender()] && tx.origin == from;
  }

  function setApprovedContract(address approvedContract, bool authorized) external onlyOwner {
    require(approvedContract != address(0));
    // Action Blocked - Not a valid address
    isApprovedContract[approvedContract] = authorized;
    emit SetApprovedContract(approvedContract, authorized);
  }


  function mint(address to, uint256 value) external onlyOwner {
    require(totalSupply() + value <= cap, "cap reached");
    _mint(to, value);
  }


  function changeGasPriceFactor(uint256 newGasPriceFactor) external onlyOwner {
    gasPriceFactor = newGasPriceFactor;

    emit GasPriceFactorChanged(newGasPriceFactor);
  }

  function changeMinGasAmount(uint256 newMinGasAmount) external onlyOwner {
    minGasAmount = newMinGasAmount;

    emit MinGasAmountChanged(newMinGasAmount);
  }


  function _msgSender() internal override(Context, RelayRecipient) view returns (address ret) {
    return ERC2771Recipient._msgSender();
  }

  function _msgData() internal override(Context, RelayRecipient) view returns (bytes calldata ret) {
    return ERC2771Recipient._msgData();
  }

  receive() external payable onlyOwner {
    emit Received(_msgSender(), msg.value);
  }
}
