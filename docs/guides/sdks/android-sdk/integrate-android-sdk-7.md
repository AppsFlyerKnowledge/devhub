---
title: Integrate Android SDK 7
slug: integrate-android-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-android-7
privacy:
  view: public
position: 2
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

See [Setting the Customer User ID](doc:customer-user-id-android-7) to associate a CUID with this integration.

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

## Test the integration

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Easily test with our SDK wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk-7');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Note**
> 
> If you prefer not to use our recommended wizard, you can find detailed manual testing instructions [here](doc:manual-testing-android).

For a full troubleshooting checklist, see [Troubleshooting](doc:troubleshooting-android-7).

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
