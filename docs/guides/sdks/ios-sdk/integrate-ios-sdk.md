---
title: "Integrate SDK"
slug: "integrate-ios-sdk"
excerpt: "Learn how to initialize and start the iOS SDK."
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2020-11-02T17:48:20.793Z"
updatedAt: "2023-05-02T12:31:52.710Z"
order: 3
---
## Before you begin

- Before integrating, you must [Install the SDK](doc:install-ios-sdk).
- This document contains example implementations. Make sure to replace the following: 
  - `<YOUR_DEV_KEY>`: The AppsFlyer dev key.
  - `<APPLE_APP_ID>`: The Apple App ID (without the `id` prefix).
  - Additional placeholders, where needed.

## Initializing the iOS SDK


[block:tutorial-tile]
{
  "backgroundColor": "#def7e8",
  "emoji": "🏆",
  "id": "60a415e196cfff0073c81954",
  "link": "https://dev.appsflyer.com/v0.1/recipes/starting-the-sdk-in-ios",
  "slug": "starting-the-sdk-in-ios",
  "title": "Starting the SDK in iOS"
}
[/block]




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

## Setting the Customer User ID

<span class="annotation-optional">Optional</span>  
The Customer User ID (CUID) is a unique user identifier created outside the SDK by the app owner. If made available to the SDK, it can be associated with installs and other in-app events. These CUID-tagged events can be cross-referenced with user data from other devices and applications.

### Set the CUID

To set the CUID:

```objectivec
[AppsFlyerLib shared].customerUserID = @"my user id";
```
```swift
AppsFlyerLib.shared().customerUserID = "my user id"
```



### Associate the CUID with the install event

If it’s important for you to associate the install event with the CUID, you should set  to set the [`customerUserId`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#customeruserid) before calling the [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) method. This is because [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) sends the install event to AppsFlyer. If the CUID is set after calling [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start), it will not be associated with the install event.

```objectivec
- (void)applicationDidBecomeActive:(UIApplication *)application {
  	// Your custom logic of retrieving CUID
    NSString *customUserId = [[NSUserDefaults standardUserDefaults] stringForKey:@"customerUserId"];  
    if (customUserId != nil && ![customUserId  isEqual: @""]) {
        // Set CUID in AppsFlyer SDK for this session
        [AppsFlyerLib shared].customerUserID = customUserId; 
        // Start
        [[AppsFlyerLib shared] start]; 
    }
}
```
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
  //  your logic to retrieve CUID
  let customUserId = UserDefaults.standard.string(forKey: "customUserId") 
  
  if(customUserId != nil && customUserId != ""){
     // Set CUID in AppsFlyer SDK for this session
    AppsFlyerLib.shared().customerUserID = customUserId    
    AppsFlyerLib.shared().start() // Start
  }
}
```

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
> - You need to import the `AppTrackingTransparency` framework to call [`requestTrackingAuthorization`](doc:https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization).
> - According to [Apple documentation](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization): 
>   - `requestTrackingAuthorization` is invoked **only** if the app is in the `UIApplicationStateActive` state.
>   -
>   - `requestTrackingAuthorization` **can't** be invoked from App Extensions.

### Customizing the ATT consent dialog

The ATT consent dialog can be customized by modifying your Xcode project's `info.plist`:

For detailed instructions, see [Apple's documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription).

### Attributing App Clips

Apple App Clips attribution was introduced in iOS SDK `V6.0.8`. See our [App Clips integration guide](doc:app-clip-overview) for detailed instructions.

### Sending SKAN postback copies to AppsFlyer

<span class="annotation-optional">iOS 15</span>  
Configure your app to send postback copies to AppsFlyer.

To register the AppsFlyer endpoint:

1. Add the `NSAdvertisingAttributionReportEndpoint` key to your app's `info.plist`.
2. Set the key's value to `https://appsflyer-skadnetwork.com/`.

According to Apple, you can set only one endpoint. Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).

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

## Testing the integration

For detailed integration testing instructions, see the [iOS SDK integration testing guide](doc:testing-ios).