---
title: "Test integration"
slug: "testing-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2021-07-26T09:22:21.564Z"
updatedAt: "2022-11-29T15:57:14.716Z"
order: 4
---
## Before you begin
To successfully complete the test in this document, you must:
 * [Integrate the SDK](doc:integrate-ios-sdk)
 * [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).

## Test iOS SDK integration
The test consists of:
1. Simulating an ad click and installing the app:
    * If you implement ATT, follow [these instructions](#apps-that-implement-att).
    * If you don't implement ATT, follow [these instructions](#apps-that-dont-implement-att).
2. [Inspection the conversion data](#inspect-conversion-data) of the install.

### Apps that implement ATT
Follow these instructions if you implement [App Tracking Transparency](https://support.appsflyer.com/hc/en-us/articles/207032066#integration-31-configuring-app-tracking-transparency-att-support) (ATT) in your app.
Attribution will occur via [ID matching](https://support.appsflyer.com/hc/en-us/articles/207447053#device-id-matching) if the following conditions are met:
 * The attribution link contains the `idfa` parameter
 * ATT is implemented and:
     1. `requestTrackingAuthorization` is called before `start` (by utilizing [`waitForATTUserAuthorization`](doc:integrate-ios-sdk#enabling-app-tracking-transparency-att-support))
    2. User consent is given.

**Step 1: Simulate ad click**
Simulate an ad click via an attribution link. Structure the attribution link as follows:
```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&idfa=<registered_device_idfa>
```
Where:
 * `app_id` is your AppsFlyer app ID (including `id` suffix)
 * `pid` is the media source to which the install should be attributed to
 * `idfa` is the registered device's IDFA.

**Example**
If your app ID is `id123456789`, the attribution link might look like this:
```
https://app.appsflyer.com/id123456789?pid=conversionTest1&idfa=1A2B3C4D-9128-4597-1234- 
04E23D654321
```

**Step 2: Install the app**
[Enable debug mode](doc:integrate-ios-sdk#enabling-debug-mode) and install the app on a [registered test device](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).

**Step 3: Execute test**
Proceed to [inspect conversion data](#inspect-conversion-data).

### Apps that don't implement ATT
**Step 1: Simulate an ad click**
Simulate an ad click via an attribution link. Structure the attribution link as follows:
```
https://app.appsflyer.com/<app_id>?pid=<media_source>
```
Where:
 * `app_id` is your AppsFlyer app ID (including `id` prefix)
 * `pid` is the media source to which the install should be attributed to.

**Example**
If your app ID is `id123456789`, the attribution link might look like this:
```
https://app.appsflyer.com/id123456789?pid=conversionTest1
```
**Step 2: Install the app**
[Enable debug mode](doc:integrate-ios-sdk#enabling-debug-mode) and install the app on any device–since the IDFA used to register the device isn't available, device registration has no effect in this case.

**Step 3: Execute test**
Proceed to [inspect conversion data](#inspect-conversion-data).
[block:callout]
{
  "type": "success",
  "body": "More often than not, tests using attribution links are performed more than once. That's why it's recommended to use one of the attribution parameters to \"version\" your tests–it makes it easier to understand which link triggered which conversion.\n\nIn the above example, the value of `pid` is `conversionTest1`. In consecutive tests, increment the value of `pid` to `conversionTest2`, `conversionTest3`, and so on.",
  "title": "Tip"
}
[/block]

### Inspect conversion data
After simulating an ad click and installing the app, follow these steps to inspect the install's conversion data.

**Step 1: Retrieve install UID**
Once the app is installed, In the Xcode terminal, search for `conversions.appsflyer`. Look for the `uid` parameter and copy its value.
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/223ae48-log-gcd-payload_en-us.png",
        "log-gcd-payload_en-us.png",
        2452,
        824,
        "#4b4b50"
      ]
    }
  ]
}
[/block]
**Step 2: Inspect conversion data**  
Go to [the conversion data test API](https://dev.appsflyer.com/hc/reference/gcd-get-data) and fill in the required fields:

1. `app-id`: Your app ID
2. `device_id`: paste the value of `uid` from step 1.
3. `devkey` - Application's devkey. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032126#integration-2-integrating-the-sdk) how to get it.


Then, click **Try it!** to execute the test.

**Expected results** 
If ATT is implemented and user consent is given, the result is a 200 response similar to (truncated for readability):
[block:code]
{
  "codes": [
    {
      "code": "{\n    ...\n    \"af_status\" = \"Non-organic\";\n    ...\n    \"match_type\" = id_matching;\n    \"media_source\" = conversionTest1;\n    ...\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]
Otherwise, attribution occurs [probabilistically](https://support.appsflyer.com/hc/en-us/articles/207447053#probabilistic-modeling) and the result is a 200 response similar to (truncated for readability):
[block:code]
{
  "codes": [
    {
      "code": "{\n    ...\n    \"af_status\" = \"Non-organic\";\n    ...\n    \"match_type\" = probabilistic;\n    \"media_source\" = conversionTest1;\n    ...\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]
If the install isn't attributed, the result is a 200 response with the following payload:
[block:code]
{
  "codes": [
    {
      "code": "{\n    \"af_message\" = \"organic install\";\n    \"af_status\" = Organic;\n    \"install_time\" = \"2021-08-23 06:59:51.194\";\n    \"is_first_launch\" = 1;\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]

[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "It might take up to 30 minutes for installs to appear in the dashboard."
}
[/block]
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
This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the [different AppsFlyer packages](https://www.appsflyer.com/pricing/), and update as needed. You can also contact our customer engagement team at [hello@appsflyer.com](mailto:hello@appsflyer.com) if you have questions about our packages.

## Creating an iOS debug app
<span class="annotation-optional">Optional</span>
You can utilize Xcode's compilation configuration capabilities to configure an easy-to-use [debug app](doc:integration-testing#debug-apps). It will enable you to switch between your debug and production apps by tapping into Xcode's active compilation conditions.
[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "If you don't mind mixing production data with test traffic, you can skip to [testing the integration](#test-ios-sdk-integration). All tests can be performed for both production and debug apps."
}
[/block]
This is achieved by configuring a User-Defined Setting in your project's Build Settings and exposing it via an `info.plist` property.

**Step 1: Add a debug app to AppsFlyer**
[Add a new pending iOS app to AppsFlyer](https://support.appsflyer.com/hc/en-us/articles/207377436-Adding-a-New-Application-to-the-AppsFlyer-Dashboard) or ask a team member with dashboard access to add it. Choose any available app ID–You will need it in step 3. Make sure the ID is 9 digits and starts with four 1s, for example, 111167538. 

**Step 2: Add a User-Defined Setting**
 1. In Xcode, in the file navigator view, select your project root and go to **Build Settings**.
 2. Click **+** in the toolbar and select **Add User-Defined Setting**. In this case, we name it `AF_APP_ID`.
 3. Expand the newly created User-Defined Setting:
    * Set the **Debug** Conditional Setting to your test app's app ID (mentioned in step 1)
    * Set the **Release** Conditional Setting to your production app's app ID. 
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/6c8e25c-2021-08-02_19-12-34.png",
        "2021-08-02_19-12-34.png",
        987,
        597,
        "#302b2e"
      ],
      "border": false
    }
  ]
}
[/block]
**Step 3: Expose app IDs via info.plist**
Go to the project's `info.plist` and add a new property (called `AFAppID` in this case). Set its value to `$(AF_APP_ID)` (based on the User-Defined Setting name in step 2).
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/2073949-2021-08-02_19-41-31.png",
        "2021-08-02_19-41-31.png",
        971,
        434,
        "#322d31"
      ]
    }
  ]
}
[/block]
**Step 4: Retrieve and set the app ID**
To access and use app ID [during SDK initialization](doc:integrate-ios-sdk#initializing-the-ios-sdk), add the following code to `didFinishLaunchingWithOptions` in your `AppDelegate`:
[block:code]
{
  "codes": [
    {
      "code": "func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {\n    // ...\n    guard let appID : String = Bundle.main.object(forInfoDictionaryKey: \"AFAppID\") as? String else {\n        fatalError(\"Cannot find app ID\")\n    }\n    AppsFlyerLib.shared().appleAppID = appID\n    // ...\n    return true\n}\n",
      "language": "swift"
    }
  ]
}
[/block]
**Step 5: Run app using Debug build configuration**
To change the active build configuration:
 1. go to **Product** > **Scheme** > **Edit Scheme...**.
 2. Select **Run** and change the **Build configuration** to **Debug** or **Release**, as needed.
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/bc4100b-2021-08-02_19-58-57.png",
        "2021-08-02_19-58-57.png",
        945,
        312,
        "#313034"
      ]
    }
  ]
}
[/block]
Now, when you use the Debug configuration to build your app, Xcode will use the debug app ID that you configured in step 2.