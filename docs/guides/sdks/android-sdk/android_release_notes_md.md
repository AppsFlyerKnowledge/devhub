---
title: "Android Release Notes"
slug: "android-release-notes"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
order: 1
---


## Version 6.15.2

#### Bug Fixes

- Fixed OutOfMemoryError related to usage of ThreadPoolExecutor


#### Changed Features

- Internal updates for the url structure used by Privacy Sandbox Attribution API.


## Version 6.15.1

#### Technical Update

- Updated the targetSDKVersion of the SDK to 34
- Updated Gradle version to v8.7
- Updated Java version to 17


## Version 6.15.0

This version introduces important dependency updates that impact the Purchase Connector and the AdRevenue Connector for Android.

- Apps that use the AdRevenue Connector and update to SDK v6.15.0 (and above) must remove the AdRevenue Connector and migrate to the SDK API. For more details, see [here](https://dev.appsflyer.com/hc/docs/ad-revenue-1).

- Apps that use the Purchase Connector and update to SDK v6.15.0 (and above) must use Purchase Connector v2.1.0 (and above)


#### New Features

- Added the logAdRevenue method to send ad revenue data to AppsFlyer. 
Note: Starting with this version, the AdRevenue Connector should no longer be used. 
For more details, see [here](https://dev.appsflyer.com/hc/docs/ad-revenue-1).


#### Changed Features

- Updated the SDK backup rules in accordance with changes in Android 12 (dataExtractionRules). 
For more information, see [here](https://dev.appsflyer.com/hc/docs/install-android-sdk#merge-backup-rules-in-android-12-and-above)


#### Bug Fixes

- Fixed an issue with Purchase Connector not detecting all purchases made by the app.
This version is compatible with Purchase Connector v2.1.0.


## Version 6.14.2

#### Bug Fixes

- Fixed an issue with fetching Meta Install Referrer on apps built with Unity.
  This fix was integrated into Unity Plugin v6.14.4.


## Version 6.14.1

#### SDK Maintenance

- Internal improvements for how the SDK uses threads to execute server requests.


## Version 6.14.0

#### New Features

- Added a new `validateAndLogInAppPurchase` API to provide in-app purchase validation and reporting of the purchase to AppsFlyer. 
This API is initially released as closed beta and requires activation before use. 
After the official release, the new API will replace the legacy [validateAndLogInAppPurchase](https://dev.appsflyer.com/hc/docs/in-app-events-android#the-validateandloginapppurchase-method) API.

- Updated Huawei Referrer integration. As part of the new integration, apps that are published on Huawei AppGallery store and would like to use Huawei Referrer need to add a new dependency. Learn more about this [here](https://dev.appsflyer.com/hc/docs/install-android-sdk#huawei-install-referrer).


## Version 6.13.0

#### New Features

- Added the ability to collect consent data from the user, that is required by Google for DMA compliance.
The complete guide for sending user consent through the SDK can be found [here](https://dev.appsflyer.com/hc/docs/android-send-consent-for-dma-compliance).


## Version 6.12.5

#### New Features

- Added "original_link" parameter to DeepLinking callback in ESP resolving flow. 
This parameter contains the original URL that was embedded into the email, and that clicking on it opened the app.

#### Changed Features

- Added the ability to invoke getSDKVersion() API before initializing the SDK.

#### Bug Fixes

- Fix warnings appeared in Strict Mode related to the usage of WindowManager from a non visual context.

- Fix errors being printed to the Log when the app called the stop() API.


For previous versions, see [here](https://support.appsflyer.com/hc/en-us/articles/115001256006-AppsFlyer-Android-SDK-release-notes)
