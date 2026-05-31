---
title: Migrate iOS SDK to V7
slug: migrate-ios-sdk-to-v7
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk-7
privacy:
  view: public
position: 1
---

## Before you begin

This guide walks you through migrating your iOS app from AppsFlyer SDK 6 to SDK 7. SDK 7 introduces a new session control model, removes several deprecated APIs, and aligns iOS behavior with Android. Use this guide to identify what you need to change, understand why each change was made, and update your integration in the right order.

> 📘 Note
>
> The vast majority of `AppsFlyerLib` methods remain unchanged between SDK 6 and SDK 7. This guide covers only the changes you need to make. You don't need to rewrite your integration from scratch.

### SDK 6 support policy

SDK 6 continues to be supported, but only for critical fixes. All new features are planned for SDK 7 only. We recommend migrating as soon as possible to stay current with new capabilities.

### What to expect

- **Low risk**: method renames in link generation and event logging — update call sites, no logic changes.
- **Medium risk**: delegate migration and parameter type changes — replace callbacks and update method signatures.
- **High risk**: session readiness initialization pattern — if not handled correctly, the SDK will not start.

**Estimated migration time**: 1–4 hours, depending on your app's complexity and use of removed APIs.

---

## The iOS SDK 7 session model

The SDK 7 gives you control over when to start the first session. In SDK 6, the session started automatically. The SDK would fire a session as soon as the app called `start()` in the `didBecomeActive` lifecycle. In SDK 7, session startup is explicit: you call `start` inside a `registerSessionReadyListener` callback when your app is ready.

This change addresses a real-world need. Many iOS apps must complete steps before sending a launch event to AppsFlyer — for example, requesting ATT authorization, collecting CMP consent, or retrieving a customer user ID.

SDK 7 also tightens initialization: `appsFlyerDevKey` and `appleAppID` are now read-only properties. Credentials must be set exactly once using `initialize(devKey:appId:)`, preventing accidental re-initialization.

---

## Upgrade checklist

Work through these in order — higher-risk changes first. The Risk column tells you whether skipping a step causes a **compile error** (caught at build time) or a **silent regression** (compiles but misbehaves at runtime).

| # | Action | Risk | Section |
|---|---|---|---|
| **High-risk changes** | | | |
| 1 | Replace direct assignments to `appsFlyerDevKey` and `appleAppID` with `initialize(devKey:appId:)`. Call it before any other SDK call. | Compile error | [§1](#1-initialize-credentials) |
| 2 | Remove `onAppOpenAttribution` and `onAppOpenAttributionFailure` from your `AppsFlyerLibDelegate`. Migrate to `AppsFlyerDeepLinkDelegate.didResolveDeepLink`. | Compile error | [§3](#3-migrate-to-the-deep-link-delegate) |
| 3 | Replace `waitForATTUserAuthorization(timeoutInterval:)` with `registerSessionReadyListener`. Call `start` inside the listener block if you're starting the SDK only after collecting ATT consent from the user. | Compile error | [§2](#2-call-start-with-the-session-readiness-listener) |
| 4 | Swap `setHost` arguments: rename to `setHost(_:hostName:)`, reverse order — prefix first, host name second. | Silent regression | [§5](#5-swap-the-host-method-argument-order) |
| 5 | Set `deepLinkDelegate` before `start` fires. | Silent regression | [§3](#3-migrate-to-the-deep-link-delegate) |
| 6 | Call `handleLaunchOptions` before registering the listener (Universal Links only). | Silent regression | [§2](#2-call-start-with-the-session-readiness-listener) |
| **Helper class updates** | | | |
| 7 | `generateInviteUrl(linkGenerator:)` → `generateInviteLink(linkGenerator:)`. Add the `Error` handler to the completion block. | Compile error | [§8](#8-update-shareinvitehelper-method-signatures) |
| 8 | `logInvite(_:parameters:)` → `logInvite(_:eventParameters:)`. | Compile error | [§8](#8-update-shareinvitehelper-method-signatures) |
| 9 | Update `logCrossPromoteImpression`: `appID:` → `appId:`, `parameters:` → `userParams:`. | Compile error | [§9](#9-update-crosspromotionhelper-parameter-labels) |
| 10 | Update `logAndOpenStore`: `appID:` → `promotedAppId:`, `parameters:` → `userParams:`. | Compile error | [§9](#9-update-crosspromotionhelper-parameter-labels) |
| 11 | Update `AppsFlyerLinkGenerator`: remove `setAppleAppID` and `setDeeplinkPath`; `setReferrerImageURL` → `setReferrerImageUrl`; `setBaseDeeplink` → `setBaseDeepLink`; `addParameters` → `addUserParams`. | Compile error | [§10](#10-update-linkgenerator-call-sites) |
| **Deprecated API removals** | | | |
| 12 | Replace the 6-parameter `validateAndLogInAppPurchase` with `validateAndLogInAppPurchase(purchaseDetails:purchaseAdditionalDetails:)` using `AFSDKPurchaseDetails`. | Compile error | [§6](#6-switch-to-the-purchase-details-object) |
| 13 | Replace `setSharingFilterForAllPartners` with `setSharingFilterForPartners(["all"])`. | Compile error | [§7](#7-remove-the-all-partners-sharing-filter) |
| **Renames** | | | |
| 14 | `getSDKVersion` → `getSdkVersion`. | Compile error | [§11](#11-apply-remaining-method-renames) |
| 15 | Update Swift: `appendParametersToDeeplinkURL` → `appendParametersToDeepLinkingURL`. | Compile error (Swift) | [§11](#11-apply-remaining-method-renames) |
| 16 | Update Swift: `setPartnerData(partnerId:partnerInfo:)` → `setPartnerData(partnerId:data:)`. | Compile error (Swift) | [§11](#11-apply-remaining-method-renames) |
| 17 | Update Swift: `DeepLinkDelegate` → `AppsFlyerDeepLinkDelegate`. | Compile error (Swift) | [§4](#4-update-the-deep-link-delegate-name-in-swift) |
| **Optional** | | | |
| 18 | Add `AppsFlyerLibConfig.plist` for constant SDK configuration values. | - | [Part 2](#part-2-new-capabilities) |

---

## Part 1: Breaking changes

The following changes will cause compile errors — or, in one case, a silent runtime regression — if not addressed. Work through them in the order below.

### 1. Initialize credentials

**What changed:** `appsFlyerDevKey` and `appleAppID` are now read-only. You can no longer assign to them directly. Instead, call `initialize(devKey:appId:)` once before any other SDK call. KVC paths that write to these properties fail silently at runtime.

**Compile error:** Existing code breaks on upgrade

> 📘 Note
>
> For SDK-level configuration (debug mode, currency, identifier collection, SKAdNetwork, custom host), you can use `AppsFlyerLibConfig.plist` instead of code. See [Part 2](#part-2-new-capabilities) for details.

```objc Objective-C
// 6.x - DO NOT use in 7.0
[AppsFlyerLib shared].appsFlyerDevKey = @"YOUR_DEV_KEY";
[AppsFlyerLib shared].appleAppID = @"123456789";

// 7.0
[[AppsFlyerLib shared] initWithDevKey:@"YOUR_DEV_KEY" appleAppId:@"123456789"];
```
```swift Swift
// 6.x - DO NOT use in 7.0
AppsFlyerLib.shared().appsFlyerDevKey = "YOUR_DEV_KEY"
AppsFlyerLib.shared().appleAppID = "123456789"

// 7.0
AppsFlyerLib.shared().initialize(devKey: "YOUR_DEV_KEY", appId: "123456789")
```

---

### 2. Call start with the session readiness listener

This is the most significant change in SDK 7. You must call `registerSessionReadyListener` before calling `start`. Call `start` inside the listener block. The listener fires once per foreground cycle when the SDK is ready to start.

`waitForATTUserAuthorization(timeoutInterval:)` is deprecated and no longer controls when `start` fires — the SDK no longer manages ATT timing internally.

If your app supports Universal Links, call `handleLaunchOptions` before registering the listener. This registers cold-launch deep link context so the listener can wait for deep link resolution before firing.

#### Call start without preconditions

Use this if your app has no pre-start conditions.

```objc Objective-C
// 6.x - DO NOT use in 7.0
[[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
[[AppsFlyerLib shared] start];

// 7.0
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[AppsFlyerLib shared] initWithDevKey:@"YOUR_DEV_KEY" appleAppId:@"123456789"];

    // Optional - only needed if supporting Universal Links
    [[AppsFlyerLib shared] handleLaunchOptions:launchOptions];

    [[AppsFlyerLib shared] registerSessionReadyListener:^{
        // Collect ATT here if required before start
        [[AppsFlyerLib shared] start];
    }];
    return YES;
}
```
```swift Swift
// 6.x - DO NOT use in 7.0
AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
AppsFlyerLib.shared().start()

// 7.0
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    AppsFlyerLib.shared().initialize(devKey: "YOUR_DEV_KEY", appId: "123456789")

    // Optional - only needed if supporting Universal Links
    AppsFlyerLib.shared().handleLaunchOptions(launchOptions)

    AppsFlyerLib.shared().registerSessionReadyListener {
        // Collect ATT here if required before start
        AppsFlyerLib.shared().start()
    }
    return true
}
```

**Readiness conditions:**

- `devKey` and `appleAppID` must be set before the listener fires.
- If a Universal Link is present at cold launch, the SDK waits for deep link resolution (with a bounded timeout; the listener always fires).

#### Call start with preconditions

If `start` must wait for both SDK readiness and your consent flow (CMP, ATT, or a custom gate), use a lightweight coordinator. Each side sets a flag independently — the SDK when the listener fires, your app when the consent flow completes — and `start` is called only when both are set.

```objc Objective-C
// AppDelegate.m
@interface AppDelegate ()
@property (nonatomic) BOOL consentGranted;
@property (nonatomic) BOOL sdkReady;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[AppsFlyerLib shared] initWithDevKey:@"YOUR_DEV_KEY" appleAppId:@"123456789"];
    [[AppsFlyerLib shared] handleLaunchOptions:launchOptions];

    __weak typeof(self) weakSelf = self;
    [[AppsFlyerLib shared] registerSessionReadyListener:^{
        weakSelf.sdkReady = YES;
        [weakSelf startIfReady];
    }];

    // Trigger your CMP / ATT flow here.
    // When it completes, set:
    //   self.consentGranted = YES;
    //   [self startIfReady];

    return YES;
}

- (void)startIfReady {
    if (self.consentGranted && self.sdkReady) {
        [[AppsFlyerLib shared] start];
        self.sdkReady = NO; // prevent duplicate starts in the same cycle
    }
}

@end
```
```swift Swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var consentGranted = false
    private var sdkReady = false

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        AppsFlyerLib.shared().initialize(devKey: "YOUR_DEV_KEY", appId: "123456789")
        AppsFlyerLib.shared().handleLaunchOptions(launchOptions)

        AppsFlyerLib.shared().registerSessionReadyListener { [weak self] in
            self?.sdkReady = true
            self?.startIfReady()
        }

        // Trigger your CMP / ATT flow here.
        // When it completes, call:
        //   consentGranted = true
        //   startIfReady()

        return true
    }

    private func startIfReady() {
        guard consentGranted, sdkReady else { return }
        AppsFlyerLib.shared().start()
        sdkReady = false
    }
}
```

**SwiftUI** — use `@UIApplicationDelegateAdaptor` to wire the same `AppDelegate`:

```swift
@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

#### Unregistering

```objc Objective-C
// Objective-C
[[AppsFlyerLib shared] unregisterSessionReadyListener];
```
```swift Swift
// Swift
AppsFlyerLib.shared().unregisterSessionReadyListener()
```

#### Check session readiness

`isSessionReady` returns `YES` (`true` in Swift) once the session-ready listener has fired in the current foreground cycle. Use it to check readiness status from code paths that execute outside the listener callback — for example, deferred logic that runs after the initial startup sequence.

No SDK 6 equivalent.

```objc Objective-C
BOOL ready = [[AppsFlyerLib shared] isSessionReady];
```
```swift Swift
let ready = AppsFlyerLib.shared().isSessionReady()
```

### 3. Migrate to the deep link delegate

**What changed:** `onAppOpenAttribution:` and `onAppOpenAttributionFailure:` have been removed from `AppsFlyerLibDelegate`. Migrate to `AppsFlyerDeepLinkDelegate.didResolveDeepLink`, which provides equivalent data via `AppsFlyerDeepLinkResult`.

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x - remove these from your AppsFlyerLibDelegate conformance
- (void)onAppOpenAttribution:(NSDictionary *)attributionData {
    // handle attribution data
}

- (void)onAppOpenAttributionFailure:(NSError *)error {
    // handle error
}

// 7.0 - conform to AppsFlyerDeepLinkDelegate instead
- (void)didResolveDeepLink:(AppsFlyerDeepLinkResult *)result {
    if (result.status == AFSDKDeepLinkResultStatusFound) {
        NSDictionary *deepLinkData = result.deepLink.clickEvent;
        // handle attribution data
    } else if (result.status == AFSDKDeepLinkResultStatusFailure) {
        NSError *error = result.error;
        // handle error
    }
}
```
```swift Swift
// 6.x - remove these from your AppsFlyerLibDelegate conformance
func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) { }
func onAppOpenAttributionFailure(_ error: Error) { }

// 7.0 - conform to AppsFlyerDeepLinkDelegate instead
func didResolveDeepLink(_ result: DeepLinkResult) {
    switch result.status {
    case .found:
        let deepLinkData = result.deepLink?.clickEvent
        // handle attribution data
    case .failure:
        let error = result.error
        // handle error
    case .notFound:
        break
    }
}
```

Assign the delegate **before** calling `start`:

```objc Objective-C
// Objective-C
[AppsFlyerLib shared].deepLinkDelegate = self;
```
```swift Swift
// Swift
AppsFlyerLib.shared().deepLinkDelegate = self
```

#### Swift type names for the deep link result

The Swift implementation of `didResolveDeepLink` uses renamed types — here's the mapping from the Objective-C API:

- `AppsFlyerDeepLinkResult` is exposed to Swift as `DeepLinkResult` (`NS_SWIFT_NAME(DeepLinkResult)`).
- `AFSDKDeepLinkResultStatus` is exposed as `DeepLinkResultStatus`; switch cases are `.found`, `.failure`, and `.notFound`.
- The `deepLink` property on `DeepLinkResult` is of type `DeepLink` (`NS_SWIFT_NAME(DeepLink)`).
- `clickEvent` is a direct property on `DeepLink` — not a nested call.

---

### 4. Update the deep link delegate name in Swift

**What changed:** `DeepLinkDelegate` → `AppsFlyerDeepLinkDelegate` (Swift name, `NS_SWIFT_NAME`). ObjC code compiles unchanged. Swift code that references the old name fails to compile.

```swift Swift
// 6.x
class MyDeepLinkHandler: DeepLinkDelegate {
    func didResolveDeepLink(_ result: AppsFlyerDeepLinkResult) { }
}

// 7.0
class MyDeepLinkHandler: AppsFlyerDeepLinkDelegate {
    func didResolveDeepLink(_ result: AppsFlyerDeepLinkResult) { }
}
```

Assignment to `deepLinkDelegate` is unaffected in both languages.

---

### 5. Swap the host method argument order

**What changed:** The method was renamed from `setHost(_:withHostPrefix:)` to `setHost(_:hostName:)`, and the argument order was reversed to align with the Android SDK. The first argument is now the host **prefix**; the second is the host **name**.

If you don't swap the arguments, the code compiles without errors but routes traffic to the wrong host, causing a silent runtime regression.

```objc Objective-C
// 6.x - host first, prefix second
[[AppsFlyerLib shared] setHost:@"example.com" withHostPrefix:@"custom"];

// 7.0 - prefix first, host second
[[AppsFlyerLib shared] setHost:@"custom" hostName:@"example.com"];
```
```swift Swift
// 6.x
AppsFlyerLib.shared().setHost("example.com", withHostPrefix: "custom")

// 7.0
AppsFlyerLib.shared().setHost("custom", hostName: "example.com")
```

---

### 6. Switch to the purchase details object

**What changed:** The 6-parameter `validateAndLogInAppPurchase` signature has been removed. Use `validateAndLogInAppPurchase(purchaseDetails:purchaseAdditionalDetails:)` with an `AFSDKPurchaseDetails` object.

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x - DO NOT use in 7.0
[[AppsFlyerLib shared] validateAndLogInAppPurchase:@"product_id"
                                             price:@"9.99"
                                          currency:@"USD"
                                     transactionId:@"txn_123"
                              additionalParameters:nil
                                           success:^(NSDictionary *result) {}
                                           failure:^(NSError *error, id response) {}];

// 7.0
AFSDKPurchaseDetails *details = [[AFSDKPurchaseDetails alloc]
    initWithProductId:@"product_id"
        transactionId:@"txn_123"
         purchaseType:AFSDKPurchaseTypeOneTimePurchase];
[[AppsFlyerLib shared] validateAndLogInAppPurchase:details
                         purchaseAdditionalDetails:nil
                                        completion:^(NSDictionary *response, NSError *error) {}];
```
```swift Swift
// 6.x - DO NOT use in 7.0
AppsFlyerLib.shared().validateAndLogInAppPurchase(
    "product_id", price: "9.99", currency: "USD",
    transactionId: "txn_123", additionalParameters: nil,
    success: { _ in }, failure: { _, _ in }
)

// 7.0
let details = AFSDKPurchaseDetails(productId: "product_id",
                                   transactionId: "txn_123",
                                   purchaseType: .oneTimePurchase)
AppsFlyerLib.shared().validateAndLogInAppPurchase(
    purchaseDetails: details,
    purchaseAdditionalDetails: nil
) { response, error in }
```

### 7. Remove the all-partners sharing filter

**What changed:** This method was deprecated in 6.4.0 and has been removed in 7.0. Pass `["all"]` to `setSharingFilterForPartners` to prevent data sharing with all partners.

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x - DO NOT use in 7.0
[[AppsFlyerLib shared] setSharingFilterForAllPartners];

// 7.0
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"all"]];
```
```swift Swift
// 6.x - DO NOT use in 7.0
AppsFlyerLib.shared().setSharingFilterForAllPartners()

// 7.0
AppsFlyerLib.shared().setSharingFilterForPartners(["all"])
```

---

### 8. Update ShareInviteHelper method signatures

#### Rename the invite link method

**What changed:** The method is renamed (`Url` → `Link`), and the completion handler gains an `NSError *` parameter. Update your handler to accept both `url` and `error`. A signature mismatch is a compile error in both Objective-C and Swift.

```objc Objective-C
// 6.x
[AppsFlyerShareInviteHelper generateInviteUrlWithLinkGenerator:^AppsFlyerLinkGenerator *(AppsFlyerLinkGenerator *gen) {
    [gen setChannel:@"email"];
    return gen;
} completionHandler:^(NSURL * _Nullable url) {
    // use url
}];

// 7.0
[AppsFlyerShareInviteHelper generateInviteLinkWithLinkGenerator:^AppsFlyerLinkGenerator *(AppsFlyerLinkGenerator *gen) {
    [gen setChannel:@"email"];
    return gen;
} completionHandler:^(NSURL * _Nullable url, NSError * _Nullable error) {
    if (error) { /* handle */ return; }
    // use url
}];
```
```swift Swift
// 6.x
AppsFlyerShareInviteHelper.generateInviteUrl(linkGenerator: { gen in
    gen.setChannel("email")
    return gen
}) { url in
    // use url
}

// 7.0
AppsFlyerShareInviteHelper.generateInviteLink(linkGenerator: { gen in
    gen.setChannel("email")
    return gen
}) { url, error in
    if let error { /* handle */ return }
    // use url
}
```

#### Update the logInvite parameter label

**What changed:** `parameters:` → `eventParameters:`

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x
[AppsFlyerShareInviteHelper logInvite:@"email" parameters:@{@"af_sub1": @"val"}];

// 7.0
[AppsFlyerShareInviteHelper logInvite:@"email" eventParameters:@{@"af_sub1": @"val"}];
```
```swift Swift
// 6.x
AppsFlyerShareInviteHelper.logInvite("email", parameters: ["af_sub1": "val"])

// 7.0
AppsFlyerShareInviteHelper.logInvite("email", eventParameters: ["af_sub1": "val"])
```

---

### 9. Update CrossPromotionHelper parameter labels

#### Update logCrossPromoteImpression parameter labels

**What changed:** `appID:` → `appId:`, `parameters:` → `userParams:`

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x
[AppsFlyerCrossPromotionHelper logCrossPromoteImpression:@"123456789"
                                                campaign:@"summer"
                                              parameters:@{@"af_sub1": @"val"}];

// 7.0
[AppsFlyerCrossPromotionHelper logCrossPromoteImpression:@"123456789"
                                                campaign:@"summer"
                                              userParams:@{@"af_sub1": @"val"}];
```
```swift Swift
// 6.x
AppsFlyerCrossPromotionHelper.logCrossPromoteImpression("123456789",
    campaign: "summer", parameters: ["af_sub1": "val"])

// 7.0
AppsFlyerCrossPromotionHelper.logCrossPromoteImpression("123456789",
    campaign: "summer", userParams: ["af_sub1": "val"])
```

#### Update logAndOpenStore parameter labels

**What changed:** `appID:` → `promotedAppId:`, `parameters:` → `userParams:`

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x
[AppsFlyerCrossPromotionHelper logAndOpenStore:@"123456789"
                                      campaign:@"summer"
                                    parameters:@{@"af_sub1": @"val"}
                                     openStore:^(NSURLSession *session, NSURL *url) {}];

// 7.0
[AppsFlyerCrossPromotionHelper logAndOpenStore:@"123456789"
                                      campaign:@"summer"
                                    userParams:@{@"af_sub1": @"val"}
                                     openStore:^(NSURLSession *session, NSURL *url) {}];
```
```swift Swift
// 6.x
AppsFlyerCrossPromotionHelper.logAndOpenStore("123456789",
    campaign: "summer", parameters: ["af_sub1": "val"]) { session, url in }

// 7.0
AppsFlyerCrossPromotionHelper.logAndOpenStore("123456789",
    campaign: "summer", userParams: ["af_sub1": "val"]) { session, url in }
```

---

### 10. Update LinkGenerator call sites

#### Remove two methods with no replacement

**What changed:** Both methods are removed with no replacement. Remove all call sites.

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x - remove these calls entirely in 7.0
[generator setAppleAppID:@"123456789"];
[generator setDeeplinkPath:@"/product/detail"];
```
```swift Swift
// 6.x - remove these calls entirely in 7.0
generator.setAppleAppID("123456789")
generator.setDeeplinkPath("/product/detail")
```

#### Remaining renames

| 6.x | 7.0 | Breakage |
|---|---|---|
| `setReferrerImageURL:` | `setReferrerImageUrl:` | Compile error |
| `setBaseDeeplink:` | `setBaseDeepLink:` | Compile error |
| `addParameters:` | `addUserParams:` | Compile error |

```objc Objective-C
// 6.x
[generator setReferrerImageURL:@"https://example.com/avatar.png"];
[generator setBaseDeeplink:@"myapp://home"];
[generator addParameters:@{@"af_sub1": @"val"}];

// 7.0
[generator setReferrerImageUrl:@"https://example.com/avatar.png"];
[generator setBaseDeepLink:@"myapp://home"];
[generator addUserParams:@{@"af_sub1": @"val"}];
```
```swift Swift
// 6.x
generator.setReferrerImageURL("https://example.com/avatar.png")
generator.setBaseDeeplink("myapp://home")
generator.addParameters(["af_sub1": "val"])

// 7.0
generator.setReferrerImageUrl("https://example.com/avatar.png")
generator.setBaseDeepLink("myapp://home")
generator.addUserParams(["af_sub1": "val"])
```

---

### 11. Apply remaining method renames

#### Rename the SDK version method

**What changed:** `getSDKVersion` → `getSdkVersion`

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x
NSString *version = [[AppsFlyerLib shared] getSDKVersion];

// 7.0
NSString *version = [[AppsFlyerLib shared] getSdkVersion];
```
```swift Swift
// 6.x
let version = AppsFlyerLib.shared().getSDKVersion()

// 7.0
let version = AppsFlyerLib.shared().getSdkVersion()
```

#### Fix the Swift deep link URL method name

**What changed:** `appendParametersToDeeplinkURL` → `appendParametersToDeepLinkingURL`

**Compile error:** Existing Swift code breaks on upgrade

```swift Swift
// 6.x
AppsFlyerLib.shared().appendParametersToDeeplinkURL(contains: "example.com", parameters: [:])

// 7.0
AppsFlyerLib.shared().appendParametersToDeepLinkingURL(contains: "example.com", parameters: [:])
```

#### Update the partner data parameter label

**What changed:** `partnerInfo:` → `data:`

**Compile error:** Existing code breaks on upgrade

```objc Objective-C
// 6.x
[[AppsFlyerLib shared] setPartnerDataWithPartnerId:@"partner_int" partnerInfo:@{@"key": @"val"}];

// 7.0
[[AppsFlyerLib shared] setPartnerDataWithPartnerId:@"partner_int" data:@{@"key": @"val"}];
```
```swift Swift
// 6.x
AppsFlyerLib.shared().setPartnerData(partnerId: "partner_int", partnerInfo: ["key": "val"])

// 7.0
AppsFlyerLib.shared().setPartnerData(partnerId: "partner_int", data: ["key": "val"])
```

---

## Part 2: New capabilities

### 1. File-based SDK configuration

SDK 7 introduces an optional property list file for configuring SDK behavior without code. Add `AppsFlyerLibConfig.plist` to your app's main bundle. The SDK loads it automatically at initialization, before `initialize(devKey:appId:)` is called. If the file is missing, the SDK uses defaults. If a key is absent from the plist, its default applies. Programmatic API calls always override plist values.

#### Supported keys

| Plist key | Type | Default | Programmatic equivalent |
|---|---|---|---|
| `debug_mode` | Boolean | `false` | `AppsFlyerLib.shared().isDebug = true` |
| `currency_code` | String | `"USD"` | `AppsFlyerLib.shared().currencyCode = "ILS"` |
| `disable_idfa_collection` | Boolean | `false` | `AppsFlyerLib.shared().disableAdvertisingIdentifier = true` |
| `disable_idfv_collection` | Boolean | `false` | `AppsFlyerLib.shared().disableIDFVCollection = true` |
| `disable_skadnetwork` | Boolean | `false` | `AppsFlyerLib.shared().disableSKAdNetwork = true` |
| `min_time_between_sessions` | Integer (seconds) | `30` | `AppsFlyerLib.shared().minTimeBetweenSessions = 1` |
| `host` | String | `""` | `AppsFlyerLib.shared().setHost("prefix", hostName: "host.com")` |
| `prefix` | String | `""` | *(set together with `host`)* |

#### Example plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>debug_mode</key>
    <true/>
    <key>currency_code</key>
    <string>USD</string>
    <key>disable_idfa_collection</key>
    <false/>
    <key>disable_idfv_collection</key>
    <false/>
    <key>disable_skadnetwork</key>
    <false/>
    <key>min_time_between_sessions</key>
    <integer>30</integer>
    <key>host</key>
    <string></string>
    <key>prefix</key>
    <string></string>
</dict>
</plist>
```

#### Adding the file to Xcode

1. Choose **File → New → File** and select **Property List**.
2. Name it exactly `AppsFlyerLibConfig` (Xcode adds `.plist`).
3. Add it to your **app target**, not the test target.
4. Verify it appears under **Build Phases → Copy Bundle Resources**.

#### Precedence

```
AppsFlyerLibConfig.plist  →  loaded at SDK init (lowest priority)
         ↓
Programmatic API calls    →  override plist values at any time (highest priority)
```

Any value set via the public API overwrites the corresponding plist value for the remainder of the process. On the next cold start, the plist value is loaded again.

#### Comparison with Android af_init_config.json file

| | iOS | Android |
|---|---|---|
| **File** | `AppsFlyerLibConfig.plist` (main bundle) | `assets/af_init_config.json` |
| **Format** | Property list (XML) | JSON |
| **Loaded at** | `AppsFlyerLib.init()` | `AppsFlyerLib.init()` |
| **Contains credentials** | No — use `initialize(devKey:appId:)` | No — use `init(key, listener, context)` |
| **Unknown keys** | Ignored | Ignored (logged) |

---

## Troubleshooting

### Session readiness listener never fires

**Symptom:** The listener block is never called, and the SDK does not start.

**Causes:**

1. `registerSessionReadyListener` called after `start` instead of before.
2. Credentials not set via `initialize(devKey:appId:)` before registering the listener.
3. Universal Link configured, but `handleLaunchOptions` not called before listener registration.

**Solution:** Ensure this order is in `didFinishLaunchingWithOptions:`:

```objc
[[AppsFlyerLib shared] initWithDevKey:@"KEY" appleAppId:@"ID"];
[[AppsFlyerLib shared] handleLaunchOptions:launchOptions]; // if using Universal Links
[[AppsFlyerLib shared] registerSessionReadyListener:^{ /* call start here */ }];
```

### Silent deep link failure in foreground

**Symptom:** `didResolveDeepLink` is called but `result.status` is `.failure` even though the link is valid.

**Causes:**

1. `handleLaunchOptions` not called in `didFinishLaunchingWithOptions:` for cold-launch links.
2. `AppsFlyerDeepLinkDelegate` set after `start` fires.

**Solution:** Set the delegate before calling `start`:

```objc
[AppsFlyerLib shared].deepLinkDelegate = self;
[[AppsFlyerLib shared] start];
```

### Compile error: method not found

**Symptom:** Xcode reports `No visible @interface for 'AppsFlyerLib' declares selector 'oldMethodName:'`.

**Solution:** Refer to the breaking changes sections above to find the 7.0 replacement. Every removed method has a direct replacement or a clear rationale for removal.

---

## Quick reference

All API changes at a glance. Use this when you hit a compile error and want to find the 7.0 replacement without reading the full section.

### AppsFlyerLib

| 6.x | 7.0 | Breakage |
|---|---|---|
| `appsFlyerDevKey` (read-write property) | `appsFlyerDevKey` (read-only) + `initialize(devKey:appId:)` | Compile |
| `appleAppID` (read-write property) | `appleAppID` (read-only) + `initialize(devKey:appId:)` | Compile |
| `setHost(_:withHostPrefix:)` — host, prefix | `setHost(_:hostName:)` — prefix, host (order swapped) | Compile + Silent regression |
| `getSDKVersion` | `getSdkVersion` | Compile |
| `validateAndLogInAppPurchase(_:price:currency:transactionId:additionalParameters:success:failure:)` | `validateAndLogInAppPurchase(purchaseDetails:purchaseAdditionalDetails:)` | Compile |
| `setSharingFilterForAllPartners` | Removed — use `setSharingFilterForPartners` | Compile |
| `waitForATTUserAuthorization(timeoutInterval:)` | Deprecated → `registerSessionReadyListener` | Compile warning → Silent regression |

**Swift-specific changes**

| 6.x Swift | 7.0 Swift | Breakage |
|---|---|---|
| `appendParametersToDeeplinkURL(contains:parameters:)` | `appendParametersToDeepLinkingURL(contains:parameters:)` | Compile |
| `setPartnerData(partnerId:partnerInfo:)` | `setPartnerData(partnerId:data:)` | Compile |

### AppsFlyerLibDelegate

| 6.x | 7.0 | Breakage |
|---|---|---|
| `onAppOpenAttribution` (`@optional`) | Removed — migrate to `AppsFlyerDeepLinkDelegate.didResolveDeepLink` | Compile |
| `onAppOpenAttributionFailure` (`@optional`) | Removed — handle errors via `result.status` in `didResolveDeepLink` | Compile |

### AppsFlyerDeepLinkDelegate

| 6.x Swift name | 7.0 Swift name | Breakage |
|---|---|---|
| `DeepLinkDelegate` | `AppsFlyerDeepLinkDelegate` | Compile (Swift) |

### AppsFlyerShareInviteHelper

| 6.x | 7.0 | Breakage |
|---|---|---|
| `generateInviteUrl(linkGenerator:completionHandler:)` — no error param | `generateInviteLink(linkGenerator:completionHandler:)` — adds `Error` | Compile |
| `logInvite(_:parameters:)` | `logInvite(_:eventParameters:)` | Compile |

### AppsFlyerCrossPromotionHelper

| 6.x | 7.0 | Breakage |
|---|---|---|
| `logCrossPromoteImpression(_:appID:campaign:parameters:)` | `logCrossPromoteImpression(_:appId:campaign:userParams:)` | Compile |
| `logAndOpenStore(_:appID:campaign:parameters:openStore:)` | `logAndOpenStore(_:promotedAppId:campaign:userParams:openStore:)` | Compile |

### AppsFlyerLinkGenerator

| 6.x | 7.0 | Breakage |
|---|---|---|
| `setReferrerImageURL` | `setReferrerImageUrl` | Compile |
| `setAppleAppID` | Removed — no replacement | Compile |
| `setDeeplinkPath` | Removed — no replacement | Compile |
| `setBaseDeeplink` | `setBaseDeepLink` | Compile |
| `addParameters` | `addUserParams` | Compile |