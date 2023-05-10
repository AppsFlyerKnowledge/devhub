---
title: "Android Deep Linking post user event"
slug: "dl_android_dl_post_event"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2023-05-04T14:40:50.447Z"
updatedAt: "2023-05-04T14:56:37.040Z"
---
## Overview
In some cases the user is required to go through some kind of an event before continuing to application page pointed by deep linking destination.
Examples for such user events:
1. Login process
2. Splash screen 
3. Consenting to usage terms.

## Implementation
In order to sync easily and safely between the user event and the deferred deep linking flow, it is recommended to [initiate](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#initializing-the-android-sdk) and [start](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#deferring-sdk-start) the SDK in the `activity context` where the user event is performed. For example, the view which implements the login process. This is different from the normal flow, where the SDK and initiated and started in the `application context`. 
The callbacks which are used in the [Extended Deferred Deep Linking](dl_android_ocds_ddl) flow should also be called in the `activity context`.
It is the developer's responsibility to save the deferred deep linking and direct deep linking data, route the user to the required destination only after the event is performed.

## Code example
In [this](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/tree/DDL_after_Login/java/basic_app) Github branch you can find a code sample which waits for a pseudo-user authencation before continuing to the deep linking destination. Once the authentication is verified, the user is directed to the destination. This flow is relevant for both deferred deep linking and direct deep linking (when the app is already installed).
You can see that the [application context](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/8dcb03c48199d5123e776463ae74e7dd274c6fdc/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L11) has no AppsFlyer SDK code. The AppsFlyer code moved entirely into the [activity](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/8dcb03c48199d5123e776463ae74e7dd274c6fdc/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/LoginActivity.java#L29) which perform the user event.