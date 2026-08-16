---
title: Setting the Customer User ID
slug: customer-user-id-android
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-android-6
privacy:
  view: public
position: 4
---
<span class="annotation-optional">Optional</span>  

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. It can be associated with in-app events if provided to the SDK. Once associated with the CUID, these events can be cross-referenced with user data from other devices and applications.

### Set the customer User ID

Once the CUID is available, you can set it by calling  [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid).

```java

...
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, conversionListener, this);  
AppsFlyerLib.getInstance().start(this , <YOUR_DEV_KEY> );
...
// Do your magic to get the customerUserID...
...
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

The CUID can only be associated with in-app events after it was set. Since `start` was called before `setCustomerUserID`, the install event will not be associated with the CUID. If you need to associate the install event with the CUID, see the below section.

### Associate the CUID with the install event

If it’s important for you to associate the install event with the CUID, you should set it before calling `start`. 

You can set the CUID before `start`  in two ways, depending on whether you start the SDK in the `Application` or the `Activity` class. 

**When starting from the application class**

If you started the SDK from the `Application` class (see: [`Starting the Android SDK`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk)) and you want the CUID to be associated with the install event, put the SDK in waiting mode to prevent the install data from being sent to AppsFlyer before the CUID is provided.

To activate the waiting mode, set [`waitForCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#waitforcustomeruserid) to `true` after [`init`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) and before [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).

> ⚠️ **Important**
> It's important to remember that putting the SDK in a waiting mode may block the SDK from sending the install event and consequently prevent attribution. This can occur, for example, when the user launches the application for the first time and then exits before the SDK can set the CUID. 

```java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
AppsFlyerLib.getInstance().start(this);
```

After calling [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start), you can add your custom code that makes the CUID available.

Once the CUID is available, the final step includes setting the CUID, releasing the SDK from the waiting mode, and sending the attribution data with the customer ID to AppsFlyer. This step is performed using the call to [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession).

```java
AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, this);
```

Other than [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession), do not use [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid) or any other AppsFlyer SDK functionality, as the waiting SDK will ignore it.

### Note

If you wish to remove the waiting mode from the SDK initialization flow, it is not enough to delete the call to `waitForCustomerUserId(true)`. It is also required to replace it with `waitForCustomerUserID(false)`. Simply removing the call is insufficient because the 'waitForCustomerUserId' boolean flag is stored in the Android Shared Preferences. 

**Example code**

```java
public class AFApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    AppsFlyerConversionListener conversionDataListener = 
    new AppsFlyerConversionListener() {
      ...
    };
    AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
    AppsFlyerLib.getInstance().waitForCustomerUserId(true);
    AppsFlyerLib.getInstance().start(this);
    // Do your magic to get the customerUserID
    // any AppsFlyer SDK code invoked here will be discarded
    // ...
    // Once the customerUserID is available, call setCustomerIdAndLogSession(). 
    // setCustomerIdAndLogSession() sets the CUID, releases the waiting mode,
    // and sends the attribution data with the customer ID to AppsFlyer.
    AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, this);
  }
}
```

**When starting from the Activity class**

If you started the SDK from an `Activity` (see: [`Deferring SDK start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#deferring-sdk-start)) class and you want the CUID to be associated with the install event, set the CUID before[`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).
