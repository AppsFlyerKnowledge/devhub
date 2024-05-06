---
title: "AppsFlyerInAppPurchaseValidatorListener (LEGACY)"
slug: "android-sdk-reference-appsflyerinapppurchasevalidatorlistener"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T15:15:23.678Z"
updatedAt: "2021-07-04T10:30:16.598Z"
---
## Overview
Implement the `AppsFlyerInAppPurchaseValidatorListener` interface to handle purchase validation success and failure.

Go back to the [SDK reference index](doc:android-sdk-reference).

**Interface declaration**
```java
public interface AppsFlyerInAppPurchaseValidatorListener
```
## Methods
### onValidateInApp
**Method signature**
```java
void onValidateInApp()
```

**Description**
Triggered upon successful purchase validation.

**Returns**
`void`

### onValidateInAppFailure
**Method signature**
```java
void onValidateInAppFailure(java.lang.String error)
```

**Description**
Triggered upon failed purchase validation.

**Callback parameters**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `String` | `error` | The type of error that occurred during validation. |

**Returns**
`void`