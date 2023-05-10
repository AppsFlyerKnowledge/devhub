---
title: "AppsFlyerCrossPromotionHelper"
slug: "ios-sdk-reference-appsflyercrosspromotionhelper"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-26T15:29:07.228Z"
updatedAt: "2021-09-09T14:39:36.475Z"
---
## Overview
AppsFlyer allows you to log and attribute installs originating from cross-promotion campaigns of your own apps. This enables marketers to optimize cross-promotion campaigns for better results.

Go back to the [SDK reference index](doc:ios-sdk-reference).

**Interface declaration**
```objc
@interface AppsFlyerCrossPromotionHelper
```

To access `AppsFlyerCrossPromotionHelper`, import [`AppsFlyerLib`](doc:ios-sdk-reference-appsflyerlib).

## Methods

### logCrossPromoteImpression
**Method signature**
```objc
(void)logCrossPromoteImpression:(id)appID
                         campaign:(id)campaign
                       parameters:(id)parameters;
```

**Description**
logs an impression as part of a cross-promotion campaign. Make sure to use the promoted App ID as it appears within the AppsFlyer dashboard.

**Input arguments**

| Type | Name | Description |
|:------|:-----|:-----|
| `NSString` | `appID` | Promoted App ID |
| `NSString` | `campaign` | Name of cross-promotion campaign |
| `NSDictionary` | `parameters` | Additional parameters to log |

**Returns**
`void`.

### logAndOpenStore
**Method signature**
```objc
(void)logAndOpenStore:(id)appID
               campaign:(id)campaign
             parameters:(id)parameters
              openStore:(void (^)(int *, int *))openStoreBlock;
```

**Description**
You can utilize the StoreKit component to open the App Store while remaining in the context of your app. Learn more in [attributing cross-promotion impressions](https://support.appsflyer.com/hc/en-us/articles/115004481946-Cross-Promotion-Tracking#attributing-crosspromotion-impressions).

**Input arguments**

| Type | Name | Description |
|:------|:-----|:-----|
| `NSString` | `appID` | Promoted App ID. |
| `NSString` | `campaign` | Name of cross-promotion campaign. |
| `NSDictionary` | `parameters` | Additional parameters to log. |
| `void (^)(int *, int *)` | `openStoreBlock` | Contains promoted clickURL. |
	
**Returns**
`void`.