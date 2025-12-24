---
title: "Purchase and subscription validation"
slug: "purchase-and-subscription-validation"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
order: 9
---

Purchase and subscription validation ensures that only real, store-confirmed in-app purchases and subscriptions are measured in AppsFlyer. It improves revenue accuracy, helps prevent reporting errors, and supports better campaign decisions.

> 📘 Note
> 
> For background information, see [Purchase and subscription validation](https://support.appsflyer.com/hc/en-us/articles/42120228484241--WIP-Purchase-and-subscription-validation-Overview) in the Knowledge Base.

AppsFlyer offers two products to support purchase validation:

- **Receipt validation** – A free, lightweight solution for basic in-app purchase verification.
- **ROI360 Store revenue** – A premium, comprehensive solution for full revenue accuracy, including subscription lifecycle coverage and net revenue reporting.




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
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/purchase-validation-android">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/purchase-validation-ios">iOS SDK</a>
  <!-- <a class="button unity" href="https://dev.appsflyer.com/hc/docs/purchase-connector-unity">Unity SDK</a> -->
</div>
<div class="button-container">
  <a target="_blank" class="button flutter" href="https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/PurchaseConnector.md">Flutter</a>
  <a class="button reactnative" href="https://dev.appsflyer.com/hc/docs/rn_purchaseconnector">React Native SDK</a>
</div>

