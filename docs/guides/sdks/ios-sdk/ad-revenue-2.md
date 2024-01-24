---
title: "Ad revenue"
slug: "ad-revenue-2"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2022-01-12T08:36:36.927Z"
updatedAt: "2022-02-21T10:40:53.749Z"
order: 9
---
**At a glance**: The AppsFlyer ad revenue SDK connector enables the ad networks to report ad revenue using impression-level granularity.
[block:api-header]
{
  "title": "Overview"
}
[/block]
**Ad revenue reporting options**

Ad revenue is reported to AppsFlyer by either aggregate granularity (via API) or impression-level granularity (via SDK). Impression-level data via SDK:
- Has better data freshness and earlier availability in AppsFlyer.
- Supports SKAN. 

This document details how to send impression-level ad revenue provided by partners in the app to AppsFlyer. 

### Reporting ad revenue using the SDK

**SDK principles of operation**

The ad revenue SDK connector sends impression revenue data to the AppsFlyer SDK. An ad revenue event, af_ad_revenue, is generated and sent to the platform. These impression events are collected and processed in AppsFlyer, and the revenue is attributed to the original UA source.
[block:api-header]
{
  "title": "Integration"
}
[/block]
To integrate the iOS ad revenue SDK connector, you need to import, initialize, and trigger the SDK.

### Import the iOS ad revenue SDK

1. In your Podfile, specify the following: 
[block:code]
{
  "codes": [
    {
      "code": "pod 'AppsFlyer-AdRevenue'",
      "language": "text",
      "name": "Podfile"
    }
  ]
}
[/block]
**Important**: If you have the `AppsFlyerFramework` pod in your Podfile, remove it to avoid a collision.

2. Run the pod update.

### Initialize the iOS ad revenue SDK

- In `AppDelegate`, in the `didFinishLaunchingWithOptions` method, call the AdRevenue [`start`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#start) method using the following code:
[block:code]
{
  "codes": [
    {
      "code": "import AppsFlyerLib\nimport AppsFlyerAdRevenue\n\n@UIApplicationMain\nclass AppDelegate: UIResponder, UIApplicationDelegate {\n  \n\n    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {\n       AppsFlyerAdRevenue.start()\n    }\n\n     @objc func applicationDidBecomeActive() {\n        AppsFlyerLib.shared().start()        \n    }\n\n}",
      "language": "swift"
    }
  ]
}
[/block]
### Trigger the logAdRevenue API call

- Trigger the [`logAdRevenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#logadrevenue) API call upon every valid impression, including mandatory, and any optional, arguments.

```swift
let adRevenueParams:[AnyHashable: Any] = [
                    kAppsFlyerAdRevenueCountry : "us",
                    kAppsFlyerAdRevenueAdUnit : "02134568",
                    kAppsFlyerAdRevenueAdType : "Banner",
                    kAppsFlyerAdRevenuePlacement : "place",
                    kAppsFlyerAdRevenueECPMPayload : "encrypt",
                    "foo" : "testcustom",
                    "bar" : "testcustom2"
                ]
                
AppsFlyerAdRevenue.shared().logAdRevenue(
    monetizationNetwork: "facebook",
    mediationNetwork: MediationNetworkType.googleAdMob,
    eventRevenue: 0.026,
    revenueCurrency: "USD",
    additionalParameters: adRevenueParams)
```
