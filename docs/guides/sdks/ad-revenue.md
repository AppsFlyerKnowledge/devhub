---
title: "Ad revenue"
slug: "ad-revenue"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
order: 8
---
Ad revenue from partners can be reported to AppsFlyer with impression-level granularity via SDK. Impression-level data via SDK:

- Has better data freshness and earlier availability in AppsFlyer.
- Supports SKAN. 

The AppsFlyer SDK sends impression revenue data to AppsFlyer. The impression revenue data is collected and processed in AppsFlyer, and the revenue is attributed to the original UA source.

> 📘 Note
> 
> If your Ad Revenue implementation predates SDK v6.15.0, and you want to upgrade, update your ad revenue code as specified in the guides below. Failing to do so will result in the Ad Revenue functionality not working correctly.

AppsFlyer ad revenue instructions for various platforms:

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
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/ad-revenue-1">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/ad-revenue-2">iOS SDK</a>
  <a class="button unity" href="https://dev.appsflyer.com/hc/docs/ad-revenue-unity">Unity SDK</a>
  <a class="button reactnative" href="https://dev.appsflyer.com/hc/docs/rn_api#logadrevenue">React Native SDK</a>
</div>
<div class="button-container">
  <a target="_blank" class="button flutter" href="https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/API.md#-void-logadrevenueadrevenuedata-adrevenuedata">Flutter</a>
  <a target="_blank" class="button cordova" href="https://github.com/AppsFlyerSDK/appsflyer-cordova-plugin/blob/master/docs/API.md#logAdRevenue">Cordova</a>
  <a target="_blank" class="button capacitor" href="https://github.com/AppsFlyerSDK/appsflyer-capacitor-plugin/blob/main/docs/API.md#logadrevenue">Capacitor</a>
  <a target="_blank" class="button cocos2dx" href="https://github.com/AppsFlyerSDK/appsflyer-cocos2dx-plugin?tab=readme-ov-file#logAdrevenue">Cocos2dx</a>
</div>