---
title: "DeepLinkResult"
slug: "android-sdk-reference-deeplinkresult"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-16T18:14:11.253Z"
updatedAt: "2022-02-03T09:50:08.228Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
DeepLinkResult is a public class that holds the result of the OneLink retrieval operation. If successful, it holds the deep link data.

Go back to the [SDK reference index](doc:android-sdk-reference).
[block:api-header]
{
  "title": "Methods"
}
[/block]
### getDeepLink
[block:code]
{
  "codes": [
    {
      "code": "public DeepLink getDeepLink()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Remarks",
    "0-0": "[DeepLink](doc:deeplink)",
    "0-1": "An object that holds the OneLink deep link data."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getStatus
[block:code]
{
  "codes": [
    {
      "code": "public DeepLinkResult.Status getStatus()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Remarks",
    "0-0": "Status",
    "0-1": "An enum describing the possible results from the OneLink data retrieval operation."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getError
[block:code]
{
  "codes": [
    {
      "code": "public DeepLinkResult.Error getError()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Remarks",
    "0-0": "Error",
    "0-1": "An enum describing the possible errors that can occur during the OneLink data retrieval operation."
  },
  "cols": 2,
  "rows": 1
}
[/block]

[block:api-header]
{
  "title": "Variables"
}
[/block]
### Status
[block:code]
{
  "codes": [
    {
      "code": "public static enum Status",
      "language": "java"
    }
  ]
}
[/block]
#### Constants
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Remarks",
    "0-0": "byte",
    "0-1": "FOUND",
    "0-2": "Unified Deep Linking API found a match to this deep linking or deferred deep linking click.\n\nThe OneLink deep link data is in a [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink) object retrieved by [`getDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getdeeplink).",
    "1-0": "byte",
    "1-1": "NOT_FOUND",
    "1-2": "Unified Deep Linking API did not find a match to this deep linking or deferred deep linking click.\n\nThe [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking) method should exit.",
    "2-0": "byte",
    "2-1": "ERROR",
    "2-2": "Unified Deep Linking API encountered an error while trying to find a match to this deep linking or deferred deep linking click, or during the OneLink data retrieval. \n\n`Get Error` enum using [`getError()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#geterror) to check which error occurred."
  },
  "cols": 3,
  "rows": 3
}
[/block]
### Error
[block:code]
{
  "codes": [
    {
      "code": "public static enum Error",
      "language": "java"
    }
  ]
}
[/block]
#### Constants
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Remarks",
    "0-0": "byte",
    "1-0": "byte",
    "2-0": "byte",
    "3-0": "byte",
    "0-1": "TIMEOUT",
    "1-1": "NETWORK",
    "2-1": "HTTP_STATUS_CODE",
    "3-1": "UNEXPECTED",
    "0-2": "Unified Deep Linking API didn’t find deferred deep link within specified timeframe.",
    "1-2": "Unable to access the network. Not related to AppsFlyer SDK.",
    "2-2": "Unified Deep Linking API got a response from the AppsFlyer server other than 200 (success).",
    "3-2": "Unified Deep Linking API encountered an error other than the errors above."
  },
  "cols": 3,
  "rows": 4
}
[/block]