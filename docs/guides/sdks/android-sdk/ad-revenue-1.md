---
title: "Ad revenue"
slug: "ad-revenue-1"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Impression-level ad revenue reporting by SDK"
hidden: false
order: 8
---
**At a glance**: The AppsFlyer ad revenue SDK connector enables the ad networks to report ad revenue using impression-level granularity.

## Overview

**Ad revenue reporting options**

Ad revenue is reported to AppsFlyer by either aggregate granularity (via API) or impression-level granularity (via SDK). Impression-level data via SDK has better data freshness and earlier availability in AppsFlyer.

This document details how to send impression-level ad revenue provided by partners in the app to AppsFlyer. 

### Reporting ad revenue using the SDK

**SDK principles of operation**

The ad revenue SDK connector sends impression revenue data to the AppsFlyer SDK. An ad revenue event, af_ad_revenue, is generated and sent to the platform. These impression events are collected and processed in AppsFlyer, and the revenue is attributed to the original UA source.

## Integration

To integrate the Android ad revenue SDK connector, you need to import, initialize, and trigger the SDK.

### Import the Android ad revenue SDK

1. Add the following code to Module-level /**app/build.gradle** before dependencies:

```java
repositories { 
  mavenCentral()
}
```

2. Add the Ad Revenue library as a dependency:

```java
dependencies {
  implementation 'com.appsflyer:adrevenue:6.9.0'
}
```

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

```java
// Make sure you import the following:

import com.appsflyer.adrevenue.adnetworks.AppsFlyerAdNetworkEventType;
import com.appsflyer.adrevenue.adnetworks.generic.MediationNetwork;
import com.appsflyer.adrevenue.adnetworks.generic.Scheme;

import java.util.Currency;
import java.util.HashMap;
import java.util.Locale;

// Create optional customParams

Map<String, String> customParams = new HashMap<>();
customParams.put(Scheme.COUNTRY, "US");
customParams.put(Scheme.AD_UNIT, "89b8c0159a50ebd1");
customParams.put(Scheme.AD_TYPE, "Banner");
customParams.put(Scheme.PLACEMENT, "place");
customParams.put(Scheme.ECPM_PAYLOAD, "encrypt");
customParams.put("foo", "test1");
customParams.put("bar", "test2");

// Record a single impression
AppsFlyerAdRevenue.logAdRevenue(
        "ironsource",
        MediationNetwork.googleadmob,
        Currency.getInstance(Locale.US),
        0.99,
        customParams
);
```
