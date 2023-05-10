---
title: "Android User Invite"
slug: "dl_android_user_invite"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
createdAt: "2022-11-30T12:20:34.448Z"
updatedAt: "2023-01-19T15:14:19.232Z"
---
Implement user invites
----------------------

**Before you begin**: Sync with the marketer to find out the exact use cases they want for the links and to get a list of the [parameters](https://support.appsflyer.com/hc/en-us/articles/115004480866#parameters) they want to be implemented.

To implement user invite attribution, complete the following steps:

1. [Set up invite link generation](#set-up-invite-link-generation) to generate invite links.
2. <span class="annotation-optional">Optional</span> [Log the invite link creation](#log-invite-link-creation-events).
3. [Set up Unified Deep Linking](doc:unified-deep-linking-udl) (UDL)
4. <span class="annotation-optional">Optional</span> [Retrieve referrer data from user invite links](#set-up-udl-for-user-invite-attribution).
5. <span class="annotation-optional">Optional</span> Set up [referrer rewards](#reward-referrers).

The following code is based on the [marketer example](https://support.appsflyer.com/hc/en-us/articles/115004480866#example).

### Set up invite link generation

To enable users to invite their friends to your app, you need a way to generate user invite links. This is done using `LinkGenerator`.  
**To set up user invite link generation:**

1. Make sure to import the following dependencies:
   ```java
   import com.appsflyer.AppsFlyerLib;
   import com.appsflyer.CreateOneLinkHttpTask;
   import com.appsflyer.share.LinkGenerator;
   import com.appsflyer.share.ShareInviteHelper;
   ```

2. Set a OneLink template using [`setAppInviteOneLink()`](doc:android-sdk-reference-appsflyerlib#setappinviteonelink) (The template ID is [provided by the marketer](https://support.appsflyer.com/hc/en-us/articles/115004480866#procedures)):
   ```java
   AppsFlyerLib.getInstance().setAppInviteOneLink("H5hv"); // set the OneLink template ID the user invite links will be based on
   ```
   > 📘 Note
   > 
   > - Make sure to call `setAppInviteOneLink()` **before** calling `start`.
   > - The OneLink template must be related to the app.

3. Create a  [`LinkGenerator`](doc:android-sdk-reference-linkgenerator) using [`ShareInviteHelper.generateInviteUrl()`](doc:android-sdk-reference-shareinvitehelper#generateinviteurl).
   ```java
   LinkGenerator linkGenerator = ShareInviteHelper.generateInviteUrl(getApplicationContext());
   ```

4. Depending on the user flow you want to achieve, add the following parameters using [`linkGenerator.addParameter()`](doc:android-sdk-reference-linkgenerator#addparameter):
   ```java
   linkGenerator.addParameter("deep_link_value", <TARGET_VIEW>);
   linkGenerator.addParameter("deep_link_sub1", <PROMO_CODE>);
   linkGenerator.addParameter("deep_link_sub2", <REFERRER_ID>);
   // Optional; makes the referrer ID available in the installs raw-data report
   linkGenerator.addParameter("af_sub1", <REFERRER_ID>);
   ```
   - `deep_link_value`: The app experience the referred user should be deep linked into.
   - `deep_link_sub1`: Promo code received by the invitee.
   - `deep_link_sub2`: Referrer identifier. Can be used to reward the referrer.
   - **Note**: If you have SDK V6.5.2 or lower, you need to encode any parameter values with special characters.

5. Set [attribution parameters](doc:android-sdk-reference-linkgenerator#methods). (These will display in AppsFlyer dashboards and raw data reports).
   ```java
   linkGenerator.setCampaign("summer_sale");
   linkGenerator.setChannel("mobile_share");
   ```

6. <span class="annotation-optional">Optional</span> Set a branded domain for the generated link:

   ```java Java
   linkGenerator.setBrandDomain("brand.domain.com");
   ```

7. Create a `CreateOneLinkHttpTask.ResponseListener` to retrieve the user invite link when it's available:

   ```java
   CreateOneLinkHttpTask.ResponseListener listener = new CreateOneLinkHttpTask.ResponseListener() {
               @Override
               public void onResponse(String s) {
                   Log.d(LOG_TAG, "Share invite link: " + s);
                   // ...
               }

               @Override
               public void onResponseError(String s) {
                   Log.d(LOG_TAG, "onResponseError called");
               }
            
   };
   ```

- `onResponse()` is called when the user invite is created successfully.
- `onResponseError()` is called when link generation fails.

8. Pass `listener` to [`linkGenerator.generateLink()`](doc:android-sdk-reference-linkgenerator#generatelink-1):
   ```java
   linkGenerator.generateLink(getApplicationContext(), listener);
   ```

### Log invite link creation events

<span class="annotation-optional">Optional</span>  
**To log the invite link creation event**:  
Log the invite using [`logInvite()`](doc:android-sdk-reference-shareinvitehelper#loginvite):

```java
HashMap<String,String> logInviteMap = new HashMap<String,String>();
logInviteMap.put("referrerId", <REFERRER_ID>);
logInviteMap.put("campaign", "summer_sale");

ShareInviteHelper.logInvite(getApplicationContext(), "mobile_share", logInviteMap);
```

`logInvite` results in an `af_invite` in-app event.

> 📘 Note
> 
> If you don't want to use a channel, you can use `logEvent` instead.

### Set up UDL for user invite attribution

<span class="annotation-optional">Optional</span>  
**To set up UDL for user invite attribution:**  
Set up [Unified Deep Linking](doc:unified-deep-linking-udl) (UDL). In `DeepLinkListener.onDeepLinking()`, retrieve the deep linking parameters created during the link generation step. In this example, the following properties are retrieved:

- `deep_link_value`, using `DeepLink.getDeepLinkValue()`
- `deep_link_sub1`, using `DeepLink.getStringValue()`
- `deep_link_sub2`, using `DeepLink.getStringValue()`

See code: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/ee2a671926520c0aa031885da078f5ecf370c5c4/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L74).

Reward referrers
----------------

<span class="annotation-optional">Optional</span>  
In the following scenarios, **User A** invites **User B** to your app.

### Reward referrers on install

**Scenario:** User B installs your app via User A's invite link.

User A's ID is available in `DeepLinkListener.onDeepLinking()` and in this example, is retrieved using `DeepLink.getStringValue("deep_link_sub2")`. Once you retrieve the ID, add it to the list of referrer IDs to be rewarded. It's up to you how to store and retrieve the list.

### Reward referrers for user actions

**Scenario:** User B makes a purchase. You want to reward User A, who initially referred User B to your app, for the action.

**To reward User A for User B's action:**

1. Retrieve User A's referrer ID and add it to one of the customizable in-app event parameters (for example, `af_param_1`):
   ```java
    Map<String, Object> purchaseEventParameters = new HashMap<String, Object>();
    purchaseEventParameters.put(AFInAppEventParameterName.PARAM_1, <REFERRER_ID>);
    purchaseEventParameters.put(AFInAppEventParameterName.CURRENCY, "USD");
    purchaseEventParameters.put(AFInAppEventParameterName.REVENUE, 200);
    
    AppsFlyerLib.getInstance().logEvent(getApplicationContext(), purchaseEventParameters);
   ```

2. On your backend, [retrieve in-app event data](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-Overview#view-inapp-event-data)

3. Add the found referrer IDs to a list of users to be rewarded.

4. When User A launches the app, check if their referrer ID is on the list of users to be rewarded and reward them if it is.

> 📘 Note
> 
> - Steps 2-3 are not carried out by the mobile developer. Step 4 depends on how steps 2-3 are implemented.
> - A purchase event is just an example. This applies to any type of in-app event.