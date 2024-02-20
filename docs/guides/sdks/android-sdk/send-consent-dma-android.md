---
title: "Send consent for DMA compliance"
slug: "android-send-consent-for-dma-compliance"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2024-02-08T19:00:15.000Z"
updatedAt: "2024-02-08T19:00:15.000Z"
order: 13
---

For a general introduction to DMA consent data, see [here](https://dev.appsflyer.com/hc/docs/send-consent-for-dma-compliance).

The SDK offers two alternative methods for gathering consent data:

- **Through a Consent Management Platform (CMP)**: If the app uses a CMP that complies with the [Transparency and Consent Framework (TCF) v2.2 protocol](https://iabeurope.eu/tcf-supporting-resources/), the SDK can automatically retrieve the consent details. 

    OR

- **Through a dedicated SDK API**: Developers can pass Google's required consent data directly to the SDK using a specific API designed for this purpose.

## Use CMP to collect consent data

A CMP compatible with TCF v2.2 collects DMA consent data and stores it in `SharedPreferences`. To enable the SDK to access this data and include it with every event, follow these steps:

1. [Initialize the SDK](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) from the `Application` class. 
2. Immediately after initializing the SDK, call `enableTCFDataCollection(true)`  to instruct the SDK to collect the TCF data from the device. 
3. In the `Activity` class, use the CMP to decide if you need the consent dialog in the current session. 
4. If needed, show the consent dialog, using the CMP,  to capture the user consent decision. Otherwise, go to step 6. 
5. Get confirmation from the CMP that the user has made their consent decision, and the data is available in `SharedPreferences`. 
6. Call `start()`.

**Application class**

```java
public class AppsflyerBasicApp extends Application {
    @Override
    public void onCreate() {
      super.onCreate();
      String afDevKey = AppsFlyerConstants.afDevKey;
      AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();  
      // In this example the AppsFlyerConversionListener is not initialized.
      // It is optional
      appsflyer.init(afDevKey, null, this);
      appsflyer.enableTCFDataCollection(true);
    }
}	
```

**Activity class**

```java
public class MainActivity extends AppCompatActivity {

  private boolean consentRequired = true;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);
      if (consentRequired)
          initConsentCollection();
      else
          AppsFlyerLib.getInstance().start(this);
  }
  
  private void initConsentCollection() {
    // Implement here the you CMP flow
    // When the flow is completed and consent was collected 
    // call onConsentCollectionFinished()
  }

  private void onConsentCollectionFinished() {
    AppsFlyerLib.getInstance().start(this);
  }
```

## Manually collect consent data

If your app does not use a CMP compatible with TCF v2.2, utilize the SDK API detailed below to provide the consent data directly to the SDK.

1. [Initialize the SDK](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) from the Application class. 
2. In the `Activity` class, determine whether the GDPR applies or not to the user. 

### When GDPR applies to the user

If GDPR applies to the user, perform the following: 

1. Given that GDPR is applicable to the user, determine whether the consent data is already stored for this session.
   1. If there is no consent data stored, show the consent dialog to capture the user consent decision. 
   2. If there is consent data stored continue to the next step. 
2. To transfer the consent data to the SDK create an object called `AppsFlyerConsent` using the `forGDPRUser()` method with the following parameters:
   - `hasConsentForDataUsage` - Indicates whether the user has consented to use their data for advertising purposes.
   - `hasConsentForAdsPersonalization` - Indicates whether the user has consented to use their data for personalized advertising purposes.
3. Call `setConsentData()` with the `AppsFlyerConsent` object.
4. Call `start()`.   

```java
// If the user is subject to GDPR - collect the consent data
// or retrieve it from the storage
...

// Set the consent data to the SDK:
boolean hasConsentForDataUsage = << true / false >> ; // Based on actual user consent
boolean hasConsentForAdsPersonalization = << true / false >>; // Based on actual user consent
AppsFlyerConsent gdprUserConsent = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage, hasConsentForAdsPersonalization); 
AppsFlyerLib.getInstance().setConsentData(gdprUserConsent);

// Start the AppsFlyer SDK
AppsFlyerLib.getInstance().start(this);
```
```kotlin
// If the user is subject to GDPR - collect the consent data
// or retrieve it from the storage
...

// Set the consent data to the SDK based on actual user consent:
val gdprUserConsent = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage = << true / false >>, // Based on actual user consent
hasConsentForAdsPersonalization = << true / false >>) // 
AppsFlyerLib.getInstance().setConsentData(gdprUserConsent)

// Start the AppsFlyer SDK
AppsFlyerLib.getInstance().start(this);
```

### When GDPR does not apply to the user

If GDPR doesn’t apply to the user perform the following:

1. Create an `AppsFlyerConsent` object using the `forNonGDPRUser()`method. This method doesn’t accept any parameters.
2. Call `setConsentData()` with the `AppsFlyerConsent` object
3. Call `start()`.  

```java
// If the user is not subject to GDPR:
AppsFlyerConsent nonGdprUser = AppsFlyerConsent.forNonGDPRUser(); 
AppsFlyerLib.getInstance().setConsentData(nonGdprUser);

// Start the AppsFlyer SDK
AppsFlyerLib.getInstance().start(this);
```
```kotlin
// If the user is not subject to GDPR:
val nonGdprUser = AppsFlyerConsent.forNonGDPRUser() 
AppsFlyerLib.getInstance().setConsentData(nonGdprUser)

// Start the AppsFlyer SDK
AppsFlyerLib.getInstance().start(this);
```

## Verify consent data is sent

To test whether your SDK sends DMA consent data with each event, perform the following steps:

1. [Enable the SDK debug mode](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).
2. Search for `consent_data` in the log of the outgoing request.

### Logs snippet example for CMP flow

```
LAUNCH-10: preparing data: { ... {"consent_data":{"tcf":{"policy_version":4,"cmp_sdk_id":300,"cmp_sdk_version":2,"gdpr_applies":1,"tcstring":"XXXXXXXX"}}} ... }
```

### Logs snippet example for manual flow

```
LAUNCH-10: preparing data: { ... {"consent_data":{"manual":{"gdpr_applies":true,"ad_user_data_enabled":true,"ad_personalization_enabled":true}}} ... }
```