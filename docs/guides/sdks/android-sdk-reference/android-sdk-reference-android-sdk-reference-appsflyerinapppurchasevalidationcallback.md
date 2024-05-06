---
title: "AppsFlyerInAppPurchaseValidationCallback"
slug: "android-sdk-reference-appsflyerinapppurchasevalidationcallback"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T15:15:23.678Z"
updatedAt: "2021-07-04T10:30:16.598Z"
---
## Overview
Implement the `AppsFlyerInAppPurchaseValidationCallback` interface to handle purchase validation success and failure.

**Interface declaration**

```Java
interface AppsFlyerInAppPurchaseValidationCallback {
    void onInAppPurchaseValidationFinished(validationResult: Map<String, Any?>)
    void onInAppPurchaseValidationError(validationError: Map<String, Any?>)
}
```

## Methods
### onInAppPurchaseValidationFinished
**Method signature**
```java
void onInAppPurchaseValidationFinished(Map<String, Any?> validationResult)
```

**Description**
Invoked when the in-app purchase validation is completed successfully, providing the validation result (success or failure) and a JSON object with the details of the validation success or failure. The object 


**Callback parameters**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| Map<String, Any?> | `validationFinishedResult` | The validation result (success or failure). |

**Returns**
`void`

### onInAppPurchaseValidationError
**Method signature**
```java
void onInAppPurchaseValidationError(Map<String, Any?> validationErrorResult)
```

**Description**
Triggered upon failed purchase validation.

**Callback parameters**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| Map<String, Any?> | `validationErrorResult` | The type of error that occurred during validation. |

**Returns**
`void`

