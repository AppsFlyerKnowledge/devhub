---
title: "iOS Branch Migration"
slug: "branch-migration-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "ctivate the Branch Migration Navigator to streamline your traffic migration journey from Branch to AppsFlyer"
hidden: true
order: 90
---

# What is Branch Migration Navigator?

The Branch Migration Navigator is a tool designed to support a gradual and informed migration from Branch to AppsFlyer. It enables AppsFlyer to collect traffic signals from Branch through a lightweight module integrated into the app.

This guide explains how to activate the Branch Migration Navigator on iOS using the `AppsFlyerMigrationHelper` module, allowing surfacing Branch traffic data and, optionally, supporting attribution continuity during the migration period. `Migration Helper` is a new module in AppsFlyer SDK suite which facilitates passing the data to AppsFlyer.

To ensure a smooth handoff of the navigator, your app should collect attribution data from Branch and pass it to the AppsFlyerMigrationHelper during the first session. In addition, in case of direct deep linking (Universal Links or URI scheme) the app should collect the deep linking data and pass it as well.

# Code flow concept

| **Scenario**                  | **Suggested Indication**                                                        | **Action**                                                                                         | **Branch Method (Click Data Retrieval)**                               | **AppsFlyer Method**                                                   |
|-------------------------------|---------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|------------------------------------------------------------------------|
| **Organic App Open**          | `+clicked_branch_link` is `false`                                                | No Branch data to retrieve; proceed to start AppsFlyer SDK                                         | N/A                                                                    | N/A                                  |
| **Branch Deferred Deep Link** | `+clicked_branch_link` is `true` and `+is_first_session` is `true`          | Introduce a 3-second delay, then retrieve and pass install-attributed click data to AppsFlyer      | `Branch.getInstance().lastAttributedTouchData()`                    | `AppsFlyerMigrationHelper.setAttributionData()`                        |
| **Branch Direct Deep Link**   | `+clicked_branch_link` is `true` and `+is_first_session` is `false`         | Retrieve and pass direct deep link click data to AppsFlyer                                         | `Branch.getInstance().getLatestReferringParams()`  | `AppsFlyerMigrationHelper.setDeepLinkingData()`                        |

## Implementation

### Initialization in `didFinishLaunchingWithOptions`

```swift
// Set isDebug to true to see AppsFlyer debug logs
AppsFlyerLib.shared().isDebug = true

// Replace 'appsFlyerDevKey' and 'appleAppID' with your values
AppsFlyerLib.shared().appsFlyerDevKey = "yourAppsFlyerDevKey"
AppsFlyerLib.shared().appleAppID = "yourAppleAppID"

// Enable Branch logging
Branch.enableLogging()

if #available(iOS 16.0, *) {
    // Use UIPasteControl instead of checking pasteboard
} else if #available(iOS 15.0, *) {
    Branch.getInstance().checkPasteboardOnInstall()
}

if Branch.getInstance().willShowPasteboardToast() {
    NSLog("[Branch] Pasteboard toast will show")
}
```

> ⚠️ Important
> 
> Do not run AppsFlyer SDK `start` immediately after the `init`.
> Read below when to start AppsFlyer SDK

- **Control the Start of the AppsFlyer SDK**:
  - Invoke the `start` method of the AppsFlyer SDK **only after** passing the deep link data from Branch to AppsFlyer. This approach allows the app to manage the SDK's initiation, ensuring all necessary data from Branch is available beforehand.
  - In all scenarios—including when a `error` occurs or when `+clicked_branch_link` is `false` (indicating an organic app open)—it is essential to call `AppsFlyerLib.getInstance().start()` to initiate the AppsFlyer SDK, ensuring it functions correctly across all app launch scenarios.

### Handling Deep Links on Re-engagement

```swift
let isFirstBranchSession = params!["+is_first_session"] as? Int
let clickedBranchLink = params!["+clicked_branch_link"] as? Int

if isFirstBranchSession == 0, clickedBranchLink == 1 {
    AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
}
```

### Handling First Install and Deferred Deep Linking

```swift
if isFirstBranchSession == 1 {
    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
        Branch.getInstance().lastAttributedTouchData(withAttributionWindow: 0) { (params, error) in
            if let params = params {
                AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
            }
            AppsFlyerLib.shared().start()
        }
    }
} else {
    AppsFlyerLib.shared().start()
}
```

## Supporting AppTrackingTransparency (ATT)

```swift
Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
    let isFirstSession = (params?["+is_first_session"] as? Bool) ?? false
    let isDeepLink = (params?["+clicked_branch_link"] as? Bool) ?? false

    if !isFirstSession, isDeepLink {
        AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
    }

    if #available(iOS 14, *) {
        ATTrackingManager.requestTrackingAuthorization { status in
            handlePostATT(isFirstSession: isFirstSession)
        }
    } else {
        handlePostATT(isFirstSession: isFirstSession)
    }
}

func handlePostATT(isFirstSession: Bool) {
    if isFirstSession {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            Branch.getInstance().lastAttributedTouchData(withAttributionWindow: 7) { (params, error) in
                if let params = params {
                    AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                }
                AppsFlyerLib.shared().start()
            }
        }
    } else {
        AppsFlyerLib.shared().start()
    }
}
```

## Full Code Example

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Initialization code here
    ...
    return true
}

func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    Branch.getInstance().continue(userActivity)
    AppsFlyerLib.shared().continue(userActivity)
    return true
}
```
