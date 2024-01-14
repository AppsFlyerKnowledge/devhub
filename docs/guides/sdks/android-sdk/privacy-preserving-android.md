---
title: "Preserve user privacy"
slug: "preserve-user-privacy-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Learn how to preserve user privacy in the Android SDK."
hidden: false
createdAt: "2024-01-07T19:00:15.000Z"
updatedAt: "2024-01-07T19:00:15.000Z"
order: 12
---

# Preserve user privacy

For a general introduction to privacy-preserving methods in the AppsFlyer SDK, see [Preserving user privacy](https://dev.appsflyer.com/hc/docs/preserve-user-privacy-1) (under Getting started).

## Use start to share only the install event

If you prefer to send only the install event and no additional information, you can invoke `start` with a request callback. Upon receiving a success message confirming that the install event has been logged, you should then call `stop` or `anonymizeUser` from within the callback function.

- [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#anonymizeuser) sends data to AppsFlyer; however, upon its arrival to AppsFlyer servers, all identifiers (including IP address) are either deleted or hashed.
- The `stop` method reverts the `start` call, which means that the SDK stops sending any data to AppsFlyer.

```java
appsflyer.start(getApplicationContext(), null, new AppsFlyerRequestListener() {
    @Override
    public void onSuccess() {
        Log.d(LOG_TAG, "Launch sent successfully, got 200 response code from server");
        appsflyer.stop(true, getApplicationContext());
    }

    @Override
    public void onError(int i, @NonNull String s) {
        Log.d(LOG_TAG, "Launch failed to be sent:\n" +
                "Error code: " + i + "\n"
                + "Error description: " + s);
    }
});
```

## Prevent sharing data with third parties

If you want to prevent sharing install and in-app event information with third parties such as SRNs and ad networks, use the `setSharingFilterForPartners` method before calling `start`. Partners that are excluded with this method will not receive data through postbacks, APIs, raw data reports, or any other means.  
mention attribution impact

**Note:** You can call [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setsharingfilterforpartners) again if the user changes the app sharing settings (adding or removing partners) later in the session.  
For a code example please refer to [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setsharingfilterforpartners).

## Anonymize user information

You can configure the SDK to instruct AppsFlyer to remove all user-identifying information by using the [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#anonymizeuser) method. In this case, the SDK sends install and in-app events to AppsFlyer, where all identifying information is then deleted or hashed:

- **Deleted:** personal identifiers (GAID, IDFA, IDFV, and CUID)
- **Hashed:** AppsFlyer ID and IP address.

To learn how to implement the method without anonymizing install events, see: [Share only the install event](https://dev.appsflyer.com/hc/docs/preserve-user-privacy#share-only-the-install-event).

## Disable IDs

The SDK is capable of sending several specific identifiers to AppsFlyer. You can choose to exclude them in accordance to your needs. 

**Note:** Disabling the advertiser ID before calling start will prevent SRN attribution.

| Disable identifier                                                                                                                                | Description                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| [`setDisableAdvertisingIdentifiers`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setdisableadvertisingidentifiers)(true) | Disables collection of various Advertising IDs by the SDK. This includes Google Advertising ID (GAID), OAID, and Amazon Advertising ID (AAID). |
| [`setCollectOaid`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcollectoaid)(false)                                    | Disables the collection of OAID by the SDK.                                                                                                    |

## Send data only after the user opts-in

In cases where you would like to not send any data to AppsFlyer until the user gives consent, defer calling [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start) until after the consent is given.