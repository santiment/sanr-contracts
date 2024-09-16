pragma solidity ^0.8.17;

import "./Competitions.sol";


contract Rewarding is Competitions {
  struct AttemptToFindWinners {
    uint256 sortedCompetitorsCount;
    mapping(uint256 => address) sortedCompetitors; // starts at 0
    mapping(address => bool) isCompetitorAlreadySorted;
  }

  mapping(address => mapping(uint256 => AttemptToFindWinners)) public attemptsToFindAvgDESCWinners;
  mapping(address => mapping(uint256 => AttemptToFindWinners)) public attemptsToFindSumDESCWinners;
  mapping(address => mapping(uint256 => AttemptToFindWinners)) public attemptsToFindSumASCWinners;


  constructor(
    IERC20 _l2ERC20SanToken,
    address _predictionsContractAddress
  )
  Competitions(_l2ERC20SanToken, _predictionsContractAddress)
  {}


  function findAvgDESCWinners(uint256 competitionID, address[] calldata partOfSortedCompetitors) external onlyReadyToCompetitions(competitionID) {
    uint256 position = attemptsToFindAvgDESCWinners[msg.sender][competitionID].sortedCompetitorsCount;
    for (uint256 i = 0; i < partOfSortedCompetitors.length; i++) {
      if (position != 0) checkCompetitorAvgDESCPosition(competitionID, partOfSortedCompetitors[i], position);

      setCompetitorPosition(competitionID, partOfSortedCompetitors[i], position, attemptsToFindAvgDESCWinners);
      position++;
    }

    attemptsToFindAvgDESCWinners[msg.sender][competitionID].sortedCompetitorsCount += partOfSortedCompetitors.length;
  }

  function findSumDESCWinners(uint256 competitionID, address[] calldata partOfSortedCompetitors) external onlyReadyToCompetitions(competitionID) {
    uint256 position = attemptsToFindSumDESCWinners[msg.sender][competitionID].sortedCompetitorsCount;
    for (uint256 i = 0; i < partOfSortedCompetitors.length; i++) {
      if (position != 0) checkCompetitorSumDESCPosition(competitionID, partOfSortedCompetitors[i], position);

      setCompetitorPosition(competitionID, partOfSortedCompetitors[i], position, attemptsToFindSumDESCWinners);
      position++;
    }

    attemptsToFindSumDESCWinners[msg.sender][competitionID].sortedCompetitorsCount += partOfSortedCompetitors.length;
  }

  function findSumASCWinners(uint256 competitionID, address[] calldata partOfSortedCompetitors) external onlyReadyToCompetitions(competitionID) {
    uint256 position = attemptsToFindSumASCWinners[msg.sender][competitionID].sortedCompetitorsCount;
    for (uint256 i = 0; i < partOfSortedCompetitors.length; i++) {
      if (position != 0) checkCompetitorSumASCPosition(competitionID, partOfSortedCompetitors[i], position);

      setCompetitorPosition(competitionID, partOfSortedCompetitors[i], position, attemptsToFindSumASCWinners);
      position++;
    }

    attemptsToFindSumASCWinners[msg.sender][competitionID].sortedCompetitorsCount += partOfSortedCompetitors.length;
  }


  function checkCompetitorAvgDESCPosition(uint256 competitionID, address competitorAddress, uint256 position) view private {
    address previousCompetitorAddress = attemptsToFindAvgDESCWinners[msg.sender][competitionID].sortedCompetitors[position - 1];
    Competitor storage previousCompetitor = allCompetitions[competitionID].competitors[previousCompetitorAddress];
    Competitor storage competitor = allCompetitions[competitionID].competitors[competitorAddress];

    if (previousCompetitor.openPredictionsCount > previousCompetitor.closedPredictionsCount) {
      require(competitor.openPredictionsCount > competitor.closedPredictionsCount, "if not all predictions is closed must be last");

      require(competitor.avgPerformance < previousCompetitor.avgPerformance
        || ((competitor.avgPerformance == previousCompetitor.avgPerformance) && (uint256(uint160(competitorAddress)) < uint256(uint160(previousCompetitorAddress))))
      , "wrong avg DESC sort for last");
    }
    else if (competitor.openPredictionsCount == competitor.closedPredictionsCount)
      require(competitor.avgPerformance < previousCompetitor.avgPerformance
        || ((competitor.avgPerformance == previousCompetitor.avgPerformance) && (uint256(uint160(competitorAddress)) < uint256(uint160(previousCompetitorAddress))))
      , "wrong avg DESC sort");
  }

  function checkCompetitorSumDESCPosition(uint256 competitionID, address competitorAddress, uint256 position) view private {
    address previousCompetitorAddress = attemptsToFindSumDESCWinners[msg.sender][competitionID].sortedCompetitors[position - 1];
    Competitor storage previousCompetitor = allCompetitions[competitionID].competitors[previousCompetitorAddress];
    Competitor storage competitor = allCompetitions[competitionID].competitors[competitorAddress];

    if (previousCompetitor.openPredictionsCount > previousCompetitor.closedPredictionsCount) {
      require(competitor.openPredictionsCount > competitor.closedPredictionsCount, "if not all predictions is closed must be last");

      require(competitor.sumPerformance < previousCompetitor.sumPerformance
        || ((competitor.sumPerformance == previousCompetitor.sumPerformance) && (uint256(uint160(competitorAddress)) < uint256(uint160(previousCompetitorAddress))))
      , "wrong sum DESC sort for last");
    }
    else if (competitor.openPredictionsCount == competitor.closedPredictionsCount) {
      require(competitor.sumPerformance < previousCompetitor.sumPerformance
        || ((competitor.sumPerformance == previousCompetitor.sumPerformance) && (uint256(uint160(competitorAddress)) < uint256(uint160(previousCompetitorAddress))))
      , "wrong sum DESC sort");
    }
  }

  function checkCompetitorSumASCPosition(uint256 competitionID, address competitorAddress, uint256 position) view private {
    address previousCompetitorAddress = attemptsToFindSumASCWinners[msg.sender][competitionID].sortedCompetitors[position - 1];
    Competitor storage previousCompetitor = allCompetitions[competitionID].competitors[previousCompetitorAddress];
    Competitor storage competitor = allCompetitions[competitionID].competitors[competitorAddress];

    if (previousCompetitor.openPredictionsCount > previousCompetitor.closedPredictionsCount) {
      require(competitor.openPredictionsCount > competitor.closedPredictionsCount, "if not all predictions is closed must be last");

      require(competitor.sumPerformance > previousCompetitor.sumPerformance
        || ((competitor.sumPerformance == previousCompetitor.sumPerformance) && (uint256(uint160(competitorAddress)) > uint256(uint160(previousCompetitorAddress))))
      , "wrong sum ASC sort for last");
    }
    else if (competitor.openPredictionsCount == competitor.closedPredictionsCount) {
      require(competitor.sumPerformance > previousCompetitor.sumPerformance
        || ((competitor.sumPerformance == previousCompetitor.sumPerformance) && (uint256(uint160(competitorAddress)) > uint256(uint160(previousCompetitorAddress))))
      , "wrong sum ASC sort");
    }
  }

  function setCompetitorPosition(uint256 competitionID, address competitor, uint256 position, mapping(address => mapping(uint256 => AttemptToFindWinners)) storage attemptsToFindWinners) private {
    require(allCompetitions[competitionID].competitors[competitor].openPredictionsCount != 0, "it is not competitor");
    require(!attemptsToFindWinners[msg.sender][competitionID].isCompetitorAlreadySorted[competitor], "competitor already sorted");

    attemptsToFindWinners[msg.sender][competitionID].sortedCompetitors[position] = competitor;
    attemptsToFindWinners[msg.sender][competitionID].isCompetitorAlreadySorted[competitor] = true;
  }

  function setAvgDESCWinners(uint256 competitionID) external {
    require(attemptsToFindAvgDESCWinners[msg.sender][competitionID].sortedCompetitorsCount == allCompetitions[competitionID].competitorsCount, "not all competitors is sorted");

    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.avgDESCWinnerRewards.length; i++) {
      allCompetitions[competitionID].avgDESCWinners[i].addr = attemptsToFindAvgDESCWinners[msg.sender][competitionID].sortedCompetitors[i];
    }
  }

  function setSumDESCWinners(uint256 competitionID) external {
    require(attemptsToFindSumDESCWinners[msg.sender][competitionID].sortedCompetitorsCount == allCompetitions[competitionID].competitorsCount, "not all competitors is sorted");

    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.sumDESCWinnerRewards.length; i++) {
      allCompetitions[competitionID].sumDESCWinners[i].addr = attemptsToFindSumDESCWinners[msg.sender][competitionID].sortedCompetitors[i];
    }
  }

  function setSumASCWinners(uint256 competitionID) external {
    require(attemptsToFindSumASCWinners[msg.sender][competitionID].sortedCompetitorsCount == allCompetitions[competitionID].competitorsCount, "not all competitors is sorted");

    for (uint256 i = 0; i < allCompetitions[competitionID].winnersInfo.sumASCWinnerRewards.length; i++) {
      allCompetitions[competitionID].sumASCWinners[i].addr = attemptsToFindSumASCWinners[msg.sender][competitionID].sortedCompetitors[i];
    }
  }


  function sendAvgDESCRewards(uint256 competitionID, uint256 fromIndex, uint256 toIndex) public {
    for (uint256 i = fromIndex; i < toIndex; i++) {
      if (!allCompetitions[competitionID].avgDESCWinners[i].isRewardAlreadySend && allCompetitions[competitionID].avgDESCWinners[i].addr != address(0)) {
        l2ERC20SanToken.transfer(allCompetitions[competitionID].avgDESCWinners[i].addr, allCompetitions[competitionID].winnersInfo.avgDESCWinnerRewards[i]);
        allCompetitions[competitionID].avgDESCWinners[i].isRewardAlreadySend = true;
      }
    }
  }

  function sendSumDESCRewards(uint256 competitionID, uint256 fromIndex, uint256 toIndex) public {
    for (uint256 i = fromIndex; i < toIndex; i++) {
      if (!allCompetitions[competitionID].sumDESCWinners[i].isRewardAlreadySend && allCompetitions[competitionID].sumDESCWinners[i].addr != address(0)) {
        l2ERC20SanToken.transfer(allCompetitions[competitionID].sumDESCWinners[i].addr, allCompetitions[competitionID].winnersInfo.sumDESCWinnerRewards[i]);
        allCompetitions[competitionID].sumDESCWinners[i].isRewardAlreadySend = true;
      }
    }
  }

  function sendSumASCRewards(uint256 competitionID, uint256 fromIndex, uint256 toIndex) public {
    for (uint256 i = fromIndex; i < toIndex; i++) {
      if (!allCompetitions[competitionID].sumASCWinners[i].isRewardAlreadySend && allCompetitions[competitionID].sumASCWinners[i].addr != address(0)) {
        l2ERC20SanToken.transfer(allCompetitions[competitionID].sumASCWinners[i].addr, allCompetitions[competitionID].winnersInfo.sumASCWinnerRewards[i]);
        allCompetitions[competitionID].sumASCWinners[i].isRewardAlreadySend = true;
      }
    }
  }


  function sortedAvgDESCPerformances(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (int256 sortedPerformance) {
    address competitor = attemptsToFindAvgDESCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
    return allCompetitions[competitionID].competitors[competitor].avgPerformance;
  }

  function sortedSumDESCPerformances(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (int256 sortedPerformance) {
    address competitor = attemptsToFindSumDESCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
    return allCompetitions[competitionID].competitors[competitor].sumPerformance;
  }

  function sortedSumASCPerformances(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (int256 sortedPerformance) {
    address competitor = attemptsToFindSumASCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
    return allCompetitions[competitionID].competitors[competitor].sumPerformance;
  }

  function sortedAvgDESCCompetitors(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (address sortedCompetitor) {
    return attemptsToFindAvgDESCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
  }

  function sortedSumDESCCompetitors(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (address sortedCompetitor) {
    return attemptsToFindSumDESCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
  }

  function sortedSumASCCompetitors(address finder, uint256 competitionID, uint256 competitorsIndex) external view returns (address sortedCompetitor) {
    return attemptsToFindSumASCWinners[finder][competitionID].sortedCompetitors[competitorsIndex];
  }

  function isCompetitorAlreadyAvgDESCSorted(address finder, uint256 competitionID, address competitor) external view returns (bool isCompetitorAlreadySorted) {
    return attemptsToFindAvgDESCWinners[finder][competitionID].isCompetitorAlreadySorted[competitor];
  }

  function isCompetitorAlreadySumDESCSorted(address finder, uint256 competitionID, address competitor) external view returns (bool isCompetitorAlreadySorted) {
    return attemptsToFindSumDESCWinners[finder][competitionID].isCompetitorAlreadySorted[competitor];
  }

  function isCompetitorAlreadySumASCSorted(address finder, uint256 competitionID, address competitor) external view returns (bool isCompetitorAlreadySorted) {
    return attemptsToFindSumASCWinners[finder][competitionID].isCompetitorAlreadySorted[competitor];
  }
}
