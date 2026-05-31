---
title: Integrate Android SDK 7
slug: integrate-android-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-7
privacy:
  view: public
position: 3
---

## Initializing the Android SDK

It's recommended to initialize the SDK in the [global Application class/subclass](https://developer.android.com/reference/android/app/Application). This ensures the SDK can start in any scenario, including deep linking.

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

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
```

1. The first argument is your AppsFlyer dev key.
2. The second argument is a nullable [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener). If you don't need conversion data, pass `null`. For more information, see [Conversion data](doc:conversion-data-android).
3. The third argument is the Application Context.

---

## Configuring the SDK with af_init_config.json

<span class="annotation-optional">Optional</span>

SDK V7 introduces a file-based initialization helper. If you place a file named `af_init_config.json` in your `src/main/assets/` folder, the SDK reads it during `init()` and applies the supported keys as if the corresponding setters had been called. This is the recommended approach for any configuration value that is constant and known at build time.

| JSON key | Type | Equivalent setter | Example value |
|---|---|---|---|
| `debug_mode` | boolean | Debug logging | `true` |
| `disable_advertising_identifiers` | boolean | `setDisableAdvertisingIdentifiers` | `true` |
| `currency_code` | string | `setCurrencyCode` | `"USD"` |
| `host` | object | `setHost` | `{ "prefix": "", "host": "af-sdk.net" }` |
| `min_time_between_sessions` | number (int) | `setMinTimeBetweenSessions` | `1` |
| `ddlTimeout` | number (int, ms) | `setDeepLinkTimeout` | `3000` |

**Example: `src/main/assets/af_init_config.json`**

```json
{
  "disable_advertising_identifiers": true,
  "debug_mode": true,
  "currency_code": "USD",
  "host": {
    "prefix": "",
    "host": "af-sdk.net"
  },
  "min_time_between_sessions": 1,
  "ddlTimeout": 3000
}
```

> 📘 Note
>
> If the file is missing, initialization continues normally. Unknown keys are ignored. Type mismatches are caught and logged.

---

## Starting the Android SDK

You control when the SDK sends its first session. Use `registerSessionReadyListener` to be notified when the SDK is ready, then call `start()` when your app's conditions are met.

### Without pre-conditions

If your app doesn't need to wait for consent, a CUID, or any other condition before sending the first session, call `start()` directly inside the listener callback:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().start();
});
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().start()
}
```

### With pre-conditions

If your app must satisfy conditions before sending the first session — such as collecting user consent or retrieving a CUID from your backend — use a coordinator class to synchronize the SDK's readiness with your app's own conditions. Create a coordinator that tracks both signals and calls `start()` only when both are met:

```java Java
package com.yourapp;

import android.util.Log;
import com.appsflyer.AppsFlyerLib;
import com.appsflyer.share.attribution.AppsFlyerRequestListener;

public final class AfSdkStartupManager {
    private boolean isConsentReady;
    private boolean isSdkReadyToStart;

    public void onConsentReady() {
        isConsentReady = true;
        startAfSdkIfAllConditionsAreMet();
    }

    public void onAfSdkReadyToStart() {
        isSdkReadyToStart = true;
        startAfSdkIfAllConditionsAreMet();
    }

    private void startAfSdkIfAllConditionsAreMet() {
        if (isConsentReady && isSdkReadyToStart) {
            AppsFlyerLib.getInstance().start(new AppsFlyerRequestListener() {
                @Override
                public void onSuccess() {
                    Log.d("AppsFlyer", "AppsFlyerRequestListener: onSuccess");
                }

                @Override
                public void onError(int code, String error) {
                    Log.d("AppsFlyer", "AppsFlyerRequestListener: onError. Code: " + code + ", error: " + error);
                }
            });
            isSdkReadyToStart = false;
        }
    }

    public void reset() {
        isConsentReady = false;
        isSdkReadyToStart = false;
    }
}
```
```kotlin Kotlin
package com.yourapp

import android.util.Log
import com.appsflyer.AppsFlyerLib
import com.appsflyer.share.attribution.AppsFlyerRequestListener

class AfSdkStartupManager {
    private var isConsentReady = false
    private var isSdkReadyToStart = false

    fun onConsentReady() {
        isConsentReady = true
        startAfSdkIfAllConditionsAreMet()
    }

    fun onAfSdkReadyToStart() {
        isSdkReadyToStart = true
        startAfSdkIfAllConditionsAreMet()
    }

    private fun startAfSdkIfAllConditionsAreMet() {
        if (isConsentReady && isSdkReadyToStart) {
            AppsFlyerLib.getInstance().start(object : AppsFlyerRequestListener {
                override fun onSuccess() {
                    Log.d("AppsFlyer", "AppsFlyerRequestListener: onSuccess")
                }

                override fun onError(code: Int, error: String) {
                    Log.d("AppsFlyer", "AppsFlyerRequestListener: onError. Code: $code, error: $error")
                }
            })
            isSdkReadyToStart = false
        }
    }

    fun reset() {
        isConsentReady = false
        isSdkReadyToStart = false
    }
}
```

Wire the coordinator from your `Application` class:

```java Java
AfSdkStartupManager startupManager = new AfSdkStartupManager();

AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    startupManager.onAfSdkReadyToStart();
});

// When your consent flow completes:
// startupManager.onConsentReady();
```
```kotlin Kotlin
val startupManager = AfSdkStartupManager()

AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
AppsFlyerLib.getInstance().registerSessionReadyListener {
    startupManager.onAfSdkReadyToStart()
}

// When your consent flow completes:
// startupManager.onConsentReady()
```

> ⚠️ The `registerSessionReadyListener` callback fires on a background thread. If your conditions also resolve on a background thread, make sure your coordinator's flags are thread-safe — mark them `volatile` in Java or `@Volatile` in Kotlin.

### Full example

The following example demonstrates how to initialize and start the SDK from the Application class without pre-conditions.

```java Java
import android.app.Application;
import com.appsflyer.AppsFlyerLib;

public class AFApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
        AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
            AppsFlyerLib.getInstance().start();
        });
    }
}
```
```kotlin Kotlin
import android.app.Application
import com.appsflyer.AppsFlyerLib

class AFApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
        AppsFlyerLib.getInstance().registerSessionReadyListener {
            AppsFlyerLib.getInstance().start()
        }
    }
}
```

---

## Setting the Customer User ID

<span class="annotation-optional">Optional</span>

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. The CUID lets app owners follow user journeys across different devices.

### Set the Customer User ID

Once the CUID is available, set it by calling [`setCustomerUserId`](doc:android-sdk-reference-appsflyerlib#setcustomeruserid):

```java Java
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

The CUID can only be associated with in-app events after it has been set. If `start` was called before `setCustomerUserId`, the install event will not be associated with the CUID. To associate the install event with the CUID, see below.

> 📘 Note
>
> In SDK V7, setter values are not persisted between sessions. Re-apply `setCustomerUserId` on every cold start.

### Associate the CUID with the install event

If you need the CUID to be associated with the install event, set it before calling `start()`.

In SDK V7, this is straightforward: since you control when `start()` is called, set the CUID inside your session ready listener callback, before calling `start()`:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
    AppsFlyerLib.getInstance().start();
});
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>)
    AppsFlyerLib.getInstance().start()
}
```

> 📘 Note
>
> The `waitForCustomerUserId` and `setCustomerIdAndLogSession` APIs have been removed in SDK V7. The new session model makes them unnecessary: since you control when `start()` is called, there is no need for a waiting mechanism.

---

## Providing the Launcher Activity

The SDK needs to get the launcher activity to determine what entity launched the app. To enable it, call `collectDataFromLauncherActivity(this)` in your launcher activity's `onCreate` method, before `start()` runs for that cold start.

```java Java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    AppsFlyerLib.getInstance().collectDataFromLauncherActivity(this);
}
```
```kotlin Kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    AppsFlyerLib.getInstance().collectDataFromLauncherActivity(this)
}
```

> ⚠️ Referrer data is only available on the activity that received the original launch intent, which is typically your main or splash activity. Call this method once, from your launcher activity, before any other activity starts.

---

## Enabling debug mode

<span class="annotation-optional">Optional</span>

You can enable debug logs by calling [`setDebugLog`](doc:android-sdk-reference-appsflyerlib#setdebuglog):

```java Java
AppsFlyerLib.getInstance().setDebugLog(true);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().setDebugLog(true)
```

> 📘 Note
>
> To see full debug logs, make sure to call `setDebugLog` before invoking other SDK methods.

> 🚧 Warning
>
> To avoid leaking sensitive information, make sure debug logs are disabled before distributing the app.

> 📘 Note
>
> Alternatively, you can enable debug mode at build time by setting `"debug_mode": true` in your `af_init_config.json` file. See [Configuring the SDK with af_init_config.json](#configuring-the-sdk-with-af_init_configjson) above.

---

## Testing the integration

<span class="annotation-optional">Optional</span>

For detailed integration testing instructions, see the [Android SDK integration testing guide](doc:testing-android).