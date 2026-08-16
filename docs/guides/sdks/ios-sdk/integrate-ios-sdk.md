---
title: Integrate SDK
slug: integrate-ios-sdk
category:
  uri: AppsFlyer SDKs
content:
  excerpt: Learn how to initialize and start the iOS SDK.
parent:
  uri: integrate-sdk-ios-6
privacy:
  view: public
position: 2
---
## Recommended

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Get started with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=integrate-sdk-ios');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_ios_int', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

- Before integrating, you must [Install the SDK](doc:install-ios-sdk).
- This document contains example implementations. Make sure to replace the following: 
  - `<YOUR_DEV_KEY>`: [The AppsFlyer dev key](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key).
  - `<APPLE_APP_ID>`: The Apple App ID (without the `id` prefix).
  - Additional placeholders, where needed.

## Initializing the iOS SDK

**Step 1: Import dependencies**  
Import `AppsFlyerLib`:

```objectivec
// AppDelegate.h
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@end
```
```swift
import UIKit
import AppsFlyerLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // ...
}
```



**Step 2: Initialize the SDK**  
 In `didFinishLaunchingWithOptions` configure your Apple App ID and AppsFlyer dev key:

```objectivec
[[AppsFlyerLib shared] setAppsFlyerDevKey:@"<YOUR_DEV_KEY>"];
[[AppsFlyerLib shared] setAppleAppID:@"<APPLE_APP_ID>"];
```
```swift
AppsFlyerLib.shared().appsFlyerDevKey = "<YOUR_DEV_KEY>"
AppsFlyerLib.shared().appleAppID = "<APPLE_APP_ID>"
```



## Starting the iOS SDK

In `applicationDidBecomeActive`, call [`start`](doc:ios-sdk-reference-appsflyerlib#start):

```objectivec
[[AppsFlyerLib shared] start];
```
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
    AppsFlyerLib.shared().start()
    // ...
}
```



### Add SceneDelegate support

<span class="annotation-optional">Optional</span>  
Do the following only if you use `SceneDelegate`s:

In `didFinishLaunchingWithOptions`, add a `UIApplicationDidBecomeActiveNotification` observer and set it to run [`start`](doc:ios-sdk-reference-appsflyerlib#start):

```objectivec
@implementation AppDelegate
    // SceneDelegate support - start AppsFlyer SDK
    - (void)sendLaunch:(UIApplication *)application {
    [[AppsFlyerLib shared] start];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ...
    // SceneDelegate support
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(sendLaunch:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    // ...
    return YES;
}
// ...
@end
```
```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ...
        // SceneDelegate support
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplicationdidBecomeActiveNotification, object: nil)
        return true
    }
    // SceneDelegate support - start AppsFlyer SDK
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
    }
// ...
}
```



### Start with completion handler

<span class="annotation-optional">Optional</span>  
To confirm that the SDK started successfully and notified the AppsFlyer servers, call `start` with a completion handler. You can then apply logic to handle the success or failure of the SDK launch.

```objectivec
[[AppsFlyerLib shared] startWithCompletionHandler:^(NSDictionary<NSString *,id> *dictionary, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        if (dictionary) {
            NSLog(@"%@", dictionary);
            return;
        }
    }];
```
```swift
AppsFlyerLib.shared()?.start(completionHandler: { (dictionary, error) in
            if (error != nil){
                print(error ?? "")
                return
            } else {
                print(dictionary ?? "")
                return
            }
        })
```



## Full example

```objectivec
#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()
@end
@implementation AppDelegate
    // Start the AppsFlyer SDK
    - (void)sendLaunch:(UIApplication *)application {
    [[AppsFlyerLib shared] start];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /** APPSFLYER INIT **/
    [AppsFlyerLib shared].appsFlyerDevKey = @"<YOUR_DEV_KEY>";
    [AppsFlyerLib shared].appleAppID = @"<APPLE_APP_ID>";
    /* Uncomment the following line to see AppsFlyer debug logs */
    // [AppsFlyerLib shared].isDebug = true;
  
    // SceneDelegate support
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(sendLaunch:)
     name:UIApplicationDidBecomeActiveNotification
     object:nil];
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
    }

    else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }

    [[UIApplication sharedApplication] registerForRemoteNotifications];
    return YES;
}

@end
```
```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerLib.shared().appsFlyerDevKey = "<YOUR_DEV_KEY>"
        AppsFlyerLib.shared().appleAppID = "<APPLE_APP_ID>"
        /* Uncomment the following line to see AppsFlyer debug logs */
        // AppsFlyerLib.shared().isDebug = true
        // SceneDelegate support
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
        return true
    }
    // SceneDelegate support
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
    }
// ...
}
```



[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L18)

See [Setting the Customer User ID](doc:customer-user-id-ios) to associate a CUID with this integration.

## Log sessions

The SDK sends an `af_app_opened` message whenever the app is opened or brought to the foreground, providing that `start` is called in the `didBecomeActive` lifecycle event method.  Before the message is sent, the SDK makes sure that the time passed since sending the last message is not smaller than a predefined interval.

### Setting the time interval between app launches

Set [`minTimeBetweenSessions`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#mintimebetweensessions) to the minimal time interval that must lapse between two `af_app_opened` messages. The default interval is 5 seconds. 

## iOS 14 support

Following are guides on setting up support for iOS 14+ features.

### Enabling App Tracking Transparency (ATT) support

Starting iOS 14.5, [IDFA access is governed by the ATT framework](https://support.appsflyer.com/hc/en-us/articles/207032066#integration-33-configuring-app-tracking-transparency-att-support).  
Enabling ATT support in the SDK handles IDFA collection on devices with iOS `14.5`+ installed.

> 🚧 Attention
> 
> Call `waitForATTUserAuthorization` only if you intend to call `requestTrackingAuthorization` somewhere in your app.

**Step 1: Set up `waitForATTUserAuthorization`**  
When [Initializing the SDK](#initializing-the-ios-sdk), **before calling** [`start`](doc:ios-sdk-reference-appsflyerlib#start) In `applicationDidBecomeActive`, call [`waitForATTUserAuthorization`](doc:ios-sdk-reference-appsflyerlib#waitforattuserauthorization):

```objectivec
[[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
```
```swift
AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
```



[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L37) 

Set `timeoutInterval` as such that app users have enough time to see and engage with the ATT prompt. A few examples:

- If ATT prompt is displayed on app launch–a 60-second interval should be enough
- If ATT prompt is displayed after a tutorial that takes approximately 2 minutes to complete–a 120-second interval should be enough.

**Step 2: Call  `requestTrackingAuthorization`**  
Call `requestTrackingAuthorization` where you wish to display the prompt:

```objectivec
- (void)didBecomeActiveNotification {
    // start is usually called here:
    // [[AppsFlyerLib shared] start]; 
    if @available(iOS 14, *) {
      
      [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        NSLog(@"Status: %lu", (unsigned long)status);
      }];
    }
}
```
```swift Swift
@objc func didBecomeActiveNotification() {
    // start is usually called here:
    // AppsFlyerLib.shared().start()
    if #available(iOS 14, *) {
      ATTrackingManager.requestTrackingAuthorization { (status) in
        switch status {
        case .denied:
            print("AuthorizationSatus is denied")
        case .notDetermined:
            print("AuthorizationSatus is notDetermined")
        case .restricted:
            print("AuthorizationSatus is restricted")
        case .authorized:
            print("AuthorizationSatus is authorized")
        @unknown default:
            fatalError("Invalid authorization status")
        }
      }
    }
}
```



[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L55-L72) 

> 📘 Note
> 
> - You need to import the `AppTrackingTransparency` framework to call [`requestTrackingAuthorization`](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/requesttrackingauthorization(completionhandler:)).
> - According to [Apple documentation](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization): 
>   - `requestTrackingAuthorization` is invoked **only** if the app is in the `UIApplicationStateActive` state.
>   - `requestTrackingAuthorization` **can't** be invoked from App Extensions.

### Customizing the ATT consent dialog

The ATT consent dialog can be customized by modifying your Xcode project's `info.plist`:

For detailed instructions, see [Apple's documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription).

### Attributing App Clips

Apple App Clips attribution was introduced in iOS SDK `V6.0.8`. See our [App Clips integration guide](doc:app-clip-overview) for detailed instructions.

### Send SKAN and AdAttributionKit postback copies to AppsFlyer 
If your app uses both `SKAdNetwork` and `AdAttributionKit`, configure both postback copy endpoints in the `Info.plist` file.
#### Send SKAN postback copies to AppsFlyer
Use this setup to send SKAdNetwork postback copies to AppsFlyer.
1. Add the `NSAdvertisingAttributionReportEndpoint` key to your app's `info.plist`.
2. Set the key's value to `https://appsflyer-skadnetwork.com/`.
Once configured, Apple will send SKAdNetwork postback copies to AppsFlyer.
Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).
#### Send AdAttributionKit postback copies to AppsFlyer
Use this setup to send AdAttributionKit postback copies to AppsFlyer.
1. In your app's Info.plist, add a new key.
2. Type the key name `AdAttributionKit` and select `AdAttributionKit - Postback Copy URL` from the pop-up menu.
3. Set the key’s value to `https://appsflyer-skadnetwork.com/`.
Once configured, Apple will send AdAttributionKit postback copies to AppsFlyer.
Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).


## Enabling debug mode

You can enable debug logs by setting [isDebug](doc:ios-sdk-reference-appsflyerlib#isdebug) to `true`:

```objectivec
[AppsFlyerLib shared].isDebug = true;
```
```swift
AppsFlyerLib.shared().isDebug = true
```



> 📘 Note
> 
> To see full debug logs, make sure to set `isDebug` before invoking other SDK methods.
> 
> See [example](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/2ca84bfb983d60ef9dc5bcb72bb0269bc581caa8/swift/basic_app/basic_app/AppDelegate.swift#L30).

> 🚧 Warning
> 
> To avoid leaking sensitive information, make sure debug logs are disabled before distributing the app.

## Test the integration

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Easily test with our SDK wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=integrate-ios-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_ios_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Note**
> 
> If you prefer not to use our recommended wizard, you can find detailed manual testing instructions [here](doc:manual-testing-ios).

For a full troubleshooting checklist, see [Troubleshooting](doc:troubleshooting-ios).

### Creating an iOS debug app

<span class="annotation-optional">Optional</span>
You can utilize Xcode's compilation configuration capabilities to configure an easy-to-use debug app. It will enable you to switch between your debug and production apps by tapping into Xcode's active compilation conditions.

> 📘 Note
>
> If you don't mind mixing production data with test traffic, you can skip this section. All tests can be performed for both production and debug apps.

This is achieved by configuring a User-Defined Setting in your project's Build Settings and exposing it via an `info.plist` property.

**Step 1: Add a debug app to AppsFlyer**
[Add a new pending iOS app to AppsFlyer](https://support.appsflyer.com/hc/en-us/articles/207377436-Adding-a-New-Application-to-the-AppsFlyer-Dashboard) or ask a team member with dashboard access to add it. Choose any available app ID–You will need it in step 3. Make sure the ID is 9 digits and starts with four 1s, for example, 111167538. 

**Step 2: Add a User-Defined Setting**
 1. In Xcode, in the file navigator view, select your project root and go to **Build Settings**.
 2. Click **+** in the toolbar and select **Add User-Defined Setting**. In this case, we name it `AF_APP_ID`.
 3. Expand the newly created User-Defined Setting:
    * Set the **Debug** Conditional Setting to your test app's app ID (mentioned in step 1)
    * Set the **Release** Conditional Setting to your production app's app ID. 

**Step 3: Expose app IDs via info.plist**
Go to the project's `info.plist` and add a new property (called `AFAppID` in this case). Set its value to `$(AF_APP_ID)` (based on the User-Defined Setting name in step 2).

**Step 4: Retrieve and set the app ID**
To access and use app ID during SDK initialization, add the following code to `didFinishLaunchingWithOptions` in your `AppDelegate`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // ...
    guard let appID : String = Bundle.main.object(forInfoDictionaryKey: "AFAppID") as? String else {
        fatalError("Cannot find app ID")
    }
    AppsFlyerLib.shared().appleAppID = appID
    // ...
    return true
}
```

**Step 5: Run app using Debug build configuration**
To change the active build configuration:
 1. go to **Product** > **Scheme** > **Edit Scheme...**.
 2. Select **Run** and change the **Build configuration** to **Debug** or **Release**, as needed.

Now, when you use the Debug configuration to build your app, Xcode will use the debug app ID that you configured in step 2.
