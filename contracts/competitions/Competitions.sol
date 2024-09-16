pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../RelayRecipient.sol";

contract Competitions is RelayRecipient {

  IERC20 public l2ERC20SanToken;

  uint256 public durationToClosePredictions = 2 * 7 * 24 * 60 * 60 + 24 * 60 * 60; //must be set like durationToClosePredictions (from Predictions contract) + predictionsLifetime (from Predictions contract)

  uint256 public competitionsCount; // starts at 1
  uint256 public competitionsBalance;

  uint256 public previousCompetition;
  uint256 public currentCompetition;

  struct Competitor {
    mapping(uint256 => uint256) predictions; // starts at 0
    uint256 openPredictionsCount;
    uint256 closedPredictionsCount;
    int256 sumPerformance;
    int256 avgPerformance;
  }

  struct Winner {
    address addr;
    bool isRewardAlreadySend;
  }

  struct WinnersInfo {
    uint256[] avgDESCWinnerRewards;
    uint256[] sumDESCWinnerRewards;
    uint256[] sumASCWinnerRewards;
  }

  struct Competition {
    WinnersInfo winnersInfo;
    uint256 startTimestamp;
    uint256 endTimestamp;
    uint256 openPredictionsCount;
    uint256 closedPredictionsCount;
    uint256 competitorsCount;
    mapping(uint256 => Winner) avgDESCWinners; // starts at 0
    mapping(uint256 => Winner) sumDESCWinners; // starts at 0
    mapping(uint256 => Winner) sumASCWinners; // starts at 0
    mapping(address => Competitor) competitors; // starts at 0
  }

  mapping(uint256 => Competition) public allCompetitions; // starts at 1
  mapping(address => bool) public isPredictionsAddressApproved;
  mapping(address => mapping(uint256 => uint256)) public competitionByPrediction; // predictionsContract -> predictionID -> competitionID


  event NewCompetitor(uint256 indexed competitionID, uint256 predictionID, address indexed competitor);
  event CompetitionBalanceWithdrawn(uint256 indexed competitionID, uint256 indexed sumOfRewards, address indexed owner);
  event PredictionsAddressApproved(address indexed contractAddress, bool approved);

  modifier onlyPredictionsContract() {
    require(isPredictionsAddressApproved[msg.sender], "Only for predictions contract");
    _;
  }

  modifier onlyReadyToCompetitions(uint256 competitionID) {
    require(isCompetitionReadyToReward(competitionID), "competition is not ready to reward");
    _;
  }

  modifier onlyNeverStartedCompetitions(uint256 competitionID) {
    require(isCompetitionNeverStarted(competitionID), "competition was be or can be started");
    _;
  }

  constructor(
    IERC20 _l2ERC20SanToken,
    address _predictionsContractAddress
  )
  {
    l2ERC20SanToken = _l2ERC20SanToken;
    isPredictionsAddressApproved[_predictionsContractAddress] = true;
  }


  function isCompetitionEnded(uint256 competitionID) public view returns (bool) {
    return block.timestamp > allCompetitions[competitionID].endTimestamp;
  }

  function isCompetitionReadyToReward(uint256 competitionID) public view returns (bool) {
    uint256 endTimestamp = allCompetitions[competitionID].endTimestamp;
    return block.timestamp > endTimestamp
    && ((allCompetitions[competitionID].openPredictionsCount == allCompetitions[competitionID].closedPredictionsCount)
    || (block.timestamp > (endTimestamp + durationToClosePredictions)));
  }

  function isCompetitionNeverStarted(uint256 competitionID) public view returns (bool) {
    if (block.timestamp > allCompetitions[competitionID].endTimestamp)
      if (allCompetitions[competitionID].competitorsCount == 0)
        return true;

    if (currentCompetition == competitionID) return false;

    return block.timestamp < allCompetitions[competitionID].startTimestamp;
  }

  function getSumOfRewards(uint256 competitionID) public view returns (uint256) {
    uint256 sumOfRewards = 0;
    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.avgDESCWinnerRewards.length; i++) {
      sumOfRewards += allCompetitions[competitionID].winnersInfo.avgDESCWinnerRewards[i];
    }
    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.sumDESCWinnerRewards.length; i++) {
      sumOfRewards += allCompetitions[competitionID].winnersInfo.sumDESCWinnerRewards[i];
    }
    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.sumASCWinnerRewards.length; i++) {
      sumOfRewards += allCompetitions[competitionID].winnersInfo.sumASCWinnerRewards[i];
    }
    return sumOfRewards;
  }

  function withdrawCompetitionBalance(uint256 competitionID) external onlyOwner onlyNeverStartedCompetitions(competitionID) {
    uint256 sumOfRewards = getSumOfRewards(competitionID);

    delete allCompetitions[competitionsCount].winnersInfo.avgDESCWinnerRewards;
    delete allCompetitions[competitionsCount].winnersInfo.sumDESCWinnerRewards;
    delete allCompetitions[competitionsCount].winnersInfo.sumASCWinnerRewards;

    competitionsBalance -= sumOfRewards;

    l2ERC20SanToken.transfer(_msgSender(), sumOfRewards);

    emit CompetitionBalanceWithdrawn(competitionID, sumOfRewards, _msgSender());
  }

  function openPredictionInCompetition(address competitor, uint256 predictionID) public virtual onlyPredictionsContract {
    uint256 current = currentCompetition;
    uint256 blockTimestamp = block.timestamp;
    if (blockTimestamp < allCompetitions[current].endTimestamp) {
      if (blockTimestamp <= allCompetitions[current].startTimestamp) current = previousCompetition;
      if (blockTimestamp > allCompetitions[current].startTimestamp && blockTimestamp < allCompetitions[current].endTimestamp) {
        allCompetitions[current].openPredictionsCount++;

        if (allCompetitions[current].competitors[competitor].openPredictionsCount == 0) {
          allCompetitions[current].competitorsCount++;
          emit NewCompetitor(current, predictionID, competitor);
        }

        allCompetitions[current].competitors[competitor].predictions[allCompetitions[current].competitors[competitor].openPredictionsCount] = predictionID;
        allCompetitions[current].competitors[competitor].openPredictionsCount++;

        competitionByPrediction[msg.sender][predictionID] = current;
      }
    }
  }

  function closePredictionInCompetition(address competitor, uint256 predictionID, int256 predictionPerformance) public virtual onlyPredictionsContract {
    uint256 competitionID = competitionByPrediction[msg.sender][predictionID];
    if (isCompetitionReadyToReward(competitionID)) return;

    allCompetitions[competitionID].closedPredictionsCount++;
    allCompetitions[competitionID].competitors[competitor].closedPredictionsCount++;

    allCompetitions[competitionID].competitors[competitor].sumPerformance += predictionPerformance;

    allCompetitions[competitionID].competitors[competitor].avgPerformance = allCompetitions[competitionID].competitors[competitor].sumPerformance
    / int256(allCompetitions[competitionID].competitors[competitor].closedPredictionsCount);
  }


  function addCompetition(
    uint256[] calldata avgDESCWinnerRewards,
    uint256[] calldata sumDESCWinnerRewards,
    uint256[] calldata sumASCWinnerRewards,
    uint256 startTimestamp,
    uint256 endTimestamp
  ) onlyOwner public {
    require(startTimestamp < endTimestamp, "startTimestamp >= endTimestamp");
    require(block.timestamp < startTimestamp, "block.timestamp >= startTimestamp");

    competitionsCount++;

    allCompetitions[competitionsCount].winnersInfo.avgDESCWinnerRewards = avgDESCWinnerRewards;
    allCompetitions[competitionsCount].winnersInfo.sumDESCWinnerRewards = sumDESCWinnerRewards;
    allCompetitions[competitionsCount].winnersInfo.sumASCWinnerRewards = sumASCWinnerRewards;

    allCompetitions[competitionsCount].startTimestamp = startTimestamp;
    allCompetitions[competitionsCount].endTimestamp = endTimestamp;

    uint256 sumOfRewards = 0;
    for (uint256 i = 0; i < avgDESCWinnerRewards.length; i++) {
      sumOfRewards += avgDESCWinnerRewards[i];
    }
    for (uint256 i = 0; i < sumDESCWinnerRewards.length; i++) {
      sumOfRewards += sumDESCWinnerRewards[i];
    }
    for (uint256 i = 0; i < sumASCWinnerRewards.length; i++) {
      sumOfRewards += sumASCWinnerRewards[i];
    }

    require(sumOfRewards != 0, "empty competition sum of rewards");

    l2ERC20SanToken.transferFrom(_msgSender(), address(this), sumOfRewards);
    competitionsBalance += sumOfRewards;
  }

  function setCurrentCompetition(uint256 newCurrentCompetition) onlyOwner public {
    uint256 current = currentCompetition;
    uint256 newStartTimestamp = allCompetitions[newCurrentCompetition].startTimestamp;

    require(block.timestamp < newStartTimestamp, "already started competition");
    require(newStartTimestamp > allCompetitions[current].endTimestamp, "start date less then end of old competition");
    require(getSumOfRewards(newCurrentCompetition) != 0, "empty competition sum of rewards");

    if (block.timestamp > allCompetitions[current].startTimestamp) previousCompetition = current;
    currentCompetition = newCurrentCompetition;
  }


  function changeDurationToClosePredictions(uint256 newDurationToClosePredictions) external onlyOwner {
    durationToClosePredictions = newDurationToClosePredictions;
  }

  function competitorPredictions(uint256 competitionID, address competitor, uint256 competitorPredictionIndex) external view returns (uint256 predictionID) {
    return allCompetitions[competitionID].competitors[competitor].predictions[competitorPredictionIndex];
  }

  function competitorOpenPredictionsCount(uint256 competitionID, address competitor) external view returns (uint256) {
    return allCompetitions[competitionID].competitors[competitor].openPredictionsCount;
  }

  function competitorClosedPredictionsCount(uint256 competitionID, address competitor) external view returns (uint256) {
    return allCompetitions[competitionID].competitors[competitor].closedPredictionsCount;
  }

  function competitorSumPerformance(uint256 competitionID, address competitor) external view returns (int256) {
    return allCompetitions[competitionID].competitors[competitor].sumPerformance;
  }

  function competitorAvgPerformance(uint256 competitionID, address competitor) external view returns (int256) {
    return allCompetitions[competitionID].competitors[competitor].avgPerformance;
  }

  function avgDESCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner) {
    return allCompetitions[competitionID].avgDESCWinners[winnerIndex].addr;
  }

  function sumDESCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner) {
    return allCompetitions[competitionID].sumDESCWinners[winnerIndex].addr;
  }

  function sumASCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner) {
    return allCompetitions[competitionID].sumASCWinners[winnerIndex].addr;
  }

  function isAvgDESCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend) {
    return allCompetitions[competitionID].avgDESCWinners[winnerIndex].isRewardAlreadySend;
  }

  function isSumDESCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend) {
    return allCompetitions[competitionID].sumDESCWinners[winnerIndex].isRewardAlreadySend;
  }

  function isSumASCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend) {
    return allCompetitions[competitionID].sumASCWinners[winnerIndex].isRewardAlreadySend;
  }

  function approvePredictionsAddress(address contractAddress, bool approved) external onlyOwner {
    isPredictionsAddressApproved[contractAddress] = approved;

    emit PredictionsAddressApproved(contractAddress, approved);
  }
}
