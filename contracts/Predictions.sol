pragma solidity ^0.8.17;

import "./ERC/ERC721NonTransferable.sol";

import "./Prices.sol";

import "./competitions/Competitions.sol";


contract Predictions is ERC721NonTransferable {
  address public pricesAddress;
  address public competitionsAddress;

  uint256 public predictionsLifetime = 2 * 7 * 24 * 60 * 60;
  uint256 public durationToClosePredictions = 24 * 60 * 60; //10 * 60;

  uint256 public maxOpenPredictionsCount = 5;
  uint256 public maxLeverage = 10;

  struct LifecycleInfo {
    bool openWhenPriceMoreThen;
    uint256 createdPriceIndex;
    uint256 openPrice;
    uint256 openTimestamp; // 0 if prediction created but not open
    uint256 openPriceIndex; // 0 if prediction created but not open
    uint256 predictionChangedTimestamp;
    uint256 closePrice;
    uint256 closeTimestamp;
    uint256 closePriceIndex;
    uint256 lifetime;
  }

  struct ChangeableInfo {
    uint256 stopLossPrice;
    uint256 takeProfitPrice;
  }

  struct Prediction {
    address issuer;
    bytes32 symbol;
    bytes32 entropy;
    bytes32 salt;
    bool isDirectionUp;
    bytes32 infoHash;
    ChangeableInfo changeableInfo;
    LifecycleInfo lifecycleInfo;
    uint256 leverage;
  }

  struct NewPredictionParams {
    address issuer;
    bytes32 symbol;
    bytes32 entropy;
    bytes32 infoHash;

    uint256 stopLossPrice;
    uint256 takeProfitPrice;

    uint256 expectedTopPrice;
    uint256 expectedBottomPrice;
    uint256 expectedTime;

    uint256 openPrice;
    uint256 leverage;
    bool openWhenPriceMoreThen;
  }

  mapping(uint256 => Prediction) public predictions; // starts at 1
  mapping(bytes32 => uint256) public predictionByInfoHash;
  mapping(address => uint256) public openPredictionsCount;
  mapping(address => bool) public isDefaultOracleUntrusted;
  mapping(address => mapping(address => bool)) public isOracleTrusted; // issuer => (oracle => isTrusted)

  event PredictionCreated(
    uint256 predictionID,
    address indexed issuer,
    address indexed oracle,
    bytes32 indexed infoHash
  );

  event PredictionOpened(
    uint256 indexed predictionID,
    address indexed issuer,
    address indexed oracle
  );

  event PredictionClosed(
    uint256 indexed predictionID,
    address indexed issuer,
    address indexed oracle,
    int256 predictionPerformance
  );

  event PredictionExpired(
    uint256 indexed predictionID,
    address indexed issuer,
    address indexed oracle
  );

  event PredictionCanceled(
    uint256 indexed predictionID,
    address indexed issuer,
    address indexed oracle
  );

  event PredictionChanged(
    uint256 indexed predictionID,
    address indexed issuer,
    address indexed oracle
  );


  event PredictionsLifetimeChanged(uint256 indexed newPredictionsLifetime);
  event DurationToClosePredictionsChanged(uint256 indexed newDurationToClosePredictions);
  event PricesAddressChanged(address indexed newPricesAddress);
  event CompetitionsAddressChanged(address indexed newCompetitionsAddress);
  event MaxOpenPredictionsCountChanged(uint256 indexed newMaxOpenPredictionsCount);
  event MaxLeverageChanged(uint256 indexed newMaxLeverage);
  event OracleTrusted(address indexed issuer, address indexed oracle, bool indexed isTrusted);
  event DefaultOracleUntrusted(address indexed issuer, bool indexed isUntrusted);

  modifier onlyTrustedOracle(uint256 predictionID) {
    require(isOracleTrustedByIssuerOrOwner(predictions[predictionID].issuer, _msgSender()), "Only for trusted oracle");
    _;
  }

  modifier onlyForNotClosedPredictions(uint256 predictionID) {
    require(predictions[predictionID].lifecycleInfo.closeTimestamp == 0, "Prediction is closed");
    _;
  }

  modifier onlyForNotOpenPredictions(uint256 predictionID) {
    require(predictions[predictionID].lifecycleInfo.openTimestamp == 0, "Prediction is open");
    _;
  }

  modifier onlyForOpenPredictions(uint256 predictionID) {
    require(predictions[predictionID].lifecycleInfo.openTimestamp != 0, "Prediction is not open");
    _;
  }

  constructor(
    string memory name,
    string memory symbol,
    string memory uri,
    address _pricesAddress,
    address forwarder
  )
  ERC721NonTransferable(name, symbol, uri, forwarder)
  {
    pricesAddress = _pricesAddress;
  }

  function isOracleTrustedByIssuerOrOwner(address issuer, address oracle) public view returns (bool) {
    return issuer == oracle || (isOracleTrusted[owner()][oracle] && !isDefaultOracleUntrusted[issuer]) || isOracleTrusted[issuer][oracle];
  }

  function getInfoHash(bytes32 salt, bool isDirectionUp) public pure returns (bytes32 infoHash) {
    return keccak256(abi.encode(
        keccak256('Info(bytes32 salt,bool isDirectionUp)'),
        salt,
        isDirectionUp
      ));
  }

  function getPredictions(uint256[] calldata ids) view external returns (Prediction[] memory predictionsArray) {
    predictionsArray = new Prediction[](ids.length);

    for (uint256 i; i < ids.length; i++) {
      predictionsArray[i] = predictions[ids[i]];
    }
  }

  function checkOpenTriggerPrice(bool openWhenPriceMoreThen, uint256 openPrice, uint256 expectedTopPrice, uint256 expectedBottomPrice, bytes32 symbol) view private returns (uint256) {
    (uint256 currentPrice,,uint256 createdPriceIndex) = Prices(pricesAddress).currentPrice(symbol);
    require(currentPrice != 0, "Only existed prices");
    require(currentPrice < expectedTopPrice, "Price more then expected");
    require(currentPrice > expectedBottomPrice, "Price less then expected");

    if (openWhenPriceMoreThen)
      require(currentPrice < openPrice, "Current price should be less then open price");
    else
      require(currentPrice > openPrice, "Current price should be more then open price");

    return createdPriceIndex;
  }

  function newPredictions(
    NewPredictionParams[] calldata params
  )
  external {
    for (uint256 i; i < params.length; i++) {
      newPrediction(
        params[i].issuer,
        params[i].symbol,
        params[i].entropy,
        params[i].infoHash,
        params[i].stopLossPrice,
        params[i].takeProfitPrice,
        params[i].expectedTopPrice,
        params[i].expectedBottomPrice,
        params[i].expectedTime,
        params[i].openPrice,
        params[i].leverage,
        params[i].openWhenPriceMoreThen
      );
    }
  }

  function newPrediction(
    address issuer,
    bytes32 symbol,
    bytes32 entropy,
    bytes32 infoHash,

    uint256 stopLossPrice,
    uint256 takeProfitPrice,

    uint256 expectedTopPrice,
    uint256 expectedBottomPrice,
    uint256 expectedTime,

    uint256 openPrice,
    uint256 leverage,
    bool openWhenPriceMoreThen
  )
  public {
    // we do that to prevent oracle mint one prediction many times
    require(predictionByInfoHash[infoHash] == 0, "Not unique infoHash");
    require(leverage <= maxLeverage, "Leverage more then max");

    openPredictionsCount[issuer]++;
    require(openPredictionsCount[issuer] <= maxOpenPredictionsCount, "Open count more then max");

    super.safeMint(issuer);

    predictions[totalSupply] = Prediction(
      issuer,
      symbol,
      entropy,
      0,
      false,
      infoHash,
      ChangeableInfo(stopLossPrice, takeProfitPrice),
      getLifecycleInfo(_msgSender(), issuer, symbol, openPrice, expectedTopPrice, expectedBottomPrice, expectedTime, openWhenPriceMoreThen),
      leverage
    );

    emitNewPredictionEvents(_msgSender(), issuer, infoHash, totalSupply);
  }

  function emitNewPredictionEvents(address oracle, address issuer, bytes32 infoHash, uint256 signalID) private {
    predictionByInfoHash[infoHash] = signalID;

    if (predictions[signalID].lifecycleInfo.openTimestamp != 0) {
      emit PredictionOpened(signalID, issuer, oracle);
      if (competitionsAddress != address(0))
        Competitions(competitionsAddress).openPredictionInCompetition(issuer, signalID);
    }

    emit PredictionCreated(signalID, issuer, oracle, infoHash);
  }


  function getLifecycleInfo(address oracle, address issuer, bytes32 symbol, uint256 openPrice, uint256 expectedTopPrice, uint256 expectedBottomPrice, uint256 expectedTime, bool openWhenPriceMoreThen) private view returns (LifecycleInfo memory) {
    require(isOracleTrustedByIssuerOrOwner(issuer, oracle), "Untrusted oracle");

    uint256 blockTimestamp = block.timestamp;

    require(blockTimestamp < expectedTime, "Expected time expired");

    uint256 openTimestamp = 0;
    uint256 openPriceIndex = 0;
    if (openPrice == 0) {
      (openPrice,,openPriceIndex) = Prices(pricesAddress).currentPrice(symbol);
      require(openPrice != 0, "Only existed prices");
      require(openPrice < expectedTopPrice, "Price more then expected");
      require(openPrice > expectedBottomPrice, "Price less then expected");
      openTimestamp = blockTimestamp;
    } else {
      openPriceIndex = checkOpenTriggerPrice(openWhenPriceMoreThen, openPrice, expectedTopPrice, expectedBottomPrice, symbol);
    }

    return LifecycleInfo(
      openWhenPriceMoreThen,
      openPriceIndex,
      openPrice,
      openTimestamp,
      (openTimestamp == 0 ? 0 : openPriceIndex),
      blockTimestamp,
      0, 0, 0,
      predictionsLifetime
    );
  }


  function openPredictions(uint256[] calldata predictionIDs, uint256[] calldata priceIndexes) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      openPrediction(predictionIDs[i], priceIndexes[i]);
    }
  }

  function openPrediction(uint256 predictionID, uint256 priceIndex) public onlyForNotClosedPredictions(predictionID) onlyForNotOpenPredictions(predictionID) {
    require(priceIndex >= predictions[predictionID].lifecycleInfo.createdPriceIndex, "Incorrect price index");

    (uint256 priceTimestamp, uint256 price) = Prices(pricesAddress).pricesByIndex(predictions[predictionID].symbol, priceIndex);
    require(price != 0, "Only existed prices");

    if (predictions[predictionID].lifecycleInfo.openWhenPriceMoreThen)
      require(price >= predictions[predictionID].lifecycleInfo.openPrice, "Price should be more then open price");
    else
      require(price <= predictions[predictionID].lifecycleInfo.openPrice, "Price should be less then open price");

    predictions[predictionID].lifecycleInfo.openTimestamp = priceTimestamp;
    predictions[predictionID].lifecycleInfo.openPriceIndex = priceIndex;

    if (competitionsAddress != address(0))
      Competitions(competitionsAddress).openPredictionInCompetition(predictions[predictionID].issuer, predictionID);

    emit PredictionOpened(predictionID, predictions[predictionID].issuer, _msgSender());
  }


  // in case when direction info is lost
  function burnPredictionToIncreaseOpenPredictionsCount(uint256 predictionID) external onlyTrustedOracle(predictionID) onlyForOpenPredictions(predictionID) onlyForNotClosedPredictions(predictionID) {
    require(block.timestamp > predictions[predictionID].lifecycleInfo.openTimestamp + predictions[predictionID].lifecycleInfo.lifetime + durationToClosePredictions, "Duration is not ended");

    predictions[predictionID].lifecycleInfo.closeTimestamp = block.timestamp;
    openPredictionsCount[predictions[predictionID].issuer]--;

    emit PredictionExpired(predictionID, predictions[predictionID].issuer, _msgSender());
  }


  function cancelPredictions(uint256[] calldata predictionIDs) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      cancelPrediction(predictionIDs[i]);
    }
  }

  function cancelPrediction(uint256 predictionID) public onlyTrustedOracle(predictionID) onlyForNotOpenPredictions(predictionID) onlyForNotClosedPredictions(predictionID) {
    predictions[predictionID].lifecycleInfo.closeTimestamp = block.timestamp;
    openPredictionsCount[predictions[predictionID].issuer]--;

    emit PredictionCanceled(predictionID, predictions[predictionID].issuer, _msgSender());
  }


  function getPredictionPerformance(uint256 predictionID) view public returns (int256) {
    int256 openPrice = int256(predictions[predictionID].lifecycleInfo.openPrice);
    int256 predictionPerformance = ((int256(predictions[predictionID].lifecycleInfo.closePrice) - openPrice) * 1 ether) / openPrice;
    if (!predictions[predictionID].isDirectionUp) predictionPerformance = - predictionPerformance;
    return predictionPerformance * int256(predictions[predictionID].leverage);
  }

  function getRealStopLossTakeProfit(uint256 predictionID, bool isDirectionUp) view public returns (uint256 stopLossPrice, uint256 takeProfitPrice) {
    uint256 possibleStopLossPrice = predictions[predictionID].changeableInfo.stopLossPrice;
    uint256 possibleTakeProfitPrice = predictions[predictionID].changeableInfo.takeProfitPrice;

    stopLossPrice = possibleStopLossPrice;
    takeProfitPrice = possibleTakeProfitPrice;
    if (!isDirectionUp) {
      stopLossPrice = possibleTakeProfitPrice;
      takeProfitPrice = possibleStopLossPrice;
    }
  }

  function _closePrediction(
    uint256 predictionID,
    bytes32 salt,
    bool isDirectionUp
  )
  private {
    address issuer = predictions[predictionID].issuer;

    predictions[predictionID].salt = salt;
    predictions[predictionID].isDirectionUp = isDirectionUp;

    require(getInfoHash(salt, isDirectionUp) == predictions[predictionID].infoHash, "Info hash is wrong");

    openPredictionsCount[issuer]--;

    int256 predictionPerformance = getPredictionPerformance(predictionID);

    if (competitionsAddress != address(0))
      Competitions(competitionsAddress).closePredictionInCompetition(issuer, predictionID, predictionPerformance);

    emit PredictionClosed(predictionID, issuer, _msgSender(), predictionPerformance);
  }


  function closePredictions(
    uint256[] calldata predictionIDs,
    uint256[] calldata expectedPrices,
    bytes32[] calldata salt,
    bool[] calldata isDirectionUp
  ) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      closePrediction(predictionIDs[i], expectedPrices[i], salt[i], isDirectionUp[i]);
    }
  }

  function closePrediction(
    uint256 predictionID,
    uint256 expectedPrice,
    bytes32 salt,
    bool isDirectionUp
  )
  public onlyForOpenPredictions(predictionID) onlyForNotClosedPredictions(predictionID) onlyTrustedOracle(predictionID) {
    (uint256 closePrice,, uint256 closePriceIndex) = Prices(pricesAddress).currentPrice(predictions[predictionID].symbol);
    if (isDirectionUp)
      require(closePrice > expectedPrice, "Price less then expected");
    else
      require(closePrice < expectedPrice, "Price more then expected");

    predictions[predictionID].lifecycleInfo.closePrice = closePrice;
    predictions[predictionID].lifecycleInfo.closePriceIndex = closePriceIndex;
    predictions[predictionID].lifecycleInfo.closeTimestamp = block.timestamp;

    _closePrediction(predictionID, salt, isDirectionUp);
  }

  function closeTimeEndedPredictions(
    uint256[] calldata predictionIDs,
    bytes32[] calldata salt,
    bool[] calldata isDirectionUp
  ) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      closeTimeEndedPrediction(predictionIDs[i], salt[i], isDirectionUp[i]);
    }
  }

  function closeTimeEndedPrediction(
    uint256 predictionID,
    bytes32 salt,
    bool isDirectionUp
  )
  public onlyForOpenPredictions(predictionID) onlyForNotClosedPredictions(predictionID) {
    require((block.timestamp - predictions[predictionID].lifecycleInfo.openTimestamp) >= predictions[predictionID].lifecycleInfo.lifetime, "Only for live time ended");

    (uint256 closePrice,, uint256 closePriceIndex) = Prices(pricesAddress).currentPrice(predictions[predictionID].symbol);

    predictions[predictionID].lifecycleInfo.closePrice = closePrice;
    predictions[predictionID].lifecycleInfo.closePriceIndex = closePriceIndex;
    predictions[predictionID].lifecycleInfo.closeTimestamp = block.timestamp;

    _closePrediction(predictionID, salt, isDirectionUp);
  }

  function closePredictionsByPriceIndex(
    uint256[] calldata predictionIDs,
    bytes32[] calldata salt,
    bool[] calldata isDirectionUp,
    uint256[] calldata priceIndexes
  ) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      closePredictionByPriceIndex(predictionIDs[i], salt[i], isDirectionUp[i], priceIndexes[i]);
    }
  }

  function closePredictionByPriceIndex(
    uint256 predictionID,
    bytes32 salt,
    bool isDirectionUp,
    uint256 priceIndex
  )
  public onlyForOpenPredictions(predictionID) onlyForNotClosedPredictions(predictionID) {
    uint256 priceByIndex;
    uint256 priceTimestamp;
    uint256 predictionChangedTimestamp = predictions[predictionID].lifecycleInfo.predictionChangedTimestamp;

    // we need do that even priceIndex == openPriceIndex because price contract might be changed
    (priceTimestamp, priceByIndex) = Prices(pricesAddress).pricesByIndex(predictions[predictionID].symbol, priceIndex);

    require((priceTimestamp >= predictionChangedTimestamp)
      || ((priceIndex == predictions[predictionID].lifecycleInfo.openPriceIndex) && (predictionChangedTimestamp <= predictions[predictionID].lifecycleInfo.openTimestamp))
    , "Incorrect price timestamp");
    require(priceByIndex != 0, "Only existed prices");

    (uint256 stopLossPrice,uint256 takeProfitPrice) = getRealStopLossTakeProfit(predictionID, isDirectionUp);

    require((stopLossPrice != 0 && ((isDirectionUp && priceByIndex <= stopLossPrice) || (!isDirectionUp && priceByIndex >= stopLossPrice)))
      || (takeProfitPrice != 0 && ((isDirectionUp && priceByIndex >= takeProfitPrice) || (!isDirectionUp && priceByIndex <= takeProfitPrice))),
      "Only for stop loss or take profit closing");

    predictions[predictionID].lifecycleInfo.closeTimestamp = priceTimestamp;
    predictions[predictionID].lifecycleInfo.closePriceIndex = priceIndex;
    predictions[predictionID].lifecycleInfo.closePrice = priceByIndex;

    _closePrediction(predictionID, salt, isDirectionUp);
  }


  function changePredictions(
    uint256[] calldata predictionIDs,
    uint256[] calldata stopLossPrice,
    uint256[] calldata takeProfitPrice
  ) external {
    for (uint256 i; i < predictionIDs.length; i++) {
      changePrediction(predictionIDs[i], stopLossPrice[i], takeProfitPrice[i]);
    }
  }

  function changePrediction(
    uint256 predictionID,
    uint256 stopLossPrice,
    uint256 takeProfitPrice
  )
  public onlyTrustedOracle(predictionID) onlyForNotClosedPredictions(predictionID) {
    ChangeableInfo memory changeableInfo = ChangeableInfo(stopLossPrice, takeProfitPrice);
    predictions[predictionID].changeableInfo = changeableInfo;
    predictions[predictionID].lifecycleInfo.predictionChangedTimestamp = block.timestamp;

    emit PredictionChanged(predictionID, predictions[predictionID].issuer, _msgSender());
  }


  function changePredictionsLifetime(uint256 newPredictionsLifetime) external onlyOwner {
    predictionsLifetime = newPredictionsLifetime;

    emit PredictionsLifetimeChanged(newPredictionsLifetime);
  }

  function changeDurationToClosePredictions(uint256 newDurationToClosePredictions) external onlyOwner {
    durationToClosePredictions = newDurationToClosePredictions;

    emit DurationToClosePredictionsChanged(newDurationToClosePredictions);
  }

  function changePricesAddress(address newPricesAddress) external onlyOwner {
    pricesAddress = newPricesAddress;

    emit PricesAddressChanged(newPricesAddress);
  }

  function changeCompetitionsAddress(address newCompetitionsAddress) external onlyOwner {
    competitionsAddress = newCompetitionsAddress;

    emit CompetitionsAddressChanged(newCompetitionsAddress);
  }

  function changeMaxOpenPredictionsCount(uint256 newMaxOpenPredictionsCount) external onlyOwner {
    maxOpenPredictionsCount = newMaxOpenPredictionsCount;

    emit MaxOpenPredictionsCountChanged(newMaxOpenPredictionsCount);
  }

  function changeMaxLeverage(uint256 newMaxLeverage) external onlyOwner {
    maxLeverage = newMaxLeverage;

    emit MaxLeverageChanged(newMaxLeverage);
  }

  function disapproveDefaultOracle(bool isUntrusted) external {
    address issuer = _msgSender();
    isDefaultOracleUntrusted[issuer] = isUntrusted;
    emit DefaultOracleUntrusted(issuer, isUntrusted);
  }

  function approveOracle(address oracle, bool isTrusted) external {
    address issuer = _msgSender();
    isOracleTrusted[issuer][oracle] = isTrusted;
    emit OracleTrusted(issuer, oracle, isTrusted);
  }
}
