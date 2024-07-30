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
The app sends impression revenue data to the AppsFlyer SDK. The SDK then generates an ad revenue event, `af_ad_revenue`, and sends it to AppsFlyer. These impression events are collected and processed in AppsFlyer, and the revenue is attributed to the original UA source. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners)

Depending on your SDK version there are two ways for the SDK to generate an ad revenue event.

- For SDK 6.15.0 and above see [`here`](#log-ad-revenue-for-sdk-6150-and-above).
- For SDK 6.14.6 and below see [`here`](#log-ad-revenue-for-sdk-6146-and-below).

## Log ad revenue (for SDK 6.15.0 and above)

When an impression with revenue occurs invoke the [`logAdRenvue`](doc:ios-sdk-reference-appsflyerlib#logadrevenue) method with the revenue details of the impression.  

**To implement the method, perform the following steps:**

1. Create an instance of [`AFAdRevenueData`](doc:ios-sdk-reference-appsflyerlib#afadrevenuedata) with the revenue details of the impression to be logged.  
2. If you want to add additional details to the ad revenue event, populate a dictionary with key-value pairs.
3. Invoke the  `logAdRenvue` method with the following arguments:
    - The `AFAdRevenueData` object you created in step 1.
    - The dictionary with the additional details you created in step 2.

Code Example

```swift

```
## [LEGACY] Log ad revenue (for SDK 6.14.6 and below)

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
