---
title: Troubleshooting
slug: troubleshooting-ios-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-ios-7
privacy:
  view: public
position: 5
---
## Troubleshooting the iOS SDK integration

#### Installs and events are not recorded

There could be several reasons why installs and events are not recorded:

* **Bad App ID format**: If you specify an app ID in the wrong format, installs and events are not recorded. When setting the app ID in the delegate file, make sure that it is comprised of numbers only. In case the app ID is in the wrong format, the log displays the following error:
   ```
   \[ERROR\] AppsFlyer: -\[AppsFlyerTracker validateAppID\] 
       AppsFlyer Error: appleAppID should be a number!
   ```

* **Incorrect App ID**: If you specify an app ID that doesn't exist in your account, install and events are not recorded. The log shows the following error:
   ```
   AppsFlyer: -[AppsFlyerHTTPClient sendRequestEventToServer:isRequestFromCache:appID:isDebug:
           completionHandler:]_block_invoke sent information to server, status = 404
   ```

The `404` error indicates that the SDK is unable to find the app in your account.

* **Bad Dev Key**: If you specify an incorrect dev key, installs and events are not recorded. The log shows the following error:
   ```
   AppsFlyer: -[AppsFlyerHTTPClient 
   sendRequestEventToServer:isRequestFromCache:appID:isDebug:completionHandler:]
           _block_invoke sent information to server, status = 400
   ```
   
   The **400** error indicates that the SDK is unable to authenticate the request to record installs and events. Check that the dev key is the correct one. Also, make sure that the dev key contains only alphanumeric characters.
   
   **Correct:**
   ```objc
   [AppsFlyerLib shared].appleAppID = @"340954503";
   ```

   **Incorrect:**
   ```objc
   [AppsFlyerLib shared].appleAppID = @"id340954503";
   ```
   
   **Incorrect:**
   ```objc
   [AppsFlyerLib shared].appleAppID = @"com.appslyer.sampleapp";
   ```

#### App ID and dev key are correct but install is not recorded

**Scenario**
The app contains the correct app ID and dev key but installs are not recorded.

**Possible reasons**
The SDK is not initiated correctly. Make sure to call the `start` method in `applicationDidBecomeActive`:  
```objc       
    - (void)applicationDidBecomeActive:(UIApplication *)application { 
        [[AppsFlyerLib shared] start]; 
        }
```
```swift
    func applicationDidBecomeActive(application: UIApplication) { 
        AppsFlyerLib.shared().start() 
    }
```

#### The log shows "AppsFlyer dev key missing or empty. aborting"

**Scenario**
You are trying to see installs and in-app events in the log. The log shows "AppsFlyer dev key missing or empty. Aborting".

#### Possible reasons
The dev key is not set. Make sure to set it in appDelegate in the `didFinishLaunchingWithOptions` method:

```objc
[AppsFlyerLib shared].appsFlyerDevKey = @"<YOUR_DEV_KEY>";
```
```swift
AppsFlyerLib.shared().appsFlyerDevKey = "<YOUR_DEV_KEY>"
```

#### Install always attributed to organic

**Scenario**
You are testing attribution using attribution links. You've implemented the SDK conversion listener but the log always shows that the install is organic. In addition, no non-organic install is recorded in the dashboard.

**Possible reasons**
1.  The attribution link you are using is incorrect. See our [guide on attribution links](https://support.appsflyer.com/hc/en-us/articles/207447163).
2.  Make sure that the device you are testing on is registered.

#### Revenue is not recorded properly

**Scenario**
You are testing in-app events with revenue. The events appear in the dashboard but revenue is not recorded

**Possible reasons**
The revenue parameter is not formatted correctly. Do NOT format the revenue value in any way. It should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

#### I'm getting a 404 on install or event recording

**Scenario**
You are testing installs and in-app events to see that they are attributed to the correct media source. However, response 404 appears for both install and in-app events. Neither the install nor the in-app events appear in the dashboard.

**Possible reasons**
A 404 response indicates that the app ID is incorrect. See [Installs and Events are not recorded](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk).

#### I get response 400 on install or event recording

**Scenario**
You are trying to test in-app events in the log. When you trigger events you see response 400 in the logs.

**Possible reasons**
This might indicate an issue with the dev key. Check that the dev key is the correct one. Also, make sure that the dev key contains only alphanumeric characters. See [Installs and Events are not recorded](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk).

#### I get response 403 on install or event recording

**Scenario**
You are trying to test installs and other conversion events in the log. When you trigger these events, you see response 403 (forbidden) in the logs.

**Possible reasons**
This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the [different AppsFlyer packages](https://www.appsflyer.com/pricing/), and update as needed. You can also contact our customer engagement team at [hello@appsflyer.com](mailto:hello@appsflyer.com) if you have questions about our packages.

#### My SDK connection to AppsFlyer is secured by TLS 1.0 or 1.1 

To ensure that the connection to AppsFlyer is secured by TLS 1.2 or 1.3 and not by lower TLS versions use the `appsflyersdk.com` endpoint without a prefix. Specifically call the [setHost](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#sethost) function in the following way: `setHost("","[appsflyersdk.com](http://appsflyersdk.com/)")`
