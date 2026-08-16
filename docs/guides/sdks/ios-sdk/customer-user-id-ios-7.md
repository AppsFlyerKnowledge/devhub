---
title: Setting the Customer User ID
slug: customer-user-id-ios-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-ios-7
privacy:
  view: public
position: 4
---
<span class="annotation-optional">Optional</span>

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. If made available to the SDK, it can be associated with installs and other in-app events. These CUID-tagged events can be cross-referenced with user data from other devices and applications.

### Set the CUID

To set the CUID:

```objc Objective-C
[AppsFlyerLib shared].customerUserID = @"my user id";
```
```swift Swift
AppsFlyerLib.shared().customerUserID = "my user id"
```

> 📘 Note
>
> The Customer User ID must be set with every app launch.

### Associate the CUID with the install event

If you need the CUID to be associated with the install event, set it before calling `start`. In SDK V7, since you control when `start` is called, set the CUID inside your `registerSessionReadyListener` callback before calling `start`.

### Send SKAN and AdAttributionKit postback copies to AppsFlyer

If your app uses both `SKAdNetwork` and `AdAttributionKit`, configure both postback copy endpoints in the `Info.plist` file.

#### Send SKAN postback copies to AppsFlyer

Use this setup to send SKAdNetwork postback copies to AppsFlyer.

1. Add the `NSAdvertisingAttributionReportEndpoint` key to your app's `info.plist`.
2. Set the key's value to `https://appsflyer-skadnetwork.com/`.

Once configured, Apple will send SKAdNetwork postback copies to AppsFlyer. Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).

#### Send AdAttributionKit postback copies to AppsFlyer

Use this setup to send AdAttributionKit postback copies to AppsFlyer.

1. In your app's Info.plist, add a new key.
2. Type the key name `AdAttributionKit` and select `AdAttributionKit - Postback Copy URL` from the pop-up menu.
3. Set the key's value to `https://appsflyer-skadnetwork.com/`.

Once configured, Apple will send AdAttributionKit postback copies to AppsFlyer. Copies of received postbacks are available in the [postbacks copy report](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).
