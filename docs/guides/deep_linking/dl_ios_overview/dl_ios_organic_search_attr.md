---
title: "[Legacy] iOS organic search attribution"
slug: "dl_ios_organic_search_attr"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
excerpt: "**At a glance**:  Attribute existing users who re-engage with your app after an organic web search."
hidden: false
createdAt: "2022-12-29T10:10:09.873Z"
updatedAt: "2023-03-08T17:08:12.424Z"
---
## Overview
App owners using Universal Links for deep linking (without OneLink), who have a domain associated with their app can attribute sessions initiated via this domain using the `appendParametersToDeepLinkingURL` method.

## Prerequisites
- iOS SDK 6.0.8+.
- Call this method before calling [`start`](#start). 

## Usage

### Input parameters

| Type           | Name         | Description                                                          |
| :------------- | :----------- | :------------------------------------------------------------------- |
| `NSString`     | `contains`   | A domain name to identify URLs                                          |
| `NSDictionary` | `parameters` | Parameters to append to the deeplink URL after it passed validation |


Provide the following parameters in the `parameters` `Map`:

- `pid`
- `is_retargeting=true`

### Usage example

```swift
AppsFlyerLib.shared().appendParametersToDeeplinkURL(contains: "example.com", parameters: ["pid" : "exampleDomain", "is_retargeting" : true])
```
```Obj-c
[[AppsFlyerLib shared] appendParametersToDeepLinkingURLWithString:@"example.com" @{@"pid" : @"exampleDomain", @"is_retargeting" : @YES}]
```

In the example above, the attribution URL sent to AppsFlyer servers is:

```
example.com?pid=exampleDomain&is_retargeting=true
```