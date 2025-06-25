---
title: "iOS Release Notes"
slug: "ios-release-notes"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
order: 1
---

## Version 6.17.1

#### New Features

- Added support for [Google Integrated Conversion](https://support.google.com/google-ads/answer/16203286) (ICM) measurement.

#### Bug Fixes

- Fixed an issue causing an App Store login popup to appear when running the SDK in a development environment

## Version 6.17.0

#### Technical Update

- Stability and performance improvements


## Version 6.16.1

#### Changed Features

- Updated the API for sending DMA Consent data manually to AppsFlyer. 
The change includes:
  - New constructor for generating the AppsFlyerConsent object. All of the parameters of the constructor are optional.
  - The new constructor contains a new flag parameter - "ad_storage" to indicate whether the user grants permission to store and access information on the device.
 See developer guide [here](https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance#manually-collect-consent-data).

## Version 6.16.0

#### New Features

- Added support for Apple’s StoreKit 2 APIs for Subscription and In-App Purchase reporting through the Purchase Connector. This feature is currently in closed beta.

Notes: 

1. This version is compatible with Purchase Connector v6.16.0. If you are using the Purhcase Connector and you would like to use this SDK version, please update the Purchase Connector to v6.16.0 as well.

2. Storekit v1 is still supported with this release.


## Version 6.15.3

#### Technical Update:

- Set the MacOS deployment target to 10.13

- Remove redundant calls to ATTTrackingManger's trackingAuthorizationStatus API when fetching the IDFA, after the app called waitForATTUserAuthorization.



## Version 6.15.2

#### Bug Fixes

- Fixed an issue with caching of Purchase Connector requests that failed to be sent.



## Version 6.15.1

#### Bug Fixes

- Fixed an issue in Reinstall Detection for apps that use the Keychain Sharing among a collection of apps. 



## Version 6.15.0

This version introduces important dependency updates that impact the Purchase Connector and the AdRevenue Connector for Android. 

- Apps that use the AdRevenue Connector and update to SDK v6.15.0 (and above) must remove the AdRevenue Connector and migrate to the SDK API. 
For more details, see [here](https://dev.appsflyer.com/hc/docs/ad-revenue-1).

- Apps that use the Purchase Connector and update to SDK v6.15.0 (and above) must use Purchase Connector v6.15.2 (and above)


#### New Features

- Added the logAdRevenue method to send ad revenue data to AppsFlyer. 
Note: Starting with this version, the AdRevenue Connector should no longer be used. 
For more details, see [here](https://dev.appsflyer.com/hc/docs/ad-revenue-1).



## Version 6.14.6

#### Bug Fixes

- Fixed an issue where the SDK was making redundant calls to the getConversionData API (GCD) when starting a new session; this does not impact measurement.



## Version 6.14.5

#### Bug Fixes

- Fixed an issue where the SDK would send the manual consent data that had been set by the app, even if the code for sending the manual consent was removed.



## Version 6.14.4

#### Changed Features

- Added a dedicated Privacy Manifest to Strict SDK, where the IDFA is not collected.


## Version 6.14.3

#### Changed Features

- Updated podspec to fix the bundling of the Privacy Manifest in CocoaPods.


## Version 6.14.2

#### Changed Features

- Re-added the MinimumOSVersion 100 for SPM builds for AppsFlyerLib-Static and AppsFlyerLib-Strict.


## Version 6.14.1

#### New Features

- Added a new `validateAndLogInAppPurchase` API to provide in-app purchase validation and reporting of the purchase to AppsFlyer. 
This API is initially released as closed beta and requires activation before use. 
After the official release, the new API will replace the legacy [validateAndLogInAppPurchase](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#validateandlogloginapppurchase) API.

#### Changed Features

- Updated the Minimum Deployment version of the SDK to 12, in accordance with the App Store Connect requirements for building apps with XCode15 described [here](https://developer.apple.com/news/?id=fxu2qp7b). As part of this change we also attempted to remove the workaround introduced v6.13.2, that set the MinimumOSVersion to 100.


## Version 6.14.0

#### New Features

- Added AppsFlyer SDK's Privacy Manifest. More information about it can be found [here](https://support.appsflyer.com/hc/en-us/articles/21677433322641-Privacy-Manifest).

- Added XCFramework Signature. The SDK's XCFramework is signed with Apple's certificate authority.
The signature can be validated using XCode 15.
Upon successful verification, the Signature in XCode's File Inspector should look like this: ![SDK Signature](https://files.readme.io/3852aae-af_sdk_signature.png).
More information about SDK signing can be found [here](https://developer.apple.com/documentation/xcode/verifying-the-origin-of-your-xcframeworks).


## Version 6.13.2

#### Bug Fixes

- Fixed an issue that prevented the release of apps using SPM with XCode 15.3.
The issue was related to building the release for archive and validation with App Store Connect.
More details about the issue can be found [here](https://github.com/AppsFlyerSDK/AppsFlyerFramework/issues/263).

The fix was published in a dedicated repository - 
https://github.com/AppsFlyerSDK/AppsFlyerFramework-Static
Please make sure to use that repository if you are integrating the SDK with SPM using XCode 15.3.


## Version 6.13.1

#### Bug Fixes

- Fixed an issue with sending consent data for non GDPR users in a CMP consent flow.
The issue affects apps that use the CMP consent data collection feature introduced in v6.13.0.
When GDPR does not apply for a certain user, the SDK would send empty consent data to AppsFlyer, as if the GDPR status of the user was not determined.

Note: When GDPR does apply for a user - the data will be sent correctly, so there is no concern for sending wrong consent data.


## Version 6.13.0

#### New Features

- Added the ability to collect consent data from the user, that is required by Google for DMA compliance.
The complete guide for sending user consent through the SDK can be found [here](https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance).


## Version 6.12.3

#### New Features

- Added "original_link" parameter to DeepLinking callback in ESP resolving flow. 
This parameter contains the original URL that was embedded into the email, and that clicking on it opened the app.

- Added "host" and "path" parameters to the payload of Universal Deep Linking (UDL) callback.

#### Changed Features

- Removed any reference to the iAd framework from the SDK. 
Following Apple's announcement about the termination of iAd framework on iOS, we removed any reference to it from the AppsFlyer SDK. The SDK will continue to use the AdServices framework for Apple Search Ads attribution.
For more information about the iAd framework removal from iOS, See "About the iAd attribution framework" [here](https://searchads.apple.com/help/reporting/0028-apple-ads-attribution-api)



For previous versions, see [here](https://support.appsflyer.com/hc/en-us/articles/115001224823-AppsFlyer-iOS-SDK-release-notes)
