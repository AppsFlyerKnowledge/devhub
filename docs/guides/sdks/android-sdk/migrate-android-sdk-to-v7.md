---
title: Migrate Android SDK to V7
slug: migrate-android-sdk-to-v7
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-7
privacy:
  view: hidden
position: 1
---

## Before you begin

This guide walks you through migrating your Android app from AppsFlyer SDK 6 to SDK 7. SDK 7 introduces a new session control model, removes several deprecated APIs, and aligns Android behavior with iOS. Use this guide to identify what you need to change, understand why each change was made, and update your integration in the right order.

> 📘 Note
>
> The vast majority of `AppsFlyerLib` methods remain unchanged between SDK 6 and SDK 7. This guide covers only the changes you need to make. You don't need to rewrite your integration from scratch.

### SDK 6 support policy

SDK 6 continues to be supported, but only for critical fixes. All new features are planned for SDK 7 only. We recommend migrating as soon as possible to stay current with new capabilities.

### Kotlin version requirement

If your app uses Kotlin 1.9, you may encounter metadata errors when building against the SDK 7 AAR. Update to Kotlin 2.0 or higher before migrating.

### Minimum SDK version

SDK 7 raises the minimum Android API level from 19 to 21. Update your `build.gradle` before proceeding.

**SDK 6**
```groovy
minSdk 19
```

**SDK 7**
```groovy
minSdk 21
```

Most apps are already above API 21, as many Google libraries require API 25 or higher.

### Article scope

This article covers Android only. For iOS, see [Migrate iOS SDK to V7](doc:migrate-ios-sdk-to-v7).

---

## The SDK 7 session model

The core theme of SDK 7 is giving you control over when to send the first session, and any subsequent session. In SDK 6, the SDK sent the session automatically when the app came to the foreground. In SDK 7, that responsibility moves to you as the developer.

This change reflects a real-world need: many apps must complete steps before sending a launch event to AppsFlyer, for example collecting user consent, retrieving a customer user ID (CUID), or completing ATT authorization. SDK 7 is designed around this requirement.

SDK 7 also addresses long-standing inconsistencies between iOS and Android. The most significant behavioral alignment is setter persistence: in SDK 6, many `AppsFlyerLib` setter values were persisted to disk on Android and survived process restarts. In SDK 7, Android aligns with iOS, meaning all setter values are runtime-only and must be re-applied on every cold start.

---

## Upgrade checklist

Work through these in order — higher-risk changes first. The Risk column tells you whether skipping a step causes a **compile error** (caught at build time) or a **silent regression** (compiles but misbehaves at runtime).

| # | Action | Risk | § |
|---|--------|------|---|
| **Prerequisites** | | | |
| 1 | Update to Kotlin 2.0 or higher if your app uses Kotlin 1.9. | Prerequisite | Before you begin |
| 2 | Set `minSdkVersion` to at least 21 in your `build.gradle`. | Prerequisite | Before you begin |
| **High-risk changes** | | | |
| 3 | Update all imports from their previous packages to `com.appsflyer.share`. Use Android Studio's auto-import to resolve them. | Compile error | §1 |
| 4 | Remove `Context` and dev key from `start()`. Use `start()` or `start(AppsFlyerRequestListener)` only. | Compile error | §2 |
| 5 | Update `registerConversionListener`: remove the `Context` parameter, remove `onAppOpenAttribution` and `onAttributionFailure`, and update the import to `com.appsflyer.share.AppsFlyerConversionListener`. | Compile error | §4 |
| 6 | Add `registerSessionReadyListener` after `init()`. Call `start()` inside the callback, or use the coordinator pattern if your app has pre-start conditions. | Silent regression | §3 |
| 7 | Re-apply all `AppsFlyerLib` setter values after every cold start, or move constant values to `af_init_config.json`. | Silent regression | Part 2 §1 |
| **Deep linking** | | | |
| 8 | Replace `performOnDeepLinking` and `performOnAppAttribution` with `performDeepLinking(String, boolean)`. Replace `subscribeForDeepLink(listener, timeout)` with `setDeepLinkTimeout(long)` followed by `subscribeForDeepLink(listener)`. | Compile error | §5 |
| **Deprecated API removals** | | | |
| 9 | Remove `SingleInstallBroadcastReceiver` and `MultipleInstallBroadcastReceiver` from your manifest. Add `implementation 'com.android.installreferrer:installreferrer:2.2'` to your app's `build.gradle`. | Compile error | §8 |
| 10 | Update `setUserEmails`: replace MD5 or SHA1 with `SHA256` or `NONE`, and update the import to `com.appsflyer.share.EmailsCryptType`. | Compile error | §7 |
| 11 | Remove or replace: `waitForCustomerUserId`, `setCustomerIdAndLogSession`, `setCollectIMEI`, `setCollectOaid`, `setExtension`, `registerValidatorListener`, `validateAndLogInAppPurchase` V1, `setSharingFilter`, and `setSharingFilterForAllPartners`. | Compile error | §9 |
| **Optional** | | | |
| 12 | Call `collectDataFromLauncherActivity(this)` from your launcher activity's `onCreate` to opt in to app-open and web referrer collection. | — | Part 2 §3 |
| 13 | If you distribute on Samsung, Xiaomi, or Huawei stores, add the relevant store referrer library to your app's Gradle dependencies. | — | §11 |

---

## Part 1: Breaking changes

The following changes will cause compile errors if not addressed. Work through them in the order below, as some steps depend on others.

### 1. Update class imports

**What changed:** All user-facing public classes moved from `com.appsflyer` subpackages to `com.appsflyer.share`.

**Compile error:** Existing code breaks on upgrade.

| SDK 6 import | SDK 7 import |
|---|---|
| `com.appsflyer.AppsFlyerConversionListener` | `com.appsflyer.share.AppsFlyerConversionListener` |
| `com.appsflyer.attribution.AppsFlyerRequestListener` | `com.appsflyer.share.attribution.AppsFlyerRequestListener` |
| `com.appsflyer.attribution.RequestError` | `com.appsflyer.share.attribution.RequestError` |
| `com.appsflyer.deeplink.DeepLinkListener` | `com.appsflyer.share.deeplink.DeepLinkListener` |
| `com.appsflyer.deeplink.DeepLinkResult` | `com.appsflyer.share.deeplink.DeepLinkResult` |
| `com.appsflyer.internal.platform_extension.PluginInfo` | `com.appsflyer.share.platform_extension.PluginInfo` |
| `com.appsflyer.AFAdRevenueData`, `AFInAppEventType`, `AFInAppEventParameterName`, `AFPurchaseDetails`, `AdRevenueScheme`, `MediationNetwork`, `AppsFlyerConsent`, and others | `com.appsflyer.share.*` (same class names, new package) |

> 📘 Note
>
> Android Studio can resolve these import changes automatically. Remove the old import and let the IDE suggest the correct replacement from `com.appsflyer.share`.

---

### 2. Update the start method

**What changed:** `start()` no longer accepts a `Context` or dev key.

**Compile error:** Existing code breaks on upgrade.

The `Context` and dev key parameters have been removed from `start()`. Both are already provided to `init()` and don't need to be passed again. SDK 7 supports only two `start()` signatures: one with no arguments, and one with an `AppsFlyerRequestListener`.

**SDK 6**
```java Java
// Application.onCreate or Activity
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

AppsFlyerLib.getInstance().start(this);
AppsFlyerLib.getInstance().start(this, devKey);
AppsFlyerLib.getInstance().start(this, devKey, requestListener);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

AppsFlyerLib.getInstance().start(this)
AppsFlyerLib.getInstance().start(this, devKey)
AppsFlyerLib.getInstance().start(this, devKey, requestListener)
```

**SDK 7**
```java Java
// Application.onCreate — Context is only passed to init
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

// After registerSessionReadyListener (see §3):
AppsFlyerLib.getInstance().start();
AppsFlyerLib.getInstance().start(requestListener);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

// After registerSessionReadyListener (see §3):
AppsFlyerLib.getInstance().start()
AppsFlyerLib.getInstance().start(requestListener)
```

---

### 3. Add a session-ready listener

**What changed:** `start()` now requires `registerSessionReadyListener` to be called first. Without a registered listener, the SDK logs a warning and does not start the session.

The listener fires when the SDK completes its internal checks and is ready to begin the session. From that point, it's up to you to decide when to actually call `start()` based on your app's requirements.

Two patterns are available depending on your app's needs.

#### Start without pre-conditions

Use this pattern if your app has no pre-start conditions, meaning you don't need to wait for consent, a CUID, or any other gate before sending the first session.

> 📘 SDK 6
>
> There was no `SessionReadyListener` API in SDK 6. `start()` could be called directly after `init`.

**SDK 7**
```java Java
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().start();
});

// Optional when you tear down (e.g. in Activity.onDestroy()):
// AppsFlyerLib.getInstance().unregisterSessionReadyListener();

boolean ready = AppsFlyerLib.getInstance().isSessionReady();
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().start()
}

// Optional when you tear down (e.g. in Activity.onDestroy()):
// AppsFlyerLib.getInstance().unregisterSessionReadyListener()

val ready = AppsFlyerLib.getInstance().isSessionReady
```

#### Start with pre-conditions

Use this pattern if your app must satisfy conditions before sending the first session, for example, collecting user consent or waiting for a CUID from your backend. The coordinator class synchronizes the SDK's readiness signal with your app's own readiness, and calls `start()` only when both conditions are met.

**`AfSdkStartupManager`**
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

AppsFlyerLib.getInstance().init(devKey, conversionListener, this);
AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    startupManager.onAfSdkReadyToStart();
});

// When your consent flow completes:
// startupManager.onConsentReady();
```
```kotlin Kotlin
val startupManager = AfSdkStartupManager()

AppsFlyerLib.getInstance().init(devKey, conversionListener, this)
AppsFlyerLib.getInstance().registerSessionReadyListener {
    startupManager.onAfSdkReadyToStart()
}

// When your consent flow completes:
// startupManager.onConsentReady()
```

> ⚠️ Warning
>
> The `SessionReadyListener` callback fires on a background thread. If your consent flow also runs on a background thread, make sure the flags in your coordinator class are thread-safe. At minimum, mark them `volatile` in Java or `@Volatile` in Kotlin.

---

### 4. Update the conversion listener

**What changed:** `registerConversionListener` no longer accepts a `Context` parameter, and the `onAppOpenAttribution` and `onAttributionFailure` callbacks have been removed. Unified Deep Linking (UDL) is now the required path for handling deep links after app open.

**Compile error:** Existing code breaks on upgrade.

**SDK 6**
```java Java
import com.appsflyer.AppsFlyerConversionListener;

AppsFlyerLib.getInstance().registerConversionListener(context, new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionData) { }

    @Override
    public void onConversionDataFail(String errorMessage) { }

    @Override
    public void onAppOpenAttribution(Map<String, String> attributionData) { }

    @Override
    public void onAttributionFailure(String errorMessage) { }
});
```
```kotlin Kotlin
import com.appsflyer.AppsFlyerConversionListener

AppsFlyerLib.getInstance().registerConversionListener(
    context,
    object : AppsFlyerConversionListener {
        override fun onConversionDataSuccess(conversionData: MutableMap<String, Any>?) { }
        override fun onConversionDataFail(errorMessage: String?) { }
        override fun onAppOpenAttribution(attributionData: MutableMap<String, String>?) { }
        override fun onAttributionFailure(errorMessage: String?) { }
    }
)
```

**SDK 7**
```java Java
import com.appsflyer.share.AppsFlyerConversionListener;

AppsFlyerLib.getInstance().registerConversionListener(new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionData) { }

    @Override
    public void onConversionDataFail(String errorMessage) { }
});
```
```kotlin Kotlin
import com.appsflyer.share.AppsFlyerConversionListener

AppsFlyerLib.getInstance().registerConversionListener(
    object : AppsFlyerConversionListener {
        override fun onConversionDataSuccess(conversionData: MutableMap<String, Any>?) { }
        override fun onConversionDataFail(errorMessage: String?) { }
    }
)
```

> 📘 Note
>
> If your app uses Self-Reporting Networks (SRNs), you still need `onConversionDataSuccess` for the Extended Deferred Deep Linking (EDDL) flow. Only `onAppOpenAttribution` and `onAttributionFailure` are removed. Move any logic from those two callbacks to your UDL implementation using `subscribeForDeepLink`.

---

### 5. Update deep linking

#### 5a. New deep linking method replaces two removed methods

**What changed:** `performOnDeepLinking` and `performOnAppAttribution` have been removed.

**Compile error:** Existing code breaks on upgrade.

Replace both with the new `performDeepLinking(String url, boolean shouldTriggerSession)` method. This method accepts the deep link as a plain string, supports both intent-based and non-intent-based sources such as Firebase Messaging Service, and gives you explicit control over whether a Launch event is sent to AppsFlyer.

| Parameter | Description |
|---|---|
| `url` | The deep link string to resolve: full URL, OneLink, `Intent` `data` string. |
| `shouldTriggerSession` | `false`: resolve `url` for `DeepLinkListener` without an extra Launch. `true`: also enqueue a Launch for re-engagement — even if `start()` has already been called in that session. |

**SDK 6**
```java Java
AppsFlyerLib.getInstance().subscribeForDeepLink(listener, 3000L);
AppsFlyerLib.getInstance().performOnDeepLinking(intent, context);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().subscribeForDeepLink(listener, 3000L)
AppsFlyerLib.getInstance().performOnDeepLinking(intent, context)
```

**SDK 7**
```java Java
AppsFlyerLib.getInstance().setDeepLinkTimeout(3000L);
AppsFlyerLib.getInstance().subscribeForDeepLink(listener);
AppsFlyerLib.getInstance().performDeepLinking("https://your.onelink/...", true);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().setDeepLinkTimeout(3000L)
AppsFlyerLib.getInstance().subscribeForDeepLink(listener)
AppsFlyerLib.getInstance().performDeepLinking("https://your.onelink/...", true)
```

#### 5b. Set deep link timeout separately

**What changed:** The `subscribeForDeepLink(DeepLinkListener, long)` overload that accepted a timeout has been removed.

**Compile error:** Existing code breaks on upgrade.

Set the timeout separately using `setDeepLinkTimeout`, then call `subscribeForDeepLink` without the timeout parameter. This aligns the Android API with iOS.

#### 5c. UDL no longer requires start first

**What changed:** In SDK 6, UDL required `start()` to have been called before a deep link could be resolved. In SDK 7, the SDK subscribes to the Android lifecycle from `init()` and can catch the very first activity creation or resume.

You can now register for deep links before calling `start()`, and your `DeepLinkListener` will fire even if `start()` hasn't been called yet.

The recommended initialization sequence in your `Application` class is:

1. Call `init()`.
2. Call `subscribeForDeepLink()`.
3. Call `registerSessionReadyListener()`.
4. Call `start()` inside the listener callback, or later when your app's conditions are met.

This also means deep-linking a user without starting a session is now a first-class supported flow. If a user hasn't yet provided consent to send data to AppsFlyer but you still want to route them within the app, call `performDeepLinking` with `shouldTriggerSession` set to `false`. The deep link resolves and reaches your listener without sending a Launch event.

---

### 6. Update push notification handling

**What changed:** The existing `sendPushNotificationData(Activity)` API is unchanged. SDK 7 adds a new overload that lets you provide push data manually using the `AFPushData` object. This is useful when your push payload is resolved outside of an `Intent`, for example directly from Firebase Messaging Service.

```java Java
import com.appsflyer.share.AFPushData;

import java.util.HashMap;
import java.util.Map;

// Same as in SDK 6
AppsFlyerLib.getInstance().sendPushNotificationData(activity);

Map<String, Object> extras = new HashMap<>();
extras.put("key1", "value1");

AFPushData pushData = new AFPushData(
        "Campaign1",
        "Firebase",
        true,
        extras
);
AppsFlyerLib.getInstance().sendPushNotificationData(pushData);
```
```kotlin Kotlin
import com.appsflyer.share.AFPushData

// Same as in SDK 6
AppsFlyerLib.getInstance().sendPushNotificationData(activity)

AppsFlyerLib.getInstance().sendPushNotificationData(
    AFPushData(
        campaign = "Campaign1",
        pid = "Firebase",
        isRetargeting = true,
        additionalParameters = mapOf("key1" to "value1")
    )
)
```

---

### 7. Update the user emails method

**What changed:** Two changes apply to `setUserEmails`:
- SHA1 and MD5 encryption types have been removed. Only `NONE` and `SHA256` are supported in SDK 7. If you used MD5 or SHA1, update your code to use `SHA256` or `NONE`.
- `EmailsCryptType` has moved from `AppsFlyerProperties` to `com.appsflyer.share`. Update the import.

**Compile error:** Existing code breaks on upgrade.

**SDK 6**
```java Java
AppsFlyerLib.getInstance().setUserEmails(
    AppsFlyerProperties.EmailsCryptType.SHA256,
    "user@example.com"
);
// Also: NONE, SHA1, MD5 under AppsFlyerProperties.EmailsCryptType
```
```kotlin Kotlin
AppsFlyerLib.getInstance().setUserEmails(
    AppsFlyerProperties.EmailsCryptType.SHA256,
    "user@example.com"
)
// Also: NONE, SHA1, MD5 under AppsFlyerProperties.EmailsCryptType
```

**SDK 7**
```java Java
import com.appsflyer.share.EmailsCryptType;

AppsFlyerLib.getInstance().setUserEmails(
    EmailsCryptType.SHA256,
    "user@example.com"
);
// Only NONE and SHA256 remain
```
```kotlin Kotlin
import com.appsflyer.share.EmailsCryptType

AppsFlyerLib.getInstance().setUserEmails(
    EmailsCryptType.SHA256,
    "user@example.com"
)
// Only NONE and SHA256 remain
```

---

### 8. Remove legacy broadcast receivers

**What changed:** `SingleInstallBroadcastReceiver` and `MultipleInstallBroadcastReceiver` have been removed.

**Compile error:** Existing code breaks on upgrade.

To migrate:

1. Remove any `<receiver>` entries in your `AndroidManifest.xml` whose `android:name` is `com.appsflyer.SingleInstallBroadcastReceiver` or `com.appsflyer.MultipleInstallBroadcastReceiver`, together with their `INSTALL_REFERRER` intent filter blocks. Leaving them breaks manifest merge.
2. Add the Google Play Install Referrer library as an `implementation` dependency in your app module's `build.gradle`. The AppsFlyer SDK declares this as `compileOnly` internally, so you must add it explicitly to your app.

```groovy
implementation 'com.android.installreferrer:installreferrer:2.2'
```

> ⚠️ Warning
>
> Leaving old `<receiver>` entries in your manifest causes a build-time error, not a runtime error. Your app won't build until you remove them.

---

### 9. Remove or replace other removed APIs

**What changed:** Several deprecated APIs have been removed.

**Compile error:** Existing code that calls these APIs breaks on upgrade.

| Removed API | Replacement |
|---|---|
| `waitForCustomerUserId(boolean)` / `setCustomerIdAndLogSession()` | No replacement needed. See the note below. |
| `setCollectIMEI(boolean)` | Use `setImeiData(String)` to provide IMEI manually when needed. |
| `setCollectOaid(boolean)` | Use `setDisableAdvertisingIdentifiers` and other supported identifier APIs. |
| `setExtension(String)` | Use `PluginInfo` (imported from `com.appsflyer.share.platform_extension`). |
| `registerValidatorListener` / `validateAndLogInAppPurchase` V1 | Use `validateAndLogInAppPurchase(AFPurchaseDetails, Map, AppsFlyerInAppPurchaseValidationCallback)` with `com.appsflyer.share.AFPurchaseDetails`. The V2 API has the listener built in. |
| `setSharingFilter(String...)` / `setSharingFilterForAllPartners()` | Use `setSharingFilterForPartners(String...)`. Pass `"all"` to block all partners. |

> 📘 Customer user ID flow in SDK 7
>
> In SDK 6, because the session started automatically, you had to call `waitForCustomerUserId(true)` to tell the SDK to hold off until the CUID was available, then call `setCustomerIdAndLogSession()` to release it. Forgetting the second call caused the SDK to wait indefinitely, which was a common source of integration issues. In SDK 7, you control when `start()` is called. If you need to include a CUID in the first session, call `setCustomerUserId()` before calling `start()`. No waiting mechanism is needed.

> 📘 `AppsFlyerProperties` removed
>
> `AppsFlyerProperties` is no longer available in SDK 7. If your app used `AppsFlyerProperties.getInstance().set()` to configure SDK behavior, contact AppsFlyer Support for guidance on your specific configuration.

> 🚧 Warning
>
> `setSharingFilter`, `setSharingFilterForAllPartners`, and `validateAndLogInAppPurchase` V1 were deprecated in SDK 6 but some apps continued to use them. Upgrading to SDK 7 causes compile errors on any of these deprecated APIs, giving you a clear signal of what to update.

---

### 10. Update the link generator response listener

**What changed:** `onResponse` now fires only when a true short OneLink is created. `onResponseError` handles all other outcomes including network failures and long-link fallbacks. The deprecated `CreateOneLinkHttpTask.ResponseListener` overload has been removed.

**Compile error:** Existing code that implements `CreateOneLinkHttpTask.ResponseListener` breaks on upgrade.

**API (unchanged signature on the supported path)**

`com.appsflyer.share.LinkGenerator#generateLink(android.content.Context, com.appsflyer.share.LinkGenerator.ResponseListener)`

| | SDK 6 | SDK 7 |
|---|---|---|
| `onResponse(String)` | Called for multiple outcomes: short link when OneLink API succeeded, and also a long (query-style) link when the task did not complete with a usable short URL. | Called only when the OneLink HTTP request finishes with a successful response body — the short URL from the API. |
| `onResponseError(String)` | Used mainly when the SDK failed to parse a response, for example a `ParsingException` on a body that looked successful. | Called for all other outcomes. The parameter is the long-link fallback string from `LinkGenerator.generateLink()`. Your app decides whether that string is acceptable for display or sharing. |

> ⚠️ Warning
>
> Do not use or implement `com.appsflyer.CreateOneLinkHttpTask.ResponseListener` or `LinkGenerator.generateLink(Context, CreateOneLinkHttpTask.ResponseListener)` — both are removed in SDK 7. Migrate to `LinkGenerator.ResponseListener` only.

> 📘 Note
>
> Both `onResponse` and `onResponseError` run on a `@WorkerThread`. Post to the main thread if you update the UI from within them.

---

### 11. Add optional store referrer libraries

<span class="annotation-optional">Optional</span>

**What changed:** Samsung, Xiaomi, and Huawei store referrer support is no longer bundled in the main `af-android-sdk` artifact in SDK 7. If you distribute your app through any of these stores and need that referrer data, add the corresponding library as a separate Gradle dependency.

**Gradle — Bill of Materials (recommended)**

Pin all AppsFlyer artifacts to one release via the BOM, then list only what you need without repeating versions:

```groovy
dependencies {
    implementation platform("com.appsflyer:af-android-sdk-bom:<SDK_VERSION>")

    implementation "com.appsflyer:af-android-sdk"

    // Optional — only for the stores you publish to:
    implementation "com.appsflyer:samsung-referrer"
    implementation "com.appsflyer:xiaomi-referrer"
    implementation "com.appsflyer:huawei-referrer"
}
```

**Gradle — explicit versions (without BOM)**

Keep the same version on `af-android-sdk` and every AppsFlyer referrer library you use:

```groovy
dependencies {
    implementation "com.appsflyer:af-android-sdk:<SDK_VERSION>"

    implementation "com.appsflyer:samsung-referrer:<SDK_VERSION>"
    implementation "com.appsflyer:xiaomi-referrer:<SDK_VERSION>"
    implementation "com.appsflyer:huawei-referrer:<SDK_VERSION>"
}
```

Add only the referrer lines you actually need.

No extra AppsFlyer initialization code is required. Once these libraries are dependencies of your app, they register with the SDK automatically on startup.

> 📘 Third-party dependencies
>
> - **Xiaomi / GetApps:** Add `com.miui.referrer:homereferrer` as an additional `implementation` dependency (not covered by the BOM).
> - **Huawei / AppGallery:** Follow the AppsFlyer + Huawei AppGallery integration guide for Maven repositories and HMS dependencies (not covered by the BOM).
> - **Samsung:** Adding `samsung-referrer` is sufficient for most apps.

---

## Part 2: Behavioral and additive changes

The following changes don't cause compile errors, but they affect runtime behavior. Review each one carefully, as some may cause silent data loss if not addressed.

### 1. Setter values are no longer persisted between sessions

In SDK 6, many `AppsFlyerLib` setter values were written to disk on Android and survived process restarts. In SDK 7, all setter values are runtime-only. After a cold start, any value you set via an `AppsFlyerLib` setter is gone.

You must re-apply any setter values you rely on after every cold start, typically right after `init()`. If you relied on persistence without realizing it, your integration may silently send incomplete data after upgrading.

| API method | Setting | Status in SDK 7 |
|---|---|---|
| `anonymizeUser(boolean)` | User anonymization | Runtime only, re-apply each cold start |
| `enableTCFDataCollection(boolean)` | TCF data collection flag | Runtime only, re-apply each cold start |
| `setDisableNetworkData(boolean)` | Disable outbound network payloads | Runtime only, re-apply each cold start |
| `setCustomerUserId(String)` | Customer user ID | Runtime only, re-apply each cold start |
| `setOutOfStore(String)` | Out-of-store / store override | Runtime only, re-apply each cold start |
| `setAppInviteOneLink(String)` | User-invite OneLink ID | Runtime only, re-apply each cold start |
| `setAdditionalData(Map)` | Custom event and launch map | Runtime only, re-apply each cold start |
| `setUserEmails(...)` | Masked emails | Runtime only, re-apply each cold start |
| `setCollectAndroidID(boolean)` | Collect Android ID | Runtime only, re-apply each cold start |
| `setImeiData(String)` | Manual IMEI | Runtime only, re-apply each cold start |
| `setOaidData(String)` | Manual OAID | Runtime only, re-apply each cold start |
| `setAppId(String)` | App ID override | Runtime only, re-apply each cold start |
| `setIsUpdate(boolean)` | Fresh install vs. update flag | Runtime only, re-apply each cold start |
| `setCurrencyCode(String)` | In-app currency | Runtime only. Alternatively, set `currency_code` in `af_init_config.json` (see below). |
| `setPreinstallAttribution(String...)` | OEM / preinstall override | Runtime only, re-apply each cold start |
| `setLogLevel(AFLogger.LogLevel)` | Log level | Runtime only, re-apply each cold start |
| `setDebugLog(boolean)` | Debug logging shortcut | Runtime only. Alternatively, set `debug_mode` in `af_init_config.json` (see below). |
| `waitForCustomerUserId` / `setCustomerIdAndLogSession` | CUID wait flow | Removed. See Part 1, §9. |
| `setCollectIMEI` / `setCollectOaid` / `setExtension` | Various | Removed. See Part 1, §9. |

---

### 2. Use a JSON config file for constant configuration values

SDK 7 introduces a JSON-based initialization helper. If you place a file named `af_init_config.json` in your `src/main/assets/` folder, the SDK reads it during `init()` and applies the supported keys as if the corresponding setters had been called.

This is the recommended approach for any configuration value that is constant and known at build time. Instead of calling the setter on every cold start, put the value in the file once.

| JSON key | Type | Equivalent setter | Example value |
|---|---|---|---|
| `debug_mode` | boolean | Debug logging | `true` |
| `disable_advertising_identifiers` | boolean | `setDisableAdvertisingIdentifiers` | `true` |
| `currency_code` | string | `setCurrencyCode` | `"USD"` |
| `host` | object `{ "prefix": string, "host": string }` | `setHost` | `{ "prefix": "", "host": "af-sdk.net" }` |
| `min_time_between_sessions` | number (int) | `setMinTimeBetweenSessions` | `1` |
| `ddlTimeout` | number (int, ms) | `setDeepLinkTimeout` | `3000` |

> 📘 SDK 6
>
> There was no file-based init in SDK 6. All configuration was done in code.

**Example `src/main/assets/af_init_config.json`**
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

If the file is missing, initialization continues normally. Unknown keys are ignored with a log line. Type mismatches are caught and logged.

---

### 3. Opt in to app-open referrer and web referrer collection

<span class="annotation-optional">Optional</span>

In SDK 6, the SDK automatically collected app-open referrer and web referrer data for all clients as part of the startup flow. In SDK 7, this collection is opt-in.

If you want the SDK to collect this data, call `collectDataFromLauncherActivity(Activity)` from your launcher activity's `onCreate` method, before `start()` runs for that cold start.

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

> ⚠️ Warning
>
> Referrer data is only available on the activity that received the original launch intent, which is typically your main or splash activity. If you call this method on a secondary activity, or if your app uses a trampoline or navigation activity that creates other activities, the referrer data will already be gone and nothing will be collected. Call this method once, from your launcher activity, before any other activity starts.

---

## Troubleshooting

The following log messages indicate common integration issues. Search your logcat output for these substrings.

| Symptom | Log message to look for |
|---|---|
| `start()` called without `registerSessionReadyListener` | `SessionReadyListener is not registered! — You must call registerSessionReadyListener(SessionReadyListener) before start().` |
| An API was called before `init()` | `AppsFlyer SDK is not initialized! The API call '…' must be called after the 'init(String, AppsFlyerConversionListener)'` |
| Dev key missing from `init()` | `You must provide AppsFlyer Dev-Key in the 'init' API method` |
| `init()` called with a null context | `AppsFlyer SDK requires a valid Context!` |
| `start()` called twice in the same session | `AppsFlyer SDK session already started. Skipping duplicate start call.` |
| Session not started when finishing | `AppsFlyer SDK session not started. Skipping session finish.` |

Enable verbose or debug logging per your integration if messages do not appear at default levels.