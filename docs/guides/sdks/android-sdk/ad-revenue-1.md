---
title: "Ad revenue"
slug: "ad-revenue-1"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Impression-level ad revenue reporting by SDK"
hidden: false
order: 8
---
The app sends impression revenue data to the AppsFlyer SDK. The SDK then sends it to AppsFlyer. These impression data is collected and processed in AppsFlyer, and the revenue is attributed to the original UA source. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners).

Depending on your SDK version, there are two ways for the SDK to generate an ad revenue event.

- [For SDK 6.15.0 and above](#log-ad-revenue-for-sdk-6150-and-above). Version 6.15.0 of the SDK removes the need for using a connector for sending Ad Revenue data to AppsFlyer.
- [For SDK 6.14.2 and below](#legacy-log-ad-revenue-for-sdk-6142-and-below).

## Log ad revenue (for SDK 6.15.0 and above)

When an impression with revenue occurs invoke the [`logAdRenvue`](doc:android-sdk-reference-appsflyerlib#logadrevenue) method with the revenue details of the impression.  

**To implement the method, perform the following steps:**

1. Create an instance of [`AFAdRevenueData`](doc:android-sdk-reference-appsflyerlib#afadrevenuedata) with the revenue details of the impression to be logged.Version 6.15.0 of the SDK removes the need for using a connector for sending Ad Revenue data to AppsFlyer.
2. If you want to add additional details to the ad revenue event, populate a `Map` instance with key-value pairs.
3. Invoke the  `logAdRenvue` method with the following arguments:
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
          123.45           // revenue
  );

Map<String, Object> additionalParameters = new HashMap<>();
additionalParameters.put(AdRevenueScheme.COUNTRY, "US");
additionalParameters.put(AdRevenueScheme.AD_UNIT, "89b8c0159a50ebd1");
additionalParameters.put(AdRevenueScheme.AD_TYPE, "Banner");
additionalParameters.put(AdRevenueScheme.PLACEMENT, "place");

appsflyer.logAdRevenue(adRevenueData, additionalParameters);
```
> 📘 Note 
>  This information is relevant only for apps that use ads from AdMob. The AdMob iLTV SDK reports impression revenue in micro-units. To display the correct ad revenue amount in USD in AppsFlyer, divide the amount extracted from the iLTV event handler by 1 million before sending it to AppsFlyer.

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
