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

## Recommended

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        We recommend using our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=adrevenue-ios-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_ios_adrevenue', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

The app sends impression revenue data to the AppsFlyer SDK. The SDK then sends it to AppsFlyer. These impression data is collected and processed in AppsFlyer, and the revenue is attributed to the original UA source. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners).

There are two ways for the SDK to generate an ad revenue event, depending on your SDK version. Use the correct method for your SDK version:
- [SDK 6.15.0 and above](#log-ad-revenue-for-sdk-6150-and-above). Uses the ad revenue SDK API.
- [SDK 6.14.2 and below](#log-ad-revenue-for-sdk-6146-and-below). Uses the ad revenue SDK connector.

## Log ad revenue (for SDK 6.15.0 and above)

When an impression with revenue occurs invoke the [`logAdRevenue`](doc:ios-sdk-reference-appsflyerlib#logadrevenue) method with the revenue details of the impression.  

> 📘 Note
> 
> If you are using the AdRevenue connector, please remove it before switching to the new `logAdRevenue` method. Failing to do so may cause unexpected behavior.


**To implement the method:**

1. Create an instance of [`AFAdRevenueData`](doc:ios-sdk-reference-appsflyerlib#afadrevenuedata) with the revenue details of the impression to be logged.  
2. If you want to add additional details to the ad revenue event, populate a dictionary with key-value pairs.
3. Invoke the  `logAdRevenue` method with the following arguments:
    - The `AFAdRevenueData` object you created in step 1.
    - The dictionary with the additional details you created in step 2.

### Code Example

```swift
import AppsFlyerLib


let my_adRevenueData = AFAdRevenueData(monetizationNetwork: "ironsource",
                        mediationNetwork: MediationNetworkType.googleAdMob,
                        currencyIso4217Code: "USD",
                        eventRevenue: 0.0015)
        
var my_additionalParameters: [String: Any] = [:]
my_additionalParameters[kAppsFlyerAdRevenueCountry] = "US"
my_additionalParameters[kAppsFlyerAdRevenueAdType] = "Banner"
my_additionalParameters[kAppsFlyerAdRevenueAdUnit] = "89b8c0159a50ebd1"
my_additionalParameters[kAppsFlyerAdRevenuePlacement] = "place"

AppsFlyerLib.shared().logAdRevenue(my_adRevenueData, additionalParameters: my_additionalParameters)
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
                    kAppsFlyerAdRevenueCountry : "US",
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
