---
title: Integrate SDK
slug: integrate-android-sdk
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-android-6
content:
  excerpt: Learn how to initialize and start the Android SDK.
privacy:
  view: public
position: 2
---

## Recommended

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Get started with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_int', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

- You must [install the Android SDK](doc:install-android-sdk). 
- Ensure that in your app `build.gradle` file, `applicationId`'s value (in the `defaultConfig` block) matches the app's app ID in AppsFlyer.
- Get the [AppsFlyer dev key](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key). It is required to successfully initialize the SDK.

## Initializing the Android SDK

It's recommended to initialize the SDK in the [global Application class/subclass]. That is to ensure the SDK can start in any scenario (for example, deep linking).

**Step 1: Import AppsFlyerLib**  
In your global Application class, import [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib):

```java Java
import com.appsflyer.AppsFlyerLib;
```
```kotlin Kotlin
import com.appsflyer.AppsFlyerLib
```

**Step 2: Initialize the SDK**  
In the global Application `onCreate`, call [`init`](doc:android-sdk-reference-appsflyerlib#init) with the following arguments:

```java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
```
```kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
```

1. The first argument is your AppsFlyer dev key.
2. The second argument is a Nullable [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener). If you don't need conversion data, we recommend passing a `null` as the second argument. For more information, see [Conversion data](doc:conversion-data-android).
3. The third argument is the Application Context.

## Starting the Android SDK

In the Application's `onCreate` method, after calling [`init`](doc:android-sdk-reference-appsflyerlib#init), call [`start`](doc:android-sdk-reference-appsflyerlib#start) and pass it the Application's Context as the first argument:

```java
AppsFlyerLib.getInstance().start(this);
```
```kotlin
AppsFlyerLib.getInstance().start(this)
```

### Deferring SDK start

<span class="annotation-optional">Optional</span>  
You can defer the SDK initialization by calling [`start`](doc:android-sdk-reference-appsflyerlib#start) from an Activity class, instead of calling it in the Application class. [`init`](doc:android-sdk-reference-appsflyerlib#init) should still be called in the Application class.

Typical usage of deferred SDK start is when an app would like to request consent from the user to collect data in the Main Activity, and call [`start`](doc:android-sdk-reference-appsflyerlib#start) after getting the user's consent.

> ⚠️ **Important notice**
> 
> If the app calls `start` from an Activity, it should pass the **Activity Context** to the SDK.  
> Failing to pass the activity context will not trigger the SDK, thus losing attribution data and in-app events.

### Starting with a response listener

To receive confirmation that the SDK was started successfully, create an `AppsFlyerRequestListener` object and pass it as the third argument of `start`:

```java
AppsFlyerLib.getInstance().start(getApplicationContext(), <YOUR_DEV_KEY>, new AppsFlyerRequestListener() {
  @Override
  public void onSuccess() {
    Log.d(LOG_TAG, "Launch sent successfully, got 200 response code from server");
  }
  
  @Override
  public void onError(int i, @NonNull String s) {
    Log.d(LOG_TAG, "Launch failed to be sent:\n" +
          "Error code: " + i + "\n"
          + "Error description: " + s);
  }
});
```
```kotlin
AppsFlyerLib.getInstance().start(this, <YOUR_DEV_KEY>, object : AppsFlyerRequestListener {
  override fun onSuccess() {
    Log.d(LOG_TAG, "Launch sent successfully")
    }
  
  override fun onError(errorCode: Int, errorDesc: String) {
    Log.d(LOG_TAG, "Launch failed to be sent:\n" +
          "Error code: " + errorCode + "\n"
          + "Error description: " + errorDesc)
    }
})
```

- The `onSuccess()` callback method is invoked for every `200` response to an attribution request made by the SDK.
- The `onError(String error)` callback method is invoked for any other response and returns the response as the error string.

## Full example

The following example demonstrates how to initialize and start the SDK from the Application class.

```java
import android.app.Application;
import com.appsflyer.AppsFlyerLib;
// ...
public class AFApplication extends Application {
    // ...
    @Override
    public void onCreate() {
        super.onCreate();
        // ...
        AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
        AppsFlyerLib.getInstance().start(this);
        // ...
    }
    // ...
}
```
```kotlin
import android.app.Application
import com.appsflyer.AppsFlyerLib
// ...
class AFApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // ...
        AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
        AppsFlyerLib.getInstance().start(this)
        // ...
    }
    // ...
}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/80763ef8c93c49b1f0226455ae35d089f7968ede/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L144-L145)

See [Setting the Customer User ID](doc:customer-user-id-android) to associate a CUID with this integration.

## Log sessions

The SDK sends an `af_app_opened` message whenever the app is opened or brought to the foreground.  Before the message is sent, the SDK makes sure that the time passed since sending the last message is not smaller than a predefined interval.

### Setting the time interval between app launches

Call [`setMinTimeBetweenSessions`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setmintimebetweensessions) to set the minimal time interval that must lapse between two `af_app_opened` messages. The default interval is 5 seconds.

### Logging sessions manually

You can log sessions manually by calling [`logSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#logsession).

## Enabling debug mode

<span class="annotation-optional">Optional</span>  
You can enable debug logs by calling [`setDebugLog`](doc:android-sdk-reference-appsflyerlib#setdebuglog):

```java
AppsFlyerLib.getInstance().setDebugLog(true);
```
```kotlin
AppsFlyerLib.getInstance().setDebugLog(true)
```

> 📘 Note
> 
> To see full debug logs, make sure to call `setDebugLog` before invoking other SDK methods.
> 
> See [example](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/d3d0d9dcf1c1dcb2f873f5b50708fc4fa24a7868/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L28).

> 🚧 Warning
> 
> To avoid leaking sensitive information, make sure debug logs are disabled before distributing the app.

## Test the integration

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Easily test with our SDK wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Note**
> 
> If you prefer not to use our recommended wizard, you can find detailed manual testing instructions [here](doc:manual-testing-android).

For a full troubleshooting checklist, see [Troubleshooting](doc:troubleshooting-android).

### Creating an Android debug app

<span class="annotation-optional">Optional</span>  
You can utilize Android Studio's build variants to configure an easy-to-use debug app for testing purposes.

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

[global Application class/subclass]: https://developer.android.com/reference/android/app/Application
