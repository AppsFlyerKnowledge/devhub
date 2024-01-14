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
Before you begin
----------------

You need [Android Studio](https://developer.android.com/studio) to follow along with these guides.

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
    // implementation 'com.appsflyer:af-android-sdk:6.12.1>> 
}
```

### Manual install

[block:html]
{
  "html": "<details><summary></summary>\n<div class=\"af__accordion\">\n  <ol>\n    <li>In <strong>Android Studio</strong>, switch the folder structure from <strong>Android</strong> to <strong>Project</strong>:\n      <img src=\"https://files.readme.io/4954a02-android-to-project.gif\"/></li>\n    <li><a href=\"https://s3-eu-west-1.amazonaws.com/download.appsflyer.com/Android/AF-Android-SDK.jar\">Download the latest Android SDK</a> and paste it in your Android project, under <strong>app &gt; libs</strong>.</li>\n    <li>Right-click the <code class=\"rdmd-code lang-\">jar</code> you pasted and select <strong>Add As Library</strong>. When prompted, click <strong>Refactor</strong>. <p>If prompted to commit to git, click <strong>OK</strong></p>.\n  <img src=\"https://files.readme.io/70420f4-add-jar-manually.gif\"/></li>\n  </ol>\n</div>\n</details>"
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
  "body": "Huawei and Samsung store referrers are supported out-of-the-box starting SDK `V6.1.1` and do not require any additional integration."
}
[/block]
Known issues
------------

### Backup rules

If you add `android:fullBackupContent="true"` inside the <application> tag in the `AndroidManifest.xml`, you might get the following error:

```
Manifest merger failed : Attribute application@fullBackupContent value=(true)
```

To fix this error, add tools:replace="android:fullBackupContent" in the `<application>` tag in the `AndroidManifest.xml` file.

If you have your own backup rules specified (`android:fullBackupContent="@xml/my_rules"`), in addition to the instructions above, please merge them with AppsFlyer rules manually by adding the following rule:

```
<full-backup-content>
    ...//your custom rules
    <exclude domain="sharedpref" path="appsflyer-data"/>
</full-backup-content>
```

### Missing resource files

<span class="annotation-deprecated">SDK V5</span>  
If you are using Android SDK V5 and above, make sure that in the APK file, in addition to the `classes.dex` and resources files, you also have a **com > appsflyer > internal**  folder with files `a-` and `b-` inside.  
Note: Before SDK 5.3.0, file names are `a.` and `b.`

Check that you have the required files by opening your APK in Android Studio:

![](https://files.readme.io/9969b81-image_with_dash.png "image_with_dash.png")

If those files are missing, the SDK can't make network requests to our server, and you need to contact your CSM or support.

### Boot Complete

If your app listens for `LOCKED_BOOT_COMPLETED`, make sure that all interactions with the SDK are initiated from the launcher activity. This precaution prevents the SDK from crashing when attempting to access `SharedPreferences` on a device that is still locked.