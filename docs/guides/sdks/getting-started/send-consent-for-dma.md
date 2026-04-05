---
title: Send consent for DMA compliance
slug: send-consent-for-dma-compliance
category:
  uri: AppsFlyer SDKs
parent:
  uri: getting-started
privacy:
  view: public
position: 12
---
As part of the EU [Digital Marketing Act](https://commission.europa.eu/strategy-and-policy/priorities-2019-2024/europe-fit-digital-age/digital-markets-act-ensuring-fair-and-open-digital-markets_en) (DMA) legislation, big tech companies must get consent from European end users before using personal data from third-party services for advertising.

To comply with the legislation, Google requires AppsFlyer customers to include specific consent fields when sending events originating from EU end-users to Google. The AppsFlyer SDK (v6.13.0+) can collect and send the necessary consent data with each event to meet this requirement.

> 📘 Note
> 
> All EU countries are subject to GDPR and DMA, with the exception of the UK. The UK complies with GDPR but is not subject to the DMA.

See guides for the following platforms:
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

<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/android-send-consent-for-dma-compliance">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance">iOS SDK</a></div>
