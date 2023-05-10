---
title: "DeepLink"
slug: "android-sdk-reference-deeplink"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-16T18:13:50.647Z"
updatedAt: "2021-07-04T10:29:29.773Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
Public class that holds the deep link data.

Go back to the [SDK reference index](doc:android-sdk-reference).
[block:api-header]
{
  "title": "Methods"
}
[/block]
### getDeepLinkValue
[block:code]
{
  "codes": [
    {
      "code": "public String getDeepLinkValue()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "Deep link value from the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getClickHttpReferrer
[block:code]
{
  "codes": [
    {
      "code": "public String getClickHttpReferrer()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "The HTTP referrer from the OneLink URL identifies the address of the web page that linked to the AppsFlyer click URL. By checking the referrer, you can see where the request originated."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getMediaSource
[block:code]
{
  "codes": [
    {
      "code": "public String getMediaSource()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nMedia source from the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getCampaign
[block:code]
{
  "codes": [
    {
      "code": "public String getCampaign()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nCampaign from the OneLink URL.",
    "h-0": "Type",
    "h-1": "Description"
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getCampaignId
[block:code]
{
  "codes": [
    {
      "code": "public String getCampaignId()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nCampaign ID from the OneLink URL.",
    "h-0": "Type",
    "h-1": "Description"
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getAfSub1
[block:code]
{
  "codes": [
    {
      "code": "public String getAFSub1()",
      "language": "java"
    }
  ]
}
[/block]
#### Returns
[block:parameters]
{
  "data": {
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "h-0": "Type",
    "h-1": "Description"
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getAfSub2
[block:code]
{
  "codes": [
    {
      "code": "public String getAFSub2()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getAfSub3
[block:code]
{
  "codes": [
    {
      "code": "public String getAFSub3()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getAfSub4
[block:code]
{
  "codes": [
    {
      "code": "public String getAFSub4()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getAfSub5
[block:code]
{
  "codes": [
    {
      "code": "public String getAFSub5()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getClickEvent
[block:code]
{
  "codes": [
    {
      "code": "public JSONObject getClickEvent()",
      "language": "java"
    }
  ]
}
[/block]
**Note:** The values in the `clickEvent` can be directly retrieved using [`getStringValue()`](https://dev.appsflyer.com/hc/docs/deeplink#getstringvalue).

####Returns
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Description",
    "0-0": "JSON object",
    "0-1": "A JSON that holds all of the OneLink data of this link."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getMatchType
[block:code]
{
  "codes": [
    {
      "code": "public String getMatchType()",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "Attribution method used to match this click. \n\nPossible values include:\n<ul><li>referrer (Google Play referrer string)</li><li>id_matching</li><li>probabilistic</li><li>srn (self-reporting network)</li></ul>\nReturned only in deferred deep linking scenarios."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### getStringValue
[block:code]
{
  "codes": [
    {
      "code": "public String getStringValue(String keyName)",
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
    "h-1": "Description",
    "0-0": "`String`",
    "0-1": "The value of a key in the OneLink click event JSON."
  },
  "cols": 2,
  "rows": 1
}
[/block]
### isDeferred
[block:code]
{
  "codes": [
    {
      "code": "public Boolean isDeferred()",
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
    "h-1": "Description",
    "0-0": "`Boolean`",
    "0-1": "Determines whether this UDL call for the first launch of the app was in a deferred deep link flow."
  },
  "cols": 2,
  "rows": 1
}
[/block]