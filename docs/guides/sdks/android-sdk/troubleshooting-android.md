---
title: Troubleshooting
slug: troubleshooting-android
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-android-6
privacy:
  view: public
position: 5
---
## Troubleshooting the Android SDK integration

-------------------------------------------

### Install always attributed to organic

**Scenario**  
You are testing attribution using attribution links. You've implemented the SDK conversion listener but the log always shows that the install is organic. In addition, no non-organic install is recorded in the dashboard.

**Possible reasons**

1. Your dev key is incorrect - if you specify an incorrect dev key, the install cannot be attributed.
2. The attribution link you are using is incorrect. See our [guide on attribution links](https://support.appsflyer.com/hc/en-us/articles/207447163).
3. Make sure that the device you are testing on is registered.
4. A non-proper channel is defined in the manifest

### Install not detected or attributed

**Scenario**  
You are testing install attribution but the log doesn't show any data about the install such as type, first launch, etc.

**Possible reasons**

1. Make sure that the `start` and `init` methods are called in the `Application` class.
2. Make sure that the device you are testing on is registered.

### I'm getting a 404 on install or event recording

**Scenario**  
You are testing in-app events to see that they are attributed to the correct media source. However, the log shows response 404 for both the install and when you send in-app events. Neither the install nor the in-app events appear in the dashboard.

**Possible reasons**  
A 404 response indicates that the app ID is incorrect. Make sure that the app ID in the `applicationId` parameter in the `build.gradle` file is the same as the one in your dashboard.

### Revenue is not recorded properly

**Scenario**  
You are testing in-app events with revenue. The events appear in the dashboard but revenue is not recorded

**Possible reasons**  
The revenue parameter is not formatted correctly. Do NOT format the revenue value in any way. It should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

### The log shows "AppsFlyer's SDK cannot send any event without providing devkey" when I test in-app events

**Scenario**  
You are trying to see in-app events in the log. When you trigger events the log only shows "AppsFlyer's SDK cannot send any event without providing DevKey".

**Possible reasons**  
You call the `start` method without passing the dev key as a parameter. Pass the dev key to the method.

### The log shows "not sending data yet, waiting for dev key" in the log when I test in-app events

**Scenario**  
You are trying to test in-app events in the log. When you trigger events the log only shows "Not sending data yet, waiting for dev key".

**Possible reasons**  
You call the `init` and you pass the dev key as an empty string. Pass the dev key to the method.

### I get response 400 when I test in-app events

**Scenario**  
You are trying to test in-app events. When you trigger events you see an error 400 in the logs.

**Possible reasons**  
This might indicate an issue with the dev key. Check that the dev key is the correct one. Also, make sure that the dev key contains only alphanumeric characters.

### The log shows "warning: Google play services is missing"

**Scenario**  
The logcat shows the warning message "WARNING: Google Play Services is missing".

**Possible reasons**  
The app is missing the Google Play Services dependencies. This might prevent the SDK from collecting the GAID which might cause issues with attribution.

Add the following dependencies to the app-level `build.gradle` file:

```groovy
implementation 'com.google.android.gms:play-services-base:<current-version>'
implementation 'com.google.android.gms:play-services-ads-identifier:<current-version>'
```

### I get response 403 on install or event recording

**Scenario**  
You are trying to test installs and other conversion events in the log. When you trigger these events, you see response 403 (forbidden) in the logs.

**Possible reasons**  
This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the [different AppsFlyer packages](https://www.appsflyer.com/pricing/), and update as needed. You can also contact our customer engagement team at [hello@appsflyer.com](mailto:hello@appsflyer.com) if you have questions about our packages.

### My SDK connection to AppsFlyer is secured by TLS 1.0 or 1.1 

To ensure that the connection to AppsFlyer is secured by TLS 1.2 or 1.3 and not by lower TLS versions use the `appsflyersdk.com` endpoint without a prefix. Specifically call the [setHost](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#sethost) function in the following way: `setHost("","[appsflyersdk.com](http://appsflyersdk.com/)")`
