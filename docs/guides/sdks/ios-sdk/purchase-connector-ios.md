---
title: "Purchase Connector"
slug: "purchase-connector-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
order: 9
---

## Prerequisites

- StoreKit SDK v1.
- iOS version 9 and higher.
- iOS AppsFlyer SDK **6.8.0** and higher.

** ⚠️IMPORTNANT NOTE: Please check Purchase Connector and AppsFlyerFramework version compatability table and use corresponding versions to avoid unexpected behaviour **

|  PurchaseConnector  | AppsFlyerSDK |
| :------: | :--------: |
| 6.8.0    | 6.8.0 - 6.9.2 |
| 6.8.1    | 6.8.0 - 6.9.2 |
| 6.10.0   |  6.10.0 |
| 6.10.1   |  6.10.1 |
| 6.12.2   |  6.12.2 |
| 6.12.3   |  6.12.2 |

## Install via Cocoapods

Add to your Podfile and run `pod install`:

```
pod 'PurchaseConnector'
```

## Install via Carthage 

Go to the `Carthage` folder in the root of the repository. Open `purchase-connector-dynamic.json` or `purchase-connector-static.json`, click raw, copy and paste the URL of the file to your `Cartfile`:

```
binary "https://raw.githubusercontent.com/AppsFlyerSDK/appsflyer-apple-purchase-connector/main/Carthage/purchase-connector-dynamic.json" == BIINARY_VERSION
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-ios.json" ~> 6.10.0
```

Then open project folder in the terminal and use command `carthage update --use-xcframeworks`, then, drag and drop PurchaseConnector.xcframework binary and AppsFlyerLib.framework (from Carthage/Build/iOS folder).

More reference on Carthage binary artifacts integration [here](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md).

## Install via SPM

Please, follow standard SPM dependency manager instructions.

> *Note: This repository contains statically linked `PurchaseConnector.xcframework`. If you want to use dynamic .xcframework, please integrate it for SPM from this repository:
https://github.com/AppsFlyerSDK/PurchaseConnector-Dynamic*
> *Note: as PurchaseConnector has a dependency on [AppsFlyerLib framework](https://github.com/AppsFlyerSDK/AppsFlyerFramework), please, make sure to integrate it as well for Carthage and SPM.*

## Basic Integration

> *Note: before the implementation of the Purchase connector, please make sure to set up AppsFlyer `appId` and `devKey`*

### Set up Purchase Connector

```swift
// Import the library
    import AppsFlyerLib
    import StoreKit
    import PurchaseConnector

// Default SDK Implementation
    AppsFlyerLib.shared().appsFlyerDevKey = "DEV_KEY"
    AppsFlyerLib.shared().appleAppID = "APPLE_APP_ID"
    //AppsFlyerLib.shared().isDebug = true

// Purchase connector implementation 
    PurchaseConnector.shared().purchaseRevenueDelegate = self
    PurchaseConnector.shared().purchaseRevenueDataSource = self
```
```objective-c
// Import the library
    #import "AppDelegate.h"
    #import <AppsFlyerLib/AppsFLyerLib.h>
    #import <PurchaseConnector/PurchaseConnector.h>

// Default SDK implementation
    [[AppsFlyerLib shared] setAppleAppID:@"APPLE_APP_ID"];
    [[AppsFlyerLib shared] setAppsFlyerDevKey:@"DEV_KEY"];
    //[[AppsFlyerLib shared] setIsDebug:YES];

// Purchase Connecor implementation
    [[PurchaseConnector shared] setPurchaseRevenueDelegate:self];
    [[PurchaseConnector shared] setPurchaseRevenueDataSource:self];
```

### Log Auto-Renewable Subscriptions and In-App Purchases

Enables automatic logging of In-App purchases and Auto-renewable subscriptions.

```swift
PurchaseConnector.shared().autoLogPurchaseRevenue = [.autoRenewableSubscriptions, .inAppPurchases]
```
```objective-c
[[PurchaseConnector shared] setAutoLogPurchaseRevenue:AFSDKAutoLogPurchaseRevenueOptionsRenewable | AFSDKAutoLogPurchaseRevenueOptionsInAppPurchases];
```

> *Note: if `autoLogPurchaseRevenue` has not been set, it is disabled by default. The value is an option set, so you can choose what kind of user purchases you want to observe.*

### Conform to Purchase Connector Data Source and Delegate protocols

- In order to receive purchase validation event callbacks, you should conform to and implement `PurchaseRevenueDelegate`(Swift) or `AppsFlyerPurchaseRevenueDelegate`(Objc-C) protocol.
- To be able to add your custom parameters to the purchase event, that Connector sends, please conform to  and implement `PurchaseRevenueDataSource`(Swift) or `AppsFlyerPurchaseRevenueDataSource`(Obj-C) protocol.

```swift
extension AppDelegate: PurchaseRevenueDataSource, PurchaseRevenueDelegate {
    // PurchaseRevenueDelegate method implementation
    func didReceivePurchaseRevenueValidationInfo(_ validationInfo: [AnyHashable : Any]?, error: Error?) {
        print("PurchaseRevenueDelegate: \(validationInfo)")
        print("PurchaseRevenueDelegate: \(error)")
      // process validationInfo here 
}
    // PurchaseRevenueDataSource method implementation
    func purchaseRevenueAdditionalParameters(for products: Set<SKProduct>, transactions: Set<SKPaymentTransaction>?) -> [AnyHashable : Any]? {
        // Add additional parameters for SKTransactions here.
        return ["additionalParameters":["param1":"value1", "param2":"value2"]];
    }
}
```
```objective-c
@interface AppDelegate () <AppsFlyerPurchaseRevenueDelegate, AppsFlyerPurchaseRevenueDataSource>
@end

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AppsFlyerLib shared] start];
    [[PurchaseConnector shared] startObservingTransactions];
}

- (void)didReceivePurchaseRevenueValidationInfo:(NSDictionary *)validationInfo error:(NSError *)error {
    NSLog(@"Validation info: %@", validationInfo);
    NSLog(@"Error: %@", error);
    
    // Process validation info
}

- (NSDictionary *)purchaseRevenueAdditionalParametersForProducts:(NSSet<SKProduct *> *)products transactions:(NSSet<SKPaymentTransaction *> *)transactions {
    return @{@"key1" : @"param1"};
}

@end
```

### Start Observing Transactions

`startObservingTransactions` should be called to start observing transactions.
 > *Note: This should be called right after the AppsFlyer iOS SDK's start method..*

```swift
    PurchaseConnector.shared().startObservingTransactions()
```
```objective-c
    [[PurchaseConnector shared] startObservingTransactions];
```

### Stop Observing Transactions

To stop observing transactions, you need to call `stopObservingTransactions`.

```swift
    PurchaseConnector.shared().stopObservingTransactions()
```
```objective-c
    [[PurchaseConnector shared] stopObservingTransactions];
```

> *Note: if you called `stopObservingTransactions` API, you should set `autoLogPurchaseRevenue` value before you call `startObservingTransactions` next time.*

## Testing the implementation in Sandbox

In order to test purchases in Xcode environment on a real device with TestFlight sandbox account, you need to set `isSandbox` to true.

```swift
    PurchaseConnector.shared().isSandbox = true
```
```objective-c
    [[PurchaseConnector shared] setIsSandbox:YES];
```

> *IMPORTANT NOTE: Before releasing your app to production please be sure to remove `isSandbox` or set it to `false`. If the production purchase event will be sent in sandbox mode, your event will not be validated properly! *

## Full Code Examples

### Swift Example 

```swift
import AppsFlyerLib
import StoreKit
import PurchaseConnector

class AppDelegate: UIResponder, UIApplicationDelegate {
   func application(_ _: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Default SDK Implementation
        AppsFlyerLib.shared().appsFlyerDevKey = "DEV_KEY"
        AppsFlyerLib.shared().appleAppID = "APLE_APP_ID"
        // AppsFlyerLib.shared().isDebug = true
      
   // Purchase Connector implementation
        PurchaseConnector.shared().purchaseRevenueDelegate = self
        PurchaseConnector.shared().purchaseRevenueDataSource = self
        PurchaseConnector.shared().autoLogPurchaseRevenue = .autoRenewableSubscriptions
   }

   func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
        PurchaseConnector.shared().startObservingTransactions()
    }
}

extension AppDelegate: PurchaseRevenueDataSource, PurchaseRevenueDelegate {
    // PurchaseRevenueDelegate method implementation
    func didReceivePurchaseRevenueValidationInfo(_ validationInfo: [AnyHashable : Any]?, error: Error?) {
        print("PurchaseRevenueDelegate: \(validationInfo)")
        print("PurchaseRevenueDelegate: \(error)")
      // process validationInfo here 
}
    // PurchaseRevenueDataSource method implementation
    func purchaseRevenueAdditionalParameters(for products: Set<SKProduct>, transactions: Set<SKPaymentTransaction>?) -> [AnyHashable : Any]? {
        // Add additional parameters for SKTransactions here.
        return ["additionalParameters":["param1":"value1", "param2":"value2"]];
    }
}
```

### Objective-C Example

```objective-c
#import "AppDelegate.h"
#import <PurchaseConnector/PurchaseConnector.h>
#import <AppsFlyerLib/AppsFLyerLib.h>

@interface AppDelegate () <AppsFlyerPurchaseRevenueDelegate, AppsFlyerPurchaseRevenueDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Set up AppsFlyerLib first
    [[AppsFlyerLib shared] setAppleAppID:@"APPLE_APP_ID"];
    [[AppsFlyerLib shared] setAppsFlyerDevKey:@"DEV_KEY"];
    // [[AppsFlyerLib shared] setIsDebug:YES];
    
    // Set up PurchaseConnector
    [[PurchaseConnector shared] setPurchaseRevenueDelegate:self];
    [[PurchaseConnector shared] setPurchaseRevenueDataSource:self];
    [[PurchaseConnector shared] setAutoLogPurchaseRevenue:AFSDKAutoLogPurchaseRevenueOptionsAutoRenewableSubscriptions];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
     [[AppsFlyerLib shared] start];
     [[PurchaseConnector shared] startObservingTransactions];
}

- (void)didReceivePurchaseRevenueValidationInfo:(NSDictionary *)validationInfo error:(NSError *)error {
    NSLog(@"Validation info: %@", validationInfo);
    NSLog(@"Error: %@", error);
    
    // Process validation info
}

- (NSDictionary *)purchaseRevenueAdditionalParametersForProducts:(NSSet<SKProduct *> *)products transactions:(NSSet<SKPaymentTransaction *> *)transactions {
    return @{@"key1" : @"param1"};
}

@end
```
