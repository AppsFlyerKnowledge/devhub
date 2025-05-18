---
title: "Ad revenue"
slug: "ad-revenue-1"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Impression-level ad revenue reporting by SDK"
hidden: false
order: 8
---

## Recommended

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        We recommend using our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=ad-revenue-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_adrevenue', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

The app sends impression revenue data to the SDK which then sends it to AppsFlyer. The revenue data is collected and processed in AppsFlyer, and the revenue is attributed to the original UA source. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners).

There are two ways for the SDK to generate an ad revenue event, depending on your SDK version. Use the correct method for your SDK version:
- [For SDK 6.15.0 and above](#log-ad-revenue-for-sdk-6150-and-above). Uses the ad revenue SDK API.
- [For SDK 6.14.2 and below](#legacy-log-ad-revenue-for-sdk-6142-and-below). Uses the ad revenue SDK connector.

## Log ad revenue (for SDK 6.15.0 and above)

When an impression with revenue occurs, invoke the [`logAdRevenue`](doc:android-sdk-reference-appsflyerlib#logadrevenue) method with the revenue details of the impression.  

> 📘 Note
> 
> If you are using the AdRevenue connector, please remove it before switching to the new `logAdRevenue` method. Failing to do so may cause unexpected behavior.

**To implement the method:**

1. Create an instance of [`AFAdRevenueData`](doc:android-sdk-reference-appsflyerlib#afadrevenuedata) with the revenue details of the impression to be logged.Version 6.15.0 of the SDK removes the need for using a connector for sending Ad Revenue data to AppsFlyer.
2. If you want to add additional details to the ad revenue event, populate a map with key-value pairs.
3. Invoke the  `logAdRevenue` method with the following arguments:
    - The `AFAdRevenueData` object you created in step 1.
    - The `Map` instance with the additional details you created in step 2.

### Code Example

```java
import com.appsflyer.AFAdRevenueData;
import com.appsflyer.MediationNetwork;
import com.appsflyer.AppsFlyerLib;
import java.util.HashMap;
import java.util.Map;

AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();

// Create an instance of AFAdRevenueData
AFAdRevenueData adRevenueData = new AFAdRevenueData(
          "ironsource",       // monetizationNetwork
          MediationNetwork.GOOGLE_ADMOB, // mediationNetwork
          "USD",           // currencyIso4217Code
          0.0015           // revenue
  );

Map<String, Object> additionalParameters = new HashMap<>();
additionalParameters.put(AdRevenueScheme.COUNTRY, "US");
additionalParameters.put(AdRevenueScheme.AD_UNIT, "89b8c0159a50ebd1");
additionalParameters.put(AdRevenueScheme.AD_TYPE, "Banner");
additionalParameters.put(AdRevenueScheme.PLACEMENT, "place");

appsflyer.logAdRevenue(adRevenueData, additionalParameters);
```
> 📘 Note 
>  The AdMob iLTV SDK reports impression revenue in micro-units. To display the correct ad revenue amount in USD in AppsFlyer, divide the amount extracted from the iLTV event handler by 1 million before sending it to AppsFlyer.

## [LEGACY] Log ad revenue (for SDK 6.14.2 and below)

For SDK v6.14.2 and below - the AdRevenue Connector should be used along side the AppsFlyer SDK to send Ad Revenue data to AppsFlyer. 

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
