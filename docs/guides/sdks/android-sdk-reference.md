---
title: "Android SDK reference"
slug: "android-sdk-reference"
category: 5f9705393c689a065c409b23
excerpt: "The AppsFlyer Android SDK reference documentation."
hidden: false
---
## Overview
This is the Android SDK reference document. In this section you will find technical descriptions of classes and methods that comprise the SDK.

Need to implement specific capabilities? See the [SDK guides](doc:android-sdk).

## Package hierarchy
 * `com.appsflyer`
    * [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib): This class contains most of the SDK functionality.
    * [`DeepLinkListener`](doc:android-sdk-reference-deeplinklistener): A public interface that holds the callback method for [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).
    * [`DeepLink`](doc:android-sdk-reference-deeplink): Object that holds the deep link data.
    * [`DeepLinkResult`](doc:android-sdk-reference-deeplinkresult): A public class that holds the result of a deep link resolution. If successful, it holds the deep link data.
    * [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener): A public interface that lets you listen to [conversions](https://dev.appsflyer.com/hc/docs/conversion-data-android).
    * [`AppsFlyerInAppPurchaseValidatorListener`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener): Interface that handles purchase validation success and failure.
    * `attribution`
      * [`AndroidRequestListener`](doc:android-sdk-reference-appsflyerrequestlistener): Interface that gets results of requests to AppsFlyer servers.
    * `share`
      * [`CrossPromotionHelper`](doc:android-sdk-reference-sharecrosspromotionhelper): Android SDK cross-promotion helper class.
      * [`ShareInviteHelper`](doc:android-sdk-reference-shareinvitehelper): Helper class to create user invite URLs.
      * [`LinkGenerator`](doc:android-sdk-reference-linkgenerator): Object used to create single-platform and OneLink URLs.

## SDK connectors
 * [`AppsFlyerAdRevenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue): The parent class for the ad revenue SDK.