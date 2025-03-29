---
title: "iOS Branch migration"
slug: "branch-migration-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Migrate your iOS app from Branch"
hidden: true
order: 90
---

# Overview

To ensure a smooth handoff of data from Branch to AppsFlyer, your app should collect attribution data from Branch and pass it to AppsFlyer during the first session. In addition, in case of direct deep linking (Android App Links or URI scheme) the app should collect the deep linkind data and pass it to AppsFlyer. `Migration Helper`, which is a new module in AppsFlyer SDK suite facilitates passing the data to AppsFlyer.

# Data flow

Before implementing the flow it is important to understand the rational behind it. 
The code described in the snippets below is a reference for implementing the follow flow. Any other implementation is accepted, as long as you follow this rational.

## Application install (deferred deep linking or organic)

When the application is installed *organically* (without clicking a Branch link), or with *deferred deep linking* (by clicking on a Branch), take the following steps:
1. Wait 3 seconds from the return of Branch callback `initSession()`.
2. Call from Branch SDK the method `getLastAttributedTouchData()`
3. Inside the `getLastAttributedTouchData()` callback, call AppsFlyer SDK's  `AppsFlyerMigrationHelper.setAttributionData()` and then `start()`.

## Direct deep linking

In case of direct deep linking (Android App Links or URI scheme) call AppsFlyer SDK's `AppsFlyerMigrationHelper.setDeepLinkingData()` and then `start()`. 
Make sure you also call `AppsFlyerLib.shared().continue(userActivity)` in the life cycle method `func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void)`

## Application launch without deep linking

When the application is launched without clicking on a Branch.io link, no special action should be taken other than calling `start` from AppsFlyer SDK. 

# Code example reference

---

## When & Where It Happens

In `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)`:
- Both SDKs are **initialized globally**.
- Register the callback of `initSession`, which handles session init and deep link resolution. 
- This callback also holds conditional logic whcih forwards **Branch deep link data** to AppsFlyer on re-engagement.

In `func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?))`:
- call `AppsFlyerLib.shared().continue(userActivity)` 

---

## `didFinishLaunchingWithOptions` code reference

### initialization

```swift
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
```

---

### Handling Deep Links on Re-engagement

The app handles **re-engagement via deep links** (when the app is reopened through a Branch link).
The Branch SDK method is used hhh

```swift
    // Access and use deep link data here (nav to page, display content, etc.)
    let isFirstBranchSession = params!["+is_first_session"] as? Int
    let clickedBranchLink = params!["+clicked_branch_link"] as? Int
    if isFirstBranchSession == 0,
        clickedBranchLink == 1 {
        AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
    }
```

### What this does:

- ✅ `sFirstBranchSession == 0`: Ensures this is not the first launch (AppsFlyer is already running).
- ✅ `iclickedBranchLink == 1`: Ensures the app was opened via a Branch deep link.
- ✅ Result: Branch deep link metadata is forwarded to AppsFlyer for proper **re-engagement attribution**.

---

### Handling first install and deferred deep linking 
If this is the first session of the application it is requried to wait 3 seconds and call Branch's SDK `lastAttributedTouchData`.
The data returned from `lastAttributedTouchData` is passed to AppsFlyer using `setAttributionData` 

```swift
    if isFirstBranchSession == 1 {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            Branch.getInstance().lastAttributedTouchData(withAttributionWindow:0) { (params, error) in
                if let params = params {
                    AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                }
                AppsFlyerLib.shared().start()
            }
            dispatchGroup.leave()
        }
    } else {
        AppsFlyerLib.shared().start()
    }
```

# Support `AppTrackingTransparency`

In the callback `initSession` call `ATTrackingManager.requestTrackingAuthorization`. 
In the first session, register the call to `lastAttributedTouchData`, when `ATTrackingManager.requestTrackingAuthorization` is called back. In the LATD callback call `start`.
If this is not the first session, call `start` immediately. 

## Code reference 

```swift
    Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            // Access and use deep link data here (nav to page, display content, etc.)
            print(params as? [String: AnyObject] ?? {})
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
            // Delay + LATD
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

# Full code example 

```swift

func application(_ application: UIApplication, h launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
                
                // Access and use deep link data here (nav to page, display content, etc.)
                let isFirstBranchSession = params!["+is_first_session"] as? Int
                let clickedBranchLink = params!["+clicked_branch_link"] as? Int
                if isFirstBranchSession == 0,
                   clickedBranchLink == 1 {
                    AFMigrationHelper.shared.setDeepLinkingData(Branch.getInstance().getLatestReferringParams())
                }
                
                if isFirstBranchSession == 1 {
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    
                    DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
                        Branch.getInstance().lastAttributedTouchData(withAttributionWindow:0) { (params, error) in
                            if let params = params {
                                AFMigrationHelper.shared.setAttributionData(params.lastAttributedTouchJSON, attributionWindow: params.attributionWindow)
                            }
                            AppsFlyerLib.shared().start()
                        }
                        dispatchGroup.leave()
                    }
                } else {
                    AppsFlyerLib.shared().start()
                }
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
