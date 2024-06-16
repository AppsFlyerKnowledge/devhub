---
title: "Android Unified Deep Linking"
slug: "dl_android_unified_deep_linking"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2022-11-30T10:00:54.354Z"
updatedAt: "2023-02-02T09:10:27.354Z"
---
**At a glance:** Unified deep linking (UDL) enables you to send new and existing users to a specific in-app activity (for example, a specific page in the app) as soon as the app is opened.

> 📘 **UDL privacy protection**
>
> For new users, the UDL method only returns parameters relevant to deferred deep linking: `deep_link_value` and `deep_link_sub1-10`. If you try to get any other parameters (`media_source`, `campaign`, `af_sub1-5`, etc.), they return null.

## Flow

![Android UDL flow!](https://files.readme.io/7309a5f-6577_Unified_Deep_Link_Android.png "Android UDL flow")

The flow works as follows:

1. User clicks a OneLink link.
   * If the user has the app installed, the Android App Links or URI scheme opens the app.
   * If the user doesn't have the app installed, they are redirected to the app store, and after downloading, the user opens the app. 
2. The app open triggers the AppsFlyer SDK.
3. The AppsFlyer SDK runs the UDL API. 
4. The UDL API retrieves OneLink data from AppsFlyer servers. 
5. The UDL API calls back the [`onDeepLinking()`] method in the [`DeepLinkingListener`] class.
6. The [`onDeepLinking()`] method gets a [`DeepLinkResult`] object. 
7. The [`DeepLinkResult`] object includes:
   * Status (Found/Not found/Error)
   * A [`DeepLink`] object that carries the `deep_link_value` and `deep_link_sub1-10` parameters, that the developer uses to route the user to a specific in-app activity, which is the main goal of OneLink.

[`onDeepLinking()`]: https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking
[`DeepLinkingListener`]: https://dev.appsflyer.com/hc/docs/deeplinklistener
[`DeepLinkResult`]: https://dev.appsflyer.com/hc/docs/deeplinkresult
[`DeepLink`]: https://dev.appsflyer.com/hc/docs/deeplink

## Planning

* UDL requires AppsFlyer Android SDK V6.1+.

When setting up OneLinks, the marketer uses parameters to create the links, and the developer customizes the behavior of the app based on the values received. It's the developer's responsibility to make sure the parameters are handled correctly in the app, for both in-app routing, and personalizing data in the link.

**To plan the OneLink:**

1. Get from the marketer the desired behavior and personal experience a user gets when they click the URL.
2. Based on the desired behavior, plan the `deep_link_value` and other parameters that are needed to give the user the desired personal experience.
   * The `deep_link_value` is set by the marketer in the URL and used by the developer to redirect the user to a specific place inside the app. For example, if you have a fruit store and want to direct users to apples, the value of `deep_link_value` can be `apples`.
   * The `deep_link_sub1-10` parameters can also be added to the URL to help personalize the user experience. For example, to give a 10% discount, the value of `deep_link_sub1` can be `10`. 

## Implementation

Implement the UDL API logic based on the chosen parameters and values.

1. Use the [`subscribeForDeepLink()`](https://dev.appsflyer.com/hc/docs/appsflyerlib#subscribefordeeplink) method (from `AppsFlyerLib`), before calling [start](doc:android-sdk-reference-appsflyerlib#start), to register the  [`DeepLinkListener`](https://dev.appsflyer.com/hc/docs/deeplinklistener) interface listener.
2. Make sure you override the callback function [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking). 
`onDeepLinking() ` accepts as an argument a [`DeepLinkResult`](https://dev.appsflyer.com/hc/docs/deeplinkresult) object. 
4. Use [`getStatus()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getstatus) to query whether the deep linking match is found.
5. For when the status is an error, call [`getError()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#geterror) and run your error flow.
6. For when the status is found, use [`getDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getdeeplink) to retrieve the [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink) object. 
The `DeepLink `object contains the deep linking information and helper functions to easily retrieve values from well-known OneLink keys, for example, [`getDeepLinkValue()`](https://dev.appsflyer.com/hc/docs/deeplink#getdeeplinkvalue).
7. Use [`getDeepLinkValue()`](https://dev.appsflyer.com/hc/docs/deeplink#getdeeplinkvalue) to retrieve the `deep_link_value`. 
8. Use [`getStringValue("deep_link_sub1")`](https://dev.appsflyer.com/hc/docs/deeplink#getstringvalue) to retrieve `deep_link_sub1`. Do the same for `deep_link_sub2-10` parameters, changing the string value as required.
9. Once `deep_link_value` and `deep_link_sub1-10` are retrieved, pass them to an in-app router and use them to personalize the user experience.

> 📘 **Note**
>
> `onDeepLinking` is not called when the app is running in the background and Application LaunchMode is not standard.
> To correct this, call `setIntent(intent)` method to set the intent value inside the overridden method `onNewIntent` if the application is using a non-standard LaunchMode.
> ```java
>        import android.content.Intent;
>        ...
>        ...
>        ...
>        @Override
>        protected void onNewIntent(Intent intent) 
>        { 
>           super.onNewIntent(intent);     
>           setIntent(intent);
>        }
>```

### Supporting legacy OneLink links 

Legacy OneLink are links that don't contain the parameters recommended for UDL: `deep_link_value` and `deep_link_sub1-10`.
Usually these are links that already exist and are in use when migrating from legacy methods to UDL.
News users using legacy links are handled by `onConversionDataSuccess` in the context of [Extended Deferred Deep Linking](dl_android_ocds_ddl).
UDL handles deep linking for existing users. In this case, it's recommended to add support in the UDL callback `onDeepLinking` for legacy parameters.
[Java code example](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/bcf13e588561af3739bafbab510d6c3a7fb4e08a/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L81-L89)

### Code example

```java
appsflyer.subscribForDeepLink(new DeepLinkListen
    @Override
    public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult) {
        DeepLinkResult.Status dlStatus = deepLinkResult.getStatus();
        if (dlStatus == DeepLinkResult.Status.FOUND) {
            Log.d(LOG_TAG, "Deep link found");
        } else if (dlStatus == DeepLinkResult.Status.NOT_FOUND) {
            Log.d(LOG_TAG, "Deep link not found");
            return;
        } else {
            // dlStatus == DeepLinkResult.Status.ERROR
            DeepLinkResult.Error dlError = deepLinkResult.getError();
            Log.d(LOG_TAG, "There was an error getting Deep Link data: " + dlError.toString());
            return;
        }
        DeepLink deepLinkObj = deepLinkResult.getDeepLink();
        try {
            Log.d(LOG_TAG, "The DeepLink data is: " + deepLinkObj.toString());
        } catch (Exception e) {
            Log.d(LOG_TAG, "DeepLink data came back null");
            return;
        }
        // An example for using is_deferred
        if (deepLinkObj.isDeferred()) {
            Log.d(LOG_TAG, "This is a deferred deep link");
        } else {
            Log.d(LOG_TAG, "This is a direct deep link");
        }
        
        // ** Next if statement is optional **
        // Our sample app's user-invite carries the referrerID in deep_link_sub2
        // See the user-invite section in FruitActivity.java
        if (dlData.has("deep_link_sub2")){
            referrerId = deepLinkObj.getStringValue("deep_link_sub2");
            Log.d(LOG_TAG, "The referrerID is: " + referrerId);
        } else {
            Log.d(LOG_TAG, "deep_link_sub2/Referrer ID not found");
        }
        // An example for using a generic getter
        String fruitName = "";
        try {
            fruitName = deepLinkObj.getDeepLinkValue();
            Log.d(LOG_TAG, "The DeepLink will route to: " + fruitName);
        } catch (Exception e) {
            Log.d(LOG_TAG, "Custom param fruit_name was not found in DeepLink data");
            return;
        }
        goToFruit(fruitName, deepLinkObj);
    }
});
```
```kotlin
AppsFlyerLib.getInstance().subscribeForDeepLink(object : DeepLinkListener{
    override fun onDeepLinking(deepLinkResult: DeepLinkResult) {
        when (deepLinkResult.status) {
            DeepLinkResult.Status.FOUND -> {
                Log.d(
                    LOG_TAG,"Deep link found"
                )
            }
            DeepLinkResult.Status.NOT_FOUND -> {
                Log.d(
                    LOG_TAG,"Deep link not found"
                )
                return
            }
            else -> {
                // dlStatus == DeepLinkResult.Status.ERROR
                val dlError = deepLinkResult.error
                Log.d(
                    LOG_TAG,"There was an error getting Deep Link data: $dlError"
                )
                return
            }
        }
        var deepLinkObj: DeepLink = deepLinkResult.deepLink
        try {
            Log.d(
                LOG_TAG,"The DeepLink data is: $deepLinkObj"
            )
        } catch (e: Exception) {
            Log.d(
                LOG_TAG,"DeepLink data came back null"
            )
            return
        }

        // An example for using is_deferred
        if (deepLinkObj.isDeferred == true) {
            Log.d(LOG_TAG, "This is a deferred deep link");
        } else {
            Log.d(LOG_TAG, "This is a direct deep link");
        }

        try {
            val fruitName = deepLinkObj.deepLinkValue
            Log.d(LOG_TAG, "The DeepLink will route to: $fruitName")
        } catch (e:Exception) {
            Log.d(LOG_TAG, "There's been an error: $e");
            return;
        }
    }
})
```

⇲ Github links: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/master/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L31-L70)

## Testing deferred deep linking

### Prerequisites
- Complete UDL [integration](#implementation)
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996)
- [Enable debug mode](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) in the app 
- Make sure the app isn't installed on your device
- Ask your marketer for a OneLink template. 
  - It will look something like this: `https://onelink-basic-app.onelink.me/H5hv`. 
  - This example uses the OneLink subdomain `onelink-basic-app.onelink.me` and the OneLink template ID `H5hv`

### The test link
You can use an existing OneLink link or ask your marketer to create a new one for testing. Both short and long OneLink URLs can be used.

#### Adding ad-hoc parameters to an existing link
 
- Use only the domain and OneLink template of your link, for example: `https://onelink-basic-app.onelink.me/H5hv`.
- Add OneLink parameters `deep_link_value` and `deep_link_sub1-10`, as expected by your application. The parameters should be added as query parameters.
  - Example: `https://onelink-basic-app.onelink.me/H5hv?deep_link_value=apples&deep_link_sub1=23` 

### Perform the test
1. Click the link on your device.
2. OneLink redirects you according to the link setup, either to Google Play or a website. 
3. Install the application.
> ** Important **
> - If the application is still in development, and not uploaded to the store yet, you see this image:
> <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style="text-align: center;"/>
> - Install the application from *Android Studio* or any other IDE you use.
4. UDL detects the deferred deep linking, matches the install to the click and retrieves the OneLink parameters to `onDeepLinking` callback. 

### Expected logs results
> 📘 The following logs are available **only** when [debug mode is enabled](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).

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
- UDL sends query to AppsFlyer to query a match with this install: 
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
    {"deepLink":"{\"campaign_id\":\"\",\"af_sub3\":\"\",\"match_type\":\"probabilistic\",\"af_sub1\":\"\",\"deep_link_value\":\"apples\",\"campaign\":\"\",\"af_sub4\":\"\",\"timestamp\":\"2022-12-06T11:47:40.037\",\"click_http_referrer\":\"\",\"af_sub5\":\"\",\"media_source\":\"\",\"af_sub2\":\"\",\"deep_link_sub1\":\"23\",\"is_deferred\":true}","status":"FOUND"}

  ```

## Testing deep linking (Android App Links)

### Prerequisites
- Complete UDL [integration](#implementation)
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996)
- [Enable debug mode](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) in the app 
- Make sure the app is already installed on your device
- Ask your marketer for a OneLink template. 
  - It will look something like this `https://onelink-basic-app.onelink.me/H5hv`. 
  - This example uses the OneLink subdomain `onelink-basic-app.onelink.me` and the OneLink template ID `H5hv`.
- [Configure Android App-Links](dl_android_init_setup#procedures-for-android-app-links).

### Create the test link
Use the same method as in [deferred deep linking](#testing-deferred-deep-linking).

### Perform the test
1. Click the link on your device.
2. UDL detects the Android App Link and retrieves the OneLink parameters to `onDeepLinking` callback. 


### Expected logs results
> 📘 The following logs are available **only** when [debug mode is enabled](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).
- If the link is a OneLink shortlink (e.g. https://onelink-basic-app.onelink.me/H5hv/apples)
  ```
  D/AppsFlyer_6.9.0: HTTP: [258990367] GET:https://onelink.appsflyer.com/shortlink-sdk/v2/H5hv?id=apples 
  ```
- UDL calls `onDeepLinking` callback with `status=FOUND` and OneLink link data
  ```
  D/AppsFlyer_6.9.0: [DDL] Calling onDeepLinking with:
      {"deepLink":"{\"path\":\"\\\/H5hv\",\"scheme\":\"https\",\"link\":\"https:\\\/\\\/onelink-basic-app.onelink.me\\\/H5hv?deep_link_value=apples&deep_link_sub1=23\",\"host\":\"onelink-basic-app.onelink.me\",\"deep_link_sub1\":\"23\",\"deep_link_value\":\"apples\",\"is_deferred\":false}","status":"FOUND"}
  ```

> 📘 **Tip**
> If when clicking an Android App Link the OS shows a Disambiguation Dialog or redirects to Google Play or a website, check whether the SHA256 signature is correct.
> 1. Use `adb` to get the app signature on the device:
> ```
> adb shell pm get-app-links <PACKAGE_NAME>
>```
> -2. Make sure the subdomain is `verified`.
> ![adb verified!](https://files.readme.io/f0086fb-Screen_Shot_2022-12-06_at_17.05.10.png "adb verified")
>
> 3. If the subdomain isn't verified, it shows `1024`.
> ![adb verified!](https://files.readme.io/f98642e-Screen_Shot_2022-12-06_at_17.05.22.png "adb verified")