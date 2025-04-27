---
title: "Install SDK"
slug: "install-android-sdk"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Learn how to download and install the Android SDK."
hidden: false
createdAt: "2020-11-02T17:40:03.171Z"
updatedAt: "2022-11-03T13:09:22.572Z"
order: 2
---

## Recommended

[block:html]
{
  "html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Get started with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=install-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_install', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

Installing the Android SDK
--------------------------

Install the Android SDK using your preferred method: Via [Gradle](#install-using-gradle), or [manually](#manual-install).

### Install using Gradle

[block:html]
{
  "html": "<span class=\"annotation-recommended\">Recommended</span>"
}
[/block]

**Step 1: Declare repositories**  
In the Project `build.gradle` file, declare the `mavenCentral` repository:

```groovy
// ...
repositories {
   mavenCentral()
}
/// ...
```

**Step 2: Add dependencies**  
In the application `build.gradle` file, add the [latest Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) package:

```groovy
dependencies {
    // Get the latest version from https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk
    implementation 'com.appsflyer:af-android-sdk:<<HERE_LATEST_VERSION>>'
    // For example
    // implementation 'com.appsflyer:af-android-sdk:6.12.1'
}
```

### Manual install

[block:html]
{
  "html": "<details><summary></summary>\n<div class=\"af__accordion\">\n  <ol>\n    <li>In <strong>Android Studio</strong>, switch the folder structure from <strong>Android</strong> to <strong>Project</strong>:\n      <img src=\"https://files.readme.io/4954a02-android-to-project.gif\"/></li>\n    <li><a href=\"https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk\">Download the latest Android SDK</a> and paste it in your Android project, under <strong>app &gt; libs</strong>.</li>\n    <li>Right-click the <code class=\"rdmd-code lang-\">aar</code> you pasted and select <strong>Add As Library</strong>. When prompted, click <strong>Refactor</strong>. <p>If prompted to commit to git, click <strong>OK</strong></p></li></ol></div>\n</details>"
}
[/block]

Setting required permissions
----------------------------

Add the following permissions to `AndroidManifest.xml` in the `manifest` section:

```xml AndroidManfiest.xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package=YOUR_PACKAGE_NAME>

      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

      ...

</manifest>
```

### The AD_ID permission

In early 2022, Google announced a change to the behavior of Google Play Services and fetching of the Android Advertising ID. According to the [announcement](https://support.google.com/googleplay/android-developer/answer/6048248?hl=en), apps targeting Android 13 (API 33) and above must declare a Google Play services normal permission in their `AndroidManifest.xml` file in order to get access to the device’s Advertising ID.

Starting `V6.8.0`, the SDK adds the AD_ID permission automatically.

> 📘 Note
> 
> - If your app participates in the [Designed for Families](https://support.google.com/googleplay/android-developer/topic/9877766?hl=en&ref_topic=9858052) program:
>   - If using SDK `V6.8.0` and above, you should [Revoke the AD_ID permission](#revoking-the-ad_id-permission).
>   - If using SDK older than `V6.8.0`, don't add this permission to your app.
> - For apps that target API level 32 (Android 12L) or older, this permission is not needed.

Apps that use SDK versions **older** than `V6.8.0` and target Android 13 (API 33) and above must manually include the permission in their `AndroidManifest.xml` to have access to the Advertising ID:

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID" />
```

#### Revoking the AD_ID permission

According to [Google’s Policy](https://support.google.com/googleplay/android-developer/answer/11043825?hl=en), apps that target children must not transmit the Advertising ID. 

When using SDK `V6.8.0` and above, children apps targeting Android 13 (API 33) and above must prevent the permission from getting merged into their app by adding a revoke declaration to their Manifest:

```xml AndroidManifest.xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"
 tools:node="remove"/>
```

For more information, see [Google Play Services documentation](https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info#public-string-getid).

ProGuard rules
--------------

<span class="annotation-optional">Optional</span>  
If you are using ProGuard and you encounter a warning regarding our `AFKeystoreWrapper` class, then add the following code to your `proguard-rules.pro` file:

#### AppsFlyer SDK ProGuard rules

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.** { *; }
```
## Backup rules

The SDK's AndroidManifest.xml includes rules to opt out of backing up the Shared Preferences data. This is done to avoid retaining the same counters and AppsFlyer ID during reinstallation, thereby preventing the accurate detection of new installs or re-installs.

To merge the SDK backup rules with your app backup rules and to prevent conflicts, perform the following instructions for each use case. 

### Fix confilict with fullBackupContent=”true”

If you add `android:fullBackupContent="true"` in the `AndroidManifest.xml`, you might get the following error:

```
Manifest merger failed : Attribute application@fullBackupContent value=(true)
```

To fix this error, add `tools:replace="android:fullBackupContent"` in the `<application>` tag in the `AndroidManifest.xml` file.

### Fix conflict with dataExtractionRule=”true”

If you add `android:dataExtractionRules="true"` in the `AndroidManifest.xml`, you might get the following error:

```
Manifest merger failed : Attribute application@dataExtractionRules value=(true)

```

To fix this error, add `tools:replace="android:dataExtractionRules"` in the `<application>` tag in the `AndroidManifest.xml` file.

### Fix conflict with allowBackup=”false”

If you add `android:allowBackup="false"` in the `AndroidManifest.xml`, you might get the following error:

```
Error:
	Attribute application@allowBackup value=(false) from AndroidManifest.xml:
	is also present at [com.appsflyer:af-android-sdk:6.14.0] AndroidManifest.xml: value=(true).
	Suggestion: add 'tools:replace="android:allowBackup"' to <application> element at AndroidManifest.xml to override.

```

To fix this error, add `tools:replace="android:allowBackup”` in the `<application>` tag in the `AndroidManifest.xml` file.


### Merge backup rules in Android 12 and above

If you’re targeting **Android 12** and above, and you have your own backup rules specified (`android:dataExtractionRules="@xml/my_rules"`), in addition to the instructions above, please merge your backup rules with the AppsFlyer rules manually by adding the following rule:

```xml AndroidManfiest.xml
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

If you’re also targeting **Android 11** and lower, and you have your own backup rules specified (`android:fullBackupContent="@xml/my_rules"`), in addition to the instructions above, please merge your backup rules with the AppsFlyer rules manually by adding the following rule:

```xml AndroidManfiest.xml
<full-backup-content>
    ...//your custom rules
    <exclude domain="sharedpref" path="appsflyer-data"/>
</full-backup-content>

```


## Adding store referrer libraries
The AppsFlyer SDK supports several store referrer libraries. Using a store referrer improves attribution accuracy. 

You only need to add the referrer dependency, the SDK takes care of the rest.

### Google Play Install Referrer
Add the following dependency to your `build.gradle`:

```groovy Groovy 
dependencies {
    // ...
    implementation "com.android.installreferrer:installreferrer:2.2"
}
```

**Google Play Install Referrer ProGuard rules**

```groovy Groovy
-keep public class com.android.installreferrer.** { *; }
```

### Meta Install Referrer

Meta install referrer allows AppsFlyer to receive ad campaign metadata from a device’s local storage.

#### Meta Install Referrer basic flow

The basic flow of the Meta install referrer mechanism is as follows:

1. Once the SDK initializes, it uses the app's Facebook App ID to make a request to the Meta Content Provider API, retrieving the stored metadata from the Facebook app.
2. AppsFlyer SDK sends the install event, along with the attribution data, to the AppsFlyer servers.

#### **Prerequisites**

To support the Meta install referrer, the following is required:

- **SDK**: Integrate with Android SDK version 6.12.6 or higher.
- **Facebook App Version**: Users must have version 428.x.x or above installed on their device.
- **Instagram App Version**: Users must have version 296.x.x or above installed on their device.

#### Configure Meta Install Referrer Support

To enable Meta install referrer support make the Facebook App ID available to the SDK by adding it to the `AndroidManifest.xml`.  This can be done either when integrating the Facebook SDK with the app or when integrating the AppsFlyer SDK with the app.

##### With Facebook SDK integrated

Refer to [Facebook’s official guide](https://developers.facebook.com/docs/android/getting-started#client-token) to learn how to add the Facebook App ID to `AndroidManifest.xml`. The SDK will read the Facebook App ID from the `meta-data` tag. 

##### Without Facebook SDK integration

Include the following tag in `AndroidManifest.xml` 

```xml
<meta-data android:name="com.appsflyer.FacebookApplicationId" android:value="@string/facebook_application_id" />
```

Include in your `strings.xml` file:

```xml
<string name="facebook_application_id" translatable="false"><YOUR_FACEBOOK_APP_ID></string>
```

### Huawei Install Referrer

Huawei Referrer is supported in SDK v6.14.0 and above.
Due to changes in the Huawei AppGallery store, previous versions of the AppsFlyer SDK are not able to fetch the referrer from the store.

Add the following repository to your Project's `build.gradle`:

```groovy Groovy 
repositories {
    //...
    maven { url 'https://developer.huawei.com/repo/' }
}
```

Add the following dependency in the app's `build.gradle`:

```groovy Groovy 
dependencies {
    // ...
    implementation 'com.huawei.hms:componentverifysdk:13.3.1.301'
}

```

If you are using ProGuard, add the following keep rules to your `proguard-rules.pro` file:

```groovy
-keep class com.huawei.hms.**{*;}
```


### Xiaomi GetApps store referrer
<span class="annotation-added">V6.9.0</span>
Add the following dependency to your `build.gradle`:

```groovy Groovy
dependencies {
  // ...
  implementation "com.miui.referrer:homereferrer:1.0.0.6"
}
```

**Xiaomi GetApps store referrer ProGuard rules**

```groovy Groovy
-keep public class com.miui.referrer.** {*;}
```
[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "Samsung store referrer is supported out-of-the-box starting SDK `V6.1.1` and does not require any additional integration."
}
[/block]

## Collecting AppSet ID

Starting with **v6.17.0**, the SDK can automatically collect the [AppSet ID](https://developer.android.com/identity/app-set-id).  
To enable this functionality, add the Google Play services AppSet dependency to your module-level `build.gradle` file:

```groovy
dependencies {
    implementation 'com.google.android.gms:play-services-appset:16.1.0'
}
```

Once added, the SDK will collect the AppSet ID if it is available on the device.  
To disable AppSet ID collection, use the [`disableAppSetId()`](doc:android-sdk-reference-appsflyerlib#disableappsetid).

Known issues
------------

### Missing resource files

<span class="annotation-deprecated">SDK V5</span>  
If you are using Android SDK V5 and above, make sure that in the APK file, in addition to the `classes.dex` and resources files, you also have a **com > appsflyer > internal**  folder with files `a-` and `b-` inside.  
Note: Before SDK 5.3.0, file names are `a.` and `b.`

Check that you have the required files by opening your APK in Android Studio:

![](https://files.readme.io/9969b81-image_with_dash.png "image_with_dash.png")

If those files are missing, the SDK can't make network requests to our server, and you need to contact your CSM or support.

### Boot Complete

If your app listens for `LOCKED_BOOT_COMPLETED`, make sure that all interactions with the SDK are initiated from the launcher activity. This precaution prevents the SDK from crashing when attempting to access `SharedPreferences` on a device that is still locked.
