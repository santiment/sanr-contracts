# ERC2771Recipient



> The ERC-2771 Recipient Base Abstract Class - Implementation

Note that this contract was called `BaseRelayRecipient` in the previous revision of the GSN.A base contract to be inherited by any contract that want to receive relayed transactions.A subclass must use `_msgSender()` instead of `msg.sender`.



## Methods

### getTrustedForwarder

```solidity
function getTrustedForwarder() external view returns (address forwarder)
```

:warning: **Warning** :warning: The Forwarder can have a full control over your Recipient. Only trust verified Forwarder.Method is not a required method to allow Recipients to trust multiple Forwarders. Not recommended yet.




#### Returns

| Name | Type | Description |
|---|---|---|
| forwarder | address | The address of the Forwarder contract that is being used. |

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




