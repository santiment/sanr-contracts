# SanrSharesV1

*doubleHolg*

> Subscriptions

You can use this contract to subscribe to Sanr signal providers. One purchased share gives access to all subject&#39;s signals on https://sanr.app

*Mostly it is FriendtechSharesV1 with referral system*

## Methods

### balances

```solidity
function balances(address) external view returns (uint256)
```

Shows subject&#39;s or referrer&#39;s or protocol&#39;s balance of earned fees

*mapping. user =&gt; balance. param user - The subject or referrer or protocol account*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Balance of earned fees |

### buyFirstShare

```solidity
function buyFirstShare(address referrer, uint256 amount) external payable
```

Purchase first share of self. Allowing other users to trade my shares. Set referrer



#### Parameters

| Name | Type | Description |
|---|---|---|
| referrer | address | The account that invited the subject to Sanr. By default it is protocolFeeDestination address |
| amount | uint256 | The amount of shares to be purchased. Price is 0 for the first share |

### buyShares

```solidity
function buyShares(address sharesSubject, uint256 amount) external payable
```

Purchase share of subject



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares to be purchased |

### earnedByReferrerFees

```solidity
function earnedByReferrerFees(address) external view returns (uint256)
```

Shows amount of fees earned by the referrer over time

*mapping. referrer =&gt; earned. used for external viewing only. param referrer - The account that invited a subjects to Sanr*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Amount of fees earned by the referrer |

### earnedBySubjectFees

```solidity
function earnedBySubjectFees(address) external view returns (uint256)
```

Shows amount of fees earned by the subject over time

*mapping. subject =&gt; earned. used for external viewing only. param subject - The Sanr signal provider account*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Amount of fees earned by the subject |

### getBuyPrice

```solidity
function getBuyPrice(address sharesSubject, uint256 amount) external view returns (uint256)
```

Show buy price of that amount of subject&#39;s shares



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares whose price is calculated |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Buy price of that amount of subject&#39;s shares |

### getBuyPriceAfterFee

```solidity
function getBuyPriceAfterFee(address sharesSubject, uint256 amount) external view returns (uint256)
```

Show the amount of eth that trader will paid



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares whose price is calculated |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Amount of eth that trader will paid |

### getPrice

```solidity
function getPrice(uint256 supply, uint256 amount) external pure returns (uint256)
```

Show price of that amount of shares

*for amount == 1 price is supply^2 * 1 ether / 16000. same as in friend tech contract*

#### Parameters

| Name | Type | Description |
|---|---|---|
| supply | uint256 | The subject&#39;s supply of shares. For selling price it should be (supply - amount) |
| amount | uint256 | The amount of shares whose price is calculated |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Price of that amount of shares |

### getReferrersFee

```solidity
function getReferrersFee(uint256 price) external view returns (uint256)
```

Show amount of fee that goes to the all subject&#39;s referrers



#### Parameters

| Name | Type | Description |
|---|---|---|
| price | uint256 | The shares price |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Amount of fee that goes to the all subject&#39;s referrers |

### getSellPrice

```solidity
function getSellPrice(address sharesSubject, uint256 amount) external view returns (uint256)
```

Show sell price of that amount of subject&#39;s shares



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares whose price is calculated |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Sell price of that amount of subject&#39;s shares |

### getSellPriceAfterFee

```solidity
function getSellPriceAfterFee(address sharesSubject, uint256 amount) external view returns (uint256)
```

Show the amount of eth that trader will get



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares whose price is calculated |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Amount of eth that trader will get |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### protocolFeeDestination

```solidity
function protocolFeeDestination() external view returns (address)
```

Shows the address where protocol fee are received

*variable. changing in setFeeDestination()*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | Address where protocol fee are received |

### protocolFeePercent

```solidity
function protocolFeePercent() external view returns (uint256)
```

Shows the percentage of the share price that goes to the protocol fee

*variable. changing in setProtocolFeePercent()*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Percentage of the share price that goes to the protocolFeeDestination |

### referrerLevelsFeePercents

```solidity
function referrerLevelsFeePercents(uint256) external view returns (uint256)
```

Shows the percentage of the share price that goes to the referrer on specified referrer level

*mapping. level =&gt; feePercent. param level - The referrer level*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Percent of the share price that goes to the referrer on specified referrer level |

### referrers

```solidity
function referrers(address) external view returns (address)
```

Shows the account that invited the subject to Sanr

*mapping. sharesSubject =&gt; referrer. param sharesSubject - The Sanr signal provider account*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | Account that invited the subject to Sanr |

### sellShares

```solidity
function sellShares(address sharesSubject, uint256 amount) external nonpayable
```

Sell share of subject



#### Parameters

| Name | Type | Description |
|---|---|---|
| sharesSubject | address | The Sanr signal provider account |
| amount | uint256 | The amount of shares to be sold |

### setFeeDestination

```solidity
function setFeeDestination(address newFeeDestination) external nonpayable
```

Set the address where protocol fee are received

*only for contract owner*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeeDestination | address | The new protocol fee destination address |

### setProtocolFeePercent

```solidity
function setProtocolFeePercent(uint256 newFeePercent) external nonpayable
```

Set the percentage of the share price that goes to the protocol fee

*only for contract owner*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent | uint256 | The new protocol fee percent |

### setReferrerLevelFeePercent

```solidity
function setReferrerLevelFeePercent(uint256 newFeePercent, uint256 level) external nonpayable
```

Set the percentage of the share price that goes to the referrer on specified referrer level

*only for contract owner*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent | uint256 | The new referrer fee percent on specified referrer level |
| level | uint256 | The referrer level |

### setSubjectFeePercent

```solidity
function setSubjectFeePercent(uint256 newFeePercent) external nonpayable
```

Set the address where subject fee are received

*only for contract owner*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent | uint256 | The new subject fee percent |

### sharesBalance

```solidity
function sharesBalance(address, address) external view returns (uint256)
```

Shows the balance of the subject&#39;s shares in the trader&#39;s account

*mapping. sharesSubject =&gt; (trader =&gt; balance). param sharesSubject - The Sanr signal provider account. param trader - The trader account*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Balance of the subject&#39;s shares in the trader&#39;s account |

### sharesSupply

```solidity
function sharesSupply(address) external view returns (uint256)
```

Shows the supply of subject&#39;s shares

*mapping. sharesSubject =&gt; supply. param sharesSubject - The Sanr signal provider account*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Supply of subject&#39;s shares |

### subjectFeePercent

```solidity
function subjectFeePercent() external view returns (uint256)
```

Shows the percentage of the share price that goes to the subject fee

*variable. changing in setSubjectFeePercent()*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Percentage of the share price that goes to the sharesSubject |

### subjectsCount

```solidity
function subjectsCount() external view returns (uint256)
```

Shows the total number of subjects

*variable. changing in buyFirstShare(). used for external viewing only*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Total number of subjects |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### withdrawAll

```solidity
function withdrawAll() external nonpayable
```

Withdraw all collected fees






## Events

### FeeDestinationWasSet

```solidity
event FeeDestinationWasSet(address newFeeDestination)
```

This event is emitted when contract owner set the address where protocol fee are received

*emitted in setFeeDestination() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeeDestination  | address | The new protocol fee destination address |

### FirstTrade

```solidity
event FirstTrade(address subject, address indexed referrer)
```

This event is emitted when a subject purchased first share of its own, allowing other users to trade subject&#39;s shares

*emitted in buyFirstShare() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| subject  | address | The Sanr signal provider account which also trader in that case |
| referrer `indexed` | address | The account that invited the subject to Sanr. By default it is protocolFeeDestination address |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### ProtocolFeePercentWasSet

```solidity
event ProtocolFeePercentWasSet(uint256 newFeePercent)
```

This event is emitted when contract owner set the percentage of the share price that goes to the protocol fee

*emitted in setProtocolFeePercent() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent  | uint256 | The new protocol fee percent |

### ReferrerLevelFeePercentWasSet

```solidity
event ReferrerLevelFeePercentWasSet(uint256 newFeePercent, uint256 level)
```

This event is emitted when contract owner set the percentage of the share price that goes to the referrer on specified referrer level

*emitted in setReferrerLevelFeePercent() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent  | uint256 | The new referrer fee percent on specified referrer level |
| level  | uint256 | The referrer level |

### SubjectFeePercentWasSet

```solidity
event SubjectFeePercentWasSet(uint256 newFeePercent)
```

This event is emitted when contract owner set the percentage of the share price that goes to the subject fee

*emitted in setSubjectFeePercent() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newFeePercent  | uint256 | The new subject fee percent |

### Trade

```solidity
event Trade(address indexed trader, address indexed subject, bool indexed isBuy, uint256 shareAmount, uint256 ethAmount, uint256 ethAmountAfterFee, uint256 supply)
```

This event is emitted when a trade occurs

*emitted in _buyShares() and sellShares() functions*

#### Parameters

| Name | Type | Description |
|---|---|---|
| trader `indexed` | address | The trader account |
| subject `indexed` | address | The Sanr signal provider account |
| isBuy `indexed` | bool | If this is true, then the trader bought the shares through this transaction. If it&#39;s false, the trader sold them |
| shareAmount  | uint256 | The amount of shares was traded |
| ethAmount  | uint256 | The amount of eth was traded |
| ethAmountAfterFee  | uint256 | The amount of eth that trader get or paid |
| supply  | uint256 | The subject&#39;s supply of shares after this trade |

### Withdrawn

```solidity
event Withdrawn(address user, uint256 amount)
```

This event is emitted when a subject or referrer or protocol withdrawn all their collected fees.

*emitted in withdrawAll() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| user  | address | The subject or the referrer or the protocol account that decided to make withdraw |
| amount  | uint256 | The amount of collected eth |



