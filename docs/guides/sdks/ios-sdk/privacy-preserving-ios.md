---
title: "Preserve user privacy"
slug: "preserve-user-privacy-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
excerpt: "Learn how to preserve user privacy in the iOS SDK."
hidden: false
createdAt: "2024-01-07T19:00:15.000Z"
updatedAt: "2024-01-07T19:00:15.000Z"
order: 11
---
## Getting Started on Privacy Preservation

For a general introduction to privacy-preserving methods in the AppsFlyer SDK, see [Preserving user privacy](https://dev.appsflyer.com/hc/docs/preserve-user-privacy-1) (under Getting started).

## Use start to share only the install event

If you prefer to send only the install event and no additional information, you can invoke [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start), with a completion handler. Once you receive a success response indicating that the install event has been received, either set [`isStopped`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#isstopped)  or [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#anonymizeuser) to `true` in the completion handler. 

- [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#anonymizeuser) = true  sends data to AppsFlyer, but upon reaching AppsFlyer, all identifiers, including the IP address, are removed or hashed.
- [`isStopped`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#isstopped) = true reverts the [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start-1) call, thereby preventing the SDK from sending out any data to AppsFlyer.

```swift
AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
    if (error != nil){
        print(error ?? "")
        return
    } else {
        AppsFlyerLib.shared().isStopped = true
        return
    }
})
```

## Prevent sharing data with third parties

If you want to prevent sharing install and in-app event information with third parties such as SRNs and ad networks, use the [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#setsharingfilterforpartners) method before calling [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start).  Partners that are excluded with this method will not receive data through postbacks, APIs, raw data reports, or any other means.

**Note:** You can call [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#setsharingfilterforpartners) again if the user changes the app sharing settings (adding or removing partners) later in the session.  
For a code example please refer to [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#setsharingfilterforpartners).

## Anonymize user information

You can configure the SDK to instruct AppsFlyer to remove all user-identifying information by using the [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#anonymizeuser) method. In this case, the SDK sends install and in-app events to AppsFlyer, where all identifying information is then deleted or hashed:

- **Deleted:** personal identifiers (GAID, IDFA, IDFV, and CUID)
- **Hashed:** AppsFlyer ID and IP address.

To learn how to implement the method without anonymizing install events, see: [share only the install event](https://dev.appsflyer.com/hc/docs/preserve-user-privacy-2#share-only-the-install-event)

## Disable IDs

The SDK is capable of sending several specific identifiers to AppsFlyer. You can choose to exclude them in accordance to your needs. 

**Note:** Disabling the advertiser ID before calling start will prevent SRN attribution.

| Disable identifier                                                                                                               | Description                                                                                                                                         |
| -------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`disableAdvertisingIdentifier `](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#disableadvertisingidentifier) | Disables the collection of IDFA by the SDK (iOS 14 and below). From iOS 14.5, access to IDFA is managed by the App Tracking Transparency framework. |
| [`disableIDFVCollection`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#disableidfvcollection)                | Disables the collection of IDFV by the SDK.                                                                                                         |

## Send data only after the user opts-in

In cases where you would like to not send any data to AppsFlyer until the user gives consent, defer calling [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) until after the consent is given.