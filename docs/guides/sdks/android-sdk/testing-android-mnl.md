---
title: "Manual testing"
slug: "manual-testing-android"
category: 5f9705393c689a065c409b23
parentDoc: 645bca51a6baa4286ef83a43
hidden: true 
order: 0
---

> 📘 **Note**
>
> We recommend using our [SDK wizard integration tool](https://dev.appsflyer.com/hc/docs/manual-testing-android) for testing

To successfully complete the tests in this document, you must:

- [Integrate the SDK](doc:integrate-android-sdk)
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).

## Test Android SDK integration
----------------------------

The test consists of:

1. Simulating an ad click and a conversion.
2. [Inspecting the conversion data](#inspect-conversion-data) of the install.

### Simulate a conversion

Simulate a user clicking an ad and installing the app.

**Step 1: Simulate ad click**  
Simulate an ad click via an attribution link. Structure the attribution link as follows:

```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&advertising_id=<registered_device_gaid>
```

Where:

- `app_id` is your AppsFlyer app ID.
- `pid` is the [media source](https://support.appsflyer.com/hc/en-us/articles/212188826) to which the install should be attributed.
- `advertising_id` is the registered device's GAID.

The `advertising_id` parameter is required to attribute via [ID matching](https://support.appsflyer.com/hc/en-us/articles/207447053#device-id-matching). If omitted, attribution will occur [probabilistically](https://support.appsflyer.com/hc/en-us/articles/207447053#probabilistic-modeling).

For example, if your app ID is `com.my.app`, the attribution link might look like this:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1
```

or, with GAID:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1&advertising_id=********-****-****-****-************
```

> 👍 Tip
> 
> Often, tests using attribution links are performed more than once. That's why it's recommended to use one of the attribution parameters to "version" your tests–it makes it easier to understand which link triggered which conversion.
> 
> In the above example, the value of `c` is `test1`. In consecutive tests, increment the value of `c` to `test2`, `test3`, and so on.

**Step 2: Install the app**  
[Enable debug mode](doc:integrate-android-sdk#enabling-debug-mode) and install the app on a [registered test device](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).

**Step 3: Execute test**  
Proceed to [inspect conversion data](#inspect-conversion-data).

### Inspect conversion data

After simulating a conversion, follow these steps to inspect the install's conversion data.

**Step 1: Retrieve install UID**  
Once the app is installed, search the debug logs for `conversions.appsflyer`

![](https://files.readme.io/bd951f1-android-uid_en-us.png "android-uid_en-us.png")

**Step 2: Inspect conversion data**  
Go to [the conversion data test API](https://dev.appsflyer.com/hc/reference/gcd-get-data) and fill in the required fields:

1. `app-id`: Your app ID
2. `device_id`: paste the value of `uid` from step 1.
3. `devkey` - Application's devkey. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key) how to get it.

Then, click **Try it!** to execute the test.

**Expected result**  
A 200 response containing the install's conversion data (truncated for readability):

```json Log
{
  ...
  "campaign": "test1",
  ...
  "media_source": "devtest",
  ...
  "af_status": "Non-organic"
  ...
}
```

> 📘 Note
> 
> It might take up to 30 minutes for the install to appear in the dashboard.
