---
title: "iOS: Set parameters based on the clicked URL domain"
slug: "dl_ios_attr_params_based_click"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
---
## Overview
Organic search attribution can be set from AppsFlyer without updating the SDK. [Learn more](https://support.appsflyer.com/hc/en-us/articles/15123194526353#setup).

Use the `appendParametersToDeepLinkingURL` method to dynamically set the media source and other parameters based on the clicked URL domain name.

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