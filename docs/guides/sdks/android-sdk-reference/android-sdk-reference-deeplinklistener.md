---
title: "DeepLinkListener"
slug: "android-sdk-reference-deeplinklistener"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-16T18:13:36.649Z"
updatedAt: "2021-08-16T12:31:06.093Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
The `DeepLinkListener` is a public interface that holds the callback method for [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).

Go back to the [SDK reference index](doc:android-sdk-reference).

[block:api-header]
{
  "title": "Public Methods"
}
[/block]
### onDeepLinking
Callback function for onDeepLinking in the [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl) API. 
[block:code]
{
  "codes": [
    {
      "code": "public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult)",
      "language": "java"
    }
  ]
}
[/block]

[block:api-header]
{
  "title": "Parameters"
}
[/block]

[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Remarks",
    "0-0": "`DeepLinkResult`",
    "0-1": "`deepLinkResult`",
    "0-2": "An object that holds the OneLink retrieval operation result and the DeepLink data."
  },
  "cols": 3,
  "rows": 1
}
[/block]