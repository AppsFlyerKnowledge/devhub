---
title: "Branch Migration Navigator on iOS"
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

# SDK and migration module initiazation

## Initialization in `didFinishLaunchingWithOptions`

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

# Migration module flow

## Error check

Initially check if `initSession` returned a non empty `error`. In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

```swift
Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
    print(params as? [String: AnyObject] ?? {})

    if error != nil {
        print("Error initializing Branch: \(String(describing: error))")
        // Even Branch starts with an error, AppsFlyer should be started
        AppsFlyerLib.shared().start()
    } else {
        // ...
    }
}
```

## Organic flow

Organic flow means install or launch of the application not initiated by a click on a Branch link.
In this case the `+clicked_branch_link` will come back `false`. 
In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

## Deep linking 

The migration process becomes relevant when an app launch is triggered by a Branch click. There are two primary types of deep linking:​
- Deferred Deep Linking: This occurs when a user clicks on a Branch link and, if the app is not already installed, is directed to install it. After installation, the user is taken directly to the intended content within the app according to link data.​
- Direct Deep Linking: This happens when the app is already installed, and a user clicks on a Branch link (e.g., through Android App Links), which opens the app directly to the specified content, according to the link data.​

When the `initSession` callback is invoked with a non-empty `params` and `+clicked_branch_link` is `true`, it indicates that a deep linking event has occurred. After completing the migration steps, the standard deep-linking procedures integrated with Branch should continue as usual.

## Handling Deferred Deep Linking

```swift
let isFirstBranchSession = (params?["+is_first_session"] as? Bool) ?? false
let isDeepLink = (params?["+clicked_branch_link"] as? Bool) ?? false

if isDeepLink {
    // deep link flow
    if isFirstBranchSession {
        // Deferred deep linking flow
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            Branch.getInstance().lastAttributedTouchData(withAttributionWindow:0) { (params, error) in
                if let params = params {
                    // In several cases the LATD can come back nil.
                    // This condition protects this case
                    AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                }
                AppsFlyerLib.shared().start()
            }
            dispatchGroup.leave()
        }
    } else {
        // Direct deep linking flow - Universal link
        // ...
    }
} else {
    // Organic flow
    // ...
}
```

## Handling Deep Links on Re-engagement

In `didFinishLaunchingWithOptions`, use the following conditions to detect direct deep linking, call `setDeepLinkingData()` and it the output of `getLatestReferringParams()`. 

```swift
let isFirstBranchSession = (params?["+is_first_session"] as? Bool) ?? false
let isDeepLink = (params?["+clicked_branch_link"] as? Bool) ?? false

if isDeepLink {
    // deep link flow
    if isFirstBranchSession {
        // Deferred deep linking flow
        // ...
    } else {
        // Direct deep linking flow - Universal link
        AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
        AppsFlyerLib.shared().start()
    }
} else {
    // Organic flow
    // ...
}
```

In `continue userActivity` call `AppsFlyerLib.shared().continue(userActivity)`

```swift
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    // Handler for Universal Links
    Branch.getInstance().continue(userActivity)
    AppsFlyerLib.shared().continue(userActivity)
    return true
}
```





# Full Code Example

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    //  Set isDebug to true to see AppsFlyer debug logs
    AppsFlyerLib.shared().isDebug = true
    
    // Replace 'appsFlyerDevKey', `appleAppID` with your DevKey, Apple App ID
    AppsFlyerLib.shared().appsFlyerDevKey = "sQ84wpdxRTR4RMCaE9YqS4"
    AppsFlyerLib.shared().appleAppID = "1512793879"
    
    Branch.enableLogging()
    
    if #available(iOS 16.0, *) {
        // Don't check pasteboard on install, instead utilize UIPasteControl
    } else if #available(iOS 15.0, *) {
        // Call `checkPasteboardOnInstall()` before Branch initialization
        Branch.getInstance().checkPasteboardOnInstall()
    }
    
    // Check if pasteboard toast will show
    if Branch.getInstance().willShowPasteboardToast(){
        // You can notify the user of what just occurred here
        NSLog("[Branch] willShowPasteboardToast ######")
    }
    
    Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
        print(params as? [String: AnyObject] ?? {})
        
        if error != nil {
            print("Error initializing Branch: \(String(describing: error))")
            // Even Branch starts with an error, AppsFlyer should be started
            AppsFlyerLib.shared().start()
        } else {
            NSLog("Branch SDK init completed successfully")
            // Access and use deep link data here (nav to page, display content, etc.)
            let isFirstBranchSession = (params?["+is_first_session"] as? Bool) ?? false
            let isDeepLink = (params?["+clicked_branch_link"] as? Bool) ?? false
            
            if isDeepLink {
                // deep link flow
                if isFirstBranchSession {
                    // Deferred deep linking flow
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
                        Branch.getInstance().lastAttributedTouchData(withAttributionWindow:0) { (params, error) in
                            if let params = params {
                                // In several cases the LATD can come back nil.
                                // This condition protects this case
                                AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                            }
                            AppsFlyerLib.shared().start()
                        }
                        dispatchGroup.leave()
                    }
                } else {
                    // Direct deep linking flow - Universal link
                    AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
                    AppsFlyerLib.shared().start()
                }
            } else {
                // Organic flow
                AppsFlyerLib.shared().start()
            }
        }
        return
    }
    return true
}

    
// Open Universal Links
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    
    // Handler for Universal Links
    Branch.getInstance().continue(userActivity)
    AppsFlyerLib.shared().continue(userActivity)
    return true
}
```


# Full code example for ATT support

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //  Set isDebug to true to see AppsFlyer debug logs
        AppsFlyerLib.shared().isDebug = true
        
        // Replace 'appsFlyerDevKey', `appleAppID` with your DevKey, Apple App ID
        AppsFlyerLib.shared().appsFlyerDevKey = "sQ84wpdxRTR4RMCaE9YqS4"
        AppsFlyerLib.shared().appleAppID = "1512793879"
        
        Branch.enableLogging()
        
        if #available(iOS 16.0, *) {
            // Don't check pasteboard on install, instead utilize UIPasteControl
        } else if #available(iOS 15.0, *) {
            // Call `checkPasteboardOnInstall()` before Branch initialization
            Branch.getInstance().checkPasteboardOnInstall()
        }

            // Check if pasteboard toast will show
        if Branch.getInstance().willShowPasteboardToast(){
            // You can notify the user of what just occurred here
            NSLog("[Branch] willShowPasteboardToast ######")
        }
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
                // Access and use deep link data here (nav to page, display content, etc.)
                print(params as? [String: AnyObject] ?? {})
                let isFirstSession = (params?["+is_first_session"] as? Bool) ?? false
                let isDeepLink = (params?["+clicked_branch_link"] as? Bool) ?? false
                
                if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization { status in
                        handlePostATT(isFirstSession: isFirstSession, isDeepLink: isDeepLink)
                    }
                } else {
                    handlePostATT(isFirstSession: isFirstSession, isDeepLink: isDeepLink)
                }
        
                if let data = params as? [String: Any],
                   let fruitName = data["fruit_name"] as? String {
                    self.walkToSceneWithParams(fruitName: fruitName, deepLinkData: data)
                }
            }
            
            func handlePostATT(isFirstSession: Bool = false, isDeepLink: Bool = false) {
                
                guard !appsFlyerStarted else {
                    return
                }
                self.appsFlyerStarted = true
                
                if isDeepLink {
                    // deep link flow
                    if isFirstSession {
                        // Deferred deep linking flow
                        let dispatchGroup = DispatchGroup()
                        dispatchGroup.enter()
                        
                        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
                            Branch.getInstance().lastAttributedTouchData(withAttributionWindow:0) { (params, error) in
                                if let params = params {
                                    // In several cases the LATD can come back nil.
                                    // This condition protects this case
                                    AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                                    print(params as? [String: AnyObject] ?? {})
                                }
                                AppsFlyerLib.shared().start()
                            }
                            dispatchGroup.leave()
                        }
                    } else {
                        // Direct deep linking flow - Universal link
                        AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
                        AppsFlyerLib.shared().start()
                    }
                } else {
                    // Organic flow
                    AppsFlyerLib.shared().start()
                }
            }
        return true
    }
        
    // Open Universal Links
    
    // For Swift version < 4.2 replace function signature with the commented out code
    // func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool { // this line for Swift < 4.2
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        // Handler for Universal Links
        Branch.getInstance().continue(userActivity)
        AppsFlyerLib.shared().continue(userActivity)
        return true
    }
```
