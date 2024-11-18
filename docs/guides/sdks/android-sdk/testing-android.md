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

## Recommended 👍

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Easily test with our SDK wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=testing-android');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Note**
> 
> If you prefer not to use our recommended wizard you can find detailed instructions [here](https://dev.appsflyer.com/hc/docs/manual-testing-android)

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
This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the [different AppsFlyer packages](https://www.appsflyer.com/pricing/), and update as needed. You can also contact our customer engagement team at [hello@appsflyer.com](mailto:hello@appsflyer.com) if you have questions about our packages.

### My SDK connection to AppsFlyer is secured by TLS 1.0 or 1.1 

To ensure that the connection to AppsFlyer is secured by TLS 1.2 or 1.3 and not by lower TLS versions use the `appsflyersdk.com` endpoint without a prefix. Specifically call the [setHost](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#sethost) function in the following way: `setHost("","[appsflyersdk.com](http://appsflyersdk.com/)")`

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