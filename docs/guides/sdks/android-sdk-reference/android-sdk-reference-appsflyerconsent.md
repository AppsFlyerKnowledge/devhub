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

`AppsFlyerConsent` encapsulates the methods for acquiring consent data required by the Digital Marketing Act (DMA) under the GDPR regulation.

## Methods

### forGDPRUser

**Method signature**

```java
public AppsFlyerConsent forGDPRUser(Boolean hasConsentForDataUsage, Boolean hasConsentForAdsPersonalization)
```

**Description**  
Acquires user consent for data usage and ad personalization. Call the function when GDPR is applicable to the user.  

**Input arguments**

| Type    | Name                            | Description                                                                   |
| ------- | ------------------------------- | ----------------------------------------------------------------------------- |
| Boolean | hasConsentForDataUsage          | Indicates whether the user consented to share. their data usage               |
| Boolean | hasConsentForAdsPersonalization | Indicates whether the user consented to share their data for ad optimization. |

**Returns**

| Type             | Description                            |
| ---------------- | -------------------------------------- |
| AppsFlyerConsent | An object containing user consent data |

**Usage example**

```java
AppsFlyerConsent gdprUserConsent = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage, hasConsentForAdsPersonalization); 
```

### forNonGDPRUser

**Method signature**

```java
public AppsFlyerConsent forNonGDPRUser()
```

**Description**  
Return an empty AppsFlyerConsent object without any consent data. Call the method when GDPR is not applicable to the user. 

**Returns**

| Type             | Description                               |
| ---------------- | ----------------------------------------- |
| AppsFlyerConsent | An empty object without any consent data. |

**Usage example**

```java
val nonGdprUser = AppsFlyerConsent.forNonGDPRUser() 
```