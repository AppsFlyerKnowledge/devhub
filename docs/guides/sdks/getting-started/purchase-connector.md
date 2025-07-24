---
title: "Purchase connector"
slug: "purchase-connector"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
order: 9
---


**At a glance**: The AppsFlyer ROI360 purchase connector is used to validate and report in-app purchase and subscription revenue events. It’s part of the ROI360 in-app purchase and subscription revenue measurement solution.

> 📘 Note
>
> - Using the purchase connector requires an ROI360 subscription.
> - If you use this in-app purchase and subscription revenue measurement solution, you shouldn’t send [in-app purchase events](https://dev.appsflyer.com/hc/docs/in-app-events-sdk) with revenue or execute `validateAndLogInAppPurchase` ([Android](https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-android) [iOS](https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-ios)), as doing so results in duplicate revenue being reported.
> - Before implementing the purchase connector, the ROI360 in-app purchase and subscription revenue measurement needs to be integrated with Google Play and the App Store. [See instructions (steps 1 and 2)](https://support.appsflyer.com/hc/en-us/articles/7459048170769) 

## Overview

Use the purchase connector to validate and report in-app purchases (IAP) and subscription revenue events to measure:

- All revenue from in-app purchases of products and subscriptions managed through either App Store Connect (iOS) or Google Play Console (Android).
- Refunds.
- Pending and deferred transaction revenue (Android).
- Subscription-related events that happen inside or outside your app.

The IAP and subscription revenue solution also:
- Makes sure no duplicate transactions are recorded. For iOS, this also can also ensure that no duplications are recorded for family sharing.
- Allows AppsFlyer to forward Apple App Store transactions to you (the advertiser).
- Provides net revenue data, meaning net revenue data that takes into account store commission and taxes. 

The purchase and subscription data originates from:
- The AppsFlyer purchase SDK connector for Android and iOS (Unity wrapper included).
- App Store and Google Play (RTDN) server notifications sent to AppsFlyer.

Purchase and subscription revenue data is available via AppsFlyer dashboards and reports. They can also be shared with partners via postbacks.

## Flow

1. A user makes an in-app purchase or auto-renewable subscription.
2. The app makes a transaction in the app store.
3. The AppsFlyer purchase SDK connector automatically detects the purchase and sends its payload to AppsFlyer for validation and logging.
4. AppsFlyer validates the purchase with the relevant store to ensure it's not fraudulent.
  - Upon successful validation, AppsFlyer logs the purchase or subscription.
5. AppsFlyer transfers the response to the SDK connector, which in turn transfers the receipt validation response (success or fail) to the app.
6. Any incoming server notifications are also processed by the AppsFlyer purchase and subscription revenue business logic.
  - Notifications regarding transactions previously reported via the SDK connector are validated and processed, and result in the internal creation of a purchase or life cycle event.
  - Notifications regarding unknown transactions are dropped.
  - For iOS, all server notifications can be rerouted to your own servers.

## Implementation

The following links direct you to the purchase connector implementation for the various platforms.

Subscription revenue is able to start recording subscriber life cycle changes for existing subscribers as soon as they launch an app version that includes the purchase SDK connector.

<style>
  .button-container {
    display: flex;
    max-width:800px;

  }
  .button {
    display: flex;
    justify-content: center;
    align-items: center;
    min-width: 200px;
    border-radius: 6px;
    padding: 8px;
    margin-right: 4px;
   }
  .button:before {  
  	margin-right: 4px;  
  }
  .button {  
    border-radius: 6px;  
    padding: 8px;  
    border: solid 2px #434446;  
  }
  
  .ios:before {  
        content: url("https://files.readme.io/19fdc72-apple-icon.svg");  
  }
  .android:before {  
        content: url("https://files.readme.io/d7dc5a3-android-icon.svg");  
  }
 .unity:before {  
    content: url("https://files.readme.io/59acdf6-unity-icon.svg");  
 }
 .flutter:before {  
    content: url("https://files.readme.io/1f70175-flutter-icon.svg");  
 }
 a[href*=http]:not([href*="dev.appsflyer.com"]):not(.landing-page__social):after 
 {
    display:none !important;

 }
 .cordova:before {  
    content: url("https://files.readme.io/5f757d6-apache_cordova-icon.svg");  
 }
 .capacitor:before {  
    content: url("https://files.readme.io/ad0d405-capacitor-icon.svg");  
 }
 .reactnative:before {  
    content: url("https://files.readme.io/3e1288d-reactnative-icon.svg");  
 }
 a[href*=http]:not([href*="dev.appsflyer.com"]):not(.landing-page__social):after 
 {
    display:none !important;

 }
 
</style>
<div class="button-container">
<p>
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/purchase-connector-android">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/purchase-connector-ios">iOS SDK</a>
  <a class="button unity" href="https://dev.appsflyer.com/hc/docs/purchase-connector-unity">Unity SDK</a>
  <a target="_blank" class="button flutter" href="https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/feature/add_purchase_connector/doc/PurchaseConnector.md">Flutter</a>
  <a class="button reactnative" href="https://dev.appsflyer.com/hc/docs/rn_purchaseconnector">React Native SDK</a>
</p>
</div>
