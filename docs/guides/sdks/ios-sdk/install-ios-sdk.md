---
title: "Install SDK"
slug: "install-ios-sdk"
excerpt: "Learn how to download and install the iOS SDK."
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2020-11-02T17:38:36.458Z"
updatedAt: "2023-04-19T09:56:35.686Z"
order: 2
---
## Before you begin

You need [Xcode](https://developer.apple.com/xcode/resources) to follow along with these guides.

## Download and install the SDK

Download and install the iOS SDK with your package manager of choice.

### Install using CocoaPods

<div><span class="annotation-recommended">Recommended</span></div>

**Step 1: Download CocoaPods**  
[Download and install](https://guides.cocoapods.org/using/getting-started.html#installation) the latest version of CocoaPods.

**Step 2: Add dependencies**  
Add the [latest version of `AppsFlyerFramework`](https://cocoapods.org/pods/AppsFlyerFramework) to your project's Podfile:

```Podfile
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

```Cartfile
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-ios.json"
```



Currently doesn't support tvOS apps.

> 📘 Note
> 
> The link above links to a static library. If you're upgrading to a newer iOS version, do the following:
> 
> 1. Remove the Run Script stage from Xcode that runs copy-frameworks.
> 2. Make sure the library is not embedded.
> 
> To learn more, see [Carthage docs](https://github.com/Carthage/Carthage#build-static-frameworks-to-speed-up-your-apps-launch-times).

### Install using Swift Package Manager (`V6.1.0`+)

Starting `V6.1.0` the iOS SDK can be installed via Install using Swift Package Manager (SPM):  
**Step 1: Navigate to Add Package Dependency**  
In Xcode, go to **File** > **Add Packages**:

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/ba6a743-Screenshot_2022-12-20_at_14.44.18.png",
        "Screenshot 2022-12-20 at 14.44.18.png",
        1572
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**Step 2: Add iOS SDK GitHub repository**  
Enter the AppsFlyer SDK GitHub repository:  
`https://github.com/AppsFlyerSDK/AppsFlyerFramework`

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/183fc98-Screenshot_2022-12-20_at_14.42.23.png",
        "Screenshot 2022-12-20 at 14.42.23.png",
        2172
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**Step 3: Select SDK version** 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5c26d51-Screenshot_2022-12-20_at_14.42.53.png",
        "Screenshot 2022-12-20 at 14.42.53.png",
        2176
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**Step 4: Add AppsFlyerLib to desired Target** 

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/f85b0d9-Screenshot_2022-12-20_at_14.43.15.png",
        "Screenshot 2022-12-20 at 14.43.15.png",
        2168
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



### Manual install

**Step 1: Download static framework**  
[Download the iOS SDK as a static framework](https://s3-eu-west-1.amazonaws.com/download.appsflyer.com/ios/AppsFlyerLib.framework.zip).

To verify the integrity of the SDK static framework download, click [here](https://support.appsflyer.com/hc/en-us/articles/115001224823#ios-sdk-checksums).

**Step 2: Unzip**  
Unzip the `AppsFlyerLib.framework.zip` file you just downloaded.

**Step 3: Import in project**  
Drag the `AppsFlyerLib.framework` folder and drop it into your Xcode project. Make sure **Copy items if needed** is checked.

> 📘 Note
> 
> This approach is only compatible with iOS 8 and above. For tvOS apps, you need a different `AppsFlyerFramework`:
> 
> 1. Clone this [repo](https://github.com/AppsFlyerSDK/AppsFlyerFramework).
> 2. Find `AppsFlyerLib.framework` in [this folder of the cloned repo](https://github.com/AppsFlyerSDK/AppsFlyerFramework/tree/master/tvOS).
> 3. Repeat step 3.

## Native iOS framework dependencies

The SDK automatically adds and uses the following native frameworks:

- `AdSupport` framework: This framework is required to collect the IDFA from devices. Without IDFA you cannot attribute installs to Meta ads, Twitter, Google Ads, and other networks.
- `AdServices` framework (`V6.1.3+`): Measure the performance of Apple Search Ads in your app.
- `iAd` framework: (Deprecated) Measure the performance of Apple Search Ads in your app. **Note:** The `iAd` framework has not been in use since `V6.10.1` and completely removed from the code base from `V6.13.0`.


## Strict mode SDK

Use the Strict Mode SDK to completely remove IDFA collection functionality and AdSupport framework dependencies (for example, when developing apps for kids).

You can install the Strict mode SDK using one of the following methods.

### Install using CocoaPods

```podfile
pod 'AppsFlyerFramework/Strict'
```



### Install using Carthage

```Cartfile
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-strict.json" ~> 6.3.2
```



### Install using Swift Package Manager

Follow the steps to install the SDK using [Swift Package Manager](https://dev.appsflyer.com/hc/docs/install-ios-sdk#install-using-swift-package-manager-v610), and in the repository name, use `https://github.com/AppsFlyerSDK/AppsFlyerFramework-Strict`