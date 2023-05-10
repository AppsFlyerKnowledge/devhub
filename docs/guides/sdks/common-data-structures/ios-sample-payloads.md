---
title: "iOS sample payloads"
slug: "ios-sample-payloads"
category: 5f9705393c689a065c409b23
hidden: true
createdAt: "2020-08-13T10:17:09.176Z"
updatedAt: "2023-03-13T09:49:54.106Z"
---
See the following sample payloads for Universal Links, URI schemes, and deferred deep linking. The samples contain a full payload, relevant for when all parameters in the Onelink custom link setup page  contain data.

**Note**: Payloads return as a map. However, for clarity, the sample payloads that follow are displayed in JSON form. 
[block:api-header]
{
  "title": "Universal Links"
}
[/block]
Input to `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`
[block:code]
{
  "codes": [
    {
      "code": "{\n   \"af_ad\": \"my_adname\",\n   \"af_adset\": \"my_adset\",\n   \"af_android_url\": \"https://isitchristmas.com/\",\n   \"af_channel\": \"my_channel\",\n   \"af_click_lookback\": \"20d\",\n   \"af_cost_currency\": \"USD\",\n   \"af_cost_value\": 6,\n   \"af_dp\": \"afbasicapp://mainactivity\",\n   \"af_ios_url\": \"https://isitchristmas.com/\",\n   \"af_sub1\": \"my_sub1\",\n   \"af_sub2\": \"my_sub2\",\n   \"c\": \"fruit_of_the_month\",\n   \"campaign\": \"fruit_of_the_month\",\n   \"fruit_amount\": 26,\n   \"fruit_name\": \"apples\",\n   \"deep_link_sub1\": 26,\n   \"deep_link_value\": \"apples\",\n   \"is_retargeting\": true,\n   \"link\": \"https://onelink-basic-app.onelink.me/H5hv/6d66214a\",\n   \"media_source\": \"Email\",\n   \"pid\": \"Email\"\n}",
      "language": "json",
      "name": "Short link"
    },
    {
      "code": "{\n   \"path\": \"/H5hv\",\n   \"af_android_url\": \"https://my_android_lp.com\",\n   \"af_channel\": \"my_channel\",\n   \"host\": \"onelink-basic-app.onelink.me\",\n   \"af_adset\": \"my_adset\",\n   \"pid\": \"Email\",\n   \"scheme\": \"https\",\n   \"af_dp\": \"afbasicapp://mainactivity\",\n   \"af_sub1\": \"my_sub1\",\n   \"fruit_name\": \"apples\",\n   \"af_ad\": \"my_adname\",\n   \"af_click_lookback\": \"20d\",\n   \"fruit_amount\": 16,\n   \"af_sub2\": \"my_sub2\",\n   \"link\": \"https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_android_url=https%3A%2F%2Fmy_android_lp.com\",\n   \"af_cost_currency\": \"USD\",\n   \"c\": \"fruit_of_the_month\",\n   \"af_ios_url\": \"https://my_ios_lp.com\",\n   \"af_cost_value\": 6\n}",
      "language": "json",
      "name": "Long link"
    }
  ]
}
[/block]

[block:api-header]
{
  "title": "URI scheme"
}
[/block]
Input to `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`
[block:code]
{
  "codes": [
    {
      "code": "{\n\t\"af_click_lookback \": \"25d\",\n\t\"af_sub1 \": \"my_sub1\",\n\t\"shortlink \": \"9270d092\",\n\t\"af_deeplink \": true,\n\t\"media_source \": \"Email\",\n\t\"campaign \": \"my_campaign\",\n\t\"af_cost_currency \": \"NZD\",\n\t\"host \": \"mainactivity\",\n\t\"af_ios_url \": \"https://my_ios_lp.com\",\n\t\"scheme \": \"afbasicapp\",\n\t\"path \": \"\",\n\t\"af_cost_value \": 5,\n\t\"af_adset \": \"my_adset\",\n\t\"af_ad \": \"my_adname\",\n\t\"af_android_url \": \"https://my_android_lp.com\",\n\t\"af_sub2 \": \"my_sub2\",\n\t\"af_force_deeplink \": true,\n\t\"fruit_amount \": 15,\n\t\"af_dp \": \"afbasicapp://mainactivity\",\n\t\"link \": \"afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092\",\n\t\"af_channel \": \"my_channel\",\n\t\"is_retargeting \": true,\n\t\"af_web_id \": \"56441f02-377b-47c6-9648-7a7f88268130-o\",\n\t\"fruit_name \": \"apples\"\n  \"deep_link_sub1\": 26,\n  \"deep_link_value\": \"apples\",\n}",
      "language": "json",
      "name": "Short link"
    },
    {
      "code": "{\n\t\"af_ad \": \"my_adname\",\n\t\"fruit_name \": \"apples\",\n\t\"host \": \"mainactivity\",\n\t\"af_channel \": \"my_channel\",\n\t\"link \": \"afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email\",\n\t\"af_deeplink \": true,\n\t\"campaign \": \"my_campaign\",\n\t\"af_sub1 \": \"my_sub1\",\n\t\"af_click_lookback \": \"25d\",\n\t\"af_web_id \": \"56441f02-377b-47c6-9648-7a7f88268130-o\",\n\t\"path \": \"\",\n\t\"af_sub2 \": \"my_sub2\",\n\t\"af_ios_url \": \"https://my_ios_lp.com\",\n\t\"af_cost_value \": 5,\n\t\"fruit_amount \": 15,\n\t\"is_retargeting \": true,\n\t\"scheme \": \"afbasicapp\",\n\t\"af_force_deeplink \": true,\n\t\"af_adset \": \"my_adset\",\n\t\"media_source \": \"Email\",\n\t\"af_cost_currency \": \"NZD\",\n\t\"af_dp \": \"afbasicapp://mainactivity\",\n\t\"af_android_url \": \"https://my_android_lp.com\"\n}",
      "language": "json",
      "name": "Long link"
    }
  ]
}
[/block]

[block:api-header]
{
  "title": "Deferred deep linking"
}
[/block]
Input to `onConversionDataSuccess(_ data: [AnyHashable: Any])`
[block:code]
{
  "codes": [
    {
      "code": "{\n\t\"adgroup\": null,\n\t\"adgroup_id\": null,\n\t\"adset\": null,\n\t\"adset_id\": null,\n\t\"af_ad\": \"my_adname\",\n\t\"af_adset\": \"my_adset\",\n\t\"af_android_url\": \"https://isitchristmas.com/\",\n\t\"af_channel\": \"my_channel\",\n\t\"af_click_lookback\": \"20d\",\n\t\"af_cost_currency\": \"USD\",\n\t\"af_cost_value\": 6,\n\t\"af_cpi\": null,\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"af_ios_url\": \"https://isitchristmas.com/\",\n\t\"af_siteid\": null,\n\t\"af_status\": \"Non-organic\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"af_sub2\": \"my_sub2\",\n\t\"af_sub3\": null,\n\t\"af_sub4\": null,\n\t\"af_sub5\": null,\n\t\"agency\": null,\n\t\"campaign\": \"fruit_of_the_month \",\n\t\"campaign_id\": null,\n\t\"click_time\": \"2020-08-12 15:08:00.770\",\n\t\"cost_cents_USD\": 600,\n\t\"engmnt_source\": null,\n\t\"esp_name\": null,\n\t\"fruit_amount\": 26,\n\t\"fruit_name\": \"apples\",\n  \"deep_link_sub1\": 26,\n  \"deep_link_value\": \"apples\",  \n\t\"http_referrer\": null,\n\t\"install_time\": \"2020-08-12 15:08:33.335\",\n\t\"is_branded_link\": null,\n\t\"is_first_launch\": 1,\n\t\"is_retargeting\": true,\n\t\"is_universal_link\": null,\n\t\"iscache\": 1,\n\t\"match_type\": \"fingerprinting\",\n\t\"media_source\": \"Email\",\n\t\"orig_cost\": \"6.0\",\n\t\"redirect_response_data\": null,\n\t\"retargeting_conversion_type\": \"none\",\n\t\"shortlink\": \"6d66214a\"\n}",
      "language": "json",
      "name": "Short link"
    }
  ]
}
[/block]