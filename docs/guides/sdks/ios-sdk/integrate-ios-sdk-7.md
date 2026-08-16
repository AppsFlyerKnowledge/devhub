---
title: Integrate iOS SDK 7
slug: integrate-ios-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-ios-7
privacy:
  view: public
position: 2
---

## Initializing the iOS SDK

It's recommended to initialize the SDK in `didFinishLaunchingWithOptions`. This ensures the SDK can start in any scenario, including deep linking.

**Step 1: Import dependencies**  
In your `AppDelegate`, import `AppsFlyerLib`:

```objc Objective-C
// AppDelegate.h
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@end
```
```swift Swift
import UIKit
import AppsFlyerLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // ...
}
```

**Step 2: Initialize the SDK**  
In `didFinishLaunchingWithOptions`, initialize the SDK with your dev key and Apple App ID:

```objc Objective-C
[[AppsFlyerLib shared] initWithDevKey:@"<YOUR_DEV_KEY>" appleAppId:@"<APPLE_APP_ID>"];
```
```swift Swift
AppsFlyerLib.shared().initialize(devKey: "<YOUR_DEV_KEY>", appId: "<APPLE_APP_ID>")
```

---

## Configuring the SDK with AppsFlyerLibConfig.plist

<span class="annotation-optional">Optional</span>

SDK V7 introduces an optional property list file for configuring SDK behavior without code. Add `AppsFlyerLibConfig.plist` to your app's main bundle. The SDK loads it automatically during initialization, before `initialize(devKey:appId:)` is called. If the file is missing, the SDK uses defaults. If a key is absent from the plist, its default applies. Programmatic API calls always override plist values.

### Supported keys

| Plist key | Type | Default | Programmatic equivalent |
|---|---|---|---|
| `debug_mode` | Boolean | `false` | `AppsFlyerLib.shared().isDebug = true` |
| `currency_code` | String | `"USD"` | `AppsFlyerLib.shared().currencyCode = "ILS"` |
| `disable_idfa_collection` | Boolean | `false` | `AppsFlyerLib.shared().disableAdvertisingIdentifier = true` |
| `disable_idfv_collection` | Boolean | `false` | `AppsFlyerLib.shared().disableIDFVCollection = true` |
| `disable_skadnetwork` | Boolean | `false` | `AppsFlyerLib.shared().disableSKAdNetwork = true` |
| `min_time_between_sessions` | Integer (seconds) | `30` | `AppsFlyerLib.shared().minTimeBetweenSessions = 1` |
| `host` | String | `""` | `AppsFlyerLib.shared().setHost("prefix", hostName: "host.com")` |
| `prefix` | String | `""` | *(set together with `host`)* |

**Example: `AppsFlyerLibConfig.plist`**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>debug_mode</key>
    <true/>
    <key>currency_code</key>
    <string>USD</string>
    <key>disable_idfa_collection</key>
    <false/>
    <key>disable_idfv_collection</key>
    <false/>
    <key>disable_skadnetwork</key>
    <false/>
    <key>min_time_between_sessions</key>
    <integer>30</integer>
    <key>host</key>
    <string></string>
    <key>prefix</key>
    <string></string>
</dict>
</plist>
```

### Adding the file to Xcode

1. Choose **File → New → File** and select **Property List**.
2. Name it exactly `AppsFlyerLibConfig` (Xcode adds `.plist`).
3. Add it to your **app target**, not the test target.
4. Verify it appears under **Build Phases → Copy Bundle Resources**.

> 📘 Note
>
> Any value set via the public API overwrites the corresponding plist value for the remainder of the process. On the next cold start, the plist value is loaded again.

---

## Starting the iOS SDK

You control when the SDK sends its first session. Use `registerSessionReadyListener` to be notified when the SDK is ready, then call `start` when your app's conditions are met.

### Without pre-conditions

Use this if your app has no pre-start conditions. If your app supports Universal Links, call `handleLaunchOptions` before registering the listener.

```objc Objective-C
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[AppsFlyerLib shared] initWithDevKey:@"<YOUR_DEV_KEY>" appleAppId:@"<APPLE_APP_ID>"];

    // Optional - only needed if supporting Universal Links
    [[AppsFlyerLib shared] handleLaunchOptions:launchOptions];

    [[AppsFlyerLib shared] registerSessionReadyListener:^{
        // Collect ATT here if required before start
        [[AppsFlyerLib shared] start];
    }];
    return YES;
}
```
```swift Swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    AppsFlyerLib.shared().initialize(devKey: "<YOUR_DEV_KEY>", appId: "<APPLE_APP_ID>")

    // Optional - only needed if supporting Universal Links
    AppsFlyerLib.shared().handleLaunchOptions(launchOptions)

    AppsFlyerLib.shared().registerSessionReadyListener {
        // Collect ATT here if required before start
        AppsFlyerLib.shared().start()
    }
    return true
}
```

### With pre-conditions

If `start` must wait for both SDK readiness and your consent flow (CMP, ATT, or a custom gate), use a lightweight coordinator. Each side sets a flag independently — the SDK when the listener fires, your app when the consent flow completes — and `start` is called only when both are set.

```objc Objective-C
// AppDelegate.m
@interface AppDelegate ()
@property (nonatomic) BOOL consentGranted;
@property (nonatomic) BOOL sdkReady;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[AppsFlyerLib shared] initWithDevKey:@"<YOUR_DEV_KEY>" appleAppId:@"<APPLE_APP_ID>"];
    [[AppsFlyerLib shared] handleLaunchOptions:launchOptions];

    __weak typeof(self) weakSelf = self;
    [[AppsFlyerLib shared] registerSessionReadyListener:^{
        weakSelf.sdkReady = YES;
        [weakSelf startIfReady];
    }];

    // Trigger your CMP / ATT flow here.
    // When it completes, set:
    //   self.consentGranted = YES;
    //   [self startIfReady];

    return YES;
}

- (void)startIfReady {
    if (self.consentGranted && self.sdkReady) {
        [[AppsFlyerLib shared] start];
        self.sdkReady = NO; // prevent duplicate starts in the same cycle
    }
}

@end
```
```swift Swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var consentGranted = false
    private var sdkReady = false

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppsFlyerLib.shared().initialize(devKey: "<YOUR_DEV_KEY>", appId: "<APPLE_APP_ID>")
        AppsFlyerLib.shared().handleLaunchOptions(launchOptions)

        AppsFlyerLib.shared().registerSessionReadyListener { [weak self] in
            self?.sdkReady = true
            self?.startIfReady()
        }

        // Trigger your CMP / ATT flow here.
        // When it completes, call:
        //   consentGranted = true
        //   startIfReady()

        return true
    }

    private func startIfReady() {
        guard consentGranted, sdkReady else { return }
        AppsFlyerLib.shared().start()
        sdkReady = false
    }
}
```

**SwiftUI** — use `@UIApplicationDelegateAdaptor` to wire the same `AppDelegate`:

```swift
@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

#### Unregistering

```objc Objective-C
// Objective-C
[[AppsFlyerLib shared] unregisterSessionReadyListener];
```
```swift Swift
// Swift
AppsFlyerLib.shared().unregisterSessionReadyListener()
```

### Check session readiness

`isSessionReady` returns `YES` (`true` in Swift) when the session-ready listener has fired in the current foreground cycle. Use it to check readiness status from code paths that execute outside the listener callback — for example, deferred logic that runs after the initial startup sequence.

```objc Objective-C
BOOL ready = [[AppsFlyerLib shared] isSessionReady];
```
```swift Swift
let ready = AppsFlyerLib.shared().isSessionReady()
```

---

## Full example

The following example demonstrates how to initialize and start the SDK without pre-conditions.

```objc Objective-C
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[AppsFlyerLib shared] initWithDevKey:@"<YOUR_DEV_KEY>" appleAppId:@"<APPLE_APP_ID>"];

    // Optional - only needed if supporting Universal Links
    [[AppsFlyerLib shared] handleLaunchOptions:launchOptions];

    [[AppsFlyerLib shared] registerSessionReadyListener:^{
        // Collect ATT here if required before start
        [[AppsFlyerLib shared] start];
    }];
    return YES;
}
```
```swift Swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    AppsFlyerLib.shared().initialize(devKey: "<YOUR_DEV_KEY>", appId: "<APPLE_APP_ID>")

    // Optional - only needed if supporting Universal Links
    AppsFlyerLib.shared().handleLaunchOptions(launchOptions)

    AppsFlyerLib.shared().registerSessionReadyListener {
        // Collect ATT here if required before start
        AppsFlyerLib.shared().start()
    }
    return true
}
```

---

See [Setting the Customer User ID](doc:customer-user-id-ios-7) to associate a CUID with this integration, and how to configure SKAN / AdAttributionKit postback copies.

---

## Enabling debug mode

<span class="annotation-optional">Optional</span>

You can enable debug logs by setting `isDebug` to `true`:

```objc Objective-C
[AppsFlyerLib shared].isDebug = true;
```
```swift Swift
AppsFlyerLib.shared().isDebug = true
```

> 📘 Note
>
> To see full debug logs, make sure to set `isDebug` before invoking other SDK methods.

> 🚧 Warning
>
> To avoid leaking sensitive information, make sure debug logs are disabled before distributing the app.

> 📘 Note
>
> Alternatively, you can enable debug mode at build time by setting `debug_mode` to `true` in your `AppsFlyerLibConfig.plist` file. See [Configuring the SDK with AppsFlyerLibConfig.plist](#configuring-the-sdk-with-appsflyerlibconfigplist) above.

---

## Test the integration

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Easily test with our SDK wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=integrate-ios-sdk-7');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_ios_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Note**
> 
> If you prefer not to use our recommended wizard, you can find detailed manual testing instructions [here](doc:manual-testing-ios).

For a full troubleshooting checklist, see [Troubleshooting](doc:troubleshooting-ios-7).

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
