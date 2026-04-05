---
title: AppsFlyerInAppPurchaseValidationCallback
slug: android-sdk-reference-appsflyerinapppurchasevalidationcallback
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-reference
privacy:
  view: public
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

