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

- **Through a Consent Management Platform (CMP)**: If the app uses a CMP that complies with the [Transparency and Consent Framework (TCF) v2.2/2.3 protocol](https://iabeurope.eu/tcf-supporting-resources/), the SDK can automatically retrieve the consent details.  

**OR**

- **Through a dedicated SDK API**: Developers can pass Google's required consent data directly to the SDK using a specific API designed for this purpose.

> 📘 Note
> 
> AppsFlyer recommends using only one of the above methods per specific event sent. If both methods are sent for the same event, AppsFlyer will prioritize the consent data sent via the dedicated SDK API.

## Use CMP to collect consent data

A CMP compatible with TCF v2.2/2.3 collects DMA consent data and stores it in `NSUserDefaults`. To enable the SDK to access this data and include it with every event, follow these steps:

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

If your app does not use a CMP compatible with TCF v2.2/2.3, use the SDK API detailed below to provide the consent data directly to the SDK.

To manually collect consent data, perform the following:

1. Initialize the SDK in `didFinishLaunchingWithOptions` as described [here](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#initializing-the-ios-sdk).
2. In the`applicationDidBecomeActive` lifecycle method determine whether the GDPR applies or not to the user.
3. Determine whether the consent data is already stored for this session.
    - If there is no consent data stored, show the consent dialog to capture the user consent decision.
    - If there is consent data stored - continue to the next step.
4. To transfer the consent data to the SDK create an object called [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance)  with the following parameters:
    - `isUserSubjectToGDPR` - Indicates whether GDPR applies to the user.
    - `hasConsentForDataUsage` - Indicates whether the user has consented to use their data for advertising purposes.
    - `hasConsentForAdsPersonalization` - Indicates whether the user has consented to use their data for personalized advertising.
    - `hasConsentForAdStorage` - indicates whether the user has consented to store or access information on a device.
5. If the GDPR does not apply to the user `isUserSubjectToGDPR` is `false` and the rest of the parameters must be `null`. See example below. 
6. Call [`setConsentData()`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#setconsentdata) with the [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance).

> 📘 Note
>   
> SDK registers only parameters which are explicitly passed to the  [`setConsentData()`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#setconsentdata) method via the [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/ios-send-consent-for-dma-compliance) object.
  
6. Call `start()`.

```swift
// Set the consent data to the SDK:
// Collect the consent data
// or retrieve it from the storage
...
//  Example for a user subject to GDPR
var gdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: true, 
	hasConsentForDataUsage: false, 
	hasConsentForAdsPersonalization: true, 
	hasConsentForAdStorage: false
)
AppsFlyerLib.shared().setConsentData(gdprUser)

//  Example for a user not subject to GDPR        
var nonGdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: false, 
	hasConsentForDataUsage: null, 
	hasConsentForAdsPersonalization: null, 
	hasConsentForAdStorage: null
)
AppsFlyerLib.shared().setConsentData(nonGdprUser)

// Start the SDK
AppsFlyerLib.shared().start()

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

{ ... "consent_data":{"tcf":{"cmp_sdk_version":1503,"tcstring":"XXXXXXX","cmp_sdk_id":31,"gdpr_applies":1,"policy_version":4}} ... }
```

### Logs snippet example for manual flow

```
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>
<~+~   SEND Start:   https://pgnjrq-launches.appsflyersdk.com/api/v6.13/iosevent?app_id=112223344&buildnumber=6.13.0.147
<~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~+~~+~>

{ ... "consent_data":{"manual":{"gdpr_applies":true,"ad_user_data_enabled":true,"ad_personalization_enabled":true}} ... }
```
