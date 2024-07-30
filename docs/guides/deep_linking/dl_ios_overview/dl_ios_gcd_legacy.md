---
title: "iOS Legacy APIs"
slug: "dl_ios_gcd_legacy"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
createdAt: "2022-12-28T11:07:32.794Z"
updatedAt: "2023-05-03T15:55:14.736Z"
---
## Direct Deep Linking

### Overview

Direct deep linking directs mobile users into a specific activity or content in an app, when the app is already installed.

This in-app routing to a specific activity in the app is possible due to the parameters passed to the app when the OS opens the app and the `onAppOpenAttribution` method is called. AppsFlyer's OneLink ensures that the correct value is passed along with the user's click, thus personalizing the user’s app experience.

**Only the `deep_link_value` is required for deep linking. However, other parameters and values (such as custom attribution parameters) can also be added to the link and returned by the SDK as deep linking data. **

**The direct deep linking flow works as follows**:  
![Direct Deep Linking flow](https://files.readme.io/2407f56-Ios_DL.png "Direct Deep Linking flow")

1. User clicks the OneLink short URL.
2. iOS reads the app’s Associated Domains Entitlements.
3. iOS opens the app.
4. AppsFlyer SDK is triggered inside the app.
5. AppsFlyer SDK retrieves the OneLink data.
   * In a short URL, the data is retrieved from the short URL resolver API in AppsFlyer's servers.
   * In a long URL, the data is retrieved directly from the long URL.

6. AppsFlyer SDK triggers `onAppOpenAttribution()` with the retrieved parameters and cached attribution parameters (e.g.`install_time`).
7. Asynchronously, `onConversionDataSuccess()` is called, holding the full cached attribution data. (You can exit this function by checking if `is_first_launch` is `true`.)
8. `onAppOpenAttribution()` uses the `attributionData` map to dispatch other activities in the app and pass relevant data.
   - This creates the personalized experience for the user, which is the main goal of OneLink.

### Procedures

To implement the `onAppOpenAttribution` method and set up the parameter behaviors, the following action checklist of procedures must be completed. 

#### Procedure checklist

1. [Deciding app behavior and `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#deciding-app-behavior) (and other parameter names and values) - with the marketer
2. [Planning method input, i.e. `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#planning-method-input) (and other parameter names and values) - with the marketer
3. [Implementing the `onAppOpenAttribution()` logic](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onappopenattribution-logic)
4. [Implementing the `onAttributionFailure()` logic](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onattributionfailure-logic)

#### Deciding app behavior

**To decide what the app behavior is when the link is clicked**: 

Get from the marketer: The expected behavior of the link when it is clicked.

#### Planning method input

When a OneLink is clicked and the user has the app installed on their device, the `onAppOpenAttribution` method is called by the AppsFlyer SDK. This is referred to as a retargeting re-engagement.

The `onAppOpenAttribution` method gets variables as an input like this: `AnyHashable: Any`.  
The input data structure is described [here](https://dev.appsflyer.com/hc/docs/gcd-input-parameters).

#### Implementing onAppOpenAttribution() logic

The deep link opens the `onAppOpenAttribution` method in the main activity. The OneLink parameters in the method input are used to implement the specific user experience when the application is opened.

#### Code Example:

```swift
func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
    //Handle Deep Link Data
    print("onAppOpenAttribution data:")
    for (key, value) in attributionData {
        print(key, ":",value)
    }
    walkToSceneWithParams(params: attributionData)
}

// User logic
fileprivate func walkToSceneWithParams(params: [AnyHashable:Any]) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)

    var fruitNameStr = ""

    if let thisFruitName = params["deep_link_value"] as? String {
        fruitNameStr = thisFruitName
    } else if let linkParam = params["link"] as? String {
        guard let url = URLComponents(string: linkParam) else {
            print("Could not extract query params from link")
            return
        }
        if let thisFruitName = url.queryItems?.first(where: { $0.name == "deep_link_value" })?.value {
            fruitNameStr = thisFruitName
        }
    }

    let destVC = fruitNameStr + "_vc"
    if let newVC = storyBoard.instantiateVC(withIdentifier: destVC) {

        print("AppsFlyer routing to section: \(destVC)")
        newVC.attributionData = params

        UIApplication.shared.windows.first?.rootViewController?.present(newVC, animated: true, completion: nil)
    } else {
        print("AppsFlyer: could not find section: \(destVC)")
    }
}
```

⇲ Github links: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L151-L159)

#### Implementing onAttributionFailure() logic

The `onAttributionFailure` method is called whenever the call to `onAppOpenAttribution` fails. The function should report the error and create an expected experience for the user.

```swift
func onAppOpenAttributionFailure(_ error: Error) {
    print("\(error)")
}
```

⇲ Github links: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L161-L163)

## Deferred Deep Linking

> ❗️ Important
> 
> Deferred deep linking using the legacy method of onConversionDataSuccess may not work for iOS 14.5+, since it requires attribution data that may not be available due to privacy protection.  
> We recommend using [unified deep linking (UDL)](https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking). UDL conforms to the iOS 14.5+ privacy standards and only returns parameters relevant to deep linking and deferred deep linking: `deep_link_value` and `deep_link_sub1-10`. Attribution parameters (such as `media_source`, `campaign`, `af_sub1-5`, etc.), return `null` and can’t be used for deep linking purposes.  
> [Learn more](https://content.appsflyer.com/ios-14-hub/deep-linking-deferred-deep-linking/)

### Overview

Deferred deep linking directs new users first to the correct app store to install the app, and then, after the first open, to a specific app experience (for example a specific page in the app).

When the user first launches the app, the `onConversionDataSuccess` callback function receives both the conversion data of the new user, and OneLink data. The OneLink data makes in-app routing possible due to the `deep_link_value` or other that is passed to the app when the OS opens the app. 

Only the `deep_link_value` is required for deep linking. However, other parameters and values (such as custom attribution parameters) can also be added to the link and returned by the SDK as deep linking data. The AppsFlyer OneLink ensures that the correct parameters are passed along with the user's click, thus personalizing the user’s app experience.

The marketer and developer must coordinate regarding desired app behavior and `deep_link_value`. The marketer uses the parameters to create deep links, and the developer customizes the behavior of the app based on the value received.

It is the developer's responsibility to make sure the parameters are handled correctly in the app, for both in-app routing, and personalizing data in the link.

**The deferred deep linking flow works as follows**:  
![Deferred Deep Linking flow!](https://files.readme.io/4db3218-Ios_DDL.png "Deferred Deep Linking flow")

1. User clicks the OneLink on a device on which the app is not installed.
2. AppsFlyer registers the click and redirects the user to the correct app store or landing page.
3. The user installs the application and launches it.
4. AppsFlyer SDK is initialized and the install is attributed in the AppsFlyer servers.
5. The SDK triggers the `onConversionDataSuccess` method. The function receives input that includes both the `deep_link_value`, and the attribution data/parameters defined in the OneLink data.
6. The parameter `is_first_launch` has the value `true`, which signals the deferred deep link flow.  
   The developer uses the data received in the `onConversionDataSuccess` function to create a personalized experience for the user for the application’s first launch. 

### Procedures

To implement the `onConversionDataSuccess` method and set up the parameter behaviors, the following action checklist of procedures need to be completed.

1. [Deciding app behavior on first launch, and `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#deciding-app-behavior-on-first-launch) (and other parameter names and values) - with the marketer
2. [Planning method input, i.e. `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#planning-method-input-1) (and other parameter names and values) - with the marketer
3. [Implementing the `onConversionDataSuccess()` logic](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onconversiondatasuccess-logic)
4. [Implementing the `onConversionDataFail()` logic](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onconversiondatafailure-logic)

#### Deciding app behavior on first launch

**To decide app behavior on first launch**: 

Get from the marketer: The expected behavior of the link when it is clicked and the app opens for the first time.

#### Planning method input

For deferred deep linking, the `onConversionDataSuccess` method input must be planned and the input decided in the previous section (for deep linking) is made relevant for the first time the app is launched.

The `onConversionDataSuccess` method gets the `deep_link_value` and other variables as an input like this: `AnyHashable: Any`.

The map holds two kinds of data:

- [Attribution data](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
- Data defined by the marketer in the link (`deep_link_value` and other parameters and values)  
  Other parameters can be either:
  - AppsFlyer official parameters.
  - Custom parameters and values chosen by the marketer and developer.
  - The input data structure is described [here](https://dev.appsflyer.com/hc/docs/ios-sample-payloads).

The marketer and developers need to plan the `deep_link_value` (and other possible parameters and values) together based on the desired app behavior when the link is clicked.

**To plan the `deep_link_value`, and other parameter names and values based on the expected link behavior**:

1. Tell the marketer what parameters and values are needed in order to implement the desired app behavior.
2. Decide on naming conventions for the `deep_link_value` and other parameters and values.  
   **Note**: 
   - Custom parameters will not appear in raw data collected in AppsFlyer.
   - Conversion data will not return a custom parameter named "name, " with a lowercase "n".

#### Implementing onConversionDataSuccess() logic

When the app is opened for the first time, the `onConversionDataSuccess` method is triggered in the main activity. The `deep_link_value` and other parameters in the method input are used to implement the specific user experience when the app is first launched.

**To implement the logic**: 

1. Implement the logic based on the chosen parameters and values. See the following code example.
2. Once completed, send confirmation to the marketer that the app behaves accordingly.

#### Sample code

```swift
// Handle Organic/Non-organic installation
func onConversionDataSuccess(_ data: [AnyHashable: Any]) {

    print("onConversionDataSuccess data:")
    for (key, value) in data {
        print(key, ":", value)
    }

    if let status = data["af_status"] as? String {
        if (status == "Non-organic") {
            if let sourceID = data["media_source"],
                let campaign = data["campaign"] {
                print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
            }
        } else {
            print("This is an organic install.")
        }
        if let is_first_launch = data["is_first_launch"] as? Bool,
            is_first_launch {
            print("First Launch")
            if let fruit_name = data["deep_link_value"]
            {
                // The key 'deep_link_value' exists only in OneLink originated installs
                print("deferred deep-linking to \(fruit_name)")
                walkToSceneWithParams(params: data)
            }
            else {
                print("Install from a non-owned media")
            }
        } else {
            print("Not First Launch")
        }
    }
}
```

⇲ Github links: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L113-L145)

#### Implementing onConversionDataFailure() logic

The `onConversionDataFailure` method is called whenever the call to `onConversionDataSuccess` fails. The function should report the error and create an expected experience for the user.

**To implement the `onConversionDataFailure` method**:

```swift
func onConversionDataFail(_ error: Error) {
    print("\(error)")
}
```

⇲ Github links: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L147-L149)

## iOS sample payloads

See the following sample payloads for Universal Links, URI schemes, and deferred deep linking. The samples contain a full payload, relevant for when all parameters in the Onelink custom link setup page  contain data.

**Note**: Payloads return as a map. However, for clarity, the sample payloads that follow are displayed in JSON form. 

### Universal Links

Input to `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`

```short_link
{
   "af_ad": "my_adname",
   "af_adset": "my_adset",
   "af_android_url": "https://isitchristmas.com/",
   "af_channel": "my_channel",
   "af_click_lookback": "20d",
   "af_cost_currency": "USD",
   "af_cost_value": 6,
   "af_dp": "afbasicapp://mainactivity",
   "af_ios_url": "https://isitchristmas.com/",
   "af_sub1": "my_sub1",
   "af_sub2": "my_sub2",
   "c": "fruit_of_the_month",
   "campaign": "fruit_of_the_month",
   "fruit_amount": 26,
   "fruit_name": "apples",
   "is_retargeting": true,
   "link": "https://onelink-basic-app.onelink.me/H5hv/6d66214a",
   "media_source": "Email",
   "pid": "Email"
}
```
```long_link
{
   "path": "/H5hv",
   "af_android_url": "https://my_android_lp.com",
   "af_channel": "my_channel",
   "host": "onelink-basic-app.onelink.me",
   "af_adset": "my_adset",
   "pid": "Email",
   "scheme": "https",
   "af_dp": "afbasicapp://mainactivity",
   "af_sub1": "my_sub1",
   "fruit_name": "apples",
   "af_ad": "my_adname",
   "af_click_lookback": "20d",
   "fruit_amount": 16,
   "af_sub2": "my_sub2",
   "link": "https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_android_url=https%3A%2F%2Fmy_android_lp.com",
   "af_cost_currency": "USD",
   "c": "fruit_of_the_month",
   "af_ios_url": "https://my_ios_lp.com",
   "af_cost_value": 6
}
```

### URI scheme

Input to `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`

```short_link
{
  "af_click_lookback ": "25d",
  "af_sub1 ": "my_sub1",
  "shortlink ": "9270d092",
  "af_deeplink ": true,
  "media_source ": "Email",
  "campaign ": "my_campaign",
  "af_cost_currency ": "NZD",
  "host ": "mainactivity",
  "af_ios_url ": "https://my_ios_lp.com",
  "scheme ": "afbasicapp",
  "path ": "",
  "af_cost_value ": 5,
  "af_adset ": "my_adset",
  "af_ad ": "my_adname",
  "af_android_url ": "https://my_android_lp.com",
  "af_sub2 ": "my_sub2",
  "af_force_deeplink ": true,
  "fruit_amount ": 15,
  "af_dp ": "afbasicapp://mainactivity",
  "link ": "afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092",
  "af_channel ": "my_channel",
  "is_retargeting ": true,
  "af_web_id ": "56441f02-377b-47c6-9648-7a7f88268130-o",
  "fruit_name ": "apples"
}
```
```long_link
{
  "af_ad ": "my_adname",
  "fruit_name ": "apples",
  "host ": "mainactivity",
  "af_channel ": "my_channel",
  "link ": "afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp.com&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email",
  "af_deeplink ": true,
  "campaign ": "my_campaign",
  "af_sub1 ": "my_sub1",
  "af_click_lookback ": "25d",
  "af_web_id ": "56441f02-377b-47c6-9648-7a7f88268130-o",
  "path ": "",
  "af_sub2 ": "my_sub2",
  "af_ios_url ": "https://my_ios_lp.com",
  "af_cost_value ": 5,
  "fruit_amount ": 15,
  "is_retargeting ": true,
  "scheme ": "afbasicapp",
  "af_force_deeplink ": true,
  "af_adset ": "my_adset",
  "media_source ": "Email",
  "af_cost_currency ": "NZD",
  "af_dp ": "afbasicapp://mainactivity",
  "af_android_url ": "https://my_android_lp.com"
}
```

### Deferred deep linking

Input to `onConversionDataSuccess(_ data: [AnyHashable: Any])`

```short_link
{
  "adgroup": null,
  "adgroup_id": null,
  "adset": null,
  "adset_id": null,
  "af_ad": "my_adname",
  "af_adset": "my_adset",
  "af_android_url": "https://isitchristmas.com/",
  "af_channel": "my_channel",
  "af_click_lookback": "20d",
  "af_cost_currency": "USD",
  "af_cost_value": 6,
  "af_cpi": null,
  "af_dp": "afbasicapp://mainactivity",
  "af_ios_url": "https://isitchristmas.com/",
  "af_siteid": null,
  "af_status": "Non-organic",
  "af_sub1": "my_sub1",
  "af_sub2": "my_sub2",
  "af_sub3": null,
  "af_sub4": null,
  "af_sub5": null,
  "agency": null,
  "campaign": "fruit_of_the_month ",
  "campaign_id": null,
  "click_time": "2020-08-12 15:08:00.770",
  "cost_cents_USD": 600,
  "engmnt_source": null,
  "esp_name": null,
  "fruit_amount": 26,
  "fruit_name": "apples",
  "http_referrer": null,
  "install_time": "2020-08-12 15:08:33.335",
  "is_branded_link": null,
  "is_first_launch": 1,
  "is_retargeting": true,
  "is_universal_link": null,
  "iscache": 1,
  "match_type": "probabilistic",
  "media_source": "Email",
  "orig_cost": "6.0",
  "redirect_response_data": null,
  "retargeting_conversion_type": "none",
  "shortlink": "6d66214a"
}
```