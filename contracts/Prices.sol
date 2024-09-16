pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Prices
/// @author doubleHolg
/// @notice You can use this contract to get prices from Sanr oracles.
/// @dev Used in Predictions contract
contract Prices is Ownable {
  /// @notice Struct contain symbol price *10^18 and block timestamp when the price was saved to this contract
  struct Price {
    uint256 timestamp;
    uint256 price;
  }

  /// @notice Shows is the address allowed to push prices to this contract
  /// @dev variable. changing in setOperator()
  /// @return Bool that is true if the address allowed to push prices to this contract
  mapping(address => bool) public operators;
  /// @notice Shows the total number symbol prices on this contract
  /// @dev variable. changing in changePrice(). used to get current price in currentPrice()
  /// @return Total number of symbol prices on this contract
  mapping(bytes32 => uint256) public totalPrices;
  /// @notice Shows the symbol price *10^18 and block timestamp when the price was saved to this contract by the index which is the ordinal number of the saved prices for this symbol
  /// @dev variable. changing in changePrice(). used to get current price in currentPrice()
  mapping(bytes32 => mapping(uint256 => Price)) public pricesByIndex;

  /// @notice This event is emitted when contract owner approve or disapprove the operator address
  /// @dev emitted in setOperator() function
  /// @param operator The operator address
  /// @param authorized Is this address should be allowed to push prices
  event SetOperator(address indexed operator, bool indexed authorized);


  modifier onlyOperator() {
    require(operators[msg.sender], "Caller is not the operator");
    _;
  }


  constructor ()
  Ownable(msg.sender)
  {}


  /// @notice Get last saved symbol price
  /// @param symbol Symbol which price you want to see. Like 'BTC/USD'. In bytes32 'BTC/USD' is 0x4254432f55534400000000000000000000000000000000000000000000000000
  /// @return price Symbol price *10^18
  /// @return timestamp Timestamp when the price was saved to this contract
  /// @return index Total number of already saved prices for this symbol
  function currentPrice(bytes32 symbol) view public returns (uint256 price, uint256 timestamp, uint256 index) {
    uint256 totalPricesBySymbol = totalPrices[symbol];
    return (pricesByIndex[symbol][totalPricesBySymbol].price, pricesByIndex[symbol][totalPricesBySymbol].timestamp, totalPricesBySymbol);
  }
  /// @notice Get last saved symbols prices
  /// @param symbol Symbols which price you want to see. Like ['BTC/USD', 'BTC/ETH']. In bytes32 [0x4254432f55534400000000000000000000000000000000000000000000000000,0x4254432f45544800000000000000000000000000000000000000000000000000]
  /// @return prices Symbols prices *10^18
  /// @return timestamps Timestamps when the prices was saved to this contract
  /// @return indexes Total number of already saved prices for these symbols
  function currentPrices(bytes32[] calldata symbol) view external returns (uint256[] memory prices, uint256[] memory timestamps, uint256[] memory indexes) {
    prices = new uint256[](symbol.length);
    timestamps = new uint256[](symbol.length);
    indexes = new uint256[](symbol.length);

    for (uint256 i; i < symbol.length; i++) {
      (prices[i], timestamps[i], indexes[i]) = currentPrice(symbol[i]);
    }
  }

  /// @notice Shows the symbol prices *10^18 and block timestamps when the prices was saved to this contract by the indexes which is the ordinal numbers of the saved prices for this symbol
  /// @param symbol Symbol which price you want to see. Like 'BTC/USD'. In bytes32 'BTC/USD' is 0x4254432f55534400000000000000000000000000000000000000000000000000
  /// @param indexes Ordinal numbers of the saved prices for this symbol.
  /// @return prices Structs that contains symbol price *10^18 and block timestamp when the price was saved to this contract
  function pricesByIndexes(bytes32 symbol, uint256[] calldata indexes) view external returns (Price[] memory prices) {
    prices = new Price[](indexes.length);

    for (uint256 i; i < indexes.length; i++) {
      prices[i] = pricesByIndex[symbol][indexes[i]];
    }
  }

  /// @notice Saves new symbol price
  /// @param symbol Symbol which price oracle want to save. Like 'BTC/USD'. In bytes32 'BTC/USD' is 0x4254432f55534400000000000000000000000000000000000000000000000000
  /// @param newPrice Symbol price *10^18. So if BTC/USD new price is 50000 newPrice should be 50000000000000000000000
  function changePrice(bytes32 symbol, uint256 newPrice) public onlyOperator {
    uint256 totalPricesBySymbol = totalPrices[symbol]++;
    require(pricesByIndex[symbol][totalPricesBySymbol].price != newPrice, "Price the same");
    pricesByIndex[symbol][totalPricesBySymbol + 1].price = newPrice;
    pricesByIndex[symbol][totalPricesBySymbol + 1].timestamp = block.timestamp;
  }
  /// @notice Saves new symbols prices
  /// @param symbol Symbols which prices oracle want to save. Like ['BTC/USD', 'BTC/ETH']. In bytes32 [0x4254432f55534400000000000000000000000000000000000000000000000000,0x4254432f45544800000000000000000000000000000000000000000000000000]
  /// @param newPrice Symbol prices *10^18. So if BTC/USD new price is 50000 and BTC/ETH price is 3000 newPrice should be [50000000000000000000000,3000000000000000000000]
  function changePrices(bytes32[] calldata symbol, uint256[] calldata newPrice) external {
    for (uint256 i; i < symbol.length; i++) {
      changePrice(symbol[i], newPrice[i]);
    }
  }


  /// @notice Approve or disapprove the operator address
  /// @dev only for contract owner
  /// @param operator The operator address
  /// @param authorized Is this address should be allowed to push prices
  function setOperator(address operator, bool authorized) external onlyOwner {
    operators[operator] = authorized;
    emit SetOperator(operator, authorized);
  }
}
