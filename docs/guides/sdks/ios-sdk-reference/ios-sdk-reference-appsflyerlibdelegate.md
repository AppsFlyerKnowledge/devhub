---
title: "AppsFlyerLibDelegate"
slug: "ios-sdk-reference-appsflyerlibdelegate"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-16T18:10:30.920Z"
updatedAt: "2021-06-28T19:47:31.592Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
Protocol extending AppDelegate. Holds the callback method for OneLink legacy APIs and attribution.

Go back to the [SDK reference index](doc:ios-sdk-reference).

**Protocol declaration** 
[block:code]
{
  "codes": [
    {
      "code": "extension AppDelegate: AppsFlyerLibDelegate {\n     \n    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {\n    ...\n    }\n    \n    func onConversionDataFail(_ error: Error) {\n    ...\n    }\n    \n    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {\n    ...\n    }\n    \n    func onAppOpenAttributionFailure(_ error: Error) {\n    ...\n    }\n}\n",
      "language": "swift"
    }
  ]
}
[/block]

[block:api-header]
{
  "title": "Public methods"
}
[/block]
### onAppOpenAttribution

**Description**
Get data for users when the app opens via direct deep linking (not via deferred deep linking).
Learn more about `onAppOpenAttribution()` for [iOS](https://dev.appsflyer.com/docs/direct-deep-linking#implementing-onappopenattribution-logic).

**Method signature**
[block:code]
{
  "codes": [
    {
      "code": "func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {\n\t\t//Handle Deep Link Data\n}",
      "language": "swift"
    },
    {
      "code": "(void) onAppOpenAttribution:(NSDictionary*) attributionData {\n\t\t//Handle Deep Link\n\t}",
      "language": "objectivec"
    }
  ]
}
[/block]
### onConversionDataSuccess

**Description**

Get conversion data after an install. Useful for deferred deep linking.
Learn more about `onConversionDataSuccess()` for [iOS](https://dev.appsflyer.com/docs/deferred-deep-linking#implementing-onconversiondatasuccess-logic).

**Method signature**
[block:code]
{
  "codes": [
    {
      "code": "func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {\n\t  //Handle Conversion Data (Deferred Deep Link)\n}",
      "language": "swift"
    },
    {
      "code": "-(void)onConversionDataSuccess:(NSDictionary*) installData {\n\t  //Handle Conversion Data (Deferred Deep Link)\n}",
      "language": "objectivec"
    }
  ]
}
[/block]
### onAppOpenAttributionFailure

**Description**

Handle errors when failing to get conversion data from installs.
Learn more about `onAppOpenAttributionFailure()` for [iOS](https://dev.appsflyer.com/docs/direct-deep-linking#implementing-onappopenattributionfailure-logic).

**Method signature**
[block:code]
{
  "codes": [
    {
      "code": "func onAppOpenAttributionFailure(_ error: Error?)",
      "language": "swift"
    },
    {
      "code": "- (void)onAppOpenAttributionFailure:(NSError *)error;",
      "language": "objectivec"
    }
  ]
}
[/block]
### onConversionDataFail

**Description**

Handle errors when failing to get conversion data from installs.
Learn more about `onConversionDataFail()` for [iOS](https://dev.appsflyer.com/docs/deferred-deep-linking#implementing-onconversiondatafailure-logic).

**Method signature**
[block:code]
{
  "codes": [
    {
      "code": "func onConversionDataFail(_ error: Error?) {\n\t\t//    print(\"\\(error)\")\n\t\t// handle conversion data failure\n}",
      "language": "swift"
    },
    {
      "code": "-(void)onConversionDataFail:(NSError *) error {\n\t  NSLog(@\"%@\",error);\n\t  // handle conversion data failure\n}",
      "language": "objectivec"
    }
  ]
}
[/block]
### performOnAppAttribution

**Description**

Allows developers to manually re-trigger onAppOpenAttribution and enables developers to access deep link data at any time without connection to the app launch process. This might be needed because the regular onAppOpenAttribution callback is only called **if the app was opened with the deep link**.
 
**Method signature**
[block:code]
{
  "codes": [
    {
      "code": "AppsFlyerLib.shared().performOnAppAttribution(with: url)               ",
      "language": "swift"
    },
    {
      "code": "[[AppsFlyerLib shared] performOnAppAttributionWithURL:(NSURL * _Nullable)url];   ",
      "language": "objectivec"
    }
  ]
}
[/block]