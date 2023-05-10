---
title: "Conversion data"
slug: "conversion-data"
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
createdAt: "2021-05-12T10:50:55.001Z"
updatedAt: "2021-07-04T13:15:40.138Z"
---
Conversion data describes the channel(s) through which users got to your app.

The SDKs let you access this data in real-time for every app session. Once the data is available, you can:
 * Customize your app's logic and flow based on the returned data
 * Send the data to your servers for further processing

## Conversion data SDK guides
The following guides detail how to retrieve and process conversion data on various platforms.

<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/conversion-data-android">Android SDK</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/conversion-data-ios">iOS SDK</a>
</div>

<style>
  .button-container {
  	display: flex;
  }
  .button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 150px;
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
  .ios {
  	border-radius: 6px;
    padding: 8px;
    border: solid 2px #7D7D7D;
  }
  .ios:before {
        content: url("https://files.readme.io/19fdc72-apple-icon.svg");
  }

  .android:before {
        content: url("https://files.readme.io/d7dc5a3-android-icon.svg");
  }
</style>