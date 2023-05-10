---
title: "Android Legacy APIs"
slug: "dl_android_gcd_legacy"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2022-11-30T12:10:13.972Z"
updatedAt: "2023-01-19T15:14:19.428Z"
---
## Direct Deep Linking

### Overview

Direct deep linking directs mobile users into a specific activity or content in an app, when the app is already installed.

This in-app routing to a specific activity in the app is possible due to the parameters passed to the app when the OS opens the app and the `onAppOpenAttribution` method is called. AppsFlyer's OneLink ensures that the correct value is passed along with the user's click, thus personalizing the user’s app experience.

**Only the `deep_link_value` is required for deep linking. However, other parameters and values (such as custom attribution parameters) can also be added to the link and returned by the SDK as deep linking data. **

**The direct deep linking flow works as follows**:

![Direct Deep Linking flow](https://files.readme.io/b9f3bff-d649913-5472_Android_DL_1.png "Direct Deep Linking flow")

1. User clicks the OneLink short URL.
2. Android launches the app based on the relevant activity in the AndroidManifest.xml.
3. AppsFlyer SDK is triggered in the app.
4. AppsFlyer SDK retrieves the OneLink data.
   * In a short URL, the data is retrieved from the short URL resolver API in AppsFlyer's servers.
   * In a long URL, the data is retrieved directly from the long URL.
5. AppsFlyer SDK triggers `onAppOpenAttribution()` with the retrieved parameters and cached attribution parameters (e.g. `install_time`).
6. Asynchronously, `onConversionDataSuccess()` is called, holding the full cached attribution data. (You can exit this function by checking if `is_first_launch` is `true`.)
7. `onAppOpenAttribution()` uses the attributionData map to dispatch other activities in the app and pass relevant data.
   * This creates the personalized experience for the user, which is the main goal of OneLink. 

### Procedures

To implement the `onAppOpenAttribution` method and set up the parameter behaviors, the following action checklist of procedures must be completed.

#### Procedure checklist
1. [Deciding app behavior and `deep_link_value`](https://dev.appsflyer.com/hc/docs/android-legacy-apis#deciding-app-behavior) (and other parameter names and values) - with the marketer
2. [Planning method input, i.e. `deep_link_value`](https://dev.appsflyer.com/hc/docs/android-legacy-apis#planning-method-input) (and other parameter names and values) - with the marketer
3. [Implementing the `onAppOpenAttribution()` logic](https://dev.appsflyer.com/hc/docs/android-legacy-apis#implementing-onappopenattribution-logic)
4. [Implementing the `onAttributionFailure()` logic](https://dev.appsflyer.com/hc/docs/android-legacy-apis#implementing-onattributionfailure-logic)

#### Deciding app behavior

**To decide what the app behavior is when the link is clicked**: 

Get from the marketer: The expected behavior of the link when it is clicked.

#### Planning method input

When a OneLink is clicked and the user has the app installed on their device, the `onAppOpenAttribution` method is called by the AppsFlyer SDK. This is referred to as a retargeting re-engagement.

The `onAppOpenAttribution` method gets variables as an input like this: `Map <String, String>`.
The input data structure is described [here](https://dev.appsflyer.com/hc/docs/gcd-input-parameters).

#### Implementing onAppOpenAttribution() logic

The deep link opens the `onAppOpenAttribution` method in the main activity. The OneLink parameters in the method input are used to implement the specific user experience when the application is opened.

#### Code Example: 
```java
@Override
  public void onAppOpenAttribution(Map<String, String> attributionData) {
  if (!attributionData.containsKey("is_first_launch"))
    Log.d(LOG_TAG, "onAppOpenAttribution: This is NOT deferred deep linking");
  for (String attrName : attributionData.keySet()) {
    String deepLinkAttrStr = attrName + " = " + attributionData.get(attrName);
    Log.d(LOG_TAG, "Deeplink attribute: " + deepLinkAttrStr);
  }
  Log.d(LOG_TAG, "onAppOpenAttribution: Deep linking into " + attributionData.get("deep_link_value"));
  goToFruit(attributionData.get("deep_link_value"), attributionData);
}

@Override
  public void onAttributionFailure(String errorMessage) {
  Log.d(LOG_TAG, "error onAttributionFailure : " + errorMessage);
}

private void goToFruit(String fruitName, Map<String, String> dlData) {
    String fruitClassName = fruitName.concat("Activity");
    try {
        Class fruitClass = Class.forName(this.getPackageName().concat(".").concat(fruitClassName));
        Log.d(LOG_TAG, "Looking for class " + fruitClass);
        Intent intent = new Intent(getApplicationContext(), fruitClass);
        if (dlData != null) {
            // Map is casted HashMap since it is easier to pass serializable data to an intent
            HashMap<String, String> copy = new HashMap<String, String>(dlData);
            intent.putExtra(DL_ATTRS, copy);
        }
        startActivity(intent);
    } catch (ClassNotFoundException e) {
        Log.d(LOG_TAG, "Deep linking failed looking for " + fruitName);
        e.printStackTrace();
    }
}
```
⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L64-L73)

> ℹ️ **Note** 
> `onAppOpenAttribution` is not called when the app is running in the background and Application `LaunchMode` is not standard.
> To correct this, call `setIntent(intent)` method to set the intent value inside the overridden method `onNewIntent` if the application is using a non-standard `LaunchMode`.
>
> ```java 
> import android.content.Intent;
>  ...
>  ...
>  ...
>  @Override
>  protected void onNewIntent(Intent intent) 
>  { 
>    super.onNewIntent(intent);     
>    setIntent(intent);
>  }
> ```

#### Implementing onAttributionFailure() logic

The `onAttributionFailure` method is called whenever the call to `onAppOpenAttribution` fails. The function should report the error and create an expected experience for the user.

```java
@Override
public void onAttributionFailure(String errorMessage) {
    Log.d(LOG_TAG, "error onAttributionFailure : " + errorMessage);
}
```
⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L75-L78)

## Deferred Deep Linking

### Overview

Deferred deep linking directs new users first to the correct app store to install the app, and then, after the first open, to a specific app experience (for example a specific page in the app).

When the user first launches the app, the `onConversionDataSuccess` callback function receives both the conversion data of the new user, and OneLink data. The OneLink data makes in-app routing possible due to the `deep_link_value` or other that is passed to the app when the OS opens the app. 

Only the `deep_link_value` is required for deep linking. However, other parameters and values (such as custom attribution parameters) can also be added to the link and returned by the SDK as deep linking data. The AppsFlyer OneLink ensures that the correct parameters are passed along with the user's click, thus personalizing the user’s app experience.

The marketer and developer must coordinate regarding desired app behavior and `deep_link_value`. The marketer uses the parameters to create deep links, and the developer customizes the behavior of the app based on the value received.

It is the developer's responsibility to make sure the parameters are handled correctly in the app, for both in-app routing, and personalizing data in the link.

**The deferred deep linking flow works as follows**:
![Deferred Deep Linking flow!](https://files.readme.io/78a2623-5472_Android_DDL.png "Deferred Deep Linking flow")

1. User clicks the OneLink on a device on which the app is not installed.
2. AppsFlyer registers the click and redirects the user to the correct app store or landing page.
3. The user installs the application and launches it.
4. AppsFlyer SDK is initialized and the install is attributed in the AppsFlyer servers.
5. The SDK triggers the `onConversionDataSuccess` method. The function receives input that includes both the `deep_link_value`, and the attribution data/parameters defined in the OneLink data.
6. The parameter `is_first_launch` has the value `true`, which signals the deferred deep link flow.
    The developer uses the data received in the `onConversionDataSuccess` function to create a personalized experience for the user for the application’s first launch. 

### Procedures
To implement the `onConversionDataSuccess` method and set up the parameter behaviors, the following action checklist of procedures need to be completed.

1. [Deciding app behavior on first launch, and `deep_link_value`](https://dev.appsflyer.com/hc/docs/android-legacy-apis#deciding-app-behavior-on-first-launch) (and other parameter names and values) - with the marketer
2. [Planning method input, i.e. `deep_link_value`](https://dev.appsflyer.com/hc/docs/android-legacy-apis#planning-method-input-1) (and other parameter names and values) - with the marketer
3. [Implementing the `onConversionDataSuccess()` logic](https://dev.appsflyer.com/hc/docs/android-legacy-apis#implementing-onconversiondatasuccess-logic)
4. [Implementing the `onConversionDataFail()` logic](https://dev.appsflyer.com/hc/docs/android-legacy-apis#implementing-onconversiondatafailure-logic)

#### Deciding app behavior on first launch

**To decide app behavior on first launch**: 

Get from the marketer: The expected behavior of the link when it is clicked and the app opens for the first time.

#### Planning method input

For deferred deep linking, the `onConversionDataSuccess` method input must be planned and the input decided in the previous section (for deep linking) is made relevant for the first time the app is launched.

The `onConversionDataSuccess` method gets the `deep_link_value` and other variables as an input like this: Map <String, Object>.

The map holds two kinds of data:
* [Attribution data](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
* Data defined by the marketer in the link (`deep_link_value` and other parameters and values)
  Other parameters can be either:
   * AppsFlyer official parameters.
   * Custom parameters and values chosen by the marketer and developer.
   * The input data structure is described [here](https://dev.appsflyer.com/hc/docs/android-legacy-apis#input-parameters).

The marketer and developers need to plan the `deep_link_value` (and other possible parameters and values) together based on the desired app behavior when the link is clicked.

**To plan the `deep_link_value`, and other parameter names and values based on the expected link behavior**:

1. Tell the marketer what parameters and values are needed in order to implement the desired app behavior.
2. Decide on naming conventions for the `deep_link_value` and other parameters and values.
    **Note**: 
    * Custom parameters will not appear in raw data collected in AppsFlyer.
    * Conversion data will not return a custom parameter named "name, " with a lowercase "n".

#### Implementing onConversionDataSuccess() logic

When the app is opened for the first time, the `onConversionDataSuccess` method is triggered in the main activity. The `deep_link_value` and other parameters in the method input are used to implement the specific user experience when the app is first launched.

**To implement the logic**: 
1. Implement the logic based on the chosen parameters and values. See the following code example.
2. Once completed, send confirmation to the marketer that the app behaves accordingly.

#### Sample code
```java
@Override
 public void onConversionDataSuccess(Map<String, Object> conversionData) {
     for (String attrName : conversionData.keySet())
         Log.d(LOG_TAG, "Conversion attribute: " + attrName + " = " + conversionData.get(attrName));
     String status = Objects.requireNonNull(conversionData.get("af_status")).toString();
     if(status.equals("Non-organic")){
         if( Objects.requireNonNull(conversionData.get("is_first_launch")).toString().equals("true")){
             Log.d(LOG_TAG,"Conversion: First Launch");
             if (conversionData.containsKey("deep_link_value")){
                 Log.d(LOG_TAG,"Conversion: This is deferred deep linking.");
                 //  TODO SDK in future versions - match the input types
                 Map<String,String> newMap = new HashMap<>();
                 for (Map.Entry<String, Object> entry : conversionData.entrySet()) {
                         newMap.put(entry.getKey(), String.valueOf(entry.getValue()));
                 }
                 onAppOpenAttribution(newMap);
             }
         } else {
             Log.d(LOG_TAG,"Conversion: Not First Launch");
         }
     } else {
         Log.d(LOG_TAG,"Conversion: This is an organic install.");
     }
 }
```
⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L33-L56)

#### Implementing onConversionDataFailure() logic

The `onConversionDataFailure` method is called whenever the call to `onConversionDataSuccess` fails. The function should report the error and create an expected experience for the user.

**To implement the `onConversionDataFailure` method**:
```java
@Override
public void onConversionDataFail(String errorMessage) {
    Log.d(LOG_TAG, "error getting conversion data: " + errorMessage);
}
```
⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L75-L78)

## Android sample payloads

See the following sample payloads for App Links, URI schemes, and deferred deep linking. The samples contain a full payload, relevant for when all parameters in the Onelink custom link setup page  contain data.

**Note**: Payloads return as a map. However, for clarity, the sample payloads that follow are displayed in JSON form. 

### Android App Links
Input to `onAppOpenAttribution(Map<String, String> attributionData)`
```short_link
{
    "af_dp": "afbasicapp://mainactivity",
    "af_ios_url": "https://isitchristmas.com/",
    "fruit_name": "apples",
    "c": "fruit_of_the_month",
    "media_source": "Email",
    "link": "https://onelink-basic-app.onelink.me/H5hv/6d66214a",
    "pid": "Email",
    "af_cost_currency": "USD",
    "af_sub1": "my_sub1",
    "af_click_lookback": "20d",
    "af_adset": "my_adset",
    "af_android_url": "https://isitchristmas.com/",
    "af_sub2": "my_sub2",
    "fruit_amount": 26,
    "af_cost_value": 6,
    "campaign": "fruit_of_the_month",
    "af_channel": "my_channel",
    "af_ad": "my_adname",
    "is_retargeting": "true"
}
```
```long_link
{
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "fruit_name": "apples",
    "af_ios_url": "https://my_ios_lp.com",
    "media_source": "Email",
    "scheme": "https",
    "link": "https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_android_url=https%3A%2F%2Fmy_android_lp.com",
    "af_cost_currency": "USD",
    "af_sub1": "my_sub1",
    "af_click_lookback": "20d",
    "path": "/H5hv",
    "af_adset": "my_adset",
    "af_android_url": "https://my_android_lp.com",
    "af_sub2": "my_sub2",
    "fruit_amount": 16,
    "af_cost_value": 6,
    "host": "onelink-basic-app.onelink.me",
    "campaign": "fruit_of_the_month",
    "af_channel": "my_channel",
    "af_ad": "my_adname"
}
```

### URI schemes
Input to `onAppOpenAttribution(Map<String, String> attributionData)`
```short_link
{
    "scheme": "afbasicapp",
    "link": "afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092",
    "af_cost_currency": "NZD",
    "af_click_lookback": "25d",
    "af_deeplink": true,
    "path": "",
    "af_android_url": "https://my_android_lp.com",
    "af_force_deeplink": true,
    "fruit_amount": 15,
    "host": "mainactivity",
    "af_channel": "my_channel",
    "shortlink": "9270d092",
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "af_ios_url": "https://my_ios_lp.com",
    "fruit_name": "apples",
    "af_web_id": "367f81fb-59a4-446a-ac6c-a68d2ee9447c-p",
    "media_source": "Email",
    "af_status": "Non-organic",
    "af_sub1": "my_sub1",
    "af_adset": "my_adset",
    "af_sub2": "my_sub2",
    "af_cost_value": 5,
    "campaign": "my_campaign",
    "af_ad": "my_adname",
    "is_retargeting": true
}
```
```long_link
{
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "af_ios_url": "https://my_ios_lp.com",
    "fruit_name": "apples",
    "af_web_id": "367f81fb-59a4-446a-ac6c-a68d2ee9447c-p",
    "scheme": "afbasicapp",
    "media_source": "Email",
    "link": "afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email",
    "af_cost_currency": "NZD",
    "af_status": "Non-organic",
    "af_click_lookback": "25d",
    "af_sub1": "my_sub1",
    "af_deeplink": true,
    "path": "",
    "af_android_url": "https://my_android_lp.com",
    "af_adset": "my_adset",
    "fruit_amount": 15,
    "af_sub2": "my_sub2",
    "host": "mainactivity",
    "af_cost_value": 5,
    "campaign": "my_campaign",
    "af_channel": "my_channel",
    "af_ad": "my_adname",
    "is_retargeting": true
}
```

### Deferred deep linking
Input to `onConversionDataSuccess(Map<String, Object> conversionData)`
```short_link
{
    "redirect_response_data": null,
    "adgroup_id": null,
    "engmnt_source": null,
    "retargeting_conversion_type": "none",
    "orig_cost": 6.0,
    "af_cost_currency": "USD",
    "is_first_launch": true,
    "af_click_lookback": "20d",
    "af_cpi": null,
    "iscache": true,
    "click_time": "2020-08-12 16:04:50.605",
    "af_android_url": "https://isitchristmas.com/",
    "fruit_amount": 26,
    "is_branded_link": null,
    "match_type": "probabilistic",
    "adset": null,
    "af_channel": "my_channel",
    "campaign_id": null,
    "shortlink": "6d66214a",
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-12 16:05:33.750",
    "af_ios_url": "https://isitchristmas.com/",
    "fruit_name": "apples",
    "media_source": "Email",
    "agency": null,
    "af_siteid": null,
    "af_status": "Non-organic",
    "af_sub1": "my_sub1",
    "cost_cents_USD": 600,
    "af_sub5": null,
    "af_adset": "my_adset",
    "af_sub4": null,
    "af_sub3": null,
    "af_sub2": "my_sub2",
    "adset_id": null,
    "esp_name": null,
    "af_cost_value": 6,
    "campaign": "fruit_of_the_month",
    "http_referrer": "android-app://com.slack/",
    "af_ad": "my_adname",
    "is_universal_link": null,
    "is_retargeting": true,
    "adgroup": null
}
```