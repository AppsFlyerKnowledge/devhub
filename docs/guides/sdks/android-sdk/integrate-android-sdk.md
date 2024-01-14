---
title: "Integrate SDK"
slug: "integrate-android-sdk"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Learn how to initialize and start the Android SDK."
hidden: false
createdAt: "2020-11-02T17:46:42.932Z"
updatedAt: "2023-05-02T12:44:20.646Z"
order: 3
---

## Before you begin

- You must [install the Android SDK](doc:install-android-sdk). 
- Ensure that in your app `build.gradle` file, `applicationId`'s value (in the `defaultConfig` block) matches the app's app ID in AppsFlyer.
- Get the [AppsFlyer dev key](https://support.appsflyer.com/hc/en-us/articles/207032126#integration-2-integrating-the-sdk). It is required to successfully initialize the SDK.
- The codes in this document are example implementations. Make sure to change the `<YOUR_DEV_KEY>` and other placeholders as needed.
- All the steps in this document are mandatory unless stated otherwise.

## Initializing the Android SDK


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

## Setting the Customer User ID

<span class="annotation-optional">Optional</span>  

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. It can be associated with in-app events if provided to the SDK. Once associated with the CUID, these events can be cross-referenced with user data from other devices and applications.

### Set the customer User ID

Once the CUID is available, you can set it by calling  [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid).

```java

...
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, conversionListener, this);  
AppsFlyerLib.getInstance().start(this , <YOUR_DEV_KEY> );
...
// Do your magic to get the customerUserID...
...
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

The CUID can only be associated with in-app events after it was set. Since `start` was called before `setCustomerUserID`, the install event will not be associated with the CUID. If you need to associate the install event with the CUID, see the below section.

### Associate the CUID with the install event

If it’s important for you to associate the install event with the CUID, you should set it before calling `start`. 

You can set the CUID before `start`  in two ways, depending on whether you start the SDK in the `Application` or the `Activity` class. 

**When starting from the application class**

If you started the SDK from the `Application` class (see: [`Starting the Android SDK`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk)) and you want the CUID to be associated with the install event, put the SDK in waiting mode to prevent the install data from being sent to AppsFlyer before the CUID is provided.

To activate the waiting mode, set [`waitForCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#waitforcustomeruserid) to `true` after [`init`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) and before [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).

### 📘Important

 It's important to remember that putting the SDK in a waiting mode may block the SDK from sending the install event and consequently prevent attribution. This can occur, for example, when the user launches the application for the first time and then exits before the SDK can set the CUID. 

```java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
AppsFlyerLib.getInstance().start(this);
```

After calling [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start), you can add your custom code that makes the CUID available.

Once the CUID is available, the final step includes setting the CUID, releasing the SDK from the waiting mode, and sending the attribution data with the customer ID to AppsFlyer. This step is performed using the call to [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession).

```java
AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, this);
```

Other than [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession), do not use [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid) or any other AppsFlyer SDK functionality, as the waiting SDK will ignore it.

### Note

If you wish to remove the waiting mode from the SDK initialization flow, it is not enough to delete the call to `waitForCustomerUserId(true)`. It is also required to replace it with `waitForCustomerUserID(false)`. Simply removing the call is insufficient because the 'waitForCustomerUserId' boolean flag is stored in the Android Shared Preferences. 

**Example code**

```java
public class AFApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    AppsFlyerConversionListener conversionDataListener = 
    new AppsFlyerConversionListener() {
      ...
    };
    AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
    AppsFlyerLib.getInstance().waitForCustomerUserId(true);
    AppsFlyerLib.getInstance().start(this);
    // Do your magic to get the customerUserID
    // any AppsFlyer SDK code invoked here will be discarded
    // ...
    // Once the customerUserID is available, call setCustomerIdAndLogSession(). 
    // setCustomerIdAndLogSession() sets the CUID, releases the waiting mode,
    // and sends the attribution data with the customer ID to AppsFlyer.
    AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, this);
  }
}
```

**When starting from the Activity class**

If you started the SDK from an `Activity` (see: [`Deferring SDK start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#deferring-sdk-start)) class and you want the CUID to be associated with the install event, set the CUID before[`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).

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

## Testing the integration

<span class="annotation-optional">Optional</span>  
For detailed integration testing instructions, see the [Android SDK integration testing guide](doc:testing-android).

[global Application class/subclass]: https://developer.android.com/reference/android/app/Application