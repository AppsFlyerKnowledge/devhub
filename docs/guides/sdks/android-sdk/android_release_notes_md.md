---
title: "Android Release Notes"
slug: "android-release-notes"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
order: 1
---

**New! Starting with v6.12.5 we are adding developer release notes to SDK releases! For previous versions, see [here](https://support.appsflyer.com/hc/en-us/articles/115001256006-AppsFlyer-Android-SDK-release-notes) **

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
