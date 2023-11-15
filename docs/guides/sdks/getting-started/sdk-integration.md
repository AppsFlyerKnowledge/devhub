---
title: "SDK integration"
slug: "sdk-integration"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
excerpt: "Links to SDK integration instructions for various supported platforms."
hidden: false
createdAt: "2021-05-11T13:18:59.767Z"
updatedAt: "2021-09-05T08:19:48.040Z"
order: 2
---
AppsFlyer SDK integration instructions for various platforms. By integrating the SDK, you get [app attribution](https://support.appsflyer.com/hc/en-us/articles/207447053#what-is-attribution%C2%A0) out-of-the-box.

Integrating the SDK consists of:
 * Initializing the SDK
 * Starting the SDK

## Before you begin
Make sure you've [installed the SDK](doc:sdk-installation).

## SDK integration guides
<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/integrate-android-sdk">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/integrate-ios-sdk">iOS SDK</a>
  <a class="button unity" href="https://dev.appsflyer.com/hc/docs/basicintegration">Unity plugin</a>
  <a class="button reactnative" href="https://dev.appsflyer.com/hc/docs/react-native-plugin">React Native plugin</a>
</div>

<style>
  .button-container {
  	display: flex;
  }
  .button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 200px;
	  border-radius: 6px;
    padding: 8px;
    margin-right: 4px;
	}
  .button:before {  
  	margin-right: 4px;  
  }
  .button.android {  
    border: solid 2px #3DDC84;  
  }
  .button.reactnative {  
    border: solid 2px #FF8C00;  
  }
  .button.ios {  
  	border-radius: 6px;  
    padding: 8px;  
    border: solid 2px #7D7D7D;  
  }
   .button.unity {  
    border: solid 2px #3DDC84;  
    border-color: var(--project-primary-color);  
  }
  .ios:before {  
        content: url("<https://files.readme.io/19fdc72-apple-icon.svg")>;  
  }
  .android:before {  
        content: url("<https://files.readme.io/d7dc5a3-android-icon.svg")>;  
  }
.unity:before {  
    content: url("<https://files.readme.io/59acdf6-unity-icon.svg")>;  
}
.reactnative:before {  
   content: url("<https://files.readme.io/3e1288d-reactnative-icon.svg")>;  
}
.flutter:before {  
    content: url("<https://files.readme.io/1f70175-flutter-icon.svg")>;  
}  
</style>
## Debug mode
<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode">iOS SDK</a>
</div>