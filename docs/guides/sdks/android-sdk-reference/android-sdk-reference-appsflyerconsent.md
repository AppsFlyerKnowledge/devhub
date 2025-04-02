---
title: "AppsFlyerConsent"
slug: "android-sdk-reference-appsflyerconsent"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2024-02-08T19:00:15.000Z"
updatedAt: "2024-02-08T19:00:15.000Z"
---
## Overview

`AppsFlyerConsent` encapsulates the methods for acquiring consent data required by the Digital Marketing Act (DMA).

### Constructor

```java
public AppsFlyerConsent(
    Boolean isUserSubjectToGDPR,
    Boolean hasConsentForDataUsage,
    Boolean hasConsentForAdsPersonalization,
    Boolean hasConsentForAdStorage
)
```

### Parameters

| Parameter | Type | Description |
| --- | --- | --- |
| `isUserSubjectToGDPR` | Boolean | Indicates whether GDPR applies to the user. |
| `hasConsentForDataUsage` | Boolean | Indicates whether the user has consented to use their data for advertising purposes. |
| `hasConsentForAdsPersonalization` | Boolean | Indicates whether the user has consented to use their data for personalized advertising purposes. |
| `hasConsentForAdStorage` | Boolean | Indicates whether the user has consented to store or access information on a device. |

### Usage example

```java
// Example for a user NOT subject to GDPR
AppsFlyerConsent nonGdprUser = new AppsFlyerConsent(false, false, false, false);
AppsFlyerLib.getInstance().setConsentData(nonGdprUser);

//  Example for a user subject to GDPR
AppsFlyerConsent gdprUser = new AppsFlyerConsent(true, true, true, false);
AppsFlyerLib.getInstance().setConsentData(gdprUser);
```


## Methods

### forGDPRUser

<span class="annotation-deprecated">Deprecated since V6.16.1</span>  


**Method signature**

```java
public AppsFlyerConsent forGDPRUser(Boolean hasConsentForDataUsage, Boolean hasConsentForAdsPersonalization)
```

**Description**  
Acquires user consent for data usage and ad personalization. Call the function when DMA is applicable to the user.  

**Input arguments**

| Type    | Name                            | Description                                                                   |
| ------- | ------------------------------- | ----------------------------------------------------------------------------- |
| Boolean | hasConsentForDataUsage          | Indicates whether the user give consent to send their user data to Google. |
| Boolean | hasConsentForAdsPersonalization | Indicates whether the user consented to use their data for personalized advertising. |

**Returns**

| Type             | Description                            |
| ---------------- | -------------------------------------- |
| AppsFlyerConsent | An object containing user consent data |

**Usage example**

```java
AppsFlyerConsent gdprUserConsent = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage, hasConsentForAdsPersonalization); 
```

### forNonGDPRUser

<span class="annotation-deprecated">Deprecated since V6.16.1</span>  


**Method signature**

```java
public AppsFlyerConsent forNonGDPRUser()
```

**Description**  
Return an empty AppsFlyerConsent object without any consent data. Call the method when DMA is not applicable to the user. 

**Returns**

| Type             | Description                               |
| ---------------- | ----------------------------------------- |
| AppsFlyerConsent | An empty object without any consent data. |

**Usage example**

```java
val nonGdprUser = AppsFlyerConsent.forNonGDPRUser() 
```