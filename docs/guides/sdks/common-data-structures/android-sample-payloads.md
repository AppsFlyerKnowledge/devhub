---
title: "Android sample payloads"
slug: "android-sample-payloads"
category: 5f9705393c689a065c409b23
hidden: true
createdAt: "2020-08-13T10:17:26.522Z"
updatedAt: "2023-03-13T09:50:33.756Z"
---
See the following sample payloads for App Links, URI schemes, and deferred deep linking. The samples contain a full payload, relevant for when all parameters in the Onelink custom link setup page contain data.

**Note**: Payloads return as a map. However, for clarity, the sample payloads that follow are displayed in JSON form. 
[block:api-header]
{
  "title": "App Links"
}
[/block]
Input to `onAppOpenAttribution(Map<String, String> attributionData)`
[block:code]
{
  "codes": [
    {
      "code": "{\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"af_ios_url\": \"https://isitchristmas.com/\",\n\t\"fruit_name\": \"apples\",\n  \"deep_link_sub1\": 26,\n  \"deep_link_value\": \"apples\",  \n\t\"c\": \"fruit_of_the_month\",\n\t\"media_source\": \"Email\",\n\t\"link\": \"https://onelink-basic-app.onelink.me/H5hv/6d66214a\",\n\t\"pid\": \"Email\",\n\t\"af_cost_currency\": \"USD\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"af_click_lookback\": \"20d\",\n\t\"af_adset\": \"my_adset\",\n\t\"af_android_url\": \"https://isitchristmas.com/\",\n\t\"af_sub2\": \"my_sub2\",\n\t\"fruit_amount\": 26,\n\t\"af_cost_value\": 6,\n\t\"campaign\": \"fruit_of_the_month\",\n\t\"af_channel\": \"my_channel\",\n\t\"af_ad\": \"my_adname\",\n\t\"is_retargeting\": \"true\"\n}",
      "language": "json",
      "name": "Short link"
    },
    {
      "code": "{\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"install_time\": \"2020-08-06 06:56:02\",\n\t\"fruit_name\": \"apples\",\n\t\"af_ios_url\": \"https://my_ios_lp.com\",\n\t\"media_source\": \"Email\",\n\t\"scheme\": \"https\",\n\t\"link\": \"https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_android_url=https%3A%2F%2Fmy_android_lp.com\",\n\t\"af_cost_currency\": \"USD\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"af_click_lookback\": \"20d\",\n\t\"path\": \"/H5hv\",\n\t\"af_adset\": \"my_adset\",\n\t\"af_android_url\": \"https://my_android_lp.com\",\n\t\"af_sub2\": \"my_sub2\",\n\t\"fruit_amount\": 16,\n\t\"af_cost_value\": 6,\n\t\"host\": \"onelink-basic-app.onelink.me\",\n\t\"campaign\": \"fruit_of_the_month\",\n\t\"af_channel\": \"my_channel\",\n\t\"af_ad\": \"my_adname\"\n}",
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
Input to `onAppOpenAttribution(Map<String, String> attributionData)`
[block:code]
{
  "codes": [
    {
      "code": "{\n\t\"scheme\": \"afbasicapp\",\n\t\"link\": \"afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092\",\n\t\"af_cost_currency\": \"NZD\",\n\t\"af_click_lookback\": \"25d\",\n\t\"af_deeplink\": true,\n\t\"path\": \"\",\n\t\"af_android_url\": \"https://my_android_lp.com\",\n\t\"af_force_deeplink\": true,\n\t\"fruit_amount\": 15,\n  \"deep_link_sub1\": 26,\n  \"deep_link_value\": \"apples\",  \n\t\"host\": \"mainactivity\",\n\t\"af_channel\": \"my_channel\",\n\t\"shortlink\": \"9270d092\",\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"install_time\": \"2020-08-06 06:56:02\",\n\t\"af_ios_url\": \"https://my_ios_lp.com\",\n\t\"fruit_name\": \"apples\",\n\t\"af_web_id\": \"367f81fb-59a4-446a-ac6c-a68d2ee9447c-p\",\n\t\"media_source\": \"Email\",\n\t\"af_status\": \"Non-organic\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"af_adset\": \"my_adset\",\n\t\"af_sub2\": \"my_sub2\",\n\t\"af_cost_value\": 5,\n\t\"campaign\": \"my_campaign\",\n\t\"af_ad\": \"my_adname\",\n\t\"is_retargeting\": true\n}",
      "language": "json",
      "name": "Short link"
    },
    {
      "code": "{\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"install_time\": \"2020-08-06 06:56:02\",\n\t\"af_ios_url\": \"https://my_ios_lp.com\",\n\t\"fruit_name\": \"apples\",\n\t\"af_web_id\": \"367f81fb-59a4-446a-ac6c-a68d2ee9447c-p\",\n\t\"scheme\": \"afbasicapp\",\n\t\"media_source\": \"Email\",\n\t\"link\": \"afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email\",\n\t\"af_cost_currency\": \"NZD\",\n\t\"af_status\": \"Non-organic\",\n\t\"af_click_lookback\": \"25d\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"af_deeplink\": true,\n\t\"path\": \"\",\n\t\"af_android_url\": \"https://my_android_lp.com\",\n\t\"af_adset\": \"my_adset\",\n\t\"fruit_amount\": 15,\n\t\"af_sub2\": \"my_sub2\",\n\t\"host\": \"mainactivity\",\n\t\"af_cost_value\": 5,\n\t\"campaign\": \"my_campaign\",\n\t\"af_channel\": \"my_channel\",\n\t\"af_ad\": \"my_adname\",\n\t\"is_retargeting\": true\n}",
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
Input to `onConversionDataSuccess(Map<String, Object> conversionData)`
[block:code]
{
  "codes": [
    {
      "code": "{\n\t\"redirect_response_data\": null,\n\t\"adgroup_id\": null,\n\t\"engmnt_source\": null,\n\t\"retargeting_conversion_type\": \"none\",\n\t\"orig_cost\": 6.0,\n\t\"af_cost_currency\": \"USD\",\n\t\"is_first_launch\": true,\n\t\"af_click_lookback\": \"20d\",\n\t\"af_cpi\": null,\n\t\"iscache\": true,\n\t\"click_time\": \"2020-08-12 16:04:50.605\",\n\t\"af_android_url\": \"https://isitchristmas.com/\",\n\t\"fruit_amount\": 26,\n\t\"is_branded_link\": null,\n\t\"match_type\": \"fingerprinting\",\n\t\"adset\": null,\n\t\"af_channel\": \"my_channel\",\n\t\"campaign_id\": null,\n\t\"shortlink\": \"6d66214a\",\n\t\"af_dp\": \"afbasicapp://mainactivity\",\n\t\"install_time\": \"2020-08-12 16:05:33.750\",\n\t\"af_ios_url\": \"https://isitchristmas.com/\",\n\t\"fruit_name\": \"apples\",\n  \"deep_link_sub1\": 26,\n  \"deep_link_value\": \"apples\",  \n\t\"media_source\": \"Email\",\n\t\"agency\": null,\n\t\"af_siteid\": null,\n\t\"af_status\": \"Non-organic\",\n\t\"af_sub1\": \"my_sub1\",\n\t\"cost_cents_USD\": 600,\n\t\"af_sub5\": null,\n\t\"af_adset\": \"my_adset\",\n\t\"af_sub4\": null,\n\t\"af_sub3\": null,\n\t\"af_sub2\": \"my_sub2\",\n\t\"adset_id\": null,\n\t\"esp_name\": null,\n\t\"af_cost_value\": 6,\n\t\"campaign\": \"fruit_of_the_month\",\n\t\"http_referrer\": \"android-app://com.slack/\",\n\t\"af_ad\": \"my_adname\",\n\t\"is_universal_link\": null,\n\t\"is_retargeting\": true,\n\t\"adgroup\": null\n}",
      "language": "json",
      "name": "Short link"
    }
  ]
}
[/block]