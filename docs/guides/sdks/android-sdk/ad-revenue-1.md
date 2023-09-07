---
title: "Ad revenue"
slug: "ad-revenue-1"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Impression-level ad revenue reporting by SDK"
hidden: false
order: 7
---
**At a glance**: The AppsFlyer ad revenue SDK connector enables the ad networks to report ad revenue using impression-level granularity.
[block:api-header]
{
  "title": "Overview"
}
[/block]
**Ad revenue reporting options**

Ad revenue is reported to AppsFlyer by either aggregate granularity (via API) or impression-level granularity (via SDK). Impression-level data via SDK has better data freshness and earlier availability in AppsFlyer.

This document details how to send impression-level ad revenue provided by partners in the app to AppsFlyer. 

### Reporting ad revenue using the SDK

**SDK principles of operation**

The ad revenue SDK connector sends impression revenue data to the AppsFlyer SDK. An ad revenue event, af_ad_revenue, is generated and sent to the platform. These impression events are collected and processed in AppsFlyer, and the revenue is attributed to the original UA source.
[block:api-header]
{
  "title": "Integration"
}
[/block]
To integrate the Android ad revenue SDK connector, you need to import, initialize, and trigger the SDK.

### Import the Android ad revenue SDK

1. Add the following code to Module-level /**app/build.gradle** before dependencies:
[block:code]
{
  "codes": [
    {
      "code": "repositories { \n  mavenCentral()\n}",
      "language": "java"
    }
  ]
}
[/block]
2. Add the Ad Revenue library as a dependency:
[block:code]
{
  "codes": [
    {
      "code": "dependencies {\n    implementation 'com.appsflyer:adrevenue:6.9.0'\n}",
      "language": "java"
    }
  ]
}
[/block]
3. Sync the project to retrieve the dependencies.

### Initialize the Android ad revenue SDK

- In the app global class, inside the `onCreate` method, call [`initialize`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#initaliaze), and put the following code:
```java
import com.appsflyer.adrevenue.AppsFlyerAdRevenue;

public class MyApplication extends Application {
    
    @Override
    public void onCreate() {
        super.onCreate();
        
        AppsFlyerAdRevenue.Builder afRevenueBuilder = new AppsFlyerAdRevenue.Builder(this);     
        
        AppsFlyerAdRevenue.initialize(afRevenueBuilder.build());
    }
}
```
### Trigger the logAdRevenue API call

- Trigger the [`logAdRevenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#logadrevenue) API call upon every valid impression, including mandatory, and any optional, arguments.
[block:code]
{
  "codes": [
    {
      "code": "// Make sure you import the following:\n\nimport com.appsflyer.adrevenue.adnetworks.AppsFlyerAdNetworkEventType;\nimport com.appsflyer.adrevenue.adnetworks.generic.MediationNetwork;\nimport com.appsflyer.adrevenue.adnetworks.generic.Scheme;\n\nimport java.util.Currency;\nimport java.util.HashMap;\nimport java.util.Locale;\n\n// Create optional customParams\n\nMap<String, String> customParams = new HashMap<>();\ncustomParams.put(Scheme.COUNTRY, \"US\");\ncustomParams.put(Scheme.AD_UNIT, \"89b8c0159a50ebd1\");\ncustomParams.put(Scheme.AD_TYPE, AppsFlyerAdNetworkEventType.BANNER.toString());\ncustomParams.put(Scheme.PLACEMENT, \"place\");\ncustomParams.put(Scheme.ECPM_PAYLOAD, \"encrypt\");\ncustomParams.put(\"foo\", \"test1\");\ncustomParams.put(\"bar\", \"test2\");\n\n// Record a single impression\nAppsFlyerAdRevenue.logAdRevenue(\n        \"ironsource\",\n        MediationNetwork.googleadmob,\n        Currency.getInstance(Locale.US),\n        0.99,\n        customParams\n);",
      "language": "java",
      "name": "Example"
    }
  ]
}
[/block]