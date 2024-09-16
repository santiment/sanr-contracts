# Competitions









## Methods

### addCompetition

```solidity
function addCompetition(uint256[] avgDESCWinnerRewards, uint256[] sumDESCWinnerRewards, uint256[] sumASCWinnerRewards, uint256 startTimestamp, uint256 endTimestamp) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| avgDESCWinnerRewards | uint256[] | undefined |
| sumDESCWinnerRewards | uint256[] | undefined |
| sumASCWinnerRewards | uint256[] | undefined |
| startTimestamp | uint256 | undefined |
| endTimestamp | uint256 | undefined |

### allCompetitions

```solidity
function allCompetitions(uint256) external view returns (struct Competitions.WinnersInfo winnersInfo, uint256 startTimestamp, uint256 endTimestamp, uint256 openPredictionsCount, uint256 closedPredictionsCount, uint256 competitorsCount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| winnersInfo | Competitions.WinnersInfo | undefined |
| startTimestamp | uint256 | undefined |
| endTimestamp | uint256 | undefined |
| openPredictionsCount | uint256 | undefined |
| closedPredictionsCount | uint256 | undefined |
| competitorsCount | uint256 | undefined |

### approvePredictionsAddress

```solidity
function approvePredictionsAddress(address contractAddress, bool approved) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| contractAddress | address | undefined |
| approved | bool | undefined |

### avgDESCWinners

```solidity
function avgDESCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| winner | address | undefined |

### changeDurationToClosePredictions

```solidity
function changeDurationToClosePredictions(uint256 newDurationToClosePredictions) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newDurationToClosePredictions | uint256 | undefined |

### closePredictionInCompetition

```solidity
function closePredictionInCompetition(address competitor, uint256 predictionID, int256 predictionPerformance) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitor | address | undefined |
| predictionID | uint256 | undefined |
| predictionPerformance | int256 | undefined |

### competitionByPrediction

```solidity
function competitionByPrediction(address, uint256) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### competitionsBalance

```solidity
function competitionsBalance() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### competitionsCount

```solidity
function competitionsCount() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### competitorAvgPerformance

```solidity
function competitorAvgPerformance(uint256 competitionID, address competitor) external view returns (int256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| competitor | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | int256 | undefined |

### competitorClosedPredictionsCount

```solidity
function competitorClosedPredictionsCount(uint256 competitionID, address competitor) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| competitor | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### competitorOpenPredictionsCount

```solidity
function competitorOpenPredictionsCount(uint256 competitionID, address competitor) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| competitor | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### competitorPredictions

```solidity
function competitorPredictions(uint256 competitionID, address competitor, uint256 competitorPredictionIndex) external view returns (uint256 predictionID)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| competitor | address | undefined |
| competitorPredictionIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |

### competitorSumPerformance

```solidity
function competitorSumPerformance(uint256 competitionID, address competitor) external view returns (int256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| competitor | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | int256 | undefined |

### currentCompetition

```solidity
function currentCompetition() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### durationToClosePredictions

```solidity
function durationToClosePredictions() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getSumOfRewards

```solidity
function getSumOfRewards(uint256 competitionID) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getTrustedForwarder

```solidity
function getTrustedForwarder() external view returns (address)
```

:warning: **Warning** :warning: The Forwarder can have a full control over your Recipient. Only trust verified Forwarder.Method is not a required method to allow Recipients to trust multiple Forwarders. Not recommended yet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | The address of the Forwarder contract that is being used. |

### isAvgDESCWinnerRewardAlreadySend

```solidity
function isAvgDESCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| isWinnerRewardAlreadySend | bool | undefined |

### isCompetitionEnded

```solidity
function isCompetitionEnded(uint256 competitionID) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isCompetitionNeverStarted

```solidity
function isCompetitionNeverStarted(uint256 competitionID) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isCompetitionReadyToReward

```solidity
function isCompetitionReadyToReward(uint256 competitionID) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isPredictionsAddressApproved

```solidity
function isPredictionsAddressApproved(address) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isSumASCWinnerRewardAlreadySend

```solidity
function isSumASCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| isWinnerRewardAlreadySend | bool | undefined |

### isSumDESCWinnerRewardAlreadySend

```solidity
function isSumDESCWinnerRewardAlreadySend(uint256 competitionID, uint256 winnerIndex) external view returns (bool isWinnerRewardAlreadySend)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| isWinnerRewardAlreadySend | bool | undefined |

### isTrustedForwarder

```solidity
function isTrustedForwarder(address forwarder) external view returns (bool)
```

:warning: **Warning** :warning: The Forwarder can have a full control over your Recipient. Only trust verified Forwarder.



#### Parameters

| Name | Type | Description |
|---|---|---|
| forwarder | address | The address of the Forwarder contract that is being used. |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | isTrustedForwarder `true` if the Forwarder is trusted to forward relayed transactions by this Recipient. |

### l2ERC20SanToken

```solidity
function l2ERC20SanToken() external view returns (contract IERC20)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract IERC20 | undefined |

### openPredictionInCompetition

```solidity
function openPredictionInCompetition(address competitor, uint256 predictionID) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitor | address | undefined |
| predictionID | uint256 | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### previousCompetition

```solidity
function previousCompetition() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby disabling any functionality that is only available to the owner.*


### setCurrentCompetition

```solidity
function setCurrentCompetition(uint256 newCurrentCompetition) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newCurrentCompetition | uint256 | undefined |

### setTrustedForwarder

```solidity
function setTrustedForwarder(address forwarder) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| forwarder | address | undefined |

### sumASCWinners

```solidity
function sumASCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| winner | address | undefined |

### sumDESCWinners

```solidity
function sumDESCWinners(uint256 competitionID, uint256 winnerIndex) external view returns (address winner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |
| winnerIndex | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| winner | address | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### withdrawCompetitionBalance

```solidity
function withdrawCompetitionBalance(uint256 competitionID) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID | uint256 | undefined |



## Events

### CompetitionBalanceWithdrawn

```solidity
event CompetitionBalanceWithdrawn(uint256 indexed competitionID, uint256 indexed sumOfRewards, address indexed owner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID `indexed` | uint256 | undefined |
| sumOfRewards `indexed` | uint256 | undefined |
| owner `indexed` | address | undefined |

### NewCompetitor

```solidity
event NewCompetitor(uint256 indexed competitionID, uint256 predictionID, address indexed competitor)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| competitionID `indexed` | uint256 | undefined |
| predictionID  | uint256 | undefined |
| competitor `indexed` | address | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### PredictionsAddressApproved

```solidity
event PredictionsAddressApproved(address indexed contractAddress, bool approved)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| contractAddress `indexed` | address | undefined |
| approved  | bool | undefined |



## Errors

### OwnableInvalidOwner

```solidity
error OwnableInvalidOwner(address owner)
```



*The owner is not a valid owner account. (eg. `address(0)`)*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner | address | undefined |

### OwnableUnauthorizedAccount

```solidity
error OwnableUnauthorizedAccount(address account)
```



*The caller account is not authorized to perform an operation.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |


