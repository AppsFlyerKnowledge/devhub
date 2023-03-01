---
title: Deep Linking work flow
category: 6384c30e5a754e005f668a74
order: 2
hidden: false
---
## Setup

Setting up a OneLink requires two different personas within an organization to work together, using their own resources: Marketers and developers.

## Marketer role
Marketers plan the marketing campaigns and set up the OneLink URLs. The OneLink URLs are set up to carry parameters (for example, `deep_link_value`) and data that are used to give users a personalized experience when deep linking and deferred deep linking. 

> 📘 **Tip**
> The marketer and developers need to decide together on the best long-term system for the `deep_link_value` (and any other parameters/values) to minimize additional app updates.
>
>   The `deep_link_value` can be based on a SKU, post ID, path, or anything else. We strongly recommend agreeing on a system that allows for you to enter dynamic values on your chosen parameter, so you can generate many different deep links that go to different content within the app, without any further changes to the app code by the developers.
>
>   See the following URL examples. The `deep_link_value` of a fruit type was chosen by the marketer and developer together. And the developers made the values dynamic, so the marketer could enter any fruit without the need for further work by the dev team.
>
>   https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**...
>   https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=bananas**...
>   https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=peaches**...

## Developer role
Developers perform the OneLink setup in the app:
- Initial setup
- Implementing the UDL API
- Implementing extended deferred deep linking

### Initial setup
Initial app setup for [Android](dl_android_init_setup) and [iOS](dl_ios_init_setup): Opens the app (using Android App Links, Universal Links, or URI schemes)

### Implement Unified Deep Linking (UDL)
Implement the unified deep linking (UDL) API for [Android](dl_android_unified_deep_linking) and [iOS](dl_ios_unified_deep_linking) to retrieve data from the click and use that data to redirect users for a personalized experience to a specific in-app activity (deep linking or deferred deep linking). 
This API is fast, easy to use, and supports both owned and paid media sources.

Note: For new users, the UDL method only returns parameters relevant to deferred deep linking: `deep_link_value` and `deep_link_sub1-10`. If you try to get any other parameters (`media_source`, `campaign`, `af_sub1-5`, etc.), they return `null`.

### [Recommended] Implement extended deferred deep linking
In some cases, UDL isn't activated for deferred deep-linking. For example, when:
    - A user clicks a link from a Self Reporting Network (SRN) like Facebook or Twitter.
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