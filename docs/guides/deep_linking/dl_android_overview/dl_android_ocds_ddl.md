---
title: "Android Extended Deferred Deep Linking"
slug: "dl_android_ocds_ddl"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2022-11-30T12:10:13.619Z"
updatedAt: "2023-04-19T09:55:10.205Z"
---
## Overview

Extended deferred deep linking allows deep linking for new users in certain scenarios:

- When UDL returns `NOT_FOUND` even though a relevant install occurred.
  Main example for such a scenario:
  - Time between click and install exceeds the UDL lookback window (15 minutes).
- When UDL returns `FOUND` but the deep linking data is missing parameters, which are not `deep_link_value` and `deep_link_sub1-10`.  
  The Main example for such scenario is clicking a link that doesn't contain `deep_link_value` or `deep_link_sub1-10` used for deep-linking, for example, old links created before `deep_link_value` existed that are still in use.

To allow deferred deep linking when UDL returns `NOT_FOUND`, `onConversionDataSuccess` callback should check whether it should handle the deferred deep linking.  
`onConversionDataSuccess` is part of the Get Conversion Data(GCD) API. Its main purpose is to [gather conversion data inside the device](https://dev.appsflyer.com/hc/docs/conversion-data).  
In the use case outlined here `onConversionDataSuccess` takes advantage of the fact that all deferred deep linking parameters are passed to the callback, on top of the conversion data. 

## Prerequisites

- Implement [Unified Deep Linking](dl_android_unified_deep_linking) to handle both deferred deep linking and direct deep linking.
- Implement `onConversionDataSuccess` to handle [deferred deep linking using the GCD API](dl_android_gcd_legacy).

## Implementation

1. `onConversionDataSuccess` should detect cases where deferred deep linking should occur that UDL didn't handle. 
   > See detailed [code dissection](#code-dissect)
2. `onConversionDataSuccess` should route the user to the deferred deep linking destination based on the deep linking parameters passed to the callback.

## Code example

### Code dissect

1. Implement the _Get Conversion Data API_ listener `AppsFlyerConversionListener`. 
   > All methods of the listener must be implemented, even though `onAppOpenAttribution` and `onAttributionFailure` are mutually exclusive with UDL, and will not be called.
2. Detect deferred deep linking scenarios by filtering-in the conversion data payload with:
   - `af_status == Non-organic`
   - `is_first_launch == true`
3. When deferred deep linking is detected, filter-out the cases that were already handled by UDL.  
   In the example that follows, all the links contain `deep_link_value`.  
   It is recommended for UDL to signal with a flag that deferred deep linking is already handled, and `onConversionDataSuccess` should skip.
4. `onConversionDataSuccess` should verify the conversion data holds parameters that are used to route users inside the application. For example `fruit_name` in the example that follows.       
5. Route the user to the deferred deep linking destination.

### Code snippet

```java
    AppsFlyerConversionListener conversionListener =  new AppsFlyerConversionListener() {
        @Override
        public void onConversionDataSuccess(Map<String, Object> conversionDataMap) {
            String status = Objects.requireNonNull(conversionDataMap.get("af_status")).toString();
            if(status.equals("Non-organic")){
                if( Objects.requireNonNull(conversionDataMap.get("is_first_launch")).toString().equals("true")){
                    Log.d(LOG_TAG,"Conversion: First Launch");
                    //Deferred deep link in case of a legacy link
                    if(conversionDataMap.containsKey("fruit_name")){
                        if (conversionDataMap.containsKey("deep_link_value")) { //Not legacy link
                            Log.d(LOG_TAG,"onConversionDataSuccess: Link contains deep_link_value, deep linking with UDL");
                        }
                        else{ //Legacy link
                            conversionDataMap.put("deep_link_value", conversionDataMap.get("fruit_name"));
                            String fruitNameStr = (String) conversionDataMap.get("fruit_name");
                            DeepLink deepLinkData = mapToDeepLinkObject(conversionDataMap);
                            goToFruit(fruitNameStr, deepLinkData);
                        }
                    }
                } else {
                    Log.d(LOG_TAG,"Conversion: Not First Launch");
                }
            } else {
                Log.d(LOG_TAG, "Conversion: This is an organic install.");
            }
        }

        @Override
        public void onConversionDataFail(String errorMessage) {
            Log.d(LOG_TAG, "error getting conversion data: " + errorMessage);
        }

        @Override
        public void onAppOpenAttribution(Map<String, String> attributionData) {
            Log.d(LOG_TAG, "onAppOpenAttribution: This is fake call.");
        }

        @Override
        public void onAttributionFailure(String errorMessage) {
            Log.d(LOG_TAG, "error onAttributionFailure : " + errorMessage);
        }
    };
```



⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/bcf13e588561af3739bafbab510d6c3a7fb4e08a/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L99-L143)

## Testing

> 📘 **Important**
> 
> The following testing scenario demonstrates the handling of deferred deep linking from links that contain custom parameters but not `deep_link_value` and `deep_link_sub1-10` parameters.  
> This testing scenario is also relevant for all extended deferred deep linking described [earlier](#overview).

### Before you begin

- Complete the implementation described earlier.
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Enable debug mode](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) in the app .
- Make sure the app isn't installed on your device.

### Test link

You can use an existing OneLink link or ask your marketer to create a new one for testing. Both short and long OneLink URLs can be used.

#### Adding ad-hoc parameters to the link

- Use only the domain and OneLink template of your link, for example: `https://onelink-basic-app.onelink.me/H5hv`.
- Add OneLink custom parameters other than `deep_link_value` and `deep_link_sub1-10`, as expected by your application. 
- The parameters should be added as _query parameters_.
  - Example: `https://onelink-basic-app.onelink.me/H5hv?my_inapp_dest=apples&my_inapp_value=23`  

### Perform the test

1. Click the link on your device.
2. OneLink redirects you according to the link setup to either Google Play or a website. 
3. Install the application.
   > ** Important **
   >
   > - If the application is still in development and not uploaded to the store yet, the following image displays:  
   >   <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style="text-align: center;"/>
   > - Install the application from Android Studio or any other IDE you use.
4. UDL detects the deferred deep linking, matches the install to the click, and retrieves the OneLink parameters to `onDeepLinking` callback. **UDL will not find any parameters to route and exit**.
5. `onConversionDataSuccess` callback is called with the conversion data, which holds both custom parameters and attribution data.
6. `onConversionDataSuccess` sets the custom parameters to route the user inside the application.

### Expected logs results

> 📘 The following logs are available only when [debug mode is enabled](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).

- SDK initialized:
  ```
  D/AppsFlyer_6.9.0: Initializing AppsFlyer SDK: (v6.9.0.126)
  ```

- The following log refers to direct deep linking, and can be ignored in a deferred deep linking scenario:
  ```
  D/AppsFlyer_6.9.0: No deep link detected
  ```

- UDL API starts:  
  ```
  D/AppsFlyer_6.9.0: [DDL] start
  ```

- UDL sends a query to AppsFlyer to query a match with this install: 
  ```
  D/AppsFlyer_6.9.0: [DDL] Preparing request 1
  ...
  I/AppsFlyer_6.9.0: call = https://dlsdk.appsflyer.com/v1.0/android/com.appsflyer.onelink.appsflyeronelinkbasicapp?af_sig=<>&sdk_version=6.9; size = 239 bytes; body = {
        ...
        TRUNCATED
        ...
  }
  ```

- UDL got a response and calls `onDeepLinking` callback with `status=FOUND` and OneLink link data:
  ```
  D/AppsFlyer_6.9.0: [DDL] Calling onDeepLinking with:
    {"deepLink":"{\"campaign_id\":\"\",\"af_sub3\":\"\",\"match_type\":\"probabilistic\",\"af_sub1\":\"\",\"deep_link_value\":\"\",\"campaign\":\"\",\"af_sub4\":\"\",\"timestamp\":\"2022-12-07T09:32:52.256\",\"click_http_referrer\":\"\",\"af_sub5\":\"\",\"media_source\":\"\",\"af_sub2\":\"\",\"is_deferred\":true}","status":"FOUND"}
  ```

- GCD is fetching the conversion data:

```
GET:https://gcdsdk.appsflyer.com/install_data/v4.0/com.appsflyer.onelink.appsflyeronelinkbasicapp?devkey=XXXXXXXXX&device_id=1670405582645-822555416155480367
```



- `onConversionDataSuccess` is called with conversion data as input:

```
 D/AppsFlyer_6.9.0: [GCD-A02] Calling onConversionDataSuccess with:
    {
        ...
        is_first_launch=true, 
        ...
        fruit_amount=56,
        fruit_name=apples, 
        ...
        af_status=Non-organic,
        ...
    }
```