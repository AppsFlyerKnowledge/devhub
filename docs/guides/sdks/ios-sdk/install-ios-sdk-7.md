---
title: Install iOS SDK 7
slug: install-ios-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk-7
privacy:
  view: hidden
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

### Install using Swift Package Manager

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

## Native iOS framework dependencies

The SDK automatically adds and uses the following native frameworks:

- **`AdSupport` framework**: Required to collect the IDFA from devices. Without IDFA you cannot attribute installs to Meta ads, Twitter, Google Ads, and other networks.
- **`AdServices` framework**: Measure the performance of Apple Search Ads in your app.

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