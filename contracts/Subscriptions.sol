// optimizer: {enabled: true, runs: 4294967295}


// File: contracts/Ownable.sol

pragma solidity 0.8.23;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
     */
  constructor() {
    _transferOwnership(msg.sender);
  }

  /**
   * @dev Throws if called by any account other than the owner.
     */
  modifier onlyOwner() {
    _checkOwner();
    _;
  }

  /**
   * @dev Returns the address of the current owner.
     */
  function owner() public view virtual returns (address) {
    return _owner;
  }

  /**
   * @dev Throws if the sender is not the owner.
     */
  function _checkOwner() internal view virtual {
    require(owner() == msg.sender, "Caller is not the owner");
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
  function transferOwnership(address newOwner) public virtual onlyOwner {
    require(newOwner != address(0), "New owner is the zero address");
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
  function _transferOwnership(address newOwner) internal virtual {
    address oldOwner = _owner;
    _owner = newOwner;
    emit OwnershipTransferred(oldOwner, newOwner);
  }
}

// File: contracts/SanrSharesV1.sol

pragma solidity 0.8.23;

/// @title Subscriptions
/// @author doubleHolg
/// @notice You can use this contract to subscribe to Sanr signal providers. One purchased share gives access to all subject's signals on https://sanr.app
/// @dev Mostly it is FriendtechSharesV1 with referral system
contract SanrSharesV1 is Ownable {
  /// @notice Shows the address where protocol fee are received
  /// @dev variable. changing in setFeeDestination()
  /// @return Address where protocol fee are received
  address public protocolFeeDestination;
  /// @notice Shows the percentage of the share price that goes to the protocol fee
  /// @dev variable. changing in setProtocolFeePercent()
  /// @return Percentage of the share price that goes to the protocolFeeDestination
  uint256 public protocolFeePercent;
  /// @notice Shows the percentage of the share price that goes to the subject fee
  /// @dev variable. changing in setSubjectFeePercent()
  /// @return Percentage of the share price that goes to the sharesSubject
  uint256 public subjectFeePercent;
  /// @notice Shows the total number of subjects
  /// @dev variable. changing in buyFirstShare(). used for external viewing only
  /// @return Total number of subjects
  uint256 public subjectsCount;

  /// @notice This event is emitted when a trade occurs
  /// @dev emitted in _buyShares() and sellShares() functions
  /// @param trader The trader account
  /// @param subject The Sanr signal provider account
  /// @param isBuy If this is true, then the trader bought the shares through this transaction. If it's false, the trader sold them
  /// @param shareAmount The amount of shares was traded
  /// @param ethAmount The amount of eth was traded
  /// @param ethAmountAfterFee The amount of eth that trader get or paid
  /// @param supply The subject's supply of shares after this trade
  event Trade(address indexed trader, address indexed subject, bool indexed isBuy, uint256 shareAmount, uint256 ethAmount, uint256 ethAmountAfterFee, uint256 supply);
  /// @notice This event is emitted when a subject purchased first share of its own, allowing other users to trade subject's shares
  /// @dev emitted in buyFirstShare() function
  /// @param subject The Sanr signal provider account which also trader in that case
  /// @param referrer The account that invited the subject to Sanr. By default it is protocolFeeDestination address
  event FirstTrade(address subject, address indexed referrer);
  /// @notice This event is emitted when a subject or referrer or protocol withdrawn all their collected fees.
  /// @dev emitted in withdrawAll() function
  /// @param user The subject or the referrer or the protocol account that decided to make withdraw
  /// @param amount The amount of collected eth
  event Withdrawn(address user, uint256 amount);
  /// @notice This event is emitted when contract owner set the address where protocol fee are received
  /// @dev emitted in setFeeDestination() function
  /// @param newFeeDestination The new protocol fee destination address
  event FeeDestinationWasSet(address newFeeDestination);
  /// @notice This event is emitted when contract owner set the percentage of the share price that goes to the protocol fee
  /// @dev emitted in setProtocolFeePercent() function
  /// @param newFeePercent The new protocol fee percent
  event ProtocolFeePercentWasSet(uint256 newFeePercent);
  /// @notice This event is emitted when contract owner set the percentage of the share price that goes to the subject fee
  /// @dev emitted in setSubjectFeePercent() function
  /// @param newFeePercent The new subject fee percent
  event SubjectFeePercentWasSet(uint256 newFeePercent);
  /// @notice This event is emitted when contract owner set the percentage of the share price that goes to the referrer on specified referrer level
  /// @dev emitted in setReferrerLevelFeePercent() function
  /// @param newFeePercent The new referrer fee percent on specified referrer level
  /// @param level The referrer level
  event ReferrerLevelFeePercentWasSet(uint256 newFeePercent, uint256 level);

  /// @notice Shows the balance of the subject's shares in the trader's account
  /// @dev mapping. sharesSubject => (trader => balance). param sharesSubject - The Sanr signal provider account. param trader - The trader account
  /// @return Balance of the subject's shares in the trader's account
  mapping(address => mapping(address => uint256)) public sharesBalance;
  /// @notice Shows the supply of subject's shares
  /// @dev mapping. sharesSubject => supply. param sharesSubject - The Sanr signal provider account
  /// @return Supply of subject's shares
  mapping(address => uint256) public sharesSupply;
  /// @notice Shows the account that invited the subject to Sanr
  /// @dev mapping. sharesSubject => referrer. param sharesSubject - The Sanr signal provider account
  /// @return Account that invited the subject to Sanr
  mapping(address => address) public referrers;
  /// @notice Shows the percentage of the share price that goes to the referrer on specified referrer level
  /// @dev mapping. level => feePercent. param level - The referrer level
  /// @return Percent of the share price that goes to the referrer on specified referrer level
  mapping(uint256 => uint256) public referrerLevelsFeePercents;
  /// @notice Shows amount of fees earned by the referrer over time
  /// @dev mapping. referrer => earned. used for external viewing only. param referrer - The account that invited a subjects to Sanr
  /// @return Amount of fees earned by the referrer
  mapping(address => uint256) public earnedByReferrerFees;
  /// @notice Shows amount of fees earned by the subject over time
  /// @dev mapping. subject => earned. used for external viewing only. param subject - The Sanr signal provider account
  /// @return Amount of fees earned by the subject
  mapping(address => uint256) public earnedBySubjectFees;
  /// @notice Shows subject's or referrer's or protocol's balance of earned fees
  /// @dev mapping. user => balance. param user - The subject or referrer or protocol account
  /// @return Balance of earned fees
  mapping(address => uint256) public balances;


  //for owner

  /// @dev check for avoid too high fee percent
  function _checkMaxReferrersPercent() private view {
    uint256 referrersFeePercent = 0;
    for (uint256 i = 0;; i++) {
      uint256 referrerFeePercent = referrerLevelsFeePercents[i];
      if (referrerFeePercent == 0) break;
      require(i < 50, "Too many referrers levels");
      referrersFeePercent += referrerFeePercent;
    }
    require(referrersFeePercent <= 0.1 ether, "Too high fee percent");
  }

  /// @notice Set the address where protocol fee are received
  /// @dev only for contract owner
  /// @param newFeeDestination The new protocol fee destination address
  function setFeeDestination(address newFeeDestination) public onlyOwner {
    protocolFeeDestination = newFeeDestination;
    emit FeeDestinationWasSet(newFeeDestination);
  }

  /// @notice Set the percentage of the share price that goes to the protocol fee
  /// @dev only for contract owner
  /// @param newFeePercent The new protocol fee percent
  function setProtocolFeePercent(uint256 newFeePercent) public onlyOwner {
    require(newFeePercent <= 0.1 ether, "Too high fee percent");
    protocolFeePercent = newFeePercent;
    emit ProtocolFeePercentWasSet(newFeePercent);
  }

  /// @notice Set the address where subject fee are received
  /// @dev only for contract owner
  /// @param newFeePercent The new subject fee percent
  function setSubjectFeePercent(uint256 newFeePercent) public onlyOwner {
    require(newFeePercent <= 0.1 ether, "Too high fee percent");
    subjectFeePercent = newFeePercent;
    emit SubjectFeePercentWasSet(newFeePercent);
  }

  /// @notice Set the percentage of the share price that goes to the referrer on specified referrer level
  /// @dev only for contract owner
  /// @param newFeePercent The new referrer fee percent on specified referrer level
  /// @param level The referrer level
  function setReferrerLevelFeePercent(uint256 newFeePercent, uint256 level) public onlyOwner {
    referrerLevelsFeePercents[level] = newFeePercent;
    _checkMaxReferrersPercent();
    emit ReferrerLevelFeePercentWasSet(newFeePercent, level);
  }


  // view

  /// @notice Show price of that amount of shares
  /// @dev for amount == 1 price is supply^2 * 1 ether / 16000. same as in friend tech contract
  /// @param supply The subject's supply of shares. For selling price it should be (supply - amount)
  /// @param amount The amount of shares whose price is calculated
  /// @return Price of that amount of shares
  function getPrice(uint256 supply, uint256 amount) public pure returns (uint256) {
    uint256 sum1 = supply == 0 ? 0 : (supply - 1) * (supply) * (2 * (supply - 1) + 1) / 6;
    uint256 sum2 = supply == 0 && amount == 1 ? 0 : (supply + amount - 1) * (supply + amount) * (2 * (supply + amount - 1) + 1) / 6;
    uint256 summation = sum2 - sum1;
    return summation * 1 ether / 16000;
  }

  /// @notice Show buy price of that amount of subject's shares
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares whose price is calculated
  /// @return Buy price of that amount of subject's shares
  function getBuyPrice(address sharesSubject, uint256 amount) public view returns (uint256) {
    return getPrice(sharesSupply[sharesSubject], amount);
  }

  /// @notice Show sell price of that amount of subject's shares
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares whose price is calculated
  /// @return Sell price of that amount of subject's shares
  function getSellPrice(address sharesSubject, uint256 amount) public view returns (uint256) {
    return getPrice(sharesSupply[sharesSubject] - amount, amount);
  }

  /// @notice Show amount of fee that goes to the all subject's referrers
  /// @param price The shares price
  /// @return Amount of fee that goes to the all subject's referrers
  function getReferrersFee(uint256 price) public view returns (uint256) {
    uint256 referrersFee = 0;
    for (uint256 i = 0;; i++) {
      uint256 referrerFeePercent = referrerLevelsFeePercents[i];
      if (referrerFeePercent == 0) break;
      referrersFee += price * referrerFeePercent / 1 ether;
    }
    return referrersFee;
  }

  /// @notice Show the amount of eth that trader will paid
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares whose price is calculated
  /// @return Amount of eth that trader will paid
  function getBuyPriceAfterFee(address sharesSubject, uint256 amount) public view returns (uint256) {
    uint256 price = getBuyPrice(sharesSubject, amount);
    uint256 protocolFee = price * protocolFeePercent / 1 ether;
    uint256 subjectFee = price * subjectFeePercent / 1 ether;

    uint256 referrersFee = getReferrersFee(price);

    return price + protocolFee + subjectFee + referrersFee;
  }

  /// @notice Show the amount of eth that trader will get
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares whose price is calculated
  /// @return Amount of eth that trader will get
  function getSellPriceAfterFee(address sharesSubject, uint256 amount) public view returns (uint256) {
    uint256 price = getSellPrice(sharesSubject, amount);
    uint256 protocolFee = price * protocolFeePercent / 1 ether;
    uint256 subjectFee = price * subjectFeePercent / 1 ether;

    uint256 referrersFee = getReferrersFee(price);

    return price - protocolFee - subjectFee - referrersFee;
  }


  // core

  /// @notice Withdraw all collected fees
  function withdrawAll() external {
    address cachedSender = msg.sender;

    uint256 balance = balances[cachedSender];
    balances[cachedSender] = 0;

    emit Withdrawn(cachedSender, balance);

    (bool success,) = cachedSender.call{value : balance}("");
    require(success, "Unable to withdraw");
  }

  function _increaseReferrersBalances(address sharesSubject, uint256 price) private {
    address prevReferrer = sharesSubject;
    for (uint256 i = 0;; i++) {
      uint256 referrerFeePercent = referrerLevelsFeePercents[i];
      if (referrerFeePercent == 0) break;

      address referrer;
      if (prevReferrer == protocolFeeDestination) referrer = protocolFeeDestination;
      else referrer = referrers[prevReferrer];

      earnedByReferrerFees[referrer] += price * referrerFeePercent / 1 ether;

      balances[referrer] += price * referrerFeePercent / 1 ether;

      prevReferrer = referrer;
    }
  }

  /// @notice Purchase first share of self. Allowing other users to trade my shares. Set referrer
  /// @param referrer The account that invited the subject to Sanr. By default it is protocolFeeDestination address
  /// @param amount The amount of shares to be purchased. Price is 0 for the first share
  function buyFirstShare(address referrer, uint256 amount) external payable {
    address cachedSender = msg.sender;

    require(sharesSupply[cachedSender] == 0, "Call buyShares instead");
    require(referrer == protocolFeeDestination || referrers[referrer] != address(0), "Invalid referrer");
    referrers[cachedSender] = referrer;

    _buyShares(cachedSender, amount);

    emit FirstTrade(cachedSender, referrer);
    subjectsCount++;
  }

  /// @notice Purchase share of subject
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares to be purchased
  function buyShares(address sharesSubject, uint256 amount) external payable {
    require(sharesSupply[sharesSubject] > 0, "Call buyFirstShare instead");
    _buyShares(sharesSubject, amount);
  }

  /// @notice Purchase share of subject
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares to be purchased
  function _buyShares(address sharesSubject, uint256 amount) private {
    address cachedSender = msg.sender;
    uint256 cachedValue = msg.value;

    uint256 supply = sharesSupply[sharesSubject];
    uint256 price = getPrice(supply, amount);
    uint256 protocolFee = price * protocolFeePercent / 1 ether;
    uint256 subjectFee = price * subjectFeePercent / 1 ether;

    uint256 referrersFee = getReferrersFee(price);
    uint256 priceAfterFee = price + protocolFee + subjectFee + referrersFee;
    require(cachedValue >= priceAfterFee, "Insufficient payment");

    sharesBalance[sharesSubject][cachedSender] = sharesBalance[sharesSubject][cachedSender] + amount;
    sharesSupply[sharesSubject] = supply + amount;
    emit Trade(cachedSender, sharesSubject, true, amount, price, priceAfterFee, supply + amount);

    earnedBySubjectFees[sharesSubject] += subjectFee;

    balances[protocolFeeDestination] += protocolFee;
    balances[sharesSubject] += subjectFee;
    _increaseReferrersBalances(sharesSubject, price);

    if (cachedValue > priceAfterFee) {
      (bool success,) = cachedSender.call{value : cachedValue - priceAfterFee}("");
      require(success, "Unable to send change");
    }
  }

  /// @notice Sell share of subject
  /// @param sharesSubject The Sanr signal provider account
  /// @param amount The amount of shares to be sold
  function sellShares(address sharesSubject, uint256 amount) external {
    address cachedSender = msg.sender;

    uint256 supply = sharesSupply[sharesSubject];
    require(supply > amount, "Cannot sell the last share");
    uint256 price = getPrice(supply - amount, amount);
    uint256 protocolFee = price * protocolFeePercent / 1 ether;
    uint256 subjectFee = price * subjectFeePercent / 1 ether;
    uint256 referrersFee = getReferrersFee(price);
    require(sharesBalance[sharesSubject][cachedSender] >= amount, "Insufficient shares");
    sharesBalance[sharesSubject][cachedSender] = sharesBalance[sharesSubject][cachedSender] - amount;
    sharesSupply[sharesSubject] = supply - amount;

    uint256 priceAfterFee = price - protocolFee - subjectFee - referrersFee;
    emit Trade(cachedSender, sharesSubject, false, amount, price, priceAfterFee, supply - amount);

    earnedBySubjectFees[sharesSubject] += subjectFee;

    balances[protocolFeeDestination] += protocolFee;
    balances[sharesSubject] += subjectFee;
    _increaseReferrersBalances(sharesSubject, price);

    (bool success,) = cachedSender.call{value : priceAfterFee}("");
    require(success, "Unable to send funds");
  }
}
