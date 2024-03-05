---
title: "iOS Release Notes"
slug: "ios-release-notes"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
order: 1
---


**New! Starting with v6.12.3 we are adding developer release notes to SDK releases! For previous versions, see [here](https://support.appsflyer.com/hc/en-us/articles/115001224823-AppsFlyer-iOS-SDK-release-notes) **


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
