---
title: Install iOS SDK
slug: install-ios-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk
privacy:
  view: public
position: 2
---

## Download and install the SDK

Download and install the iOS SDK with your package manager of choice.

### Install using CocoaPods

**Recommended**

**Step 1: Download CocoaPods**  
[Download and install](https://guides.cocoapods.org/using/getting-started.html#installation) the latest version of CocoaPods.

**Step 2: Add dependencies**  
Add the [latest version of `AppsFlyerFramework`](https://cocoapods.org/pods/AppsFlyerFramework) to your project's Podfile:

```ruby
pod 'AppsFlyerFramework'
```

**Step 3: Install dependencies**  
In your terminal, navigate to your project's root folder and run `pod install`.

**Step 4: Open Xcode workspace**  
In Xcode, use the `.xcworkspace` file to open the project from this point forward, instead of the `.xcodeproj` file.

If you are developing a tvOS app, CocoaPods automatically adds the relevant dependencies from `AppsFlyerFramework`.

### Install using Carthage

**Step 1: Install Carthage**  
[Install](https://github.com/Carthage/Carthage#installing-carthage) the latest version of Carthage.

**Step 2: Add dependencies**  
Add the following line to your `Cartfile` binary:

```
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-ios.json"
```

Currently doesn't support tvOS apps.

> 📘 Note
>
> The link above links to a static library. If you're upgrading to a newer iOS version, do the following:
> 1. Remove the Run Script stage from Xcode that runs copy-frameworks.
> 2. Make sure the library is not embedded.
>
> To learn more, see [Carthage docs](https://github.com/Carthage/Carthage#build-static-frameworks-to-speed-up-your-apps-launch-times).

### Install using Swift Package Manager (V6.1.0+)

Starting `V6.1.0` the iOS SDK can be installed via Swift Package Manager (SPM):

**Step 1: Navigate to Add Package Dependency**  
In Xcode, go to **File > Add Packages**.

**Step 2: Add iOS SDK GitHub repository**  
Enter the AppsFlyer SDK GitHub repository. You can select one of the following:

- [Statically Linked Library](https://github.com/AppsFlyerSDK/AppsFlyerFramework-Static)
- [Dynamically Linked Library](https://github.com/AppsFlyerSDK/AppsFlyerFramework-Dynamic) — **Note:** The use of this version is not supported for apps that can run on MacOS. Instead, use the Statically Linked library version.
- [Strict (No IDFA Collection) Library](https://github.com/AppsFlyerSDK/AppsFlyerFramework-Strict)

**Step 3: Select SDK version**  
Select the desired SDK version in the version picker.

**Step 4: Add AppsFlyerLib to desired Target**  
Add `AppsFlyerLib` to your app target.

### Manual install

**Step 1: Download static framework**  
[Download the iOS SDK as a static framework](https://github.com/AppsFlyerSDK/AppsFlyerFramework/releases).

To verify the integrity of the SDK static framework download, click [here](https://support.appsflyer.com/hc/en-us/articles/115001224823#ios-sdk-checksums).

**Step 2: Unzip**  
Unzip the `AppsFlyerLib.framework.zip` file you just downloaded.

**Step 3: Import in project**  
Drag the `AppsFlyerLib.framework` folder and drop it into your Xcode project. Make sure **Copy items if needed** is checked.

> 📘 Note
>
> This approach is only compatible with iOS 8 and above. For tvOS apps, you need a different `AppsFlyerFramework`:
> 1. Clone this [repo](https://github.com/AppsFlyerSDK/AppsFlyerFramework).
> 2. Find `AppsFlyerLib.framework` in [this folder of the cloned repo](https://github.com/AppsFlyerSDK/AppsFlyerFramework/tree/master/tvOS).
> 3. Repeat step 3.

---

## Native iOS framework dependencies

The SDK automatically adds and uses the following native frameworks:

- **`AdSupport` framework**: Required to collect the IDFA from devices. Without IDFA you cannot attribute installs to Meta ads, Twitter, Google Ads, and other networks.
- **`AdServices` framework** (`V6.1.3+`): Measure the performance of Apple Search Ads in your app.
- **`iAd` framework**: (Deprecated) Measure the performance of Apple Search Ads in your app. **Note:** The `iAd` framework has not been in use since `V6.10.1` and was completely removed from the code base from `V6.13.0`.

---

## Optional: Configure using AppsFlyerLibConfig.plist

SDK V7 introduces an optional property list file for configuring SDK behavior without code. Add `AppsFlyerLibConfig.plist` to your app's main bundle — the SDK loads it automatically at initialization, before `initialize(devKey:appId:)` is called.

If the file is missing, the SDK uses defaults. If a key is absent from the plist, its default applies. Programmatic API calls always override plist values.

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

### Example plist

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

### Adding the file in Xcode

1. Choose **File → New → File** and select **Property List**.
2. Name it exactly `AppsFlyerLibConfig` (Xcode adds `.plist`).
3. Add it to your **app target**, not the test target.
4. Verify it appears under **Build Phases → Copy Bundle Resources**.

### Precedence

Programmatic API calls always override plist values. On every cold start, the plist is re-read first, and any subsequent API calls override those values for the remainder of the process.

---

## Strict mode SDK

Use the Strict Mode SDK to completely remove IDFA collection functionality and AdSupport framework dependencies (for example, when developing apps for kids).

You can install the Strict mode SDK using one of the following methods.

### Install using CocoaPods

```ruby
pod 'AppsFlyerFramework/Strict'
```

### Install using Carthage

```
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-strict.json" ~> 6.3.2
```

### Install using Swift Package Manager

Follow the steps to install the SDK using Swift Package Manager, and in the repository name, use `https://github.com/AppsFlyerSDK/AppsFlyerFramework-Strict`