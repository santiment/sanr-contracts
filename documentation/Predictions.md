# Predictions









## Methods

### approve

```solidity
function approve(address to, uint256 tokenId) external nonpayable
```



*See {IERC721-approve}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| to | address | undefined |
| tokenId | uint256 | undefined |

### approveOracle

```solidity
function approveOracle(address oracle, bool isTrusted) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| oracle | address | undefined |
| isTrusted | bool | undefined |

### balanceOf

```solidity
function balanceOf(address owner) external view returns (uint256)
```



*See {IERC721-balanceOf}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### burnPredictionToIncreaseOpenPredictionsCount

```solidity
function burnPredictionToIncreaseOpenPredictionsCount(uint256 predictionID) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |

### cancelPrediction

```solidity
function cancelPrediction(uint256 predictionID) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |

### cancelPredictions

```solidity
function cancelPredictions(uint256[] predictionIDs) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |

### changeCompetitionsAddress

```solidity
function changeCompetitionsAddress(address newCompetitionsAddress) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newCompetitionsAddress | address | undefined |

### changeDurationToClosePredictions

```solidity
function changeDurationToClosePredictions(uint256 newDurationToClosePredictions) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newDurationToClosePredictions | uint256 | undefined |

### changeMaxLeverage

```solidity
function changeMaxLeverage(uint256 newMaxLeverage) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newMaxLeverage | uint256 | undefined |

### changeMaxOpenPredictionsCount

```solidity
function changeMaxOpenPredictionsCount(uint256 newMaxOpenPredictionsCount) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newMaxOpenPredictionsCount | uint256 | undefined |

### changePrediction

```solidity
function changePrediction(uint256 predictionID, uint256 stopLossPrice, uint256 takeProfitPrice) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| stopLossPrice | uint256 | undefined |
| takeProfitPrice | uint256 | undefined |

### changePredictions

```solidity
function changePredictions(uint256[] predictionIDs, uint256[] stopLossPrice, uint256[] takeProfitPrice) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |
| stopLossPrice | uint256[] | undefined |
| takeProfitPrice | uint256[] | undefined |

### changePredictionsLifetime

```solidity
function changePredictionsLifetime(uint256 newPredictionsLifetime) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newPredictionsLifetime | uint256 | undefined |

### changePricesAddress

```solidity
function changePricesAddress(address newPricesAddress) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newPricesAddress | address | undefined |

### closePrediction

```solidity
function closePrediction(uint256 predictionID, uint256 expectedPrice, bytes32 salt, bool isDirectionUp) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| expectedPrice | uint256 | undefined |
| salt | bytes32 | undefined |
| isDirectionUp | bool | undefined |

### closePredictionByPriceIndex

```solidity
function closePredictionByPriceIndex(uint256 predictionID, bytes32 salt, bool isDirectionUp, uint256 priceIndex) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| salt | bytes32 | undefined |
| isDirectionUp | bool | undefined |
| priceIndex | uint256 | undefined |

### closePredictions

```solidity
function closePredictions(uint256[] predictionIDs, uint256[] expectedPrices, bytes32[] salt, bool[] isDirectionUp) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |
| expectedPrices | uint256[] | undefined |
| salt | bytes32[] | undefined |
| isDirectionUp | bool[] | undefined |

### closePredictionsByPriceIndex

```solidity
function closePredictionsByPriceIndex(uint256[] predictionIDs, bytes32[] salt, bool[] isDirectionUp, uint256[] priceIndexes) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |
| salt | bytes32[] | undefined |
| isDirectionUp | bool[] | undefined |
| priceIndexes | uint256[] | undefined |

### closeTimeEndedPrediction

```solidity
function closeTimeEndedPrediction(uint256 predictionID, bytes32 salt, bool isDirectionUp) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| salt | bytes32 | undefined |
| isDirectionUp | bool | undefined |

### closeTimeEndedPredictions

```solidity
function closeTimeEndedPredictions(uint256[] predictionIDs, bytes32[] salt, bool[] isDirectionUp) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |
| salt | bytes32[] | undefined |
| isDirectionUp | bool[] | undefined |

### competitionsAddress

```solidity
function competitionsAddress() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### disapproveDefaultOracle

```solidity
function disapproveDefaultOracle(bool isUntrusted) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| isUntrusted | bool | undefined |

### durationToClosePredictions

```solidity
function durationToClosePredictions() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### getApproved

```solidity
function getApproved(uint256 tokenId) external view returns (address)
```



*See {IERC721-getApproved}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### getInfoHash

```solidity
function getInfoHash(bytes32 salt, bool isDirectionUp) external pure returns (bytes32 infoHash)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| salt | bytes32 | undefined |
| isDirectionUp | bool | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| infoHash | bytes32 | undefined |

### getPredictionPerformance

```solidity
function getPredictionPerformance(uint256 predictionID) external view returns (int256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | int256 | undefined |

### getPredictions

```solidity
function getPredictions(uint256[] ids) external view returns (struct Predictions.Prediction[] predictionsArray)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| ids | uint256[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| predictionsArray | Predictions.Prediction[] | undefined |

### getRealStopLossTakeProfit

```solidity
function getRealStopLossTakeProfit(uint256 predictionID, bool isDirectionUp) external view returns (uint256 stopLossPrice, uint256 takeProfitPrice)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| isDirectionUp | bool | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| stopLossPrice | uint256 | undefined |
| takeProfitPrice | uint256 | undefined |

### getTrustedForwarder

```solidity
function getTrustedForwarder() external view returns (address)
```

:warning: **Warning** :warning: The Forwarder can have a full control over your Recipient. Only trust verified Forwarder.Method is not a required method to allow Recipients to trust multiple Forwarders. Not recommended yet.




#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | The address of the Forwarder contract that is being used. |

### isApprovedForAll

```solidity
function isApprovedForAll(address owner, address operator) external view returns (bool)
```



*See {IERC721-isApprovedForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner | address | undefined |
| operator | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isDefaultOracleUntrusted

```solidity
function isDefaultOracleUntrusted(address) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isOracleTrusted

```solidity
function isOracleTrusted(address, address) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### isOracleTrustedByIssuerOrOwner

```solidity
function isOracleTrustedByIssuerOrOwner(address issuer, address oracle) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| issuer | address | undefined |
| oracle | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

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

### maxLeverage

```solidity
function maxLeverage() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### maxOpenPredictionsCount

```solidity
function maxOpenPredictionsCount() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### name

```solidity
function name() external view returns (string)
```



*See {IERC721Metadata-name}.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### newPrediction

```solidity
function newPrediction(address issuer, bytes32 symbol, bytes32 entropy, bytes32 infoHash, uint256 stopLossPrice, uint256 takeProfitPrice, uint256 expectedTopPrice, uint256 expectedBottomPrice, uint256 expectedTime, uint256 openPrice, uint256 leverage, bool openWhenPriceMoreThen) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| issuer | address | undefined |
| symbol | bytes32 | undefined |
| entropy | bytes32 | undefined |
| infoHash | bytes32 | undefined |
| stopLossPrice | uint256 | undefined |
| takeProfitPrice | uint256 | undefined |
| expectedTopPrice | uint256 | undefined |
| expectedBottomPrice | uint256 | undefined |
| expectedTime | uint256 | undefined |
| openPrice | uint256 | undefined |
| leverage | uint256 | undefined |
| openWhenPriceMoreThen | bool | undefined |

### newPredictions

```solidity
function newPredictions(Predictions.NewPredictionParams[] params) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| params | Predictions.NewPredictionParams[] | undefined |

### openPrediction

```solidity
function openPrediction(uint256 predictionID, uint256 priceIndex) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID | uint256 | undefined |
| priceIndex | uint256 | undefined |

### openPredictions

```solidity
function openPredictions(uint256[] predictionIDs, uint256[] priceIndexes) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionIDs | uint256[] | undefined |
| priceIndexes | uint256[] | undefined |

### openPredictionsCount

```solidity
function openPredictionsCount(address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### ownerOf

```solidity
function ownerOf(uint256 tokenId) external view returns (address)
```



*See {IERC721-ownerOf}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### pause

```solidity
function pause() external nonpayable
```






### paused

```solidity
function paused() external view returns (bool)
```



*Returns true if the contract is paused, and false otherwise.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### predictionByInfoHash

```solidity
function predictionByInfoHash(bytes32) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### predictions

```solidity
function predictions(uint256) external view returns (address issuer, bytes32 symbol, bytes32 entropy, bytes32 salt, bool isDirectionUp, bytes32 infoHash, struct Predictions.ChangeableInfo changeableInfo, struct Predictions.LifecycleInfo lifecycleInfo, uint256 leverage)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| issuer | address | undefined |
| symbol | bytes32 | undefined |
| entropy | bytes32 | undefined |
| salt | bytes32 | undefined |
| isDirectionUp | bool | undefined |
| infoHash | bytes32 | undefined |
| changeableInfo | Predictions.ChangeableInfo | undefined |
| lifecycleInfo | Predictions.LifecycleInfo | undefined |
| leverage | uint256 | undefined |

### predictionsLifetime

```solidity
function predictionsLifetime() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### pricesAddress

```solidity
function pricesAddress() external view returns (address)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby disabling any functionality that is only available to the owner.*


### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId) external nonpayable
```



*See {IERC721-safeTransferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| tokenId | uint256 | undefined |

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 tokenId, bytes data) external nonpayable
```



*See {IERC721-safeTransferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| tokenId | uint256 | undefined |
| data | bytes | undefined |

### setApprovalForAll

```solidity
function setApprovalForAll(address operator, bool approved) external nonpayable
```



*See {IERC721-setApprovalForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | undefined |
| approved | bool | undefined |

### setBaseURI

```solidity
function setBaseURI(string newBaseURI) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newBaseURI | string | undefined |

### setIssuerBaseURI

```solidity
function setIssuerBaseURI(string newBaseURI) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newBaseURI | string | undefined |

### setTrustedForwarder

```solidity
function setTrustedForwarder(address forwarder) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| forwarder | address | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### symbol

```solidity
function symbol() external view returns (string)
```



*See {IERC721Metadata-symbol}.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### tokenByIndex

```solidity
function tokenByIndex(uint256 index) external pure returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| index | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### tokenOfOwnerByIndex

```solidity
function tokenOfOwnerByIndex(address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### tokenURI

```solidity
function tokenURI(uint256 tokenId) external view returns (string)
```



*See {IERC721Metadata-tokenURI}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### tokenURIs

```solidity
function tokenURIs(address) external view returns (string)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 tokenId) external nonpayable
```



*See {IERC721-transferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| tokenId | uint256 | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### unpause

```solidity
function unpause() external nonpayable
```








## Events

### Approval

```solidity
event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId)
```



*Emitted when `owner` enables `approved` to manage the `tokenId` token.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner `indexed` | address | undefined |
| approved `indexed` | address | undefined |
| tokenId `indexed` | uint256 | undefined |

### ApprovalForAll

```solidity
event ApprovalForAll(address indexed owner, address indexed operator, bool approved)
```



*Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner `indexed` | address | undefined |
| operator `indexed` | address | undefined |
| approved  | bool | undefined |

### CompetitionsAddressChanged

```solidity
event CompetitionsAddressChanged(address indexed newCompetitionsAddress)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newCompetitionsAddress `indexed` | address | undefined |

### DefaultOracleUntrusted

```solidity
event DefaultOracleUntrusted(address indexed issuer, bool indexed isUntrusted)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| issuer `indexed` | address | undefined |
| isUntrusted `indexed` | bool | undefined |

### DurationToClosePredictionsChanged

```solidity
event DurationToClosePredictionsChanged(uint256 indexed newDurationToClosePredictions)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newDurationToClosePredictions `indexed` | uint256 | undefined |

### MaxLeverageChanged

```solidity
event MaxLeverageChanged(uint256 indexed newMaxLeverage)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newMaxLeverage `indexed` | uint256 | undefined |

### MaxOpenPredictionsCountChanged

```solidity
event MaxOpenPredictionsCountChanged(uint256 indexed newMaxOpenPredictionsCount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newMaxOpenPredictionsCount `indexed` | uint256 | undefined |

### NewBaseURI

```solidity
event NewBaseURI(string newBaseURI)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newBaseURI  | string | undefined |

### NewIssuerBaseURI

```solidity
event NewIssuerBaseURI(string newBaseURI, address indexed issuer)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newBaseURI  | string | undefined |
| issuer `indexed` | address | undefined |

### OracleTrusted

```solidity
event OracleTrusted(address indexed issuer, address indexed oracle, bool indexed isTrusted)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |
| isTrusted `indexed` | bool | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### Paused

```solidity
event Paused(address account)
```



*Emitted when the pause is triggered by `account`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |

### PredictionCanceled

```solidity
event PredictionCanceled(uint256 indexed predictionID, address indexed issuer, address indexed oracle)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID `indexed` | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |

### PredictionChanged

```solidity
event PredictionChanged(uint256 indexed predictionID, address indexed issuer, address indexed oracle)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID `indexed` | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |

### PredictionClosed

```solidity
event PredictionClosed(uint256 indexed predictionID, address indexed issuer, address indexed oracle, int256 predictionPerformance)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID `indexed` | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |
| predictionPerformance  | int256 | undefined |

### PredictionCreated

```solidity
event PredictionCreated(uint256 predictionID, address indexed issuer, address indexed oracle, bytes32 indexed infoHash)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID  | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |
| infoHash `indexed` | bytes32 | undefined |

### PredictionExpired

```solidity
event PredictionExpired(uint256 indexed predictionID, address indexed issuer, address indexed oracle)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID `indexed` | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |

### PredictionOpened

```solidity
event PredictionOpened(uint256 indexed predictionID, address indexed issuer, address indexed oracle)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| predictionID `indexed` | uint256 | undefined |
| issuer `indexed` | address | undefined |
| oracle `indexed` | address | undefined |

### PredictionsLifetimeChanged

```solidity
event PredictionsLifetimeChanged(uint256 indexed newPredictionsLifetime)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newPredictionsLifetime `indexed` | uint256 | undefined |

### PricesAddressChanged

```solidity
event PricesAddressChanged(address indexed newPricesAddress)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| newPricesAddress `indexed` | address | undefined |

### Transfer

```solidity
event Transfer(address indexed from, address indexed to, uint256 indexed tokenId)
```



*Emitted when `tokenId` token is transferred from `from` to `to`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| tokenId `indexed` | uint256 | undefined |

### Unpaused

```solidity
event Unpaused(address account)
```



*Emitted when the pause is lifted by `account`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account  | address | undefined |



## Errors

### ERC721IncorrectOwner

```solidity
error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner)
```



*Indicates an error related to the ownership over a particular token. Used in transfers.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| sender | address | Address whose tokens are being transferred. |
| tokenId | uint256 | Identifier number of a token. |
| owner | address | Address of the current owner of a token. |

### ERC721InsufficientApproval

```solidity
error ERC721InsufficientApproval(address operator, uint256 tokenId)
```



*Indicates a failure with the `operator`’s approval. Used in transfers.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | Address that may be allowed to operate on tokens without being their owner. |
| tokenId | uint256 | Identifier number of a token. |

### ERC721InvalidApprover

```solidity
error ERC721InvalidApprover(address approver)
```



*Indicates a failure with the `approver` of a token to be approved. Used in approvals.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| approver | address | Address initiating an approval operation. |

### ERC721InvalidOperator

```solidity
error ERC721InvalidOperator(address operator)
```



*Indicates a failure with the `operator` to be approved. Used in approvals.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | Address that may be allowed to operate on tokens without being their owner. |

### ERC721InvalidOwner

```solidity
error ERC721InvalidOwner(address owner)
```



*Indicates that an address can&#39;t be an owner. For example, `address(0)` is a forbidden owner in EIP-20. Used in balance queries.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| owner | address | Address of the current owner of a token. |

### ERC721InvalidReceiver

```solidity
error ERC721InvalidReceiver(address receiver)
```



*Indicates a failure with the token `receiver`. Used in transfers.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| receiver | address | Address to which tokens are being transferred. |

### ERC721InvalidSender

```solidity
error ERC721InvalidSender(address sender)
```



*Indicates a failure with the token `sender`. Used in transfers.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| sender | address | Address whose tokens are being transferred. |

### ERC721NonexistentToken

```solidity
error ERC721NonexistentToken(uint256 tokenId)
```



*Indicates a `tokenId` whose `owner` is the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| tokenId | uint256 | Identifier number of a token. |

### EnforcedPause

```solidity
error EnforcedPause()
```



*The operation failed because the contract is paused.*


### ExpectedPause

```solidity
error ExpectedPause()
```



*The operation failed because the contract is not paused.*


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


