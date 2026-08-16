---
title: Setting the Customer User ID
slug: customer-user-id-android-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-android-7
privacy:
  view: public
position: 4
---
<span class="annotation-optional">Optional</span>

The Customer User ID (CUID) is a unique user identifier created by the app owner outside the SDK. The CUID lets app owners follow user journeys across different devices.

### Set the Customer User ID

Once the CUID is available, set it by calling [`setCustomerUserId`](doc:android-sdk-reference-appsflyerlib#setcustomeruserid):

```java Java
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

The CUID can only be associated with in-app events after it has been set. If `start` was called before `setCustomerUserId`, the install event will not be associated with the CUID. To associate the install event with the CUID, see below.

> 📘 Note
>
> In SDK V7, setter values are not persisted between sessions. Re-apply `setCustomerUserId` on every cold start.

### Associate the CUID with the install event

If you need the CUID to be associated with the install event, set it before calling `start()`.

In SDK V7, this is straightforward: since you control when `start()` is called, set the CUID inside your session ready listener callback, before calling `start()`:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
    AppsFlyerLib.getInstance().start();
});
```
```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>)
    AppsFlyerLib.getInstance().start()
}
```

> 📘 Note
>
> The `waitForCustomerUserId` and `setCustomerIdAndLogSession` APIs have been removed in SDK V7. The new session model makes them unnecessary: since you control when `start()` is called, there is no need for a waiting mechanism.
