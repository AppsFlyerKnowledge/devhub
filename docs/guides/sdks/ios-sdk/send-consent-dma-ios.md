---
title: "Send consent for DMA compliance"
slug: "ios-send-consent-for-dma-compliance"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
excerpt: "Learn how to preserve user privacy in the iOS SDK."
hidden: false
createdAt: "2024-02-08T19:00:15.000Z"
updatedAt: "2024-02-08T19:00:15.000Z"
order: 12
---

For a general introduction to DMA consent data, see [here](https://dev.appsflyer.com/hc/docs/send-consent-for-dma-compliance).

The SDK offers two alternative methods for gathering consent data:

- **Through a Consent Management Platform (CMP)**: If the app uses a CMP that complies with the [Transparency and Consent Framework (TCF) v2.2 protocol](https://iabeurope.eu/tcf-supporting-resources/), the SDK can automatically retrieve the consent details.  

  OR

- **Through a dedicated SDK API**: Developers can pass Google's required consent data directly to the SDK using a specific API designed for this purpose.

## Use CMP to collect consent data

A CMP compatible with TCF v2.2 collects DMA consent data and stores it in `NSUserDefaults`. To enable the SDK to access this data and include it with every event, follow these steps:

1. Initialize the SDK in `didFinishLaunchingWithOptions` as described [here](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#initializing-the-ios-sdk).
2. Call `enableTCFDataCollection(true)`  to instruct the SDK to collect the TCF data from the device.
3. In the `applicationDidBecomeActive` lifecycle method, use the CMP to decide if you need the consent dialog in the current session to acquire the consent data.  If you need the consent dialog move to step 4; otherwise move to step 5.
4. Get confirmation from the CMP that the user has made their consent decision and the data is available in `NSUserDefaults`.
5. Call `start()`.

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate , AppsFlyerLibDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "RootViewController") // set this to your ViewController
        window?.rootViewController = viewController
        
        //YOUR_CMP_FLOW()
        
        
        //Init the SDK
	AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().enableTCFDataCollection(true)
        return true
    }
		
    func applicationDidBecomeActive(_ application: UIApplication) {
        if(cmpManager!.hasConsent()){
            //CMP manager already has consent ready - you can start
            AppsFlyerLib.shared().start()
        }else{
            //CMP doesn't have consent data ready yet
            //Waiting for CMP completion and data ready and then start
            cmpManager?.withOnCmpButtonClickedCallback({ CmpButtonEvent in
                AppsFlyerLib.shared().start()
            })
        }
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .denied:
                    print("AuthorizationSatus is denied")
                case .notDetermined:
                    print("AuthorizationSatus is notDetermined")
                case .restricted:
                    print("AuthorizationSatus is restricted")
                case .authorized:
                    print("AuthorizationSatus is authorized")
                @unknown default:
                    fatalError("Invalid authorization status")
                }
            }
        }
    }
}
```

## Manually collect consent data

If your app does not use a CMP compatible with TCF v2.2, use the SDK API detailed below to provide the consent data directly to the SDK.

1. Initialize the SDK in `didFinishLaunchingWithOptions` as described [here](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#initializing-the-ios-sdk).
2. In the`applicationDidBecomeActive` lifecycle method determine whether the GDPR applies or not to the user. 

### When GDPR applies to the user

If GDPR applies to the user, perform the following: 

1. Given that GDPR is applicable to the user, determine whether the consent data is already stored for this session.
   1. If there is no consent data stored, show the consent dialog to capture the user consent decision. 
   2. If there is consent data stored continue to the next step.
2. To transfer the consent data to the SDK create an `AppsFlyerConsent` object with the following parameters:
   - `forGDPRUserWithHasConsentForDataUsage` - Indicates whether the user has consented to use their data for advertising purposes.
   - `hasConsentForAdsPersonalization` - Indicates whether the user has consented to use their data for personalized advertising.
3. Call `setConsentData()`with the `AppsFlyerConsent` object. 
4. Call `start()`.  

```swift
// If the user is subject to GDPR - collect the consent data
// or retrieve it from the storage
...
// Set the consent data to the SDK:
var gdprConsent = AppsFlyerConsent(forGDPRUserWithHasConsentForDataUsage: << true / false >>, hasConsentForAdsPersonalization: << true / false >>) 
AppsFlyerLib.shared().setConsentData(gdprConsent)
// Start the AppsFlyer SDK
```

### When GDPR does not apply to the user

If GDPR doesn’t apply to the user perform the following:

1. Create an `AppsFlyerConsent` object using the `nonGDPRUser()` initializer. This initializer doesn’t accept any parameters.
2. Pass the empty `AppsFlyerConsent` object to `setConsentData()`. 
3. Call `start()`. 

```swift
// If the user is not subject to GDPR:
var nonGdprUser = AppsFlyerConsent(nonGDPRUser: ()) 
AppsFlyerLib.shared().setConsentData(nonGdprUser)
```
```objectivec
// If the user is not subject to GDPR:
AppsFlyerConsent *consentNonGDPR = [[AppsFlyerConsent alloc] initNonGDPRUser];
[[AppsFlyerLib shared] setConsentData:consentNonGDPR];
```

## Verify consent data is sent

To test whether your SDK sends DMA consent data with each event, perform the following steps:

1. [Enable the SDK debug mode](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode).
2. Search for `consent_data` in the log of the outgoing request.

### Logs snippet example for CMP flow

```
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>
<~+~   SEND Start:   https://pgnjrq-launches.appsflyersdk.com/api/v6.13/iosevent?app_id=112223344&buildnumber=6.13.0.147
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>

{ ... "consent_data":{"tcf":{"cmp_sdk_id":-1,"policy_version":-1,"tcstring":"","gdpr_applies":-1,"cmp_sdk_version":-1}} ... }
```

### Logs snippet example for manual flow

```
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>
<~+~   SEND Start:   https://pgnjrq-launches.appsflyersdk.com/api/v6.13/iosevent?app_id=112223344&buildnumber=6.13.0.147
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>

{ ... "consent_data":{"manual":{"gdpr_applies":true,"ad_user_data_enabled":true,"ad_personalization_enabled":true}} ... }
```
