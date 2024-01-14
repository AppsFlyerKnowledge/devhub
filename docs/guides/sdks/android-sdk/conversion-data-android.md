---
title: "Conversion data"
slug: "conversion-data-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2021-01-28T10:04:50.003Z"
updatedAt: "2022-07-18T17:29:49.495Z"
order: 6
---
In this guide you will learn how to get conversion data using [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener), as well as [examples](doc:conversion-data-android#accessing-attribution-data) for using the conversion data.

Learn more about [what is conversion data](doc:conversion-data).

Before you begin
----------------

The following code examples require you import [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib) and [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener):

```java Java
import com.appsflyer.AppsFlyerLib;
import com.appsflyer.AppsFlyerConversionListener;
```

Setting-up AppsFlyerConversionListener in Android SDK
-----------------------------------------------------


[block:tutorial-tile]
{
  "backgroundColor": "#018FF4",
  "emoji": "🐣",
  "id": "615d66bdd3797c004251ba3e",
  "link": "https://dev.appsflyer.com/v0.1/recipes/get-conversion-data-in-android",
  "slug": "get-conversion-data-in-android",
  "title": "Get Conversion Data in Android"
}
[/block]


### AppsFlyerConversionListener overview

The [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener) interface lets you listen to conversions.

If you implement and register [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener) when calling [`init`](doc:android-sdk-reference-appsflyerlib#init), its [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) callback is invoked whenever:

- A user opens the app
- A user moves the app to the foreground

If for whatever reason the SDK fails to fetch the conversion data, [`onConversionDataFail`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatafail) is invoked.

Accessing attribution data
--------------------------

When invoked, [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) returns a `Map` (called `conversionDataMap` in the example) that contains the conversion data for that install. The conversion data is cached the first time [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) is called and will be identical on consecutive calls.

### Organic vs. Non-organic conversions

A conversion can be either **Organic** or **Non-organic**:

- An Organic conversion is an unattributed conversion that is usually the result of a direct install from an app store.
- A Non-organic conversion is a conversion that is attributed to a [media source](https://support.appsflyer.com/hc/en-us/articles/212188826-Types-of-media-sources).

You can get the conversion type by checking the value of `af_status` in [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess)'s payload. It can be one of the following values:

- `Organic`
- `Non-organic`

#### Example

```java
import com.appsflyer.AppsFlyerConversionListener;
import com.appsflyer.AppsFlyerLib;
import com.appsflyer.AppsFlyerLibCore.LOG_TAG;

AppsFlyerConversionListener conversionListener =  new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionDataMap) {
        for (String attrName : conversionDataMap.keySet())
            Log.d(LOG_TAG, "Conversion attribute: " + attrName + " = " + conversionDataMap.get(attrName));
        String status = Objects.requireNonNull(conversionDataMap.get("af_status")).toString();
        if(status.equals("Organic")){
            // Business logic for Organic conversion goes here.
        }
        else {
            // Business logic for Non-organic conversion goes here.
        }
    }

    @Override
    public void onConversionDataFail(String errorMessage) {
      Log.d(LOG_TAG, "error getting conversion data: " + errorMessage);
    }

    @Override
    public void onAppOpenAttribution(Map<String, String> attributionData) {
      // Must be overriden to satisfy the AppsFlyerConversionListener interface.
      // Business logic goes here when UDL is not implemented.
    }

    @Override
    public void onAttributionFailure(String errorMessage) {
      // Must be overriden to satisfy the AppsFlyerConversionListener interface.
      // Business logic goes here when UDL is not implemented.
      Log.d(LOG_TAG, "error onAttributionFailure : " + errorMessage);
    }

};
```
```kotlin
import com.appsflyer.AppsFlyerConversionListener
import com.appsflyer.AppsFlyerLib
import com.appsflyer.AppsFlyerLibCore.LOG_TAG
  
class AFApplication : Application() {
    // ...
    override fun onCreate() {
        super.onCreate()
        val conversionDataListener  = object : AppsFlyerConversionListener{
            override fun onConversionDataSuccess(data: MutableMap<String, Any>?) {
                // ...
            }
            override fun onConversionDataFail(error: String?) {
                Log.e(LOG_TAG, "error onAttributionFailure :  $error")
            }
            override fun onAppOpenAttribution(data: MutableMap<String, String>?) {
                // Must be overriden to satisfy the AppsFlyerConversionListener interface.
                // Business logic goes here when UDL is not implemented.
                data?.map {
                    Log.d(LOG_TAG, "onAppOpen_attribute: ${it.key} = ${it.value}")
                }
            }
            override fun onAttributionFailure(error: String?) {
                // Must be overriden to satisfy the AppsFlyerConversionListener interface.
                // Business logic goes here when UDL is not implemented.
                Log.e(LOG_TAG, "error onAttributionFailure :  $error")
            }
        }
        AppsFlyerLib.getInstance().init(devKey, conversionDataListener, applicationContext)
        AppsFlyerLib.getInstance().start(this)
    }

}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/80763ef8c93c49b1f0226455ae35d089f7968ede/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L99-L143)

Deferred deep linking (Legacy method)
-------------------------------------

When the app is opened via deferred deep linking, [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess)'s payload returns deep linking data, as well as attribution data.

- The recommended best practice is to implement deep linking with [Unified Deep Linking (UDL)](doc:unified-deep-linking-udl)
- For existing clients and reference, here is our [legacy Android deep linking guide](doc:android-legacy-apis#deferred-deep-linking), using [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener).