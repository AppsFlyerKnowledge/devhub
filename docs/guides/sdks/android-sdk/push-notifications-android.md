---
title: "Push notifications"
slug: "push-notifications-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2022-04-24T11:55:17.726Z"
updatedAt: "2022-08-17T12:18:19.822Z"
order: 7
---
## Overview
The following guide covers the configuration of the Android SDK for processing incoming push notifications and sending extracted attribution data to AppsFlyer.

There are 2 methods of implementing the integration:
* By utilizing OneLink in the push payload (recommended method).
* By using plain JSON in the push payload (legacy method).

Choose the right method for you [based on how the marketer structures the push notification](https://support.appsflyer.com/hc/en-us/articles/207364076#1-creating-the-push-notification).

### Prerequisites
Before you continue, make sure you have:
1. An Android app with the [AppsFlyer SDK integrated](doc:integrate-android-sdk#initializing-the-android-sdk).
2. If implementing the [recommended OneLink-based solution](https://support.appsflyer.com/hc/en-us/articles/207364076#using-onelink-recommended), you need the name of the key inside the push notification payload that contains the OneLink (provided by the app marketer).

## Integrating AppsFlyer with Android push notifications using OneLink
<span class="annotation-recommended">Recommended</span>
This is the recommended method for implementing push notification measurement in the Android SDK.

**To integrate AppsFlyer with Android push notifications:**
In your `Application`, call `addPushNotificationDeepLinkPath` **before** calling `start`:
```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link");
```
In this example, the SDK is configured to look for the `af_push_link` key in the first level of the push notification payload.
When calling `addPushNotificationDeepLinkPath` the SDK verifies that:
- The required key exists in the payload.
- The key contains a valid OneLink URL.

> 📘 Note
> `addPushNotificationDeepLinkPath` accepts an array of strings too, to allow you to extract the relevant key from nested JSON structures. For more information, see [`addPushNotificationDeepLinkPath`](doc:android-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath).

## Integrating AppsFlyer with Android push notifications using JSON (legacy)
This is the [legacy method](https://support.appsflyer.com/hc/en-us/articles/207364076#using-json-legacy) for implementing push notification measurement in the Android SDK.

**To integrate AppsFlyer with Android push notifications using the legacy solution:**
In your deep-linked activity's `onCreate`, call `sendPushNotificationData`:
```java
public class MainActivity extends AppCompatActivity {
    // ...
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // ...
        if (getIntent().getExtras() != null) {            
            AppsFlyerLib.getInstance().sendPushNotificationData(this);
        }
        // ...
    }
}
```
The SDK expects to get the `af` key in the Intent's `extras` Bundle. If an `af` key is found, the SDK sends the value to AppsFlyer.