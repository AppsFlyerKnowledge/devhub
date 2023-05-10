---
title: "AppsFlyerLinkGenerator"
slug: "ios-sdk-reference-appsflyerlinkgenerator"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-28T10:05:32.458Z"
updatedAt: "2021-08-10T15:01:46.715Z"
---
## Overview
Instances of the `AppsFlyerLinkGenerator` class are provided as input for [`generateInviteUrl`](doc:ios-sdk-reference-appsflyershareinvitehelper#generateinviteurl) from [`AppsFlyerShareInviteHelper`](doc:ios-sdk-reference-appsflyershareinvitehelper).

Go back to the [SDK reference index](doc:ios-sdk-reference).

**Declaration**
```objc
@interface AppsFlyerLinkGenerator : NSObject
```

To access `AppsFlyerLinkGenerator`, import [`AppsFlyerLib`](doc:ios-sdk-reference-appsflyerlib).

## Properties
### brandDomain
**Property declaration**
```objc
@property(nonatomic, nullable) NSString *brandDomain;
```

## Methods
### setChannel
**Method signature**
```objc
- (void)setChannel           :(nonnull NSString *)channel;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `channel` | The channel through which the invite is sent. |

**Returns**
`void`.

### setReferrerCustomerId
**Method signature**
```objc
- (void)setReferrerCustomerId:(nonnull NSString *)referrerCustomerId;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `referrerCustomerId` | |

**Returns**
`void`.

### setCampaign
**Method signature**
```objc
- (void)setCampaign          :(nonnull NSString *)campaign;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `campaign` | |

**Returns**
`void`.

### setReferrerUID
**Method signature**
```objc
- (void)setReferrerUID       :(nonnull NSString *)referrerUID;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `referrerUID` | |

**Returns**
`void`.

### setReferrerName
**Method signature**
```objc
- (void)setReferrerName      :(nonnull NSString *)referrerName;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `referrerName` | |

**Returns**
`void`.

### setReferrerImageURL
**Method signature**
```objc
- (void)setReferrerImageURL  :(nonnull NSString *)referrerImageURL;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `referrerImageURL` | The URL to referrer user avatar. |

**Returns**
`void`.

### setAppleAppID
**Method signature**
```objc
- (void)setAppleAppID        :(nonnull NSString *)appleAppID;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `appleAppID` | Apple App ID |

**Returns**
`void`.

### setDeeplinkPath
**Method signature**
```objc
- (void)setDeeplinkPath      :(nonnull NSString *)deeplinkPath;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `deeplinkPath` | Deeplink path. |

**Returns**
`void`.

### setBaseDeeplink
**Method signature**
```objc
- (void)setBaseDeeplink      :(nonnull NSString *)baseDeeplink;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `baseDeeplink` | Base deeplink path. |

**Returns**
`void`.

### addParameterValue
**Method signature**
```objc
- (void)addParameterValue    :(nonnull NSString *)value forKey:(NSString *)key;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSString` | `value` | URL parameter value. |
| `NSString` | `key` | URL parameter name. |

**Returns**
`void`.

### addParameters
**Method signature**
```objc
- (void)addParameters        :(nonnull NSDictionary *)parameters;
```

**Input arguments**

| Type | Name | Description |
|:--------|:---------- |:--------------- |
| `NSDictionary` | `parameters` | URL parameters dictionary. |

**Returns**
`void`.