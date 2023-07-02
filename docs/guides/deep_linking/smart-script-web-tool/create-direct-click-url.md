---
title: "Creating a direct click URL"
slug: "create-direct-click-url"
category: 6384c30e5a754e005f668a74
parentDoc: 63ad67e32f0483001e26406b
hidden: false
createdAt: "2023-02-21T13:14:37.778Z"
updatedAt: "2023-03-01T12:21:52.568Z"
---
[block:callout]
{
  "type": "warning",
  "title": "This method requires v2.4.0 and above"
}
[/block]

[block:callout]
{
  "type": "info",
  "title": "This method is an extension to Smart Script",
  "body": "Make sure you read the Smart Script [implementation](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#implementation-steps) and [arguments](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#arguments)"
}
[/block]
## Overview

This method provides support for creating a click URLs, to be used mainly by non mobile platforms (e.g. Steam, CTVs etc). When the click is matched to an installation, an attribution will be noted.

## Arguments
[block:html]
{
  "html": "<table class=\"table--hover table--striped table--color-header unsortable\" style=\"height: 532px; width: 842px;\">\n  <thead>\n    <tr style=\"height: 40px;\">\n      <th style=\"width: 272.312px;\" colspan=\"2\">Argument</th>\n      <th style=\"width: 291.5px; height: 40px;\">Remarks</th>\n      <th style=\"width: 268.188px; height: 40px;\">Example</th>\n    </tr>\n  </thead>\n  <tbody>    \n    <tr style=\"height: 19px;\">\n      <td style=\"width: 119.953px;\" rowspan=\"6\">\n        <p>afParameters</p>\n        <p>(required)</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 133.359px; height: 19px;\">\n        <p>mediaSource</p>\n        <p>(required)</p>\n      </td>\n      <td style=\"width: 283.5px; height: 19px;\">\n        <p>Configuration object for media source</p>\n      </td>\n      <td style=\"width: 260.188px; height: 19px;\">\n        <ul>\n          <li>Keys: ['incoming_mediasource’' 'utm_source']</li>\n          <li>\n            Override values: {twitter: 'twitter_int', orig_src: 'new_src'}\n          </li>\n          <li>Default value: ['any_source']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 40px;\">\n      <td style=\"width: 133.359px; height: 40px;\">\n        <p>campaign</p>\n      </td>\n      <td style=\"width: 283.5px; height: 40px;\">\n        <p>Configuration object for campaign</p>\n      </td>\n      <td style=\"width: 260.188px; height: 40px;\">\n        <ul>\n          <li>Keys: ['incoming_campaign', 'utm_campaign']</li>\n          <li>Override values: {campaign_name: 'new_campaign_name'}</li>\n          <li>Default value: ['any_campaign_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 133.359px;\">\n        <p>channel</p>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <p>Configuration object for channel</p>\n      </td>\n      <td style=\"width: 260.188px;\">\n        <ul>\n          <li>Keys: ['incoming_channel', 'utm_channel']</li>\n          <li>Override values: {video: 'new_video'}</li>\n          <li>Default value: ['any_video']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <p>ad</p>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <p>Configuration object for ad</p>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>Keys: ['incoming_ad', 'utm_ad']</li>\n          <li>Override values: {ad_name: 'new_ad_name'}</li>\n          <li>Default value: ['any_ad_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 62px;\">\n      <td style=\"width: 133.359px; height: 62px;\">adSet</td>\n      <td style=\"width: 283.5px; height: 62px;\">\n        <p>Configuration object for adset</p>\n      </td>\n      <td style=\"width: 260.188px; height: 62px;\">\n        <ul>\n          <li>Keys: ['incoming_adset', 'utm_adset']</li>\n          <li>Override values: {'adset_name': 'new_adset_name'}</li>\n          <li>Default value: ['any_adset_name']</li>\n        </ul>\n      </td>\n    </tr>      \n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <span style=\"font-weight: 400;\">Other (custom) query parameters</span><span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <ul>\n          <li>\n            List of any other parameters you want to be included in the\n            outgoing OneLink URL for attribution or deep linking, along\n            with their configuration objects.\n          </li>\n          <li>\n            The name of the custom parameter is listed by the developer\n            as <code>paramKey</code> in the configuration object.\n          </li>\n        </ul>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>paramKey: 'deep_link_sub1'</li>\n          <li>Keys: ['page_id']</li>\n          <li>Override values: {page12: 'new_page12'}</li>\n          <li>Default value: 'page1'</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">platform</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        A string describes the platform. MUST be from this list:\n        <li>smartcast</li>        \n        <li>tizen</li>\n        <li>roku</li>\n        <li>webos</li>\n        <li>vidaa</li>\n        <li>playstation</li>\n        <li>android</li>\n        <li>ios</li>\n        <li>steam</li>\n        <li>quest</li>\n        <li>battlenet</li>\n      </td>\n      <td style=\"width: 260.188px;\">\"steam\"</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">app_id</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span> Application ID</span>\n      </td>\n      <td style=\"width: 260.188px;\">\"123456\"</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">redirectURL</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span> The URL the user will be redirected</span>\n      </td>\n      <td style=\"width: 260.188px;\">\"https://store.steampowered.com/app/123456/Team_Fortress_2/\"</td>\n    </tr>\n  </tbody>\n</table>"
}
[/block]
## Code example for a Steam game
[block:code]
{
  "codes": [
    {
      "code": "//Initializing Smart Script arguments\n// If a media source key is NOT FOUND on the link and NO default value is found, the script will return a null string \nvar mediaSource = {keys: [\"my_media_source\"], defaultValue: \"my_default_media_source\"};\nvar campaign = {keys: [\"my_campaign\"], defaultValue: \"my_default_campaign\"};\n\n//Calling the function after embedding the code will be through a global parameter on the window object called window.AF_SMART_SCRIPT\n//Onelink URL is generated\n\nvar result = window.AF_SMART_SCRIPT.generateDirectClickURL({\n  afParameters:{\n    mediaSource: mediaSource,\n    campaign: campaign\n  },\n  platform: 'steam',\n  app_id: '123456',\n  redirectURL:'https://store.steampowered.com/app/123456/Team_Fortress_2/'\n})\n\nvar result_url = \"No output from script\"\nif (result) {\n  result_url = result.clickURL;            \n}      ",
      "language": "javascript"
    }
  ]
}
[/block]
See [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/direct_click.html?incmp=gogo&inmedia=new_source) of the conversion of an incoming URL to an outgoing direct click URL for a Steam game.