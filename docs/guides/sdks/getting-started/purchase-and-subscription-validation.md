---
title: Purchase and subscription validation
slug: purchase-and-subscription-validation
category:
  uri: AppsFlyer SDKs
parent:
  uri: getting-started
privacy:
  view: public
position: 10
---
Purchase validation ensures that only real, store-confirmed in-app purchases and subscriptions are measured in AppsFlyer. It improves revenue accuracy, helps prevent reporting errors, and supports better campaign decisions.

AppsFlyer offers two products to support purchase validation:

- **Receipt validation** – A free, lightweight solution for basic in-app purchase verification.
- **ROI360 Store revenue** – A premium, comprehensive solution for full revenue accuracy, including subscription lifecycle coverage and net revenue reporting.

For more information, see [Purchase and subscription validation](https://support.appsflyer.com/hc/en-us/articles/42120228484241--WIP-Purchase-and-subscription-validation-Overview).

## SDK Integration Methods

AppsFlyer supports two SDK integration methods for sending in-app purchase data to AppsFlyer for validation:

### 1. Manual Integration method – Validate and Log

Call Validate and Log (`validateAndLogInAppPurchase`) every time a transaction occurs in the app (such as an in-app purchase, subscription start, or trial start). The method sends the transaction to AppsFlyer, which validates it with the store and generates the relevant in-app event.

- Requires an explicit call from the app for every transaction
- Suitable for apps that need to capture events not included in the Purchase Connector's default coverage. With the Validate and log method, developers can explicitly target and send these additional events.

To get started see:

[block:html]
{
  "html": "<style>\n  .button-container {\n    display: flex;\n    max-width: 800px;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    min-width: 200px;\n    border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n    border: solid 2px #434446;\n  }\n  .button:before {\n    margin-right: 4px;\n  }\n  .ios:before {\n    content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\");\n  }\n  .android:before {\n    content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\");\n  }\n  .unity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\");\n  }\n  .flutter:before {\n    content: url(\"https://files.readme.io/1f70175-flutter-icon.svg\");\n  }\n  .cordova:before {\n    content: url(\"https://files.readme.io/5f757d6-apache_cordova-icon.svg\");\n  }\n  .capacitor:before {\n    content: url(\"https://files.readme.io/ad0d405-capacitor-icon.svg\");\n  }\n  .reactnative:before {\n    content: url(\"https://files.readme.io/3e1288d-reactnative-icon.svg\");\n  }\n  a[href*=http]:not([href*=\"dev.appsflyer.com\"]):not(.landing-page__social):after {\n    display: none !important;\n  }\n</style>\n<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-android\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-ios\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-unity\">Unity SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a target=\"_blank\" class=\"button flutter\" href=\"https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/API.md#validatePurchaseV2\">Flutter</a>\n  <a class=\"button reactnative\" href=\"https://dev.appsflyer.com/hc/docs/rn_api#validateAndLogInAppPurchaseV2\">React Native SDK</a>\n  <a class=\"button cordova\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cordova-plugin/blob/master/docs/API.md#-validateandloginapppurchasev2purchasedetails-additionalparameters-successc-failurec-void\">Cordova SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a class=\"button cocos2dx\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cocos2dx-plugin?tab=readme-ov-file#-validate-and-log-20-api\">Cocos2dx SDK</a>\n  <a class=\"button unreal\" href=\"https://github.com/AppsFlyerSDK/appsflyer-unreal-plugin/blob/master/docs/API.md#validate-and-log-in-app-purchase\">Unreal Engine</a>\n</div>"
}
[/block]

### 2. Automated Integration method – Purchase Connector

Purchase Connector automatically detects in-app purchases and subscriptions made on the device. Once initialized, it sends the required data to AppsFlyer without additional logging code.

- Supported only by ROI360 products and recommended for most apps
- Triggers validation automatically and returns the result to the client in real time
- The following capabilities cannot be supported through simple customization of the Validate and Log method and therefore require Purchase Connector:
    - Logging subscription revenue from users who subscribed before the integration was added.
    - Logging subscription price changes, ensuring revenue reflects updated pricing.

To get started see:

[block:html]
{
  "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-android\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-ios\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-unity\">Unity SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a target=\"_blank\" class=\"button flutter\" href=\"https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/PurchaseConnector.md\">Flutter</a>\n  <a class=\"button reactnative\" href=\"https://dev.appsflyer.com/hc/docs/rn_purchaseconnector\">React Native SDK</a>\n</div>"
}
[/block]

---
> ⚠️ Important
> 
> To avoid duplicate event logging and inconsistent validation results, it's recommended to use only one integration method per application.