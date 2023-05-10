---
title: "AppsFlyerShareInviteHelper"
slug: "ios-sdk-reference-appsflyershareinvitehelper"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-28T09:21:01.322Z"
updatedAt: "2022-04-14T12:06:46.371Z"
---
## Overview
The `AppsFlyerShareInviteHelper` class provides a structured way to construct user-invite URLs for various scenarios.

Go back to the [SDK reference index](doc:ios-sdk-reference).

## Methods
### generateInviteUrl
**Method signature**
```objc
(void)generateInviteUrlWithLinkGenerator:(AppsFlyerLinkGenerator *(^)(AppsFlyerLinkGenerator *generator))generatorCreator completionHandler:(void (^)(NSURL *_Nullable url))completionHandler;
```

**Description**
Generates a OneLink URL.

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `AppsFlyerLinkGenerator` | `generator` | |
| `(void (^)(NSURL *_Nullable url))` | `completionHandler` | Optional. If provided, the SDK will attempt to generate a short link using the OneLink API. |

**Returns**
`void`.

### logInvite
**Method signature**
```objc
(void)logInvite:(nullable NSString *)channel parameters:(nullable NSDictionary *)parameters;
```

**Description**
Use to log a user-invite in-app event ([`af_invite`](doc:in-app-events-ios#af_invite)).

**Input arguments**

**Returns**
`void`.