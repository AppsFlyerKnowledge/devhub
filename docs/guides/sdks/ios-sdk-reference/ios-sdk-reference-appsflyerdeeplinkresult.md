---
title: AppsFlyerDeepLinkResult
slug: ios-sdk-reference-appsflyerdeeplinkresult
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk-reference
privacy:
  view: public
---
## Overview
Go back to the [SDK reference index](doc:ios-sdk-reference).
[block:api-header]
{
  "title": "Properties"
}
[/block]
### deepLink
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "[`DeepLink`](doc:deeplink-1)",
    "0-1": "`DeepLink`",
    "0-2": "Property holding the retrieved OneLink data from UDL API."
  },
  "cols": 3,
  "rows": 1
}
[/block]
### status
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "0-0": "`DeepLinkResultStatus`",
    "0-1": "`status`",
    "h-2": "Description"
  },
  "cols": 3,
  "rows": 1
}
[/block]
#### Constants
[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Description",
    "0-0": "`AFSDKDeepLinkResultStatusNotFound`",
    "1-0": "`AFSDKDeepLinkResultStatusFound`",
    "2-0": "`AFSDKDeepLinkResultStatusFailure`",
    "0-1": "UDL API did not find a match to this deep linking or deferred deep linking click.\nThe [`didResolveDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink) method should exit.",
    "1-1": "UDL API found a match to this deep linking or deferred deep linking click.\nThe OneLink deep link data is in a [DeepLink object]([http://google.com](https://dev.appsflyer.com/hc/docs/deeplink-1)) in [deepLink property](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#deeplink).",
    "2-1": "UDL API encountered an error while trying to find a match to this deep linking or deferred deep linking click, or during the OneLink data retrieval.\nGet the error from the [error](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#error) property."
  },
  "cols": 2,
  "rows": 3
}
[/block]
### Error
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`NSError`",
    "0-1": "`error`",
    "0-2": "Property holding the error detected during the UDL operation."
  },
  "cols": 3,
  "rows": 1
}
[/block]
