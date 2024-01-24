---
title: "Conversion data"
slug: "conversion-data-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2021-05-10T10:40:55.129Z"
updatedAt: "2022-07-18T17:35:39.716Z"
order: 6
---
In this guide you will learn how to get [conversion data](doc:conversion-data) using the iOS SDK, as well as [usage examples](https://dev.appsflyer.com/hc/docs/conversion-data-android#accessing-attribution-data).

Before you begin
----------------

Getting conversion data requires you first [integrate the SDK](doc:integrate-ios-sdk).

Getting conversion data in iOS SDK
----------------------------------


[block:tutorial-tile]
{
  "backgroundColor": "#01f476",
  "emoji": "👟",
  "id": "615d904dc6b5e20016df6293",
  "link": "https://dev.appsflyer.com/v0.1/recipes/get-conversion-data-in-ios",
  "slug": "get-conversion-data-in-ios",
  "title": "Get Conversion Data in iOS"
}
[/block]


```objectivec
#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate ()
@end
@implementation AppDelegate
    // ...
    -(void)onConversionDataSuccess:(NSDictionary*) installData {
    // Invoked when conversion data resolution succeeds
}
-(void)onConversionDataFail:(NSError *) error {
    // Invoked when conversion data resolution fails
    NSLog(@"%@",error);
}
// ...
@end
```
```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // ..
}

extension AppDelegate: AppsFlyerLibDelegate {

    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        // Invoked when conversion data resolution succeeds
    }

    func onConversionDataFail(_ error: Error!) {
        // Invoked when conversion data resolution fails
    }
}
```

#### onConversionDataSuccess

[`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) is implemented in [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate).  
The [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) method is invoked whenever:

- A user opens the app
- A user moves the app to the foreground

When invoked, [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) returns a `NSDictionary` (called `installData` in the example) that contains attribution data for that install. `installData` is cached the first time [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) is called and will be identical on consecutive calls.

#### onConversionDataFail

[`onConversionDataFail`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatafail) is implemented in  [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate).  
If for whatever reason the SDK fails to fetch the conversion data, [`onConversionDataFail`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatafail) is invoked.

Accessing attribution data
--------------------------

You can get the conversion type by checking the value of `af_status` in `onConversionDataSuccess`'s payload. It can be one of the following values:

- `Organic`
- `Non-organic`

#### Example

Following is an example implementation:

```objectivec
#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()
@end
@implementation AppDelegate
    // ...
-(void)onConversionDataSuccess:(NSDictionary*) installData {
    // Business logic for Non-organic install scenario is invoked
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        NSLog(@"This is a Non-organic install. Media source: %@  Campaign: %@",sourceID,campaign);
    }

    else if([status isEqualToString:@"Organic"]) {
        // Business logic for Organic install scenario is invoked
        NSLog(@"This is an Organic install.");
    }

}
-(void)onConversionDataFail:(NSError *) error {
    NSLog(@"%@",error);
}
// ...
@end
```
```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {
    // ...
}

extension AppDelegate: AppsFlyerLibDelegate {

    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                // Business logic for Non-organic install scenario is invoked
                if let sourceID = installData["media_source"],
                let campaign = installData["campaign"] {
                    print("This is a Non-organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            }
            else {
                // Business logic for organic install scenario is invoked
            }
        }
    }

    func onConversionDataFail(_ error: Error!) {
        // Logic for when conversion data resolution fails
        if let err = error{
            print(err)
        }
    }
}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L168-L212)

Deferred deep linking (Legacy method)
-------------------------------------

When the app is opened via deferred deep linking, [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess)'s payload returns deep linking data, as well as attribution data.

- The recommended best practice is to implement deep linking with [Unified Deep Linking (UDL)](https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking)
- For existing clients and reference, here is our [legacy iOS deep linking guide](https://dev.appsflyer.com/hc/docs/dl_ios_gcd_legacy), using [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess).