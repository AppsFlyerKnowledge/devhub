---
title: "Preserve user privacy"
slug: "preserve-user-privacy"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
createdAt: "2024-01-07T19:00:15.000Z"
updatedAt: "2024-01-07T19:00:15.000Z"
order: 10
---
The SDK offers various privacy-preserving methods to manage the data sent to AppsFlyer from your app. These methods help to ensure that private information is not exposed without user consent and that user privacy is maintained in accordance with relevant data protection laws and regulations.

## Privacy-preserving methods: When, Who, and What to send

The SDK enables you to manage the information you send to AppsFlyer by providing methods that control:

- When to send user-level data
- Who receives user-level data
- What user-level data to send

### When to send user-level data

The SDK sends information about app installs and in-app events to AppsFlyer as soon as the `start` method is called. Privacy-preserving methods affect the availability of certain user-level event data depending on whether they are invoked before or after the `start` method call.

When `start` is called for the first time, the SDK sends the install event to AppsFlyer, along with the parameters required to attribute the installation to the correct media source. Therefore, invoking methods before calling `start` can prevent AppsFlyer from attributing the install event properly.  
So, if you want attribution to occur, avoid calling privacy-preserving methods before the `start` method. Instead, call them only after the install event has been sent to AppsFlyer. This approach ensures that the user's in-app events remain private while install attribution can still take place.

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

### Who receives user-level data

The ad networks and Self-Reporting Networks (SRNs) you partner with receive user-level information for attribution and optimization. However, you can employ a partner-sharing filter method to limit data sharing with some or all partners according to end-user preferences.

### What data to send

The SDK offers multiple methods to safeguard user-level data. The user anonymization method deletes or hashes all user-level identifiers, while other methods delete only specific types of identifiers. 

## Privacy-preserving methods guides


<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/preserve-user-privacy">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/preserve-user-privacy-2">iOS SDK</a></div>