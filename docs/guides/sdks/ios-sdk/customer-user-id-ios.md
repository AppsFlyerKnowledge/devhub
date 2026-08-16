---
title: Setting the Customer User ID
slug: customer-user-id-ios
category:
  uri: AppsFlyer SDKs
parent:
  uri: integrate-sdk-ios-6
privacy:
  view: public
position: 4
---
<span class="annotation-optional">Optional</span>  
The Customer User ID (CUID) is a unique user identifier created outside the SDK by the app owner. If made available to the SDK, it can be associated with installs and other in-app events. These CUID-tagged events can be cross-referenced with user data from other devices and applications.

### Set the CUID

To set the CUID:

```objectivec
[AppsFlyerLib shared].customerUserID = @"my user id";
```
```swift
AppsFlyerLib.shared().customerUserID = "my user id"
```

> 📘 Note
> 
> The Customer User ID must be set with every app launch.

### Associate the CUID with the install event

If it’s important for you to associate the install event with the CUID, you should set  to set the [`customerUserId`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#customeruserid) before calling the [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) method. This is because [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) sends the install event to AppsFlyer. If the CUID is set after calling [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start), it will not be associated with the install event.

```objectivec
- (void)applicationDidBecomeActive:(UIApplication *)application {
  	// Your custom logic of retrieving CUID
    NSString *customUserId = [[NSUserDefaults standardUserDefaults] stringForKey:@"customerUserId"];  
    if (customUserId != nil && ![customUserId  isEqual: @""]) {
        // Set CUID in AppsFlyer SDK for this session
        [AppsFlyerLib shared].customerUserID = customUserId; 
        // Start
        [[AppsFlyerLib shared] start]; 
    }
}
```
```swift
func applicationDidBecomeActive(_ application: UIApplication) {
  //  your logic to retrieve CUID
  let customUserId = UserDefaults.standard.string(forKey: "customUserId") 
  
  if(customUserId != nil && customUserId != ""){
     // Set CUID in AppsFlyer SDK for this session
    AppsFlyerLib.shared().customerUserID = customUserId    
    AppsFlyerLib.shared().start() // Start
  }
}
```
