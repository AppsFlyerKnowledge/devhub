---
title: "Integration testing"
slug: "integration-testing"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
createdAt: "2021-08-01T14:48:25.376Z"
updatedAt: "2021-12-26T11:09:53.081Z"
order: 3
---
## Overview
After completing the [SDK integration](doc:sdk-integration), it's recommended to test it. Testing ensures accurate and comprehensive data collection and delivery.

## Testing the integration 
Testing verifies that the SDK:
 * Starts and successfully establishes a connection to AppsFlyer, with no networking/authentication issues.
 * Relays attribution data correctly.

It's performed by:
 1. creating an AppsFlyer attribution link and using it to simulate a user clicking an ad.
 2. Installing the app on a [registered test device](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).
 3. Inspecting the conversion data.
[block:html]
{
  "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/testing-android#test-android-sdk-integration\">Test Android SDK integration</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/testing-ios#test-ios-sdk-integration\">Test iOS SDK integration</a>\n</div>\n\n<style>\n  .button-container {\n  \tdisplay: flex;\n  }\n\n  .button {\n  \tmargin: 4px;\n  }\n  \n  .button:before {\n  \tmargin-right: 4px;\n  }\n  .ios:before {\n        content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\");\n  }\n\n  .android:before {\n        content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\");\n  }\n</style>"
}
[/block]
## Debug apps
To avoid mixing production data with test conversions and in-app events, you can test the SDK integration using a debug app.

Debug apps differ from production apps in that they:
 1. Have a different app ID.
 2. Have their own instance in the AppsFlyer dashboard.
 3. Are not published to app stores.

Creating debug apps involves adjusting your app build configurations and adding a new app in the dashboard, to be used for testing purposes.

[block:html]
{
  "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/testing-android#creating-an-android-debug-app\">Android debug app</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/testing-ios#creating-an-ios-debug-app\">iOS debug app</a>\n</div>\n"
}
[/block]