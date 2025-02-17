---
title: "AppsFlyerConsent"
slug: "ios-sdk-reference-appsflyerconsent"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2024-02-08T19:00:15.000Z"
updatedAt: "2024-02-08T19:00:15.000Z"
---
### Overview

AppsFlyerConsent encapsulates the properties for acquiring consent data required by the Digital Marketing Act (DMA) and GDPR compliance.

```swift
public struct AppsFlyerConsent {
    public let isUserSubjectToGDPR: Bool
    public let hasConsentForDataUsage: Bool
    public let hasConsentForAdsPersonalization: Bool
    public let hasConsentForAdStorage: Bool
}
```

### Parameters

| Name | Type | Description |
| --- | --- | --- |
| isUserSubjectToGDPR | Boolean | Indicates whether GDPR applies to the user. |
| hasConsentForDataUsage | Boolean | Indicates whether the user has consented to use their data for advertising purposes. |
| hasConsentForAdsPersonalization | Boolean | Indicates whether the user has consented to use their data for personalized advertising. |
| hasConsentForAdStorage | Boolean | Indicates whether the user has consented to store or access data on a device. |

### Usage examples

### Swift

```swift
// If the user is subject to DMA - collect the consent data
// or retrieve it from the storage

// Set the consent data to the SDK:
//  Example for a user subject to GDPR
var gdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: true, 
	hasConsentForDataUsage: false, 
	hasConsentForAdsPersonalization: true, 
	hasConsentForAdStorage: false
)
AppsFlyerLib.shared().setConsentData(gdprUser)

//  Example for a user not subject to GDPR        
var nonGdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: false, 
	hasConsentForDataUsage: false, 
	hasConsentForAdsPersonalization: false, 
	hasConsentForAdStorage: false
)
AppsFlyerLib.shared().setConsentData(nonGdprUser)

```
## Initializers

### initForGDPRUser

<span class="annotation-deprecated">Deprecated since V6.16.1</span>  

**Input arguments**

| Type    | Name                                  | Description                                                                   |
| ------- | ------------------------------------- | ----------------------------------------------------------------------------- |
| Boolean | forGDPRUserWithHasConsentForDataUsage | Indicates whether the user give consent to send their user data to Google. |
| Boolean | hasConsentForAdsPersonalization       | Indicates whether the user consented to use their data for personalized advertising. |

**Usage examples**

```swift
// If the user is subject to DMA - collect the consent data
// or retrieve it from the storage

// Set the consent data to the SDK:
var gdprConsent = AppsFlyerConsent(forGDPRUserWithHasConsentForDataUsage: true, hasConsentForAdsPersonalization: true) 
AppsFlyerLib.shared().setConsentData(gdprConsent)
```

### initForNonGDPRUser

<span class="annotation-deprecated">Deprecated since V6.16.1</span>  

**Input arguments**

None

**Usage examples**

```swift
// If the user is not subject to DMA:
var nonGdprUser = AppsFlyerConsent(nonGDPRUser: ()) 
AppsFlyerLib.shared().setConsentData(nonGdprUser)
```