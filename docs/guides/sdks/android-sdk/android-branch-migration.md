---
title: "Branch Migration Navigator on Android"
slug: "branch-migration-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Activate the Branch Migration Navigator to streamline your traffic migration journey from Branch to AppsFlyer"
hidden: true
order: 90
---

# What is Branch Migration Navigator?

The Branch Migration Navigator is a tool designed to support a gradual and informed migration from Branch to AppsFlyer. It enables AppsFlyer to collect traffic signals from Branch through a lightweight module integrated into the app.

This guide explains how to activate the Branch Migration Navigator on Android using the AppsFlyerMigrationHelper module, allowing surfacing Branch traffic data and, optionally, supporting attribution continuity during the migration period. `Migration Helper` is a new module in AppsFlyer SDK suite which facilitates passing the data to AppsFlyer.

To ensure a smooth handoff of the navigator, your app should collect attribution data from Branch and pass it to the AppsFlyerMigrationHelper during the first session. In addition, in case of direct deep linking (Android App Links or URI scheme) the app should collect the deep linking data and pass it as well.

# Installation

## Prerequisites

- AppsFlyer SDK: 6.16.2+
- Minimum iOS Version: 12

## Adding the migration helper to your project via Cocoapods

Add to your Podfile and run `pod install`:

```
// for statically linked dependency
pod 'AppsFlyerMigrationHelper'
```

## Adding the connector to your project via Carthage

To integrate the AppsFlyer Apple Migration Helper via Carthage:

1. Go to the `Carthage` folder in the root of the repository. 
2. Open `AppsFlyerMigrationHelper-dynamic.json`, 
3. Click raw, 
4. Copy and paste the URL of the file to your `Cartfile`: 

    ```
    binary "https://raw.githubusercontent.com/AppsFlyerSDK/appsflyer-apple-migration-helper/main/Carthage/AppsFlyerMigrationHelper-dynamic.json" == BIINARY_VERSION
    ```

5. Open the project folder in the terminal and use command `carthage update --use-xcframeworks`, 
6. Drag and drop `AppsFlyerMigrationHelper.xcframework` binary (from Carthage/Build/iOS folder).

More reference on Carthage binary artifacts integration [here](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md).

## Adding the connector to your project via SPM

To integrate the AppsFlyer Apple Migration Helper via Swift Package Manager (SPM):
1. In Xcode, go to File > Swift Packages > Add Package Dependency.
2. Enter the repository URL:

    ```
    https://github.com/AppsFlyerSDK/appsflyer-apple-migration-helper
    ```

3. Choose the desired version or branch.
4. Select your project’s target and click Finish.



# Code flow concept

Before implementing the flow it is important to understand the rational behind it. Any other implementation is accepted, as long as you follow this rational.

| **Scenario**                  | **Suggested Indication**                                                        | **Action**                                                                                         | **Branch Method (Click Data Retrieval)**                               | **AppsFlyer Method**                                                   |
|-------------------------------|---------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|------------------------------------------------------------------------|
| **Organic App Open**          | `branchUniversalObject` is `null`                                                | No Branch data to retrieve; proceed to start AppsFlyer SDK                                         | N/A                                                                    | N/A                                  |
| **Branch Deferred Deep Link** | `branchUniversalObject` is not `null` and `+is_first_session` is `true`          | Introduce a 3-second delay, then retrieve and pass install-attributed click data to AppsFlyer      | `Branch.getInstance().getLastAttributedTouchData()`                    | `AppsFlyerMigrationHelper.setAttributionData()`                        |
| **Branch Direct Deep Link**   | `branchUniversalObject` is not `null` and `+is_first_session` is `false`         | Retrieve and pass direct deep link click data to AppsFlyer                                         | `Branch.getInstance().getLatestReferringParams()` or `branchUniversalObject.getContentMetadata().convertToJson()` | `AppsFlyerMigrationHelper.setDeepLinkingData()`                        |

# SDK and migration module initiazation

- **Initialize Both SDKs Globally**:
  - In the `application` context, initialize both the Branch and AppsFlyer SDKs globally.

> ⚠️ Important
> 
> Do not run AppsFlyer SDK `start` immediately after the `init`.
> Read below when to start AppsFlyer SDK

- **Control the Start of the AppsFlyer SDK**:
  - Invoke the `start` method of the AppsFlyer SDK **only after** passing the deep link data from Branch to AppsFlyer. This approach allows the app to manage the SDK's initiation, ensuring all necessary data from Branch is available beforehand.
  - In all scenarios—including when a `BranchError` occurs or when `branchUniversalObject` is `null` (indicating an organic app open)—it is essential to call `AppsFlyerLib.getInstance().start()` to initiate the AppsFlyer SDK, ensuring it functions correctly across all app launch scenarios.

# Migration module flow

All the migration module flow is implemented in the Branch callback `onInitFinished`.  
Branch recommends `onInitFinished` implemeneted in `onStart` of your `MainActivity`. `MainActivity` refers to the applications where you chose to handle deep linking.
The following code describes the migration code in `onInitFinished`. The full reference can be found [here](#full-code-example). 

## Error check

Initially check if `onInitFinished` returned a non empty `BranchError`. In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

## Organic flow

Organic flow means install or launch of the application not initiated by a click on a Branch link.
In this case the `BranchUniversalObject` will come back empty. 
In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

## Deep linking 

The migration process becomes relevant when an app launch is triggered by a Branch click. There are two primary types of deep linking:​
- Deferred Deep Linking: This occurs when a user clicks on a Branch link and, if the app is not already installed, is directed to install it. After installation, the user is taken directly to the intended content within the app according to link data.​
- Direct Deep Linking: This happens when the app is already installed, and a user clicks on a Branch link (e.g., through Android App Links), which opens the app directly to the specified content, according to the link data.​

When the `onInitFinished` callback is invoked with a non-empty `BranchUniversalObject`, it indicates that a deep linking event has occurred. After completing the migration steps, the standard deep-linking procedures integrated with Branch should continue as usual.

## Deferred deep linking

In a deferred deep linking scenario, the parameter `+is_first_session` in the incoming `BranchUniversalObject` is `true`.
In this case:
 1. After a mandatory 3 seconds register the callback `getLastAttributedTouchData`
 2. In the `getLastAttributedTouchData` callback call:
    - AppsFlyer `AppsFlyerMigrationHelper.setAttributionData` with the incoming deep linking data from `getLastAttributedTouchData`.
    - Call AppsFlyer `start`

## Direct deep linking

In a direct deep linking scenario, the parameter `+is_first_session` in the incoming `BranchUniversalObject` is `false`.
In this case:
 1. Call AppsFlyer `AppsFlyerMigrationHelper.setDeepLinkingData` with the output from `getLatestReferringParams`.
 2. Call AppsFlyer `start` 

# Full code example 

## `MainActivity`

```java

public class MainActivity extends AppCompatActivity {

    // ...
    // onNewIntent() and onCreate() not affected
    // ...
    
    @Override
    protected void onStart() {
        super.onStart();
        Branch.sessionBuilder(this).withCallback(new Branch.BranchUniversalReferralInitListener() {
            @Override
            public void onInitFinished(BranchUniversalObject branchUniversalObject, LinkProperties linkProperties, BranchError error) {

                if (error != null) {
                    // Branch init failed. Start AppsFlyer immediately
                    Log.e("BranchSDK_Tester", "branch init failed. Caused by -" + error.getMessage());
                    AppsFlyerLib.getInstance().start(MainActivity.this);
                } else {
                    Log.i("BranchSDK_Tester", "branch init complete!");
                    boolean isBranchDeeplink = branchUniversalObject != null;
                    if (isBranchDeeplink) {
                        // Deep link flow
                        JSONObject sessionParams = branchUniversalObject.getContentMetadata().convertToJson();
                        try {
                            boolean isFirstSession = Boolean.parseBoolean(sessionParams.getString("+is_first_session"));
                            if(isFirstSession) {
                                // Deferred deep link
                                new Handler(Looper.getMainLooper()).postDelayed(() -> {
                                    Branch.getInstance().getLastAttributedTouchData((jsonObject, latd_error) -> {
                                        // Read the data from the LATD jsonObject
                                        AppsFlyerMigrationHelper.setAttributionData(jsonObject);
                                        // On LATD collected
                                        AppsFlyerLib.getInstance().start(MainActivity.this);
                                    }, 7);
                                }, 3000);
                            } else {
                                // Direct deep link
                                AppsFlyerMigrationHelper.setDeepLinkingData(Branch.getInstance().getLatestReferringParams());
                                AppsFlyerLib.getInstance().start(MainActivity.this);
                            }
                            goToFruit(sessionParams.getString("fruit_name"));
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }

                    } else {
                        // Organic install or launch
                        Log.i("BranchSDK_Tester", "@@@@ branchUniversalObject came back null");
                        AppsFlyerLib.getInstance().start(MainActivity.this);
                    }

                    if (linkProperties != null) {
                        Log.i("BranchSDK_Tester", "control params " + linkProperties.getControlParams());
                    } else {
                        Log.i("BranchSDK_Tester", "@@@@ linkProperties came back null");
                    }
                }
            }
        }).withData(this.getIntent().getData()).init();
        // init the LATD call from inside the session initialization callback
    }
}
```