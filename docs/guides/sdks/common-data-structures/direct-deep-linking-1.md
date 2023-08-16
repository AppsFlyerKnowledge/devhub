---
title: "Input parameters"
slug: "direct-deep-linking-1"
category: 5f9705393c689a065c409b23
hidden: true
createdAt: "2020-06-29T12:43:59.959Z"
updatedAt: "2020-11-22T14:06:54.805Z"
---
The following table lists the possible parameters OneLink can pass as an input.

The  input map holds two kinds of data:
* [Attribution data](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
* Data defined by the marketer in the link (parameters and values)
Parameters can be either:
   * AppsFlyer official parameters.
   * Custom parameters and values chosen by the marketer and developer.
[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "* The following table is relevant for AppsFlyer **SDK 5.4.1 and above**.\n   * Parameters may not be present or renamed in earlier SDK versions\n* The parameters **not marked as deprecated ** are relevant for all OneLink types:\n   * Short URL\n   * Long URL\n   * All OS's links:\n      * Android App Link\n      * Universal Links\n      * URL schemes (both iOS and Android)"
}
[/block]

[block:parameters]
{
  "data": {
    "h-0": "Parameter name",
    "h-1": "Type",
    "h-2": "Description",
    "h-3": "Remarks",
    "0-0": "af_dp",
    "0-1": "String",
    "0-2": "URI scheme URL.",
    "0-3": "Fallback to App Link. \nFor example:  afbasicapp://mainactivity",
    "1-0": "link",
    "1-1": "String",
    "1-2": "The full link that was used to perform the deep link.",
    "1-3": "Example: https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month",
    "3-0": "pid (media source)",
    "3-1": "String",
    "3-2": "OneLink's media source, e.g. email, SMS, social media.",
    "4-0": "install_time",
    "4-1": "String",
    "4-2": "Time of the first app launch.",
    "4-3": "**Deprecated**\nExample: 2020-05-06 13:51:19",
    "5-0": "scheme",
    "5-1": "String",
    "5-2": "The first word in the URL, that identifies the protocol to be used to access the resource on the Internet. For example: **mygreatapp**://mainactivity or **https**://killerapp.onelink.me/coolactivity/H7JK",
    "5-3": "**Deprecated**\nNever use `http` or `https` for URI schemes",
    "6-0": "host",
    "6-1": "String",
    "6-2": "Identifies the host that holds the resource. For example: mygreatapp://**mainactivity** or \nhttps://**killerapp.onelink.me**/coolactivity/H7JK",
    "7-0": "path",
    "7-1": "String",
    "7-2": "The specific resource in the host that the web client wants to access. For example:  https://killerapp.onelink.me/coolactivity/**H7JK**",
    "7-3": "**Deprecated**\nNot relevant for URI schemes",
    "9-0": "af_web_id",
    "9-1": "String",
    "9-2": "Token for People Based Attribution.",
    "10-0": "af_status",
    "10-1": "String",
    "10-2": "**Deprecated**",
    "10-3": "Passed **only** in URI scenario",
    "11-0": "af_deeplink",
    "11-1": "Boolean",
    "11-2": "**Deprecated**",
    "11-3": "Passed **only** in URI scenario",
    "12-0": "c (campaign)",
    "12-1": "String",
    "12-2": "Name of the marketing campaign.",
    "8-0": "shortlink",
    "8-1": "String",
    "8-2": "A shortened URL, with significantly fewer characters than the original link. For example: https://killerapp.onelink.me/coolactivity/H7JK/**checkitout**",
    "13-0": "is_retargeting",
    "13-1": "Boolean",
    "13-2": "Marks the link as part of a retargeting campaign.",
    "14-0": "af_ios_url",
    "14-1": "String",
    "14-3": "Passed to Android devices as well, even when not relevant",
    "14-2": "Fallback URL when deep linking fails on an iOS device.",
    "15-0": "af_android_url",
    "15-1": "String",
    "15-2": "Fallback URL when deep-linking fails on an Android device.",
    "16-0": "af_sub[1-5]",
    "16-1": "String",
    "16-2": "Optional custom parameter defined by the advertiser.",
    "16-3": "Values set by the marketer in the AppsFlyer dashboard.\nRecommended for passing parameters relevant for in-app routing.",
    "17-0": "af_adset",
    "17-1": "String",
    "17-2": "Adset is an intermediate level in the hierarchy between campaign and ad.",
    "20-0": "af_cost_currency",
    "21-0": "af_cost_value",
    "22-0": "af_click_lookback",
    "18-0": "af_channel",
    "19-0": "af_adname",
    "18-1": "String",
    "19-1": "String",
    "18-2": "The media source channel through which the ads are distributed. For example:  UAC_Search, UAC_Display, Instagram, Facebook Audience Network etc.",
    "19-2": "Ad name provided by the marketer/publisher.",
    "17-3": "Value set by the marketer in AppsFlyer's dashboard",
    "23-0": "af_force_deeplink",
    "23-1": "Boolean",
    "23-2": "Force deep linking into the activity specified in af_dp value.",
    "23-3": "Relevant for iOS only.\nValue is passed to Android, even when not relevant.",
    "20-1": "String",
    "21-1": "String",
    "22-1": "String",
    "20-2": "3 letter currency code compliant with [ISO-4217](https://support.appsflyer.com/hc/en-us/articles/207040526-Ad-cost-measurement-guide#cost-aggregation-methods). For example, USD, ZAR, EUR\n[Default]: USD",
    "21-2": "Cost value in using cost currency.",
    "22-2": "Configurable number of days for the lookback click attribution period.",
    "18-3": "Value set by the marketer in AppsFlyer's dashboard",
    "19-3": "Value set by the marketer in AppsFlyer's dashboard",
    "20-3": "Value set by the marketer in AppsFlyer's dashboard",
    "21-3": "Value set by the marketer in AppsFlyer's dashboard",
    "22-3": "Value set by the marketer in AppsFlyer's dashboard",
    "13-3": "The value is set by the marketer.",
    "12-3": "The value set by the marketer in the AppsFlyer dashboard.",
    "6-3": "**Deprecated**",
    "2-0": "deep_link_value",
    "2-1": "string",
    "2-2": "The value name for the specific in-app content that users will be directed to."
  },
  "cols": 4,
  "rows": 24
}
[/block]