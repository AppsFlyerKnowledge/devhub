---
title: "Test integration"
slug: "testing-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2021-07-27T21:45:38.893Z"
updatedAt: "2022-11-29T15:55:40.188Z"
order: 4
---

## Before you begin
----------------

To successfully complete the tests in this document, you must:

- [Integrate the SDK](doc:integrate-android-sdk)
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).

## Test Android SDK integration
----------------------------

The test consists of:

1. Simulating an ad click and a conversion.
2. [Inspecting the conversion data](#inspect-conversion-data) of the install.

### Simulate a conversion

Simulate a user clicking an ad and installing the app.

**Step 1: Simulate ad click**  
Simulate an ad click via an attribution link. Structure the attribution link as follows:

```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&advertising_id=<registered_device_gaid>
```

Where:

- `app_id` is your AppsFlyer app ID.
- `pid` is the [media source](https://support.appsflyer.com/hc/en-us/articles/212188826) to which the install should be attributed.
- `advertising_id` is the registered device's GAID.

The `advertising_id` parameter is required to attribute via [ID matching](https://support.appsflyer.com/hc/en-us/articles/207447053#device-id-matching). If omitted, attribution will occur [probabilistically](https://support.appsflyer.com/hc/en-us/articles/207447053#probabilistic-modeling).

For example, if your app ID is `com.my.app`, the attribution link might look like this:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1
```

or, with GAID:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1&advertising_id=********-****-****-****-************
```

> 👍 Tip
> 
> Often, tests using attribution links are performed more than once. That's why it's recommended to use one of the attribution parameters to "version" your tests–it makes it easier to understand which link triggered which conversion.
> 
> In the above example, the value of `c` is `test1`. In consecutive tests, increment the value of `c` to `test2`, `test3`, and so on.

**Step 2: Install the app**  
[Enable debug mode](doc:integrate-android-sdk#enabling-debug-mode) and install the app on a [registered test device](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).

**Step 3: Execute test**  
Proceed to [inspect conversion data](#inspect-conversion-data).

### Inspect conversion data

After simulating a conversion, follow these steps to inspect the install's conversion data.

**Step 1: Retrieve install UID**  
Once the app is installed, search the debug logs for `conversions.appsflyer`

![](https://files.readme.io/bd951f1-android-uid_en-us.png "android-uid_en-us.png")

**Step 2: Inspect conversion data**  
Go to [the conversion data test API](https://dev.appsflyer.com/hc/reference/gcd-get-data) and fill in the required fields:

1. `app-id`: Your app ID
2. `device_id`: paste the value of `uid` from step 1.
3. `devkey` - Application's devkey. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032126#integration-2-integrating-the-sdk) how to get it.

Then, click **Try it!** to execute the test.

**Expected result**  
A 200 response containing the install's conversion data (truncated for readability):

```json Log
{
  ...
  "campaign": "test1",
  ...
  "media_source": "devtest",
  ...
  "af_status": "Non-organic"
  ...
}
```

> 📘 Note
> 
> It might take up to 30 minutes for the install to appear in the dashboard.

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
implementation 'com.google.android.gms:play-services-base:15.0.1'
implementation 'com.google.android.gms:play-services-ads:15.0.1'
```

### I get response 403 on install or event recording

**Scenario**  
You are trying to test installs and other conversion events in the log. When you trigger these events, you see response 403 (forbidden) in the logs.

**Possible reasons**  
This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the [different AppsFlyer packages](https://www.appsflyer.com/pricing/), and update as needed. You can also contact our customer engagement team at [hello@appsflyer.com](mailto:hello@appsflyer.com) if you have questions about our packages.

## Creating an Android debug app

-----------------------------

<span class="annotation-optional">Optional</span>  
You can utilize Android Studio's build variants to configure an easy-to-use [debug app](doc:integration-testing#debug-apps) for testing purposes.

All tests can be performed for both production and debug apps.

**Step 1: Configure Gradle's `debug` build type**  
In your app-level `build.gradle` file, configure the `debug` [build type](https://developer.android.com/studio/build/build-variants#build-types) and set `applicationIdSuffix` to the test app's name (in this case, `.debug`).

```groovy
android {
    // ...
    buildTypes {
        // Prevents a signing error when building the production app
        release {
            signingConfig signingConfigs.debug
        } 
        debug {
            applicationIdSuffix ".debug"
        }
    }
}
```

**Step 2: Add a new app to AppsFlyer**  
Use the resulting package name as the app ID when [adding the app to the AppsFlyer dashboard](https://support.appsflyer.com/hc/en-us/articles/207377436), or ask a team member with dashboard access to add it.

For example, if you have an app with the package name `com.your.app` and you use the Gradle configuration above, the test app's name will be `com.your.app.debug`. Pass this name as the app ID when adding the app to AppsFlyer.