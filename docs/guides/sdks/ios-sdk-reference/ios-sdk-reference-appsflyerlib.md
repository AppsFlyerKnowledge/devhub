---
title: "AppsFlyerLib"
slug: "ios-sdk-reference-appsflyerlib"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3e14e22f76007884b6fc
hidden: false
createdAt: "2021-06-16T18:09:37.826Z"
updatedAt: "2023-05-07T09:12:24.329Z"
---
## Overview

`AppsFlyerLib` is the main class of the AppsFlyer iOS SDK, and encapsulates most of the methods.

To import `AppsFlyerLib`:

```objectivec
// AppDelegate.h
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AppsFlyerLibDelegate>

@end
```
```swift
import AppsFlyerLib
```

Go back to the [SDK reference index](doc:ios-sdk-reference).

## Properties

### advertisingIdentifier (read-only)

**Property declaration**

```objc
@property(nonatomic, strong, readonly) NSString *advertisingIdentifier
```

**Description**  
AppsFlyer SDK collect Apple's `advertisingIdentifier` if the `AdSupport.framework` included in the SDK.  
You can disable this behavior by setting the `disableAdvertisingIdentifier` to `true`.

| Type       | Name                    |
| :--------- | :---------------------- |
| `NSString` | `advertisingIdentifier` |

### anonymizeUser

**Property declaration**

```objc
@property(atomic) BOOL anonymizeUser;
```

**Description**  
Opt-out logging for specific user

| Type   | Name            |
| :----- | :-------------- |
| `bool` | `anonymizeUser` |

### appInviteOneLinkID

**Property declaration**

```objc
@property(nonatomic, strong, nullable, setter = setAppInviteOneLink:) NSString * appInviteOneLinkID
```

**Description**  
Set your OneLink ID from OneLink configuration. Used in User Invites to generate a OneLink.

| Type       | Name                 |
| :--------- | :------------------- |
| `NSString` | `appInviteOneLinkID` |

### appleAppID

**Property declaration**

```objc
@property(nonatomic, strong) NSString * appleAppID
```

**Description**  
Use this property to set your app’s Apple ID(taken from the app’s page on iTunes Connect)

| Type       | Name         |
| :--------- | :----------- |
| `NSString` | `appleAppID` |

### appsFlyerDevKey

**Property declaration**

```objc
@property(nonatomic, strong) NSString * appsFlyerDevKey
```

**Description**  
Use this property to set your [AppsFlyer dev key](https://support.appsflyer.com/hc/en-us/articles/207032066#integration-2-integrating-the-sdk).

| Type       | Name              | Description             |
| :--------- | :---------------- | :---------------------- |
| `NSString` | `appsFlyerDevKey` | Your AppsFlyer dev key. |

### currencyCode

**Property declaration**

```objc
@property(nonatomic, strong, nullable) NSString *currencyCode
```

**Description**  
In case of in app purchase events, you can set the currency code your user has purchased with.  
The currency code is a [3 letter code according to ISO standards](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3).

**Usage example**

```objc
[[AppsFlyerLib shared] setCurrencyCode:@"USD"];
```
```swift
AppsFlyerLib.shared().currencyCode = "USD"
```

### customData

> 📘
> Setting `customData` before first launch will have the additional data included in installs, sessions, as well as in-app events.

**Property declaration**

```objc
@property(nonatomic, strong, nullable, setter = setAdditionalData:) NSDictionary * customData
```

**Description**  
Use to add custom data to events' payload. You will receive it in the raw-data reports.

| Type           | Name         |
| :------------- | :----------- |
| `NSDictionary` | `customData` |

### customerUserID

**Property declaration**

```objc
@property(nonatomic, strong, nullable) NSString * customerUserID
```

**Description**  
In case you use your own user ID in your app, you can set this property to that ID.  
Enables you to cross-reference your own unique ID with AppsFlyer’s unique ID and the other devices’ IDs

| Type       | Name             |
| :--------- | :--------------- |
| `NSString` | `customerUserID` |

### deepLinkDelegate

**Property declaration**

```objc
@property(weak, nonatomic) id<AppsFlyerDeepLinkDelegate> deepLinkDelegate
```

**Description**  
Delegate property of an object, that conforms to DeepLinkDelegate protocol and implements its methods.

| Type               | Name               |
| :----------------- | :----------------- |
| `DeepLinkDelegate` | `deepLinkDelegate` |

**Usage example**

```swift
AppsFlyerLib.shared().deepLinkDelegate = self
```

### deepLinkTimeout

**Description**  
Request timeout for **Deferred Deeplinking**.

Units in milliseconds.

**Property declaration**

```objc
@property(nonatomic) NSUInteger deepLinkTimeout
```

| Type         | Name              |
| :----------- | :---------------- |
| `NSUInteger` | `deepLinkTimeout` |

### delegate

**Description**  
AppsFlyer delegate. See [AppsFlyerLibDelegate](doc:ios-sdk-reference-appsflyerlibdelegate).  
**Property declaration**

```objc
@property (nonatomic, weak) id<AppsFlyerLibDelegate> delegate;
```

| Type                                                                 | Name       |
| :------------------------------------------------------------------- | :--------- |
| [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate) | `delegate` |

### disableAdvertisingIdentifier

**Property declaration**

```objc
@property (nonatomic) int disableAdvertisingIdentifier;
```

**Description**  
If `AdSupport.framework` isn't disabled, the SDK collects the Apple `advertisingIdentifier`.  
You can disable this behavior by setting the following property to `YES`.

| Type       | Name                    |
| :--------- | :---------------------- |
| `NSString` | `advertisingIdentifier` |

### disableAppleAdsAttribution

**Property declaration**

```objc
@property(nonatomic) BOOL disableAppleAdsAttribution
```

**Description**

| Type   | Name                         |
| :----- | :--------------------------- |
| `bool` | `disableAppleAdsAttribution` |

### disableCollectASA

**Property declaration**

```objc
@property(atomic) BOOL disableCollectASA;
```

**Description**  
Opt-out of Apple Search Ads attributions.

| Type   | Name                |
| :----- | :------------------ |
| `bool` | `disableCollectASA` |

### disableIDFVCollection

**Property declaration**

```objc
@property(nonatomic) BOOL disableIDFVCollection;
```

**Description**  
To disable app vendor identifier (IDFV) collection, set `disableIDFVCollection` to `YES`.

| Type   | Name                    |
| :----- | :---------------------- |
| `bool` | `disableIDFVCollection` |

### disableSKAdNetwork

**Property declaration**

```objc
@property(nonatomic) BOOL disableSKAdNetwork
```

**Description**

| Type   | Name                 |
| :----- | :------------------- |
| `bool` | `disableSKAdNetwork` |

### facebookDeferredAppLink

**Property declaration**

```objc
@property (nonatomic, nullable) int *facebookDeferredAppLink;
```

**Description**  
Manually set Facebook deferred app link.

| Type       | Name                    |
| :--------- | :---------------------- |
| `NSString` | `advertisingIdentifier` |

### host (read-only)

**Property declaration**

```objc
@property(nonatomic, strong, readonly) NSString *host
```

**Description**  
This property accepts a string value representing the host name for all endpoints.  To set the host, use [setHost](#sethost).

To use default SDK endpoint – set value to `nil`.

| Type       | Name   |
| :--------- | :----- |
| `NSString` | `host` |

### hostPrefix (read-only)

**Property declaration**

```objc
@property(nonatomic, strong, readonly) NSString *hostPrefix
```

**Description**  
This property accepts a string value representing the prefix hostname for all endpoints. To set the host, use [setHost](#sethost).

| Type       | Name         |
| :--------- | :----------- |
| `NSString` | `hostPrefix` |

### isDebug

**Property declaration**

```objc
@property(nonatomic) BOOL isDebug;
```

**Description**  
Prints SDK messages to the console log. Should be disabled for production builds.

| Type   | Name      |
| :----- | :-------- |
| `bool` | `isDebug` |

### isStopped

**Property declaration**

```objc
@property(atomic) BOOL isStopped;
```

> 📘 SDK Restart
> 
> Set `isStopped = true` and then set `isStopped = false`  
> 
> No need to call `start()`

**Description**  
API to shut down all SDK activities. This will disable all requests from the SDK except for those related to fetching SKAd Network data from the server.

| Type   | Name        |
| :----- | :---------- |
| `bool` | `isStopped` |

### minTimeBetweenSessions

**Property declaration**

```objc
@property(atomic) NSUInteger minTimeBetweenSessions;
```

**Description**  
Set a custom value for the minimum required time between sessions.

**Input arguments**

| Type         | Name                     | Description                                                                                                                                                         |
| :----------- | :----------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `NSUInteger` | `minTimeBetweenSessions` | Sets the minimum time that must pass between two app launches to count as two separate sessions. If not set, the default minimum time between sessions is 5 seconds |

### oneLinkCustomDomains

**Property declaration**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *oneLinkCustomDomains;
```

**Description**  
For advertisers who use vanity OneLinks.

| Type                  | Name                   |
| :-------------------- | :--------------------- |
| `NSArray<NSString *>` | `oneLinkCustomDomains` |

### phoneNumber

**Property declaration**

```objc
@property(nonatomic, nullable) NSString *phoneNumber
```

**Description**

| Type       | Name          |
| :--------- | :------------ |
| `NSString` | `phoneNumber` |

### resolveDeepLinkURLs

**Property declaration**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *resolveDeepLinkURLs;
```

**Description**

| Type                  | Name                  |
| :-------------------- | :-------------------- |
| `NSArray<NSString *>` | `resolveDeepLinkURLs` |

**Usage example**  
Some third-party services such as email service providers (ESPs) wrap links in emails with their own click recording domains. Some even allow you to set your own click recording domains. If OneLink is wrapped in such domains, it might limit its functionality.

To overcome this issue, use `setResolveDeepLinkURLs` to get the OneLink from click domains that launch the app. Make sure to call this API before SDK initialization.

For example, you have three click domains that redirect to your OneLink which is <https://mysubdomain.onelink.me/abCD>. Use this API to get the OneLink that your click domains redirect to. This API method receives a list of domains that the SDK resolves.

```objectivec
[AppsFlyerLib shared].resolveDeepLinkURLs = @[@"example.com",@"click.example.com"];
```
```swift
AppsFlyerLib.shared().resolveDeepLinkURLs = ["example.com", "click.example.com"]
```

This allows you to use your click domain while preserving OneLink functionality. The click domains are responsible for launching the app. The API, in turn, gets the OneLink from these click domains, and then you can use the data from this OneLink to deep-link and customize user content.

### sharingFilter

**Property declaration**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *sharingFilter;
```

**Description**

| Type                  | Name            |
| :-------------------- | :-------------- |
| `NSArray<NSString *>` | `sharingFilter` |

### shouldCollectDeviceName

**Property declaration**

```objc
@property(nonatomic) BOOL shouldCollectDeviceName;
```

**Description**  
Set this flag to YES, to collect the current device name(e.g. “My iPhone”). 

| Type   | Name                      |
| :----- | :------------------------ |
| `bool` | `shouldCollectDeviceName` |

### useReceiptValidationSandbox

**Property declaration**

```objc
@property (nonatomic) BOOL useReceiptValidationSandbox;
```

**Description**  
In-app purchase receipt validation Apple environment(production or sandbox).

| Type   | Name                          |
| :----- | :---------------------------- |
| `bool` | `useReceiptValidationSandbox` |

### useUninstallSandbox

**Property declaration**

```objc
@property (nonatomic) BOOL useUninstallSandbox;
```

**Description**  
Set this flag to test uninstall on Apple environment(production or sandbox).

| Type   | Name                  |
| :----- | :-------------------- |
| `bool` | `useUninstallSandbox` |

## Methods

### addPushNotificationDeepLinkPath

**Method signature**

```objc
- (void)addPushNotificationDeepLinkPath:(NSArray<NSString *> *)deepLinkPath;
```
```swift
addPushNotificationDeepLinkPath(deepLinkPath: [String])
```

**Description**  
Adds array of keys, which are used to compose key path to resolve deeplink from push notification payload.

**Input arguments**

| Type                  | Name           |
| :-------------------- | :------------- |
| `NSArray<NSString *>` | `deepLinkPath` |

**Returns**  
`void`.

**Usage example**  
Basic configuration:

```objc
[AppsFlyerLib shared] addPushNotificationDeepLinkPath:@[@"af_push_link"]]
```
```swift
AppsFlyerLib.shared().addPushNotificationDeepLinkPath(["af_push_link"])
```

Advanced configuration:

```objc
[AppsFlyerLib shared] addPushNotificationDeepLinkPath:@[@"deeply", @"nested", @"deep_link"]]
```
```swift
AppsFlyerLib.shared().addPushNotificationDeepLinkPath(["deeply", "nested", "deep_link"])
```

This call matches the following payload structure:

```json
{
  "deeply": {
      "nested": {
          “deep_link”: “https://yourdeeplink2.onelink.me”
      }
  }
}
```

### appendParametersToDeepLinkingURL

**Method signature**

```objc
(void)appendParametersToDeepLinkingURLWithString:(NSString *)containsString parameters:(NSDictionary<NSString *, NSString*> *)parameters;
```
```swift
appendParametersToDeeplinkURL(contains: String, parameters: [String : String])
```

**Description**  
Matches URLs that contain `contains` as a substring and appends query parameters to them. In case the URL does not match, parameters are not appended to it.

> 🚧 
> 
> Call this method before calling [`start`](#start)

**Input arguments**

| Type           | Name         | Description                                                          |
| :------------- | :----------- | :------------------------------------------------------------------- |
| `NSString`     | `contains`   | The string to check in URL.                                          |
| `NSDictionary` | `parameters` | Parameters to append to the deeplink url after it passed validation. |

**Returns**  
`void`.

### continue

**Method signature**

```objc
- (id)continueUserActivity:(id)userActivity
restorationHandler:
(void (^_Nullable)(int *_Nullable))restorationHandler;
```
```swift
AppsFlyerLib.shared().continue(userActivity: NSUserActivity?, restorationHandler: (([Any]?) -> Void)?)
```

**Description**  
Allow AppsFlyer to handle restoration from an \``NSUserActivity`. Use this method to handle Universal links.

**Input arguments**

| Type                                | Name                 | Description                                               |
| :---------------------------------- | :------------------- | :-------------------------------------------------------- |
| `NSUserActivity`                    | `userActivity`       | The `NSUserActivity` that was passed to your app delegate |
| `void (^_Nullable)(int *_Nullable)` | `restorationHandler` | pass `nil`                                                |

**Returns**  
`void`.

### enableFacebookDeferderedApplinks

**Method signature**

```objc
- (void)enableFacebookDeferredApplinksWithClass:(Class _Nullable)facebookAppLinkUtilityClass;
```
```swift
enableFacebookDeferredApplinks(with:AnyClass?)
```

**Description**  
Enable the collection of Facebook Deferred AppLinks.

- Requires Facebook SDK and Facebook app on target/client device.
- This API must be invoked prior to initializing the AppsFlyer SDK in order to function properly

**Input arguments**

| Type                  | Name                          | Description |
| :-------------------- | :---------------------------- | :---------- |
| `FBSDKAppLinkUtility` | `facebookAppLinkUtilityClass` |             |

**Returns**  
`void`.

### getAppsFlyerUID

**Method signature**

```objc
- (NSString *)getAppsFlyerUID;
```
```swift
getAppsFlyerUID()
```

**Description**  
Get AppsFlyer's unique device ID. The SDK generates an AppsFlyer unique device ID upon app installation. When the SDK is started, this ID is recorded as the ID of the first app install.

**Input arguments**  
This method takes no input arguments.

**Returns**

| Type       | Description            |
| :--------- | :--------------------- |
| `NSString` | AppsFlyer internal ID. |

### getSDKVersion

**Method signature**

```objc
- (NSString *)getSDKVersion;
```
```swift
getSDKVersion()
```

**Description**  
Get SDK version.

**Input arguments**  
This method takes no input arguments.

**Returns**

| Type       | Description                |
| :--------- | :------------------------- |
| `NSString` | The AppsFlyer SDK version. |

### handleOpen

**Method signature**

```objc
- (void)handleOpenUrl:(id)url options:(id)options;
```
```swift
AppsFlyerLib.shared().handleOpen(url: URL?, options: [AnyHashable : Any]?)
```

**Description**  
Call this method from inside of your AppDelegate `openURL` method.  
This method handles URI-scheme for iOS 9 and above.

**Input arguments**

| Type          | Name      | Description                                                 |
| :------------ | :-------- | :---------------------------------------------------------- |
| `NSURL`       | `url`     | The URL that was passed to your app delegate.               |
| `AnyHashable` | `options` | The options dictionary that was passed to your AppDelegate. |

**Returns**  
`void`.

### handlePushNotification

**Method signature**

```objc
- (void)handlePushNotification:(NSDictionary * _Nullable)pushPayload;
```
```swift
AppsFlyerLib.shared().handlePushNotification(pushPayload: [AnyHashable : Any]?)
```

**Description**  
Enable AppsFlyer to handle a push notification.

**Input arguments**

| Type          | Name          | Description                                                                                                                                                                     |
| :------------ | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `AnyHashable` | `pushPayload` | The `userInfo` from received remote notification. Unless [`addPushNotificationDeepLinkPath`](#addPushNotificationDeepLinkPath) is used, the data must be under the `@“af”` key. |

**Returns**  
`void`.

### logEvent

**Method signature**

```objc
- (void)logEvent:(NSString *)eventName withValues:(NSDictionary * _Nullable)values;
```
```swift
logEvent(eventName: String, withValues: [AnyHashable : Any]?)
```

**Description**  
Use this method to log an event with event parameters.

**Input arguments**

| Type          | Name         | Description                                                             |
| :------------ | :----------- | :---------------------------------------------------------------------- |
| `NSString`    | `eventName`  | Contains name of event that could be provided from predefined constants |
| `AnyHashable` | `withValues` | dictionary of values for handling by backend                            |

**Returns**  
`void`.

### logEvent

**Method signature**

```objc
- (void)logEventWithEventName:(NSString *)eventName
  eventValues:(NSDictionary<NSString * , id> * _Nullable)eventValues
  completionHandler:(void (^ _Nullable)(NSDictionary<NSString *, id> * _Nullable dictionary, NSError * _Nullable error))completionHandler;
```
```swift
logEvent(eventName: String, withValues: [AnyHashable : Any]?, completionHandler:(([String : Any]?, Error?) -> Void)?)
```

**Description**  
Use this method to log an event with event parameters, and pass a completion handler to [handle event submissions success and failure](doc:in-app-events-ios#handling-event-submission-success-and-failure). 

**Input arguments**

| Type                                                                                             | Name                | Description                                                             |
| :----------------------------------------------------------------------------------------------- | :------------------ | :---------------------------------------------------------------------- |
| `NSString`                                                                                       | `eventName`         | Contains name of event that could be provided from predefined constants |
| `AnyHashable`                                                                                    | `withValues`        | dictionary of values for handling by backend                            |
| `(^ _Nullable)(NSDictionary<NSString _, id> _ _Nullable dictionary, NSError * _Nullable error))` | `completionHandler` |                                                                         |

**Returns**  
`void`.

### logLocation

**Method signature**

```objc
- (void)logLocation:(double)longitude latitude:(double)latitude;
```
```swift
logLocation(longitude: Double, latitude: Double)
```

**Description**  
To log location for geo-fencing. Does the same as code below.

**Input arguments**

| Type     | Name        | Description            |
| :------- | :---------- | :--------------------- |
| `Double` | `longitude` | The location longitude |
| `Double` | `latitude`  | The location latitude  |

**Returns**  
`void`.

### performOnAppAttribution

**Method signature**

```objc
- (void)performOnAppAttributionWithURL:(NSURL * _Nullable)URL;
```
```swift
performOnAppAttribution(with:URL?)
```

**Description**  
Used to manually trigger `onAppOpenAttribution` delegate.

**Input arguments**

| Type    | Name  | Description                                                                 |
| :------ | :---- | :-------------------------------------------------------------------------- |
| `NSURL` | `URL` | The parameter to resolve into -[AppsFlyerLibDelegate onAppOpenAttribution:] |

**Returns**  
`void`.

### registerUninstall

**Method signature**

```objc
- (void)registerUninstall:(NSData * _Nullable)deviceToken;
```
```swift
registerUninstall(deviceToken: Data?)
```

**Description**  
Register uninstall - you should register for remote notification and provide AppsFlyer the push device token.

**Input arguments**

| Type     | Name          | Description                                                                                                                                                                                                    |
| :------- | :------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `NSData` | `deviceToken` | The `deviceToken` is from [`didRegisterForRemoteNotificationsWithDeviceToken`](https://developer.apple.com/documentation/watchkit/wkextensiondelegate/3141924-didregisterforremotenotification?language=objc). |

**Returns**  
`void`.

### setConsentData

**Method signature**

```swift
.setConsentData(afConsent: AppsFlyerConsent)
```
```objectivec
- (void)setConsentData:(AppsFlyerConsent) afConsent
```

**Description**

Transfers consent data to the SDK. 

**Input arguments**

| Type                   | Name      | Description                            |
| ---------------------- | --------- | -------------------------------------- |
| [AppsFlyerConsent](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerconsent) | afConsent | An object containing user consent data |

### setCurrentDeviceLanguage

**Method signature**

```objc
- (void)setCurrentDeviceLanguage:(NSString *)currentDeviceLanguage
```

**Description**  
Use this method to set the device language in the SDK and pass it to AppsFlyer.

**Input arguments**

| Type       | Name                    | Description              |
| :--------- | :---------------------- | :----------------------- |
| `NSString` | `currentDeviceLanguage` | Current device language. |

**Usage example**

```objc
NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0]
    [[AppsFlyerLib shared] setCurrentDeviceLanguage: @language];
```
```swift
let language = NSLocale.current.languageCode
AppsFlyerLib.shared().currentDeviceLanguage = language
```

### setHost

**Method signature**

```objc
(void)setHost:(NSString *)host withHostPrefix:(NSString *)hostPrefix;
```
```swift
setHost(host: String, withHostPrefix: String)
```

**Description**  
This function sets the hostname and prefix hostname for all the endpoints.

**Note**: Starting with SDK V6.11, if the host value is empty or null, the API call will be ignored.

**Input arguments**

| Type       | Name             | Description            |
| :--------- | :--------------- | :--------------------- |
| `NSString` | `host`           | hostname.              |
| `NSString` | `withHostPrefix` | Required. host prefix. |

**Returns**  
`void`.

** Usage example**

```objc
[[AppsFlyerLib shared] setHost:@"example.com" withHostPrefix:@"my_host_prefix"];
```
```swift
AppsFlyerLib.shared().setHost("example.com", withHostPrefix: "my_host_prefix")
```

### setPartnerData

**Method signature**

```objc
- (void)setPartnerDataWithPartnerId:(NSString * _Nullable)partnerId partnerInfo:(NSDictionary<NSString *, id> * _Nullable)partnerInfo;
```
```swift
setPartnerData(partnerId: String?, partnerInfo: [String : Any]?)
```

**Description**  
Allows sending custom data for partner integration purposes.

**Input arguments**

| Type                                       | Name          | Description                                                            |
| :----------------------------------------- | :------------ | :--------------------------------------------------------------------- |
| `NSString`                                 | `partnerId`   | ID of the partner (usually has `_int` suffix)                          |
| `NSDictionary<NSString _, id> _ _Nullable` | `partnerInfo` | customer data, depends on the integration nature with specific partner |

**Returns**  
`void`.

**Usage example**

```objectivec
NSDictionary *partnerInfo = @{
 @"puid": @"123456789",
};

[[AppsFlyerLib shared] setPartnerDataWithPartnerId: @"test_int" partnerInfo:partnerInfo];
```
```swift
let partnerInfo = [
  "puid":"123456789",
]

AppsFlyerLib.shared().setPartnerData(partnerId:"test_int", partnerInfo:partnerInfo)
```

### setSharingFilterForPartners

<span class="annotation-added">Added in V6.4</span>  
**Method signature**

```objc
- (void)setSharingFilterForPartners:(NSArray<NSString *> * _Nullable)sharingFilter;
```

This function replaces the deprecated [`setSharingFilterForAllPartners`](#setsharingfilterforallpartners)

**Description**  
Lets you configure which partners should the SDK exclude from data-sharing.

**Input arguments**

[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`NSArray<NSString _> _ _Nullable`",
    "0-1": "`sharingFilter`",
    "0-2": "One or more partner identifiers you wish to exclude. Must include letters/digits and underscores only.  \n  \nMaximum partner ID length: 45"
  },
  "cols": 3,
  "rows": 1,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]

**Note:** 
To find out the required partner IDs:
1. Run the [Get active integrations API](https://dev.appsflyer.com/hc/reference/get_v1-integrations) for a list of all active integrations
2. Use the `media_source_name` values from the [API response](https://dev.appsflyer.com/hc/reference/get_v1-integrations) as input values to the method `partners` array. 

**Exceptions**:
- For Apple Search Ads use `Apple Search Ads` (and not `iossearchads_int`).
- For Twitter, use `twitter` (and not `twitter_int`)

**Usage example**

```objectivec
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"examplePartner1_int"]]; // 1 partner
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"examplePartner1_int", @"examplePartner2_int"]]; // multiple partners
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"all"]]; // All partners
[[AppsFlyerLib shared] setSharingFilterForPartners:nil]; // Reset list (default)
```
```swift
AppsFlyerLib.shared().setSharingFilterForPartners(["examplePartner1_int"]) // 1 partner
AppsFlyerLib.shared().setSharingFilterForPartners(["examplePartner2_int", "examplePartner1_int"]) // multiple partners
AppsFlyerLib.shared().setSharingFilterForPartners(["all"]) // All partners
AppsFlyerLib.shared().setSharingFilterForPartners(nil) // Reset list (default)
```

### setSharingFilterForAllPartners

<span class="annotation-deprecated">Deprecated in V6.4</span>  
**Method signature**

```objc
- (void)setSharingFilterForAllPartners;
```
```swift
setSharingFilterForAllPartners()
```

This function is deprecated and has been replaced by [`setSharingFilterForPartners`](#setsharingFilterforpartners)

**Description**  
Block an event from being shared with integrated partners.

**Input arguments**  
This method takes no input arguments.

**Returns**  
`void`

### setUserEmails

**Method signature**

```objc
- (void)setUserEmails:(NSArray<NSString *> * _Nullable)userEmails withCryptType:(EmailCryptType)type;
```
```swift
setUserEmails(userEmails: [String]?, with: EmailCryptType)
```

**Description**  
Use this to set the user email(s).
**Note**: `MD-5` and `SHA-1` encryption types are deprecated starting with SDK V6.9.0. Currently, only `SHA-256` and `NONE` are supported.

**Input arguments**

| Type                  | Name         | Description      |
| :-------------------- | :----------- | :--------------- |
| `NSArray<NSString *>` | `userEmails` | Email array.     |
| `EmailCryptType`      | `type`       | Encryption type. |

**Returns**  
`void`.

### shared

**Method signature**

```objc
(AppsFlyerLib *)shared;
```

**Description**  
Gets the singleton instance of the `AppsFlyerLib` class, creating it if necessary.

**Usage example**

```swift Swift
AppsFlyerLib.shared()
```

### start

**Method signature**

```objc
- (void)start;
```
```swift
(void) start()
```

**Description**  
Starts the SDK.

**Input arguments**  
This method takes no input arguments.

**Returns**  
`void`.

### start

**Method signature**

```objc
- (void)startWithCompletionHandler:(void (^ _Nullable)(NSDictionary<NSString *, id> * _Nullable dictionary, NSError * _Nullable error))completionHandler;
```
```swift
start(completionHandler: (([String : Any]?, Error?) -> Void)?)
```

**Description**  
Start the SDK with a [completion handler](<>).

**Input arguments**

| Type                                                                                                 | Name                | Description |
| :--------------------------------------------------------------------------------------------------- | :------------------ | :---------- |
| `void (^ _Nullable)(NSDictionary<NSString _, id> _ _Nullable dictionary, NSError * _Nullable error)` | `completionHandler` |             |

**Returns**  
`void`.

### validateAndLogLogInAppPurchase

**Method signature**

```objc
- (void)validateAndLogInAppPurchase:(id)productIdentifier
price:(id)price
 currency:(id)currency
transactionId:(id)transactionId
additionalParameters:(id)params
success:(void (^_Nullable)(int *))successBlock
failure:
(void (^_Nullable)(int *_Nullable,
 id _Nullable))failedBlock;
```
```swift
validateAndLog(inAppPurchase: String?, price: String?, currency: String?, transactionId: String?, additionalParameters: [AnyHashable : Any]?, success: ([AnyHashable : Any]) -> Void)?, failure: ((Error?, Any?) -> Void)?)
```

**Description**  
To log and validate in-app purchases you can call this method from the [`completeTransaction`] method in your `SKPaymentTransactionObserver`.

**Input arguments**

| Type                                                | Name                   | Description                                                |
| :-------------------------------------------------- | :--------------------- | :--------------------------------------------------------- |
| `NSString`                                          | `productIdentifier`    | `inAppPurchase` in Swift.                                  |
| `NSString`                                          | `price`                |                                                            |
| `NSString`                                          | `currency`             |                                                            |
| `NSString`                                          | `transactionId`        |                                                            |
| `NSDictionary`                                      | `additionalParameters` |                                                            |
| `void (^_Nullable)(int *))successBlock`             | `successBlock`         | Completion handler for successful logging and  validation. |
| `void (^_Nullable)(int *_Nullable,  id _Nullable))` | `failedBlock`          | Completion handler for failure in logging and  validation. |

**Returns**  
`void`.

### waitForATTUserAuthorization

**Method signature**

```objc
- (void)waitForATTUserAuthorizationWithTimeoutInterval:(id)timeoutInterval;
```
```swift
waitForATTUserAuthorization(timeoutInterval:)
```

**Description**  
Waits for request user authorization to access app-related data

**Input arguments**

| Type        | Name              | Description |
| :---------- | :---------------- | :---------- |
| `NSInteger` | `timeoutInterval` |             |

**Usage example**

```objc Objective-C
if (@available(iOS 14, *)) {
        [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status){
        }];
    }
```
```swift Swift
if #available(iOS 14, *) {
            AppsFlyerLib.shared().waitForATTUserAuthorization(withTimeoutInterval: 60)
            ATTrackingManager.requestTrackingAuthorization { (status) in
            }
        }
```

**Returns**  
`void`.
