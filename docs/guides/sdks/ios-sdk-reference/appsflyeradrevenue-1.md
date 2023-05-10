---
title: "AppsFlyerAdRevenue"
slug: "appsflyeradrevenue-1"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2022-01-12T08:43:38.960Z"
updatedAt: "2023-02-09T14:41:10.064Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
AppsFlyerAdRevenue is the parent class for the ad revenue SDK.
[block:api-header]
{
  "title": "Properties"
}
[/block]
### MediationNetworkType

#### Constants

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `String` | `ironsource` | The name of the mediation network. |
| `String` | `applovinmax` |  The name of the mediation network. |
| `String` | `googleadmob` |  The name of the mediation network. |
| `String` | `fyber` | The name of the mediation network. |
| `String` | `appodeal` | The name of the mediation network. |
| `String` | `admost` | The name of the mediation network. |
| `String` | `topon` | The name of the mediation network. |
| `String` | `tradplus` | The name of the mediation network. |
| `String` | `yandex` | The name of the mediation network. |
| `String` | `chartboost` | The name of the mediation network. |
| `String` | `unity` | The name of the mediation network. |
| `String` | `customMediation` | The mediation solution is not on the list of supported mediation partners. |
| `String` | `directMonetizationNetwork` | The app integrates directly with monetization networks without mediation. |
[block:api-header]
{
  "title": "Methods"
}
[/block]
### start
**Method signature**
```swift
(void)start;
```

**Description**
Initializes the ad revenue SDK.
 
**Input arguments**

This method doesn't accept input arguments.

**Returns**
`void`.

### logAdRevenue
**Method signature**
```swift
(void)logAdRevenueWithMonetizationNetwork:(NSString * _Nonnull)monetizationNetwork
      mediationNetwork:(AppsFlyerAdRevenueMediationNetworkType)mediationNetwork
      eventRevenue:(NSNumber * _Nonnull)eventRevenue
      revenueCurrency:(NSString * _Nonnull)revenueCurrency
      additionalParameters:(NSDictionary * _Nullable)additionalParameters
```

**Description**
Logs an ad revenue impression.

**Input arguments**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `String` | `monetizationNetwork` | The name of the monetization network. |
| [`MediationNetworkType`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#mediationnetworktype) | `mediationNetwork` | Enum of the mediation network. |
| `String` | `revenueCurrency` | Currency of the ad revenue event. |
| `NSNumber` | `eventRevenue` | Amount of the ad revenue event. |
| `NSDictionary` | `additionalParameters` | Contains native and custom fields for the ad revenue payload, as described in the following usage example. |

**Returns**
`void`.

**Usage example**
```swift
let adRevenueParams:[AnyHashable: Any] = [
            kAppsFlyerAdRevenueCountry : "us",
            kAppsFlyerAdRevenueAdUnit : "02134568",     //Add ! here
            kAppsFlyerAdRevenueAdType : "Banner",  //Add ! here
            kAppsFlyerAdRevenuePlacement : "place",
            kAppsFlyerAdRevenueECPMPayload : "encrypt",
            "foo" : "testcustom",
            "bar" : "testcustom2"
        ]
        
        AppsFlyerAdRevenue.shared().logAdRevenue(
            monetizationNetwork: "facebook",
            mediationNetwork: MediationNetworkType.moPub,
            eventRevenue: 0.026,
            revenueCurrency: "USD",
            additionalParameters: adRevenueParams)
```