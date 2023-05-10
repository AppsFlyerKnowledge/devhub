---
title: "AppsFlyerDeepLinkDelegate"
slug: "ios-sdk-reference-appsflyerdeeplinkdelegate"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-16T18:11:37.298Z"
updatedAt: "2021-06-28T19:48:49.115Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
Protocol extending AppDelegate. Holds the callback method for [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).

Go back to the [SDK reference index](doc:ios-sdk-reference).

**Protocol declaration** 
[block:code]
{
  "codes": [
    {
      "code": "extension AppDelegate: DeepLinkDelegate {\n     \n    func didResolveDeepLink(_ result: DeepLinkResult) {\n    ….\n    }    \n}\n",
      "language": "swift"
    }
  ]
}
[/block]

[block:api-header]
{
  "title": "Public methods"
}
[/block]
### didResolveDeepLink

**Method signature** 
[block:code]
{
  "codes": [
    {
      "code": "- (void)didResolveDeepLink:(AppsFlyerDeepLinkResult *_Nonnull)result;",
      "language": "swift"
    }
  ]
}
[/block]
**Description**
`didResolveDeepLink(_ result:)` is the callback function for onDeepLinking in the [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl) API. 

**Callback parameters**
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`didResolveDeepLink`",
    "0-1": "`result`",
    "0-2": "An object that holds the OneLink retrieval operation result and the DeepLink data, (or the error if it occurs."
  },
  "cols": 3,
  "rows": 1
}
[/block]