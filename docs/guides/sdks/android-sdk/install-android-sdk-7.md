---
title: Install Android SDK 7
slug: install-android-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-7
privacy:
  view: hidden
position: 2
---

## Before you begin

Before installing Android SDK V7, make sure your project meets the following requirements:

- **Minimum Android API level**: SDK V7 requires API level 21 or higher. Update your `build.gradle` before proceeding:

```groovy
minSdk 21
```

- **Kotlin version**: If your app uses Kotlin 1.9, you may encounter metadata errors when building against the SDK V7 AAR. Update to Kotlin 2.0 or higher before installing.


## Installing the Android SDK

Install the Android SDK using your preferred method: via Gradle (recommended), or manually.

### Install using Gradle

**Recommended**

**Step 1: Declare repositories**  
In the Project `build.gradle` file, declare the `mavenCentral` repository:

```groovy
// ...
repositories {
   mavenCentral()
}
// ...
```

**Step 2: Add dependencies**  
In the application `build.gradle` file, add the [latest Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) package:

```groovy
dependencies {
    // Get the latest version from https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk
    implementation 'com.appsflyer:af-android-sdk:<<HERE_LATEST_VERSION>>'
    // For example
    // implementation 'com.appsflyer:af-android-sdk:7.0.0'
}
```

### Manual install

1. In **Android Studio**, switch the folder structure from **Android** to **Project**.
2. [Download the latest Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) and paste it in your Android project, under **app > libs**.
3. Right-click the `aar` you pasted and select **Add As Library**. When prompted, click **Refactor**. If prompted to commit to git, click **OK**.


## Setting required permissions

Add the following permissions to `AndroidManifest.xml` in the `manifest` section:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package=YOUR_PACKAGE_NAME>

      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

      ...

</manifest>
```

### The AD_ID permission

The SDK adds the AD_ID permission automatically. If your app participates in the Designed for Families program, you should review the AD_ID permission.

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID" />
```

#### Revoking the AD_ID permission

According to [Google's Policy](https://support.google.com/googleplay/android-developer/answer/11043825?hl=en), apps that target children must not transmit the Advertising ID.

When using SDK `V6.8.0` and above, children apps targeting Android 13 (API 33) and above must prevent the permission from getting merged into their app by adding a revoke declaration to their Manifest:

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"
tools:node="remove"/>
```

For more information, see [Google Play Services documentation](https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info#public-string-getid).


## ProGuard rules

<span class="annotation-optional">Optional</span>

If you are using ProGuard and you encounter a warning regarding our `AFKeystoreWrapper` class, add the following code to your `proguard-rules.pro` file:

### AppsFlyer SDK ProGuard rules

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.** { *; }
```


## Backup rules

The SDK's `AndroidManifest.xml` includes rules to opt out of backing up the Shared Preferences data. This is done to avoid retaining the same counters and AppsFlyer ID during reinstallation, thereby preventing the accurate detection of new installs or re-installs.

To merge the SDK backup rules with your app backup rules and to prevent conflicts, perform the following instructions for each use case.

### Fix conflict with fullBackupContent="true"

If you add `android:fullBackupContent="true"` in the `AndroidManifest.xml`, you might get the following error:

```
Manifest merger failed : Attribute application@fullBackupContent value=(true)
```

To fix this error, add `tools:replace="android:fullBackupContent"` in the `<application>` tag in the `AndroidManifest.xml` file.

### Fix conflict with dataExtractionRule="true"

If you add `android:dataExtractionRules="true"` in the `AndroidManifest.xml`, you might get the following error:

```
Manifest merger failed : Attribute application@dataExtractionRules value=(true)
```

To fix this error, add `tools:replace="android:dataExtractionRules"` in the `<application>` tag in the `AndroidManifest.xml` file.

### Fix conflict with allowBackup="false"

If you add `android:allowBackup="false"` in the `AndroidManifest.xml`, you might get the following error:

```
Error:
	Attribute application@allowBackup value=(false) from AndroidManifest.xml:
	is also present at [com.appsflyer:af-android-sdk:7.x.x] AndroidManifest.xml: value=(true).
	Suggestion: add 'tools:replace="android:allowBackup"' to <application> element at AndroidManifest.xml to override.
```

To fix this error, add `tools:replace="android:allowBackup"` in the `<application>` tag in the `AndroidManifest.xml` file.

### Merge backup rules in Android 12 and above

If you're targeting **Android 12** and above, and you have your own backup rules specified (`android:dataExtractionRules="@xml/my_rules"`), in addition to the instructions above, please merge your backup rules with the AppsFlyer rules manually by adding the following rule:

```xml
<data-extraction-rules>
    <cloud-backup>
        <exclude domain="sharedpref" path="appsflyer-data"/>
    </cloud-backup>
    <device-transfer>
        <exclude domain="sharedpref" path="appsflyer-data"/>
    </device-transfer>
</data-extraction-rules>
```

### Merge backup rules in Android 11 and below

If you're also targeting **Android 11** and lower, and you have your own backup rules specified (`android:fullBackupContent="@xml/my_rules"`), in addition to the instructions above, please merge your backup rules with the AppsFlyer rules manually by adding the following rule:

```xml
<full-backup-content>
    ...//your custom rules
    <exclude domain="sharedpref" path="appsflyer-data"/>
</full-backup-content>
```


## Adding store referrer libraries

The AppsFlyer SDK supports several store referrer libraries. Using a store referrer improves attribution accuracy.

You only need to add the referrer dependency, the SDK takes care of the rest.

### Google Play Install Referrer

> ⚠️ Required in SDK V7
>
> Starting with V7, the SDK declares this dependency as `compileOnly` internally, meaning it is no longer bundled with the SDK. You must add it explicitly to your app's `build.gradle`. Without it, Google Play referrer data will not be collected.

Add the following dependency to your `build.gradle`:

```groovy
dependencies {
    // ...
    implementation "com.android.installreferrer:installreferrer:2.2"
}
```

**Google Play Install Referrer ProGuard rules**

```groovy
-keep public class com.android.installreferrer.** { *; }
```

### Meta Install Referrer

Meta install referrer allows AppsFlyer to receive ad campaign metadata from a device's local storage.

#### Meta Install Referrer basic flow

1. Once the SDK initializes, it uses the app's Facebook App ID to make a request to the Meta Content Provider API, retrieving the stored metadata from the Facebook app.
2. AppsFlyer SDK sends the install event, along with the attribution data, to the AppsFlyer servers.

#### Prerequisites

To support the Meta install referrer, the following is required:

- **SDK**: Integrate with Android SDK version 6.12.6 or higher.
- **Facebook App Version**: Users must have version 428.x.x or above installed on their device.
- **Instagram App Version**: Users must have version 296.x.x or above installed on their device.

#### Configure Meta Install Referrer support

To enable Meta install referrer support, make the Facebook App ID available to the SDK by adding it to the `AndroidManifest.xml`. This can be done either when integrating the Facebook SDK with the app or when integrating the AppsFlyer SDK with the app.

**With Facebook SDK integrated**

Refer to [Facebook's official guide](https://developers.facebook.com/docs/android/getting-started#client-token) to learn how to add the Facebook App ID to `AndroidManifest.xml`. The SDK will read the Facebook App ID from the `meta-data` tag.

**Without Facebook SDK integration**

Include the following tag in `AndroidManifest.xml`:

```xml
<meta-data android:name="com.appsflyer.FacebookApplicationId" android:value="@string/facebook_application_id" />
```

Include in your `strings.xml` file:

```xml
<string name="facebook_application_id" translatable="false"><YOUR_FACEBOOK_APP_ID></string>
```

### Alternative store referrer modules

Samsung, Xiaomi, and Huawei store referrer support is no longer bundled in the main `af-android-sdk` artifact in SDK 7. If you distribute your app through any of these stores and need that referrer data, add the corresponding library as a separate Gradle dependency.

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
> - **Xiaomi / GetApps:** If you add `xiaomi-referrer`, you typically also need Xiaomi's GetApps Install Referrer client (`com.miui.referrer:homereferrer`) as a separate `implementation` dependency. That library is not part of the AppsFlyer BOM.
> - **Huawei / AppGallery:** If you add `huawei-referrer`, follow the AppsFlyer + Huawei AppGallery integration guide for Maven repositories and Huawei verification / HMS dependencies. Those are not part of the AppsFlyer BOM.
> - **Samsung:** For most apps, adding `samsung-referrer` is enough; merged manifest rules from the library cover the usual store integration.

---

## Collecting AppSet ID

<span class="annotation-optional">Optional</span>

Starting with **v6.17.0**, the SDK can automatically collect the [AppSet ID](https://developer.android.com/identity/app-set-id). To enable this functionality, add the Google Play services AppSet dependency to your module-level `build.gradle` file:

```groovy
dependencies {
    implementation 'com.google.android.gms:play-services-appset:16.1.0'
}
```

Once added, the SDK will collect the AppSet ID if it is available on the device. To disable AppSet ID collection, use `disableAppSetId()`.

---

## Google Play Integrity API

The SDK has built-in integration with Google Play Integrity API. This provides device integrity verification via Google Play. You can read more about it [here](https://support.google.com/googleplay/android-developer/answer/15299193).

If your app is distributed outside the Google Play Store, you can safely exclude this dependency by adding the following lines to your app's `build.gradle`:

```groovy
implementation ("com.appsflyer:af-android-sdk:HERE_SDK_VERSION") {
    exclude group: 'com.google.android.play', module: 'integrity'
}

// For example:
// implementation ("com.appsflyer:af-android-sdk:7.0.0") {
//      exclude group: 'com.google.android.play', module: 'integrity'
// }
```


## Known issues

### Boot Complete

If your app listens for `LOCKED_BOOT_COMPLETED`, make sure that all interactions with the SDK are initiated from the launcher activity. This precaution prevents the SDK from crashing when attempting to access `SharedPreferences` on a device that is still locked.