---
title: "iOS Unified Deep Linking"
slug: "dl_ios_unified_deep_linking"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
createdAt: "2022-12-27T13:58:01.063Z"
updatedAt: "2023-02-02T09:10:57.367Z"
---
**At a glance:** Unified deep linking (UDL) enables you to send new and existing users to a specific in-app activity (for example, a specific page in the app) as soon as the app is opened.

> 📘 **UDL privacy protection**
>
> For new users, the UDL method only returns parameters relevant to deferred deep linking: `deep_link_value` and `deep_link_sub1-10`. If you try to get any other parameters (`media_source`, `campaign`, `af_sub1-5`, etc.), they return null.


Step-by-step example
--------------------------------
[block:tutorial-tile]
{
  "title": "Unified Deep Linking (UDL) API in iOS",
  "emoji": "🍏",
  "backgroundColor": "#cef2d1",
  "slug": "unified-deep-linking-udl-api-in-ios",
  "_id": "60a3e81226e6060010cea750",
  "id": "60a3e81226e6060010cea750",
  "link": "https://dev.appsflyer.com/v0.1/recipes/unified-deep-linking-udl-api-in-ios",
  "align": "default"
}
[/block]
## Flow
![iOS UDL flow!](https://files.readme.io/b1079fb-6577_Unified_Deep_Link_flow_iOS.png "iOS UDL flow")

The flow works as follows:

1. User clicks a OneLink link.
   * If the user has the app installed, the Universal Links or URI scheme opens the app. 
   * If the user doesn’t have the app installed, they are redirected to the app store, and after downloading, the user opens the app. 
2. The app open triggers the AppsFlyer SDK.
3. The AppsFlyer SDK runs the UDL API. 
4. The UDL API retrieves OneLink data from AppsFlyer servers. 
5. The UDL API calls back the [`didResolveDeepLink()`] in the [`DeepLinkDelegate`].
6. The [`didResolveDeepLink()`] method gets a [`DeepLinkResult`] object. 
7. The [`DeepLinkResult`] object includes:
   * Status (Found/Not found/Failure)
   * A [`DeepLink`] object that carries the `deep_link_value` and `deep_link_sub1-10` parameters that the developer uses to route the user to a specific in-app activity, which is the main goal of OneLink.

[`didResolveDeepLink()`]: https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink
[`DeepLinkDelegate`]: https://dev.appsflyer.com/hc/docs/appsflyerlib-1#deeplinkdelegate
[`DeepLinkResult`]: https://dev.appsflyer.com/hc/docs/deeplinkresult-1
[`DeepLink`]: https://dev.appsflyer.com/hc/docs/deeplink-1

## Prerequisites
* UDL requires AppsFlyer iOS SDK V6.1+.

## Planning
When setting up OneLink, the marketer uses parameters to create the links, and the developer customizes the behavior of the app based on the values received. It is the developer's responsibility to make sure the parameters are handled correctly in the app, for both in-app routing, and personalizing data in the link.

**To plan the OneLink:**

1. Get from the marketer the desired behavior and personal experience a user gets when they click the URL.
2. Based on the desired behavior, plan the `deep_link_value` and other parameters that are needed to give the user the desired personal experience.
   * The `deep_link_value` is set by the marketer in the URL and used by the developer to redirect the user to a specific place inside the app. For example, if you have a fruit store and want to direct users to apples, the value of `deep_link_value` can be `apples`.
    * The `deep_link_sub1-10`  parameters can also be added to the URL to help personalize the user experience. For example, to give a 10% discount, the value of `deep_link_sub1` can be `10`.

## Implementation
Implement the UDL API logic based on the chosen parameters and values.
1. Assign the `AppDelegate` using `self` to [`AppsFlyerLib.shared().deepLinkDelegate`](https://dev.appsflyer.com/hc/docs/appsflyerlib-1#deeplinkdelegate).
2. Implement application function to allow:
     * Universal Links support with [`continue`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#continue).
     * URI scheme support with [`handleOpen`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#handleopen).
3. Create [`DeepLinkDelegate`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate) as an extension of `AppDelegate`.
4. Add `application` functions to support Universal Links and URI schemes. 
5. In `DeepLinkDelegate`, make sure you override the callback function, [`didResolveDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink). 
`didResolveDeepLink()` accepts a [`DeepLinkResult`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1) object as an argument. 
6. Use [`DeepLinkResult.status`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#status) to query whether the deep linking match is found.
7. For when the status is an error, call [`DeepLinkResult.error`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#error) and run your error flow.
8. For when the status is found, use [`DeepLinkResult.deepLink`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#deeplink) to retrieve the [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink-1) object. 
The `DeepLink` object contains the deep linking information arranged in public variables to retrieve the values from well-known OneLink keys, for example, [`DeepLink.deeplinkValue`](https://dev.appsflyer.com/hc/docs/deeplink-1#deeplinkvalue) for `deep_link_value`.
9. Use [`deepLinkObj.clickEvent["deep_link_sub1"]`](https://dev.appsflyer.com/hc/docs/deeplink-1#clickevent) to retrieve `deep_link_sub1`. Do the same for `deep_link_sub2-10` parameters, changing the string value as required.
10. Once `deep_link_value` and `deep_link_sub1-10` are retrieved, pass them to an in-app router and use them to personalize the user experience.

### Supporting legacy OneLink links 

Legacy OneLink links are links that don't contain the parameters recommended for Unified Deep Linking: `deep_link_value` and `deep_link_sub1-10`.
Usually these are links that already exist in the field when migrating from legacy methods to UDL.
News users using legacy links are handled by `onConversionDataSuccess` in the context of [extended deferred deep linking](dl_ios_ocds_ddl).
UDL handles deep linking for existing users. It's recommended that you add support in the UDL callback `didResolveDeepLink` for legacy parameters.
[Swift code example](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L152-L162)

### Code example

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  ...
  AppsFlyerLib.shared().deepLinkDelegate = self
  ...
}

// For Swift version < 4.2 replace function signature with the commented out code
// func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool { // this line for Swift < 4.2
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
  AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
  return true
}

// Open URI-scheme for iOS 9 and above
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
  AppsFlyerLib.shared().handleOpen(url, options: options)
  return true
}

extension AppDelegate: DeepLinkDelegate {
    func didResolveDeepLink(_ result: DeepLinkResult) {
        var fruitNameStr: String?
        switch result.status {
        case .notFound:
            NSLog("[AFSDK] Deep link not found")
            return
        case .failure:
            print("Error %@", result.error!)
            return
        case .found:
            NSLog("[AFSDK] Deep link found")
        }
        
        guard let deepLinkObj:DeepLink = result.deepLink else {
            NSLog("[AFSDK] Could not extract deep link object")
            return
        }
        
        if deepLinkObj.clickEvent.keys.contains("deep_link_sub2") {
            let ReferrerId:String = deepLinkObj.clickEvent["deep_link_sub2"] as! String
            NSLog("[AFSDK] AppsFlyer: Referrer ID: \(ReferrerId)")
        } else {
            NSLog("[AFSDK] Could not extract referrerId")
        }        
        
        let deepLinkStr:String = deepLinkObj.toString()
        NSLog("[AFSDK] DeepLink data is: \(deepLinkStr)")
            
        if( deepLinkObj.isDeferred == true) {
            NSLog("[AFSDK] This is a deferred deep link")
        }
        else {
            NSLog("[AFSDK] This is a direct deep link")
        }
        
        fruitNameStr = deepLinkObj.deeplinkValue
        walkToSceneWithParams(fruitName: fruitNameStr!, deepLinkData: deepLinkObj.clickEvent)
    }
}
// User logic
fileprivate func walkToSceneWithParams(deepLinkObj: DeepLink) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    guard let fruitNameStr = deepLinkObj.clickEvent["deep_link_value"] as? String else {
         print("Could not extract query params from link")
         return
    }
    let destVC = fruitNameStr + "_vc"
    if let newVC = storyBoard.instantiateVC(withIdentifier: destVC) {
       print("AppsFlyer routing to section: \(destVC)")
       newVC.deepLinkData = deepLinkObj
       UIApplication.shared.windows.first?.rootViewController?.present(newVC, animated: true, completion: nil)
    } else {
        print("AppsFlyer: could not find section: \(destVC)")
    }
}
```

⇲ Github links: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/a96399329a369b30263ea4f8cc4558029ea603b3/swift/basic_app/basic_app/AppDelegate.swift#L126)

### Deferred Deep Linking after network consent

In some cases the application might require consent from the user in order to connect to the network, in a dialog similar to this one:
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/c4ac931-network_consent_dialog.png",
        "c4ac931-network_consent_dialog.png",
        null
      ],
      "align": "center",
      "sizing": "250px"
    }
  ]
}
[/block]

In order to support deferred deep linking once the network consent is given we recommend:
- Implement [eDDL](./dl_ios_ocds_ddl) to allow UDL to handle the deferred deep linking

## Testing deferred deep linking

### Before you begin
- Complete UDL [integration](#implementation).
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Enable debug mode](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode) in the app. 
- Make sure the app isn't installed on your device.
- Ask your marketer for a OneLink template. 
  - It will look something like this `https://onelink-basic-app.onelink.me/H5hv`. 
  - This example uses the OneLink subdomain `onelink-basic-app.onelink.me` and the OneLink template ID `H5hv`.

### The test link
You can use an existing OneLink link or ask your marketer to create a new one for testing. Both short and long OneLink URLs can be used.

#### Adding ad-hoc parameters to an existing link
 
- Use only the domain and OneLink template of your link. For example: `https://onelink-basic-app.onelink.me/H5hv`.
- Add OneLink parameters `deep_link_value` and `deep_link_sub1-10` as expected by your application. The parameters should be added as query parameters.
  - Example: `https://onelink-basic-app.onelink.me/H5hv?deep_link_value=apples&deep_link_sub1=23` 

### Perform the test
1. Click the link on your device.
2. OneLink redirects you according to the link setup, to either the App Store or a website. 
3. Install the application.
> ** Important **
> - If the application is still in development and not uploaded to the store yet, you see this image:
> <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style="text-align: center;"/>
> - Install the application from Xcode.
4. UDL detects the deferred deep linking, matches the install to the click, and retrieves the OneLink parameters to `didResolveDeepLink` callback. 

### Expected logs results
> 📘 The following logs are available only when [debug mode is enabled](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode).

- SDK initialized:
  ```
  [AppsFlyerSDK] [com.apple.main-thread] AppsFlyer SDK version 6.6.0 started build
  ```
  ```
- UDL API starts:  
  ```
  D/AppsFlyer_6.9.0: [DDL] start
  ```
- UDL sends query to AppsFlyer to query a match with this install:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] URL: https://dlsdk.appsflyer.com/v1.0/ios/id1512793879?sdk_version=6.6&af_sig=efcecc2bc95a0862ceaa7b62fa8e98ae1e3e022XXXXXXXXXXXXXXXX
  ```
- UDL got a response and calls `didResolveDeepLink` callback with `status=FOUND` and OneLink link data:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] Calling didResolveDeepLink with: {"af_sub4":"","click_http_referrer":"","af_sub1":"","click_event":{"af_sub4":"","click_http_referrer":"","af_sub1":"","af_sub3":"","deep_link_value":"peaches","campaign":"","match_type":"probabilistic","af_sub5":"","campaign_id":"","media_source":"","deep_link_sub1":"23","af_sub2":""},"af_sub3":"","deep_link_value":"peaches","campaign":"","match_type":"probabilistic","af_sub5":"","media_source":"","campaign_id":"","af_sub2":""}
  ```

## Testing deep linking (Universal Links)

### Before you begin
- Complete UDL [integration](#implementation).
- [Register your testing device](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Enable debug mode](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode) in the app. 
- Make sure the app is already installed on your device.
- Ask your marketer for a **OneLink template**. 
  - It will look something like this `https://onelink-basic-app.onelink.me/H5hv`. 
  - This example uses the OneLink subdomain `onelink-basic-app.onelink.me` and the OneLink template ID `H5hv`
- [Configure Universal Links](dl_ios_init_setup#procedures-for-ios-universal-links).

### Create the test link
Use the same method as in [deferred deep linking](#testing-deferred-deep-linking).

### Perform the test
1. Click the link on your device.
2. UDL detects the Universal Link and retrieves the OneLink parameters to `didResolveDeepLink` callback. 


### Expected logs results
> 📘 The following logs are available only when [debug mode is enabled](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode).
- If the link is a OneLink shortlink (e.g. https://onelink-basic-app.onelink.me/H5hv/apples):
  ```
 [AppsFlyerSDK] [com.apple.main-thread] NSUserActivity `webpageURL`: https://onelink-basic-app.onelink.me/H5hv/apples
 [AppsFlyerSDK] [com.appsflyer.serial] UniversalLink/Deeplink found:
https://onelink-basic-app.onelink.me/H5hv/apples
[AppsFlyerSDK] [com.appsflyer.serial] Shortlink found. Executing: https://onelink.appsflyer.com/shortlink-sdk/v2/H5hv?id=apples
 ...
[AppsFlyerSDK] [com.appsflyer.serial]                        
[Shortlink] OneLink:{
    c = test1;
    campaign = test1;
    "deep_link_sub1" = 23;
    "deep_link_value" = peaches;
    "is_retargeting" = true;
    "media_source" = SMS;
    pid = SMS;
} 
  ```
- UDL calls `didResolveDeepLink` callback with `status=FOUND` and OneLink link data:
  ```
[AppsFlyerSDK] [com.appsflyer.serial] [DDL] Calling didResolveDeepLink with: {"af_sub4":null,"click_http_referrer":null,"af_sub1":null,"click_event":{"campaign":"test1","deep_link_sub1":"23","deep_link_value":"peaches","media_source":"SMS"},"af_sub3":null,"deep_link_value":"peaches","campaign":"test1","match_type":null,"af_sub5":null,"media_source":"SMS","campaign_id":null,"af_sub2":null}
  ```