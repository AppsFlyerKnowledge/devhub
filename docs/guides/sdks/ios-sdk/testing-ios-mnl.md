---
title: "Manual testing"
slug: "manual-testing-ios"
category: 5f9705393c689a065c409b23
parentDoc: 645bca9009c0a70a08399a55
hidden: true
order: 0
---

> 📘 **Note**
>
> We recommend using our [SDK wizard integration tool](https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=testing-ios-mnl) for testing

To successfully complete the test in this document, you must:
 * [Integrate the SDK](doc:integrate-ios-sdk)
 * [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).

## Test iOS SDK integration
The test consists of:
1. Simulating an ad click and installing the app:
    * If you implement ATT, follow [these instructions](#apps-that-implement-att).
    * If you don't implement ATT, follow [these instructions](#apps-that-dont-implement-att).
2. [Inspection the conversion data](#inspect-conversion-data) of the install.

### Apps that implement ATT
Follow these instructions if you implement [App Tracking Transparency](https://support.appsflyer.com/hc/en-us/articles/207032066#integration-31-configuring-app-tracking-transparency-att-support) (ATT) in your app.
Attribution will occur via [ID matching](https://support.appsflyer.com/hc/en-us/articles/207447053#device-id-matching) if the following conditions are met:
 * The attribution link contains the `idfa` parameter
 * ATT is implemented and:
     1. `requestTrackingAuthorization` is called before `start` (by utilizing [`waitForATTUserAuthorization`](doc:integrate-ios-sdk#enabling-app-tracking-transparency-att-support))
    2. User consent is given.

**Step 1: Simulate ad click**
Simulate an ad click via an attribution link. Structure the attribution link as follows:
```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&idfa=<registered_device_idfa>
```
Where:
 * `app_id` is your AppsFlyer app ID (including `id` suffix)
 * `pid` is the media source to which the install should be attributed to
 * `idfa` is the registered device's IDFA.

**Example**
If your app ID is `id123456789`, the attribution link might look like this:
```
https://app.appsflyer.com/id123456789?pid=conversionTest1&idfa=1A2B3C4D-9128-4597-1234- 
04E23D654321
```

**Step 2: Install the app**
[Enable debug mode](doc:integrate-ios-sdk#enabling-debug-mode) and install the app on a [registered test device](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).

**Step 3: Execute test**
Proceed to [inspect conversion data](#inspect-conversion-data).

### Apps that don't implement ATT
**Step 1: Simulate an ad click**
Simulate an ad click via an attribution link. Structure the attribution link as follows:
```
https://app.appsflyer.com/<app_id>?pid=<media_source>
```
Where:
 * `app_id` is your AppsFlyer app ID (including `id` prefix)
 * `pid` is the media source to which the install should be attributed to.

**Example**
If your app ID is `id123456789`, the attribution link might look like this:
```
https://app.appsflyer.com/id123456789?pid=conversionTest1
```
**Step 2: Install the app**
[Enable debug mode](doc:integrate-ios-sdk#enabling-debug-mode) and install the app on any device–since the IDFA used to register the device isn't available, device registration has no effect in this case.

**Step 3: Execute test**
Proceed to [inspect conversion data](#inspect-conversion-data).
[block:callout]
{
  "type": "success",
  "body": "More often than not, tests using attribution links are performed more than once. That's why it's recommended to use one of the attribution parameters to \"version\" your tests–it makes it easier to understand which link triggered which conversion.\n\nIn the above example, the value of `pid` is `conversionTest1`. In consecutive tests, increment the value of `pid` to `conversionTest2`, `conversionTest3`, and so on.",
  "title": "Tip"
}
[/block]

### Inspect conversion data
After simulating an ad click and installing the app, follow these steps to inspect the install's conversion data.

**Step 1: Retrieve install UID**
Once the app is installed, In the Xcode terminal, search for `conversions.appsflyer`. Look for the `uid` parameter and copy its value.
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/223ae48-log-gcd-payload_en-us.png",
        "log-gcd-payload_en-us.png",
        2452,
        824,
        "#4b4b50"
      ]
    }
  ]
}
[/block]
**Step 2: Inspect conversion data**  
Go to [the conversion data test API](https://dev.appsflyer.com/hc/reference/gcd-get-data) and fill in the required fields:

1. `app-id`: Your app ID
2. `device_id`: paste the value of `uid` from step 1.
3. `devkey` - Application's devkey. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key) how to get it.


Then, click **Try it!** to execute the test.

**Expected results** 
If ATT is implemented and user consent is given, the result is a 200 response similar to (truncated for readability):
[block:code]
{
  "codes": [
    {
      "code": "{\n    ...\n    \"af_status\" = \"Non-organic\";\n    ...\n    \"match_type\" = id_matching;\n    \"media_source\" = conversionTest1;\n    ...\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]
Otherwise, attribution occurs [probabilistically](https://support.appsflyer.com/hc/en-us/articles/207447053#probabilistic-modeling) and the result is a 200 response similar to (truncated for readability):
[block:code]
{
  "codes": [
    {
      "code": "{\n    ...\n    \"af_status\" = \"Non-organic\";\n    ...\n    \"match_type\" = probabilistic;\n    \"media_source\" = conversionTest1;\n    ...\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]
If the install isn't attributed, the result is a 200 response with the following payload:
[block:code]
{
  "codes": [
    {
      "code": "{\n    \"af_message\" = \"organic install\";\n    \"af_status\" = Organic;\n    \"install_time\" = \"2021-08-23 06:59:51.194\";\n    \"is_first_launch\" = 1;\n}",
      "language": "json",
      "name": "Terminal output"
    }
  ]
}
[/block]

[block:callout]
{
  "type": "info",
  "title": "Note",
  "body": "It might take up to 30 minutes for installs to appear in the dashboard."
}
[/block]

> 📘 Note
> 
> It might take up to 30 minutes for the install to appear in the dashboard.
