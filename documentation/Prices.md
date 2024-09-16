# Prices

*doubleHolg*

> Prices

You can use this contract to get prices from Sanr oracles.

*Used in Predictions contract*

## Methods

### changePrice

```solidity
function changePrice(bytes32 symbol, uint256 newPrice) external nonpayable
```

Saves new symbol price



#### Parameters

| Name | Type | Description |
|---|---|---|
| symbol | bytes32 | Symbol which price oracle want to save. Like &#39;BTC/USD&#39;. In bytes32 &#39;BTC/USD&#39; is 0x4254432f55534400000000000000000000000000000000000000000000000000 |
| newPrice | uint256 | Symbol price *10^18. So if BTC/USD new price is 50000 newPrice should be 50000000000000000000000 |

### changePrices

```solidity
function changePrices(bytes32[] symbol, uint256[] newPrice) external nonpayable
```

Saves new symbols prices



#### Parameters

| Name | Type | Description |
|---|---|---|
| symbol | bytes32[] | Symbols which prices oracle want to save. Like [&#39;BTC/USD&#39;, &#39;BTC/ETH&#39;]. In bytes32 [0x4254432f55534400000000000000000000000000000000000000000000000000,0x4254432f45544800000000000000000000000000000000000000000000000000] |
| newPrice | uint256[] | Symbol prices *10^18. So if BTC/USD new price is 50000 and BTC/ETH price is 3000 newPrice should be [50000000000000000000000,3000000000000000000000] |

### currentPrice

```solidity
function currentPrice(bytes32 symbol) external view returns (uint256 price, uint256 timestamp, uint256 index)
```

Get last saved symbol price



#### Parameters

| Name | Type | Description |
|---|---|---|
| symbol | bytes32 | Symbol which price you want to see. Like &#39;BTC/USD&#39;. In bytes32 &#39;BTC/USD&#39; is 0x4254432f55534400000000000000000000000000000000000000000000000000 |

#### Returns

| Name | Type | Description |
|---|---|---|
| price | uint256 | Symbol price *10^18 |
| timestamp | uint256 | Timestamp when the price was saved to this contract |
| index | uint256 | Total number of already saved prices for this symbol |

### currentPrices

```solidity
function currentPrices(bytes32[] symbol) external view returns (uint256[] prices, uint256[] timestamps, uint256[] indexes)
```

Get last saved symbols prices



#### Parameters

| Name | Type | Description |
|---|---|---|
| symbol | bytes32[] | Symbols which price you want to see. Like [&#39;BTC/USD&#39;, &#39;BTC/ETH&#39;]. In bytes32 [0x4254432f55534400000000000000000000000000000000000000000000000000,0x4254432f45544800000000000000000000000000000000000000000000000000] |

#### Returns

| Name | Type | Description |
|---|---|---|
| prices | uint256[] | Symbols prices *10^18 |
| timestamps | uint256[] | Timestamps when the prices was saved to this contract |
| indexes | uint256[] | Total number of already saved prices for these symbols |

### operators

```solidity
function operators(address) external view returns (bool)
```

Shows is the address allowed to push prices to this contract

*variable. changing in setOperator()*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | Bool that is true if the address allowed to push prices to this contract |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### pricesByIndex

```solidity
function pricesByIndex(bytes32, uint256) external view returns (uint256 timestamp, uint256 price)
```

Shows the symbol price *10^18 and block timestamp when the price was saved to this contract by the index which is the ordinal number of the saved prices for this symbol

*variable. changing in changePrice(). used to get current price in currentPrice()*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |
| _1 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| timestamp | uint256 | undefined |
| price | uint256 | undefined |

### pricesByIndexes

```solidity
function pricesByIndexes(bytes32 symbol, uint256[] indexes) external view returns (struct Prices.Price[] prices)
```

Shows the symbol prices *10^18 and block timestamps when the prices was saved to this contract by the indexes which is the ordinal numbers of the saved prices for this symbol



#### Parameters

| Name | Type | Description |
|---|---|---|
| symbol | bytes32 | Symbol which price you want to see. Like &#39;BTC/USD&#39;. In bytes32 &#39;BTC/USD&#39; is 0x4254432f55534400000000000000000000000000000000000000000000000000 |
| indexes | uint256[] | Ordinal numbers of the saved prices for this symbol. |

#### Returns

| Name | Type | Description |
|---|---|---|
| prices | Prices.Price[] | Structs that contains symbol price *10^18 and block timestamp when the price was saved to this contract |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby disabling any functionality that is only available to the owner.*


### setOperator

```solidity
function setOperator(address operator, bool authorized) external nonpayable
```

Approve or disapprove the operator address

*only for contract owner*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | The operator address |
| authorized | bool | Is this address should be allowed to push prices |

### totalPrices

```solidity
function totalPrices(bytes32) external view returns (uint256)
```

Shows the total number symbol prices on this contract

*variable. changing in changePrice(). used to get current price in currentPrice()*

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | bytes32 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | Total number of symbol prices on this contract |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |



## Events

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### SetOperator

```solidity
event SetOperator(address indexed operator, bool indexed authorized)
```

This event is emitted when contract owner approve or disapprove the operator address

*emitted in setOperator() function*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | The operator address |
| authorized `indexed` | bool | Is this address should be allowed to push prices |



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


