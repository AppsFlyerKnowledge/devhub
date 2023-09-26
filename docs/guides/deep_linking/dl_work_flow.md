---
title: "Deep Linking work flow"
slug: "dl_work_flow"
category: 6384c30e5a754e005f668a74
hidden: false
createdAt: "2022-11-30T10:00:54.337Z"
updatedAt: "2023-04-19T09:57:22.029Z"
---
## Setup

Setting up a OneLink requires two different personas within an organization to work together, using their own resources: Marketers and developers.

## Marketer role

Marketers plan the marketing campaigns and set up the OneLink URLs. The OneLink URLs are set up to carry parameters (for example, `deep_link_value`) and data that are used to give users a personalized experience when deep linking and deferred deep linking. 

> 📘 **Tip**
> 
> The marketer and developers need to decide together on the best long-term system for the `deep_link_value` (and any other parameters/values) to minimize additional app updates.
> 
>   The `deep_link_value` can be based on a SKU, post ID, path, or anything else. We strongly recommend agreeing on a system that allows for you to enter dynamic values on your chosen parameter, so you can generate many different deep links that go to different content within the app, without any further changes to the app code by the developers.
> 
>   See the following URL examples. The `deep_link_value` of a fruit type was chosen by the marketer and developer together. And the developers made the values dynamic, so the marketer could enter any fruit without the need for further work by the dev team.
> 
>   [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**..).  
>   [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=bananas**..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=bananas**..).  
>   [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=peaches**..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=peaches**..).

## Developer role

Developers perform the OneLink setup in the app:

- Initial setup
- Implementing the UDL API
- Implementing extended deferred deep linking

### Initial setup

Initial app setup for [Android](dl_android_init_setup) and [iOS](dl_ios_init_setup): Opens the app (using Android App Links, Universal Links, or URI schemes)

### Implement Unified Deep Linking (UDL)

Implement the unified deep linking (UDL) API to retrieve data from the click and use that data to redirect users for a personalized experience to a specific in-app activity (deep linking or deferred deep linking).  
This API is fast, easy to use, and supports both owned and paid media sources.

Note: For new users, the UDL method only returns parameters relevant to deferred deep linking: `deep_link_value` and `deep_link_sub1-10`. If you try to get any other parameters (`media_source`, `campaign`, `af_sub1-5`, etc.), they return `null`.

#### Implement UDL

[block:html]
{
  "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/dl_android_unified_deep_linking\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/unifieddeeplink\">Unity plugin</a>\n</div>\n\n<style>\n  .button-container {\n  \tdisplay: flex;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    width: 150px;\n\t  border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n\t}\n  \n  .button:before {\n  \tmargin-right: 4px;\n  }\n\n  .button.android {\n    border: solid 2px #3DDC84;\n  }\n\n  .button.ios {\n  \tborder-radius: 6px;\n    padding: 8px;\n    border: solid 2px #7D7D7D;\n  }\n  \n   .button.unity {\n    border: solid 2px #3DDC84;\n    border-color: var(--project-primary-color);\n  }\n\n\n  .ios:before {\n        content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\");\n  }\n\n  .android:before {\n        content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\");\n  }\n\n.unity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\");\n}\n\n.reactnative:before {\n   content: url(\"https://files.readme.io/3e1288d-reactnative-icon.svg\");\n}\n\n.flutter:before {\n    content: url(\"https://files.readme.io/1f70175-flutter-icon.svg\");\n}\n</style>"
}
[/block]

### [Recommended] Implement extended deferred deep linking

In some cases, UDL isn't activated for deferred deep-linking. For example, when:  
    - A user clicks a link from a Self Reporting Network (SRN) like Meta ads or Twitter.  
    - A user clicks a link that doesn't contain parameters like `deep_link_value` or `deep_link_sub1-10`.  
    - The time period between click and install exceeds the UDL lookback window of 15 minutes.  
To guarantee deferred deep-linking works in such cases, we recommend implementing the `onConversionDataSuccess` (OCDS) method, which is part of the GCD API. OCDS is usually used to retrieve [conversion data](https://dev.appsflyer.com/hc/docs/conversion-data) and prior to UDL, was the exclusive method for handling deferred deep linking.  
**Important**: When implementing both UDL and OCDS, it is the developer's responsibility to guarantee that **only one** of the methods handles deferred deep linking.  
See instructions for implementing extended deferred deep linking for [Android](dl_android_ocds_ddl) and [iOS](dl_ios_ocds_ddl).

### Legacy: Use only GCD API for Deep-Linking

Developers already using OneLink may be using the legacy methods for deep linking and deferred deep linking, instead of UDL.  
The legacy methods exclusively use the GCD API, which consists of two methods: `onConversionDataSuccess` for deferred deep linking and `onAppOpenAttribution` for deep linking. See information about the legacy methods for [Android](dl_android_gcd_legacy) and [iOS](dl_ios_gcd_legacy).

**Recommended**: Apps with only the GCD API implemented should implement [UDL](#implement-unified-deep-linking-udl) and [extended deferred deep linking](#optional-implement-extended-deferred-deep-linking).

### User invites

Allow users to refer others to the app using OneLink links by [creating user invites](dl_user_invite)