---
title: "Android initial setup"
slug: "dl_android_init_setup"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2022-11-30T10:30:22.647Z"
updatedAt: "2023-04-27T06:38:09.782Z"
---
**At a glance**: The initial app setup enables the marketer to create links that send existing app users directly into the app. The initial setup is also a prerequisite for deep linking and deferred deep linking.

## App opening methods

There are two app opening methods that can be implemented to cover your entire user base. The method used depends on the mobile platform version.

The two methods and instructions for implementation are described in detail in the following sections.

| Method | Description | Android Versions | Procedure |
| --- | --- | --- | --- |
| **Android App Links** | Directly opens the mobile app at the default activity. | Android V6+| <ol><li>[Generate SHA256 fingerprint.](#generating-a-sha256-fingerprint)</li><li> [Add intent-filter to main activity.](#adding-app-link-intent-filter-to-main-activity)</li></ol>|
| **URI Scheme** | Directly opens the app based on the activity path specified in the URI scheme. | Android all versions | <ol><li>[Decide on a URI scheme with the marketer.](#deciding-on-a-uri-scheme) </li><li> [Add intent-filter to main activity.](#adding-uri-scheme-intent-filter-to-the-main-activity) </li><li> [Testing](#testing-uri-schemes) </li></ol>| 

## Procedures for Android App Links
Android App Links work with Android V6 and above. [Learn more](https://support.appsflyer.com/hc/en-us/articles/115005314223).

### Generating a SHA256 fingerprint

**To generate the SHA256 fingerprint:**

1. Locate your [app's keystore](https://developer.android.com/training/articles/keystore).
If the app is in still in development, locate the `debug.keystore`
   * For Windows user: `C:\Users\USERNAME\.android\debug.keystore`
   * For Linux or Mac OS user: `~/.android/debug.keystore`
2. Open the command line and navigate to the folder where the keystore file is located.
3. Run the command:
    
```shell
keytool -list -v -keystore [APK-KEY].keystore
```

> 🚧 
>
> The password for the debug.keystore is usually \"android\".

The output should look like this:

```text 
Alias name: test
Creation date: Sep 27, 2017
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=myname
Issuer: CN=myname
Serial number: 365ead6d
Valid from: Wed Sep 27 17:53:32 IDT 2017 until: Sun Sep 21 17:53:32 IDT 2042
Certificate fingerprints:
MD5: DB:71:C3:FC:1A:42:ED:06:AC:45:2B:6D:23:F9:F1:24
SHA1: AE:4F:5F:24:AC:F9:49:07:8D:56:54:F0:33:56:48:F7:FE:3C:E1:60
SHA256: A9:EA:2F:A7:F1:12:AC:02:31:C3:7A:90:7C:CA:4B:CF:C3:21:6E:A7:F0:0D:60:64:4F:4B:5B:2A:D3:E1:86:C9
Signature algorithm name: SHA256withRSA
Version: 3
Extensions:
#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
  KeyIdentifier [
   0000: 34 58 91 8C 02 7F 1A 0F  0D 3B 9F 65 66 D8 E8 65 
   0010: 74 42 2D 44                    
 ]
]
```

4. Send the SHA256 back to the marketer. 

### Adding App Link intent-filter to main activity

**To add the intent-filter to the main activity:**

1. Get the auto-generated intent-filter code from the [marketer](https://support.appsflyer.com/hc/en-us/articles/207032246#add-redirection-logic-for-existing-app-users). The intent-filter code is used in the AndroidManifest.XML. 
2. Open the app's `AndroidManifest.xml` file.
3. Add the intent-filter to the **main activity**.
If there already is an intent-filter for the Android App Link in the main activity, overwrite it. 

#### Example

```xml XML
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />

    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:host="onelink-basic-app.onelink.me"
        android:scheme="https" />
</intent-filter>
```

> ℹ️
>
> When `android:autoVerify="true"` is present on any of your intent filters, installing your app on devices with Android 6 and higher causes the system to attempt to verify all hosts associated with the URLs in any of your app's intent filters. 
> For each unique host name found in the above intent filters, Android queries the corresponding websites for the Digital Asset Links file at `https://hostname/.well-known/assetlinks.json`. Once the OneLink is created, AppsFlyer creates and hosts this path for you. You can test the App Links configuration using the [AppsFlyer link validator](https://www.appsflyer.com/tools/link-validator/). 
> [Learn more](https://developer.android.com/training/app-links/verify-site-associations#request-verify)

Github link: [XML](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/AndroidManifest.xml#L39-L49)

4. Tell the marketer that the App Link configuration is completed.
When the marketer tests the link, it should direct the user to the app's main page.

## Procedures for URI Scheme

A URI scheme is a URL that leads users directly to the mobile app. 

When an app user enters a URI scheme in a browser address bar, or clicks on a link based on a URI scheme, the app launches, and the user is deep linked.

Whenever an App Link fails to open the app, the URI scheme can be used as a fallback to open the application.

### Deciding on a URI scheme

**To decide on a URI scheme:**
1. Contact the marketer and iOS developer. 
2. Choose a URI scheme. For example: `yourappname://`
> ℹ️
>
> * Use a URI scheme that is as unique as possible to your app and brand to avoid coincidental overlap with other apps in the ecosystem. Overlap with other apps is an inherent issue in the nature of URI scheme protocol.
> * The URI scheme should not start with *http* or *https*.
> * The URI scheme should be similarly defined on Android and iOS.

3. Send the URI scheme to the marketer. For example: `afshopapp://mainactivity` 

### Adding URI scheme intent-filter to the main activity

**To add the intent-filter to the main activity:**

1. Open the app's `AndroidManifest.xml` file.
2. Add the following intent-filter to the **main activity**.
In the `data` section, replace `host` and `scheme` with the URI scheme you chose. In the intent-filter code below, `host="mainactivity"` and `scheme="afshopapp"`, matching the URI scheme `afshopapp://mainactivity`.
If there already is an intent-filter for the URI scheme in the main activity, overwrite it.

```xml XML
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />

    <data
        android:host="mainactivity"
        android:scheme="afshopapp" />
</intent-filter>
```

⇲ Github link: [XML][uri_intent_filter]

3. Give the URI scheme to the marketer.

[uri_intent_filter]: https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/AndroidManifest.xml#L29-L38

### Testing URI schemes

**Prerequisites**:

An Android device with the app installed. Make sure it is the app source and version where you made changes and implemented App Links and/or a URI scheme.

**To test the URI scheme**:

1. Contact the marketer and get the custom link they created.
2. Send the short or long URL the marketer gives you to your phone. You can either:
   * Scan the QR code with your phone camera or QR scanner app.
   * Email or WhatsApp yourself the link, and open it on your phone.
3. Click the link on your mobile device.
The app should open to its home screen.

[1]: https://support.appsflyer.com/hc/en-us/articles/207033836?__hstc=215508872.986091deeadbd815ef04121e1d880589.1586684365062.1591196345127.1591212728952.29&__hssc=215508872.2.1591212728952&__hsfp=3667076369 "Title"