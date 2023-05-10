---
title: "iOS user invite"
slug: "dl_ios_user_invite"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
createdAt: "2022-12-29T10:09:41.374Z"
updatedAt: "2023-05-03T16:00:09.572Z"
---
Overview
--------

Implement and attribute user invite links for when existing users refer others to your app.  
For an introduction, see [user invite](doc:user-invite-attribution).

Want to see a full example? check out the recipe:


[block:tutorial-tile]
{
  "title": "Get Conversion Data in Android",
  "id": "615d66bdd3797c004251ba3e",
  "slug": "get-conversion-data-in-android",
  "backgroundColor": "#018FF4",
  "emoji": "🐣",
  "link": "https://dev.appsflyer.com/v0.1/recipes/get-conversion-data-in-android",
  "align": "default",
  "_id": "615d66bdd3797c004251ba3e"
}
[/block]


Implement user-invites
----------------------

**Before you begin**: Sync with the marketer to find out the exact use cases they want for the links and to get a list of the [parameters](https://support.appsflyer.com/hc/en-us/articles/115004480866#parameters) they want to be implemented.

To implement user invite attribution, complete the following steps:

1. [Set up invite link generation](#set-up-invite-link-generation) to generate invite links.
2. <span class="annotation-optional">Optional</span> [Log the invite link creation](#log-invite-link-creation-events).
3. Set up [Unified Deeplinking](doc:unified-deep-linking-udl-1) (UDL)
4. <span class="annotation-optional">Optional</span> [Retrieve referrer data from user invite links](#set-up-udl-for-user-invite-attribution).
5. <span class="annotation-optional">Optional</span> Set up [referrer rewards](#reward-referrers).

The following code is based on the [marketer example](https://support.appsflyer.com/hc/en-us/articles/115004480866#example).

### Set up invite link generation

To enable users to invite their friends to your app, you need a way to generate invitation links. This is done using `AppsFlyerLinkGenerator`.  
**To set up invite link generation:**

1. Make sure you import `AppsFlyerLib`:
   ```swift
   import com.appsflyer.AppsFlyerLib;
   ```

2. In `AppDelegate`, set a OneLink template using [`appInviteOneLinkID`](ios-sdk-reference-appsflyerlib#appinviteonelinkid) (The template ID is [provided by the marketer](hhttps://support.appsflyer.com/hc/en-us/articles/115004480866#procedures)):
   ```swift
   AppsFlyerLib.shared().appInviteOneLinkID = "H5hv" // Set the OneLink template ID for userinvitation links
   ```
   > 📘 Note
   > 
   > - Make sure to set `appInviteOneLinkID` **before** calling `start`
   > - The OneLink template must be related to the app.

3. Call [`AppsFlyerShareInviteHelper.generateInviteUrl`](doc:ios-sdk-reference-appsflyershareinvitehelper#generateinviteurl) and pass it an [`AppsFlyerLinkGenerator`](doc:ios-sdk-reference-appsflyerlinkgenerator) and a `completionHandler`:
   ```swift
   AppsFlyerShareInviteHelper.generateInviteUrl(
       linkGenerator: {
           (_ generator: AppsFlyerLinkGenerator) -> AppsFlyerLinkGenerator in
               generator.addParameterValue(<TARGET_VIEW>, forKey: "deep_link_value")
               generator.addParameterValue(<PROMO_CODE>, forKey: "deep_link_sub1")
               generator.addParameterValue(<REFERRER_ID>, forKey: "deep_link_sub2")
               // Optional; makes the referrer ID available in the installs raw-data report
               generator.addParameterValue(<REFERRER_ID>, forKey: "af_sub1")
               generator.setCampaign("summer_sale")
               generator.setChannel("mobile_share")
         		// Optional; Set a branded domain name:
         		generator.brandDomain = "brand.domain.com"
               return generator
       },
       completionHandler: {
           (_ url: URL?) -> Void in
               if url != nil {
                   NSLog("[AFSDK] AppsFlyer share-invite link: \(url!.absoluteString)")
               }        
               else {
                   print("url is nil")
               }
           }
   )
   ```
   Depending on the user flow you and the marketer want to achieve, configure `generator` as follows:
   - Set attribution parameters using [setters](ios-sdk-reference-appsflyerlinkgenerator#methods).
   - Set deep linking parameters, using [`AppsFlyerLinkGenerator.addParameterValue`](doc:ios-sdk-reference-appsflyerlinkgenerator#addparametervalue):
     - `deep_link_value`: The app experience the referred user should be deep linked into.
     - `deep_link_sub1`: A customizable parameter. In this example, used to pass the promo code received by the invitee.
     - `deep_link_sub2`: Referrer identifier. Can be used to reward the referrer.

4. In the `completionHandler`, check if the URL was created successfully (`url` not `nil`), and retrieve the generated user invite link.

5. Enable users to share generated links. For example, copy it to their clipboard.

### Log invite link creation events

<span class="annotation-optional">Optional</span>  
**To log the invite link creation event**:  
Send an event indicating that a user has generated an invite link using [`logInvite`](doc:ios-sdk-reference-appsflyershareinvitehelper#loginvite):

```swift
AppsFlyerShareInviteHelper.logInvite(<CHANNEL>, parameters: [
    "campaign" : "summer_sale",
    "referrerId" : <REFERRER_ID>,
]);
```

`logInvite` results in an `af_invite` in-app event. 

> 📘 Note
> 
> If you don't want to use a channel, you can use `logEvent` instead.

### Set up UDL for user invite attribution

<span class="annotation-optional">Optional</span>  
**To set up UDL for user invite attribution:**

1. Set up [Unified Deep Linking](doc:unified-deep-linking-udl-1) (UDL). 

2. In `DeepLinkDelegate.didResolveDeepLink`, retrieve the deep linking parameters created during the link generation step. In this example, the following properties are retrieved:

   - `deep_link_value`, using `DeepLink.deeplinkValue`
   - `deep_link_sub1`, using `DeepLink.clickEvent["deep_link_sub1"]`
   - `deep_link_sub2`, using `DeepLink.clickEvent["deep_link_sub2"]`

   See code: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/11178dd846fa105cff295312286274824c556339/swift/basic_app/basic_app/AppDelegate.swift#L134).

3. Once you retrieve the referrer ID, it's up to you how it is stored and used.

Reward referrers
----------------

<span class="annotation-optional">Optional</span>  
In the following scenarios, **User A** invites **User B** to your app.

### Reward referrers on install

**Scenario:** User B installs your app via User A's invite link.  
User A's referrer ID is available in the UDL `didResolveDeepLink` (in this example, under `DeepLink.clickEvent["deep_link_sub2"]`). Once you retrieve the ID, add it to the list of referrer IDs to be rewarded. It's up to you how to store and retrieve the list.

### Reward referrers on in-app events

**Scenario:** User B makes a purchase. You want to reward User A, who initially referred User B to your app, for the action.

**To reward User A for User B's action:**

1. Retrieve user A's referrer ID and add it to one of the customizble in-app event parameters (for example, `af_param_1`):
   ```swift
   AppsFlyerLib.shared().logEvent(AFEventPurchase, 
     withValues: [
   		AFEventParamRevenue: 200,
   		AFEventParamCurrency:"USD",
           AFEventParam1: <REFERRER_ID>
     ]);
   ```
2. On your backend, [retrieve in-app event data](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-Overview#view-inapp-event-data).
3. Add the found referrer IDs to a list of users to be rewarded.
4. When User A launches the app, check if their referrer ID is on the list of users to be rewarded and reward them if it is.

> 📘 Note
> 
> - Steps 2-3 are not carried out by the mobile developer. Step 4 depends on how steps 2-3 are implemented.
> - A purchase event is just an example. This applies to any type of in-app event.