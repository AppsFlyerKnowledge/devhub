---
title: Integrate iOS SDK 7
slug: integrate-ios-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk-7
privacy:
  view: hidden
position: 3
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

## Setting the Customer User ID

<span class="annotation-optional">Optional</span>

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. If made available to the SDK, it can be associated with installs and other in-app events. These CUID-tagged events can be cross-referenced with user data from other devices and applications.

### Set the CUID

To set the CUID:

```objc Objective-C
[AppsFlyerLib shared].customerUserID = @"my user id";
```
```swift Swift
AppsFlyerLib.shared().customerUserID = "my user id"
```

> 📘 Note
>
> The Customer User ID must be set with every app launch.

### Associate the CUID with the install event

If you need the CUID to be associated with the install event, set it before calling `start`. In SDK V7, since you control when `start` is called, set the CUID inside your `registerSessionReadyListener` callback before calling `start`.

### Send SKAN and AdAttributionKit postback copies to AppsFlyer

If your app uses both `SKAdNetwork` and `AdAttributionKit`, configure both postback copy endpoints in the `Info.plist` file.

#### Send SKAN postback copies to AppsFlyer

Use this setup to send SKAdNetwork postback copies to AppsFlyer.

1. Add the `NSAdvertisingAttributionReportEndpoint` key to your app's `info.plist`.
2. Set the key's value to `https://appsflyer-skadnetwork.com/`.

Once configured, Apple will send SKAdNetwork postback copies to AppsFlyer. Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).

#### Send AdAttributionKit postback copies to AppsFlyer

Use this setup to send AdAttributionKit postback copies to AppsFlyer.

1. In your app's Info.plist, add a new key.
2. Type the key name `AdAttributionKit` and select `AdAttributionKit - Postback Copy URL` from the pop-up menu.
3. Set the key's value to `https://appsflyer-skadnetwork.com/`.

Once configured, Apple will send AdAttributionKit postback copies to AppsFlyer. Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).

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

## Testing the integration

For detailed integration testing instructions, see the [iOS SDK integration testing guide](doc:testing-ios).