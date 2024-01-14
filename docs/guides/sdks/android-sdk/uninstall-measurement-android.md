---
title: "Uninstall measurement"
slug: "uninstall-measurement-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2022-03-16T10:04:32.183Z"
updatedAt: "2022-05-05T12:59:21.488Z"
order: 9
---
## Overview
Set up uninstall measurement in Android apps using AppsFlyer SDK and Firebase Cloud Messaging.

## Integrating uninstall measurement for Android
This document covers integration of uninstall measurement for the following scenarios:
* Apps that already use FCM
* Apps that don't use FCM.

The latest FCM client version can be found [here](https://firebase.google.com/docs/cloud-messaging/android/client).

### Apps using FCM
**To add uninstall measurement to an existing FCM integration:**
in the `onNewToken()` override, invoke `updateServerUninstallToken`:
``` java
@Override
public void onNewToken(String s) {
    super.onNewToken(s);
    // Sending new token to AppsFlyer
    AppsFlyerLib.getInstance().updateServerUninstallToken(getApplicationContext(), s);
    // the rest of the code that makes use of the token goes in this method as well
}
```

### Apps not using FCM
**To integrate uninstall measurement:**
1. Download `google-services.json` [from Firebase console](https://support.google.com/firebase/answer/7015592).
2. Add the `google-services.json` to the app module directory
3. Add the following dependencies to your root-level `build.gradle` file:
    ``` java
    buildscript { 
        // ... 
        dependencies { 
          // ... 
          classpath 'com.google.gms:google-services:4.2.0' // google-services plugin 
        } 
      }
    ```
4. In the app-level `build.gradle`, add the following dependencies:
    ```groovy
    dependencies {
        // ...
        implementation 'com.google.firebase:firebase-messaging:23.0.3'
        implementation 'com.google.firebase:firebase-core:20.1.2'
        // ...
    }
   ```
   **Note:** If you receive a "**Could not find method implementation()...**" error, make sure you have the latest Google Repository in the Android SDK Manager.
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/7d639a9-Screen_Shot_2022-04-17_at_12.01.34.png",
        "Screen Shot 2022-04-17 at 12.01.34.png",
        1169,
        47,
        "#3d3030"
      ]
    }
  ]
}
[/block]
5. **If you use FCM only to measure uninstalls in AppsFlyer**, use `appsFlyer.FirebaseMessagingServiceListener` service, embedded in the SDK. This extends the `FirebaseMessagingService` class, used to receive the FCM Device Token and calls `updateServerUninstallToken`. To add `appsFlyer.FirebaseMessagingServiceListener` service to the app:
    ```xml
    <application
       <!-- ... -->
          <service
            android:name="com.appsflyer.FirebaseMessagingServiceListener">
            <intent-filter>
              <action android:name="com.google.firebase.MESSAGING_EVENT"/>
            </intent-filter>
          </service>
       <!-- ... -->
    </application>
    ```
    Otherwise, override the `FirebaseMessagingService.onNewToken()` method and call `updateServerUninstallToken`:
    ``` java
    @Override
    public void onNewToken(String s) {
        super.onNewToken(s);
        // Sending new token to AppsFlyer
        AppsFlyerLib.getInstance().updateServerUninstallToken(getApplicationContext(), s);
        // the rest of the code that makes use of the token goes in this method as well
    }
    ```
[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "If you use Proguard, make sure to add the following rule:\n```java\n-dontwarn com.appsflyer.**\n-keep public class com.google.firebase.messaging.FirebaseMessagingService {\n    public *;\n}\n```"
}
[/block]

## Testing Android uninstall measurement
The testing procedure described is valid for apps available via Google Play Store, pending, direct download, and via alternative app stores.
* The **Uninstalls** metric is available in the Overview dashboard.
* The list of users who uninstall the app is available in the uninstalls [raw-data reports].(https://support.appsflyer.com/hc/en-us/articles/209680773-Raw-data-reporting-overview#user-journey-report-availability).

**To test Android uninstall measurement:**
1. Install the app.
2. Uninstall the app. You can uninstall the app immediately after installing it.
3. Wait for the uninstall to appear in the dashboard. This can take up to 48 hours.

## Considerations
* The uninstall event registers within 24 hours as uninstall measurement is processed [daily](https://support.appsflyer.com/hc/en-us/articles/360000310629-Data-freshness-and-time-zone-support#data-freshness-types).
* If the app is reinstalled during this time, **no uninstall event is recorded**.

## Overriding FCM's `onMessageReceived`
Overriding FCM's `onMessageReceived` method and implementing your own logic
in it might cause uninstall push notifications to not be silent. This can impact the user experience. To prevent this, verify that the message contains `af-uinstall-tracking`. See the following example:
``` java
@Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        
        if(remoteMessage.getData().containsKey("af-uinstall-tracking")){ // "uinstall" is not a typo
            return;
        } else {
           // handleNotification(remoteMessage);
        }
    }
```