---
title: "AppsFlyerDeepLink"
slug: "ios-sdk-reference-appsflyerdeeplink"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-16T18:11:19.889Z"
updatedAt: "2022-03-22T13:13:37.900Z"
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
Public class that holds the deep link data. 

Go back to the [SDK reference index](doc:ios-sdk-reference).
[block:api-header]
{
  "title": "Properties"
}
[/block]
### deeplinkValue
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`NSString`",
    "0-1": "`deeplinkValue`",
    "0-2": "Deep link value from the OneLink URL."
  },
  "cols": 3,
  "rows": 1
}
[/block]
### clickHTTPReferrer
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`NSString`",
    "0-1": "`clickHTTPReferrer`",
    "0-2": "The HTTP referrer from the OneLink URL identifies the address of the web page that linked to the AppsFlyer click URL. By checking the referrer, you can see where the request originated."
  },
  "cols": 3,
  "rows": 1
}
[/block]
### mediaSource
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-1": "`mediaSource`",
    "0-0": "`NSString`",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nMedia source from the OneLink URL."
  },
  "cols": 3,
  "rows": 1
}
[/block]
### campaign
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-1": "`campaign`",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nCampaign from the OneLink URL.",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### campaignId
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-1": "`campaignId`",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nCampaign ID from the OneLink URL.",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### afSub1
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "0-1": "`afSub1`",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### afSub2
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "0-0": "`NSString`",
    "0-1": "`afSub2`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### afSub3
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "0-1": "`afSub3`",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### afSub4
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "0-1": "`afSub4`",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### afSub5
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-2": "**In the near future, this will return null, due to UDL privacy protections.**\nPredefined parameter carried in the OneLink URL.",
    "0-1": "`afSub4`",
    "0-0": "`NSString`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### clickEvent
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`NSDictionary<NSString*, id>`",
    "0-1": "`clickEvent`",
    "0-2": "Returns a dictionary that holds all the OneLink data of this link."
  },
  "cols": 3,
  "rows": 1
}
[/block]
If the OneLink URL contains any of the following keys, they will appear in `clickEvent`:
* `deep_link_sub1`
* `deep_link_sub2`
* `deep_link_sub3`
* `deep_link_sub4`
* `deep_link_sub5`
* `deep_link_sub6`
* `deep_link_sub7`
* `deep_link_sub8`
* `deep_link_sub9`
* `deep_link_sub10`

### matchType
[block:parameters]
{
  "data": {
    "0-0": "`NSString`",
    "0-1": "`matchType`",
    "0-2": "Attribution method used to match this click. \n\nPossible values include:\n<ul><li>referrer (Google Play referrer string)</li><li>id_matching</li><li>probabilistic</li><li>srn (self-reporting network)</li></ul>\nReturned only in deferred deep linking scenarios.",
    "h-2": "Description",
    "h-1": "Name",
    "h-0": "Type"
  },
  "cols": 3,
  "rows": 1
}
[/block]
### isDeferred
[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`bool`",
    "0-1": "`isDeferred`",
    "0-2": "Determines whether this UDL call for the first launch of the app was in a deferred deep link flow."
  },
  "cols": 3,
  "rows": 1
}
[/block]