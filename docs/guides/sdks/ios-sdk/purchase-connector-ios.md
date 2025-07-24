---
title: "Purchase connector"
slug: "purchase-connector-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
order: 10
---

## Overview

The AppsFlyer ROI360 purchase connector is used to validate and report in-app purchase and subscription revenue events. It’s part of the ROI360 in-app purchase and subscription revenue measurement solution.

- Using the purchase connector requires an ROI360 subscription.
- If you use this in-app purchase and subscription revenue measurement solution, you shouldn’t send [in-app purchase events](https://dev.appsflyer.com/hc/docs/in-app-events-ios) with revenue or execute [`validateAndLogInAppPurchase`](https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-ios), as doing so results in duplicate revenue being reported.
- Before implementing the purchase connector, the ROI360 in-app purchase and subscription revenue measurement needs to be integrated with Google Play and the App Store. [See instructions (steps 1 and 2)](https://support.appsflyer.com/hc/en-us/articles/7459048170769)

## This Module is Built for
- AppsFlyer SDK:
- iOS AppsFlyer SDK **6.17.0** .
- 6.8.0+: StoreKit 1 support
- 6.16.2+: StoreKit 1 & 2 support
- Minimum iOS Version: 12

** ⚠️Important note: ** See the following table for purchase connector and AppsFlyer SDK version compatability and use the correct version to avoid unexpected behavior.

|  Purchase connector  | AppsFlyer SDK |
| :------: | :--------: |
| 6.8.0    | 6.8.0 - 6.9.2 |
| 6.8.1    | 6.8.0 - 6.9.2 |
| 6.10.0   |  6.10.0 |
| 6.10.1   |  6.10.1 |
| 6.12.2   |  6.12.2 |
| 6.12.3   |  6.12.2 |
| 6.17.0   |  6.17.0 |

## Install via Cocoapods

Add the following to your Podfile and run `pod install`:

```
pod 'PurchaseConnector'
```

## Install via Carthage 

1. Go to the `Carthage` folder in the root of the repository. 
2. Open `purchase-connector-dynamic.json` or `purchase-connector-static.json`.
3. Click **ra**.
4. Copy and paste one of the following file URLs to your `Cartfile`:

```
binary "https://raw.githubusercontent.com/AppsFlyerSDK/appsflyer-apple-purchase-connector/main/Carthage/purchase-connector-dynamic.json" == BIINARY_VERSION
binary "https://raw.githubusercontent.com/AppsFlyerSDK/AppsFlyerFramework/master/Carthage/appsflyer-ios.json" ~> 6.10.0
```

5. Open the project folder in the terminal and use the command `carthage update --use-xcframeworks`.
6. Drag and drop PurchaseConnector.xcframework binary and AppsFlyerLib.framework (from Carthage/Build/iOS folder).

[Learn more about Carthage binary artifacts integration](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md).

## Install via SPM

Follow standard SPM dependency manager instructions.

> **Note**: 
> - This repository contains statically linked `PurchaseConnector.xcframework`. If you want to use dynamic .xcframework, integrate it for SPM from ththe following repository:
https://github.com/AppsFlyerSDK/PurchaseConnector-Dynamic*
> - PurchaseConnector has a dependency on [AppsFlyerLib framework](https://github.com/AppsFlyerSDK/AppsFlyerFramework), so make sure to integrate it as well for Carthage and SPM.

## StoreKit 2 Overview

StoreKit 2, introduced by Apple, offers a modern, Swift-first API for managing in-app purchases. It simplifies tasks such as fetching product information, handling transactions, and managing subscriptions by leveraging Swift concurrency features like `async/await`. Additionally, StoreKit 2 provides enhanced tools for testing and debugging in-app purchases, improving the overall developer experience.

### New Purchase Connector Capabilities

With the release of AppsFlyer SDK 6.16.2 and Purchase Connector 6.16.2, the Purchase Connector now supports both StoreKit 1 and StoreKit 2, enabling automatic capture of various transaction types, including:

- Auto-Renewable Subscriptions  
- Non-Renewing Subscriptions  
- Non-Consumable Purchases  
- Consumable Purchases (from iOS 18+ with appropriate configuration)

Due to limitations in earlier iOS versions, consumable purchases require manual logging. This process is detailed later in this document.

To specify which StoreKit version to use, utilize the `setStoreKitVersion:` method with the `AFSDKStoreKitVersion` enum:

```objc
typedef NS_ENUM(NSUInteger, AFSDKStoreKitVersion) {
    AFSDKStoreKitVersionSK1 = 0, // StoreKit 1
    AFSDKStoreKitVersionSK2 = 1, // StoreKit 2
};
```

For example, to set StoreKit 2:

```objc
[[PurchaseConnector shared] setStoreKitVersion:AFSDKStoreKitVersionSK2];
```

```swift
PurchaseConnector.shared().setStoreKitVersion(.SK2)
```

In addition, the Purchase Connector provides wrapper classes to encapsulate StoreKit 2’s `Transaction` and `Product` objects. This is necessary due to Objective-C <> Swift interoperability constraints, allowing for seamless integration with the Purchase Connector.

Example:

```swift
if #available(iOS 15.0, *) {
    let afTransaction = AFSDKTransactionSK2(transaction: transaction)
    // Now you can use afTransaction with Purchase Connector methods
    let originalTransaction = afTransaction.value.originalID
    let transactionDescription = afTransaction.value.debugDescription

    let afProduct = AFSDKProductSK2(product: product)
    // Now you can use afProduct
    let productId = afProduct.value.id
    let productDescription = afProduct.value.description
}
```

> **Important!**  
> Before implementing the Purchase Connector with StoreKit 2, ensure that your App Store credentials are updated in the AppsFlyer Revenue settings.  
> For detailed instructions, refer to our [Help Center article](https://support.appsflyer.com/hc/en-us/articles/27880822483985-Bulletin-Update-App-Store-credendials-for-iOS-ROI360-receipt-validation).

## Basic integration

> **Note**: Before implemening the purchase connector, make sure to set up AppsFlyer `appId` and `devKey`.

### Set up purchase connector

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
```objectivec
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

### Log auto-renewable subscriptions and in-app purchases

Enables automatic logging of auto-renewable subscriptions and in-app purchases.

```swift
PurchaseConnector.shared().autoLogPurchaseRevenue = [.autoRenewableSubscriptions, .inAppPurchases]
```
```objectivec
[[PurchaseConnector shared] setAutoLogPurchaseRevenue:AFSDKAutoLogPurchaseRevenueOptionsRenewable | AFSDKAutoLogPurchaseRevenueOptionsInAppPurchases];
```

> **Note**: If `autoLogPurchaseRevenue` hasn't been set, it is disabled by default. The value is an option set, so you can choose what kind of user purchases you want to observe.

###  Logging Consumable Transactions (StoreKit 2 Only)

For iOS versions prior to 18, or when the `SKIncludeConsumableInAppPurchaseHistory` flag is not enabled, consumable purchases must be manually logged. This requires a verified transaction to be wrapped in an `AFSDKTransactionSK2` object before invoking the `logConsumableTransaction` API.

#### Key Behavior:

- **Automatic Logging:**
  - Non-consumable products, non-renewable subscriptions, and auto-renewable subscriptions are automatically captured by the framework and do not require manual logging.
  - Starting from iOS 18, consumable purchases will also be automatically logged if the `SKIncludeConsumableInAppPurchaseHistory` flag is set to `YES` in the Info.plist file.

- **Manual Logging for Consumables:**
  - For iOS versions 15 to 18, or when the `SKIncludeConsumableInAppPurchaseHistory` flag is not available, consumable purchases must be manually logged.
  - This requires a verified transaction to be wrapped in an `AFSDKTransactionSK2` object before calling the `logConsumableTransaction` API.

#### Code Example

```swift
private func purchaseProductSK2(with productId: String, completion: @escaping (String) -> Void) {
    if #available(iOS 15.0, *) {
        Task {
            do {
                // Fetch the product
                let products = try await Product.products(for: [productId])
                guard let product = products.first else {
                    completion("Product not found for product ID: \(productId)")
                    return
                }

                // Attempt to purchase the product
                let result = try await product.purchase()
                switch result {
                case .success(let verificationResult):
                    switch verificationResult {
                    case .verified(let transaction):
                        // We only log consumable transactions manually.
                        if transaction.productType == .consumable {
                            let afTransaction = AFSDKTransactionSK2(transaction: transaction)
                            PurchaseConnector.shared().logConsumableTransaction(afTransaction)
                        }
                        await transaction.finish()
                        completion("Purchase successful for \(productId), and the transaction is verified!")
                    case .unverified(let transaction, let verificationError):
                        completion("Transaction unverified: \(transaction), error: \(verificationError)")
                    }
                case .pending:
                    completion("Purchase is pending.")
                case .userCancelled:
                    completion("User cancelled the purchase.")
                @unknown default:
                    completion("Unexpected purchase result.")
                }
            } catch {
                completion("Failed to purchase product: \(error.localizedDescription)")
            }
        }
    } else {
        completion("StoreKit 2 is not supported on this device.")
    }
}
```


###  Info.plist Flag for iOS 18+

To enable automatic logging of consumable purchases on iOS 18+, add the following entry to your `Info.plist`:

```xml
<key>SKIncludeConsumableInAppPurchaseHistory</key>
<true/>
```

###  Conform to Purchase Connector Data Source and Delegate Protocols

- To receive purchase validation event callbacks, conform to and implement the `PurchaseRevenueDelegate` (Swift) or `AppsFlyerPurchaseRevenueDelegate` (Objective-C) protocol.
- **StoreKit 1**: To add custom parameters to purchase events sent by the connector, conform to and implement the `PurchaseRevenueDataSource` (Swift) or `AppsFlyerPurchaseRevenueDataSource` (Objective-C) protocol.
- **StoreKit 2**: To add custom parameters to purchase events sent by the connector, conform to and implement the `PurchaseRevenueDataSourceStoreKit2` (Swift) or `AppsFlyerPurchaseRevenueDataSourceStoreKit2` (Objective-C) protocol.



```swift
extension AppDelegate: PurchaseRevenueDataSource, PurchaseRevenueDelegate, PurchaseRevenueDataSourceStoreKit2 {

    @available(iOS 15.0, *)
    func purchaseRevenueAdditionalParametersStoreKit2(
        forProducts products: Set<AFSDKProductSK2>,
        transactions: Set<AFSDKTransactionSK2>?
    ) -> [String: Any]? {
        let additionalParameters: [String: Any] = [
            "products": products.map { ["product_id": $0.value.id] },
            "transactions": transactions?.map { ["transaction_id": $0.value.id] } ?? []
        ]
        return additionalParameters.isEmpty ? nil : additionalParameters
    }

    // PurchaseRevenueDelegate method implementation
    func didReceivePurchaseRevenueValidationInfo(_ validationInfo: [AnyHashable: Any]?, error: Error?) {
        print("PurchaseRevenueDelegate - Validation Info: \(String(describing: validationInfo))")
        print("PurchaseRevenueDelegate - Error: \(String(describing: error))")
        // Process validationInfo here
    }

    // PurchaseRevenueDataSource method implementation
    func purchaseRevenueAdditionalParameters(
        for products: Set<SKProduct>,
        transactions: Set<SKPaymentTransaction>?
    ) -> [AnyHashable: Any]? {
        // Add additional parameters for SKTransactions here
        return ["additionalParameters": ["param1": "value1", "param2": "value2"]]
    }
}
```
```objective-c
@interface AppDelegate () <AppsFlyerPurchaseRevenueDelegate, AppsFlyerPurchaseRevenueDataSource, AppsFlyerPurchaseRevenueDataSourceStoreKit2>
@end

@implementation AppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AppsFlyerLib shared] start];
    [[PurchaseConnector shared] startObservingTransactions];
}

- (NSDictionary<NSString *, id> * _Nullable)purchaseRevenueAdditionalParametersStoreKit2ForProducts:(NSSet<AFSDKProductSK2 *> *)products
                                                                                      transactions:(NSSet<AFSDKTransactionSK2 *> *)transactions API_AVAILABLE(ios(15.0)) {
    NSMutableArray *productArray = [NSMutableArray array];
    for (AFSDKProductSK2 *product in products) {
        [productArray addObject:@{@"product_id": product.value.productIdentifier}];
    }

    NSMutableArray *transactionArray = [NSMutableArray array];
    for (AFSDKTransactionSK2 *transaction in transactions) {
        [transactionArray addObject:@{@"transaction_id": transaction.value.transactionIdentifier}];
    }

    NSMutableDictionary *additionalParameters = [NSMutableDictionary dictionary];
    if (productArray.count > 0) {
        additionalParameters[@"products"] = productArray;
    }
    if (transactionArray.count > 0) {
        additionalParameters[@"transactions"] = transactionArray;
    }

    return additionalParameters.count > 0 ? additionalParameters : nil;
}

- (void)didReceivePurchaseRevenueValidationInfo:(NSDictionary *)validationInfo error:(NSError *)error {
    NSLog(@"Validation info: %@", validationInfo);
    NSLog(@"Error: %@", error);
    
    // Process validation info
}

- (NSDictionary *)purchaseRevenueAdditionalParametersForProducts:(NSSet<SKProduct *> *)products
                                                    transactions:(NSSet<SKPaymentTransaction *> *)transactions {
    return @{@"additionalParameters": @{@"param1": @"value1"}};
}

@end
```

### Start observing transactions

To observe transactions, you need to call `startObservingTransactions`.
 > **Note**: Call this right after the AppsFlyer iOS SDK start method.

```swift
    PurchaseConnector.shared().startObservingTransactions()
```
```objectivec
    [[PurchaseConnector shared] startObservingTransactions];
```

### Stop observing transactions

To stop observing transactions, you need to call `stopObservingTransactions`.

```swift
    PurchaseConnector.shared().stopObservingTransactions()
```
```objectivec
    [[PurchaseConnector shared] stopObservingTransactions];
```

> **Note**: If you called `stopObservingTransactions` API, set the `autoLogPurchaseRevenue` value before you call `startObservingTransactions` next time.

## Test the implementation in Sandbox

To test purchases in an Xcode environment on a real device with a TestFlight sandbox account, set `isSandbox` to `true`.

```swift
    PurchaseConnector.shared().isSandbox = true
```
```objectivec
    [[PurchaseConnector shared] setIsSandbox:YES];
```

> **Important note**: Before releasing your app to production, be sure to remove `isSandbox` or set it to `false`. If the production purchase events are sent in sandbox mode, your events will not be validated properly.

## Full code examples

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
```objectivec
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
