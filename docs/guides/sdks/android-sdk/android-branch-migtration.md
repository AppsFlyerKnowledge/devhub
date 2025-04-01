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

# Data flow

Before implementing the flow it is important to understand the rational behind it. 
The code described in the snippets below is a reference for implementing the follow flow. Any other implementation is accepted, as long as you follow this rational.

## Application install (deferred deep linking or organic)

When the application is installed *organically* (without clicking a Branch.io link), or with *deferred deep linking* (by clicking on a Branch.io), take the following steps:
1. Wait 3 seconds from the return of Branch.io callback `onInitFinished()`.
2. Call from Branch.io SDK the method `getLastAttributedTouchData()`
3. Inside the `getLastAttributedTouchData()` callback, call AppsFlyer SDK's  `AppsFlyerMigrationHelper.setAttributionData()` and then `start()`.

## Direct deep linking

In case of direct deep linking (Android App Links or URI scheme) call AppsFlyer SDK's `AppsFlyerMigrationHelper.setDeepLinkingData()` and then `start()`. 

## Application launch without deep linking

When the application is launched without clicking on a Branch.io link, no special action should be taken other than calling `start` from AppsFlyer SDK. 

# SDK and migration module initiazation

## Where is it implemented?

In `application` context:
- Both SDKs are **initialized once globally**.
- The **AppsFlyer SDK is not started here** — it's only initialized. This is important because you delay the actual `start()` call until Branch provides attribution or deep link data.
- This allows the app to **control when AppsFlyer starts** based on LATD availability (from Branch).

# Migration module flow

## Where is it implemented?

All the migration module flow is implemented in the Branch callback `onInitFinished`.  
Branch recommends `onInitFinished` implemeneted in `onStart` of your `MainActivity`. `MainActivity` refers to the applications where you chose to implement Branch `onInitFinished`.
The following code describes the migration code in `onInitFinished`. The full reference can be found [here](#full-code-example). 

## Error check

Initially check if `onInitFinished` returned a non empty `BranchError`. In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

## Organic flow

Organic flow means install or launch of the application not initiated by a click on a Branch link.
In this case the `BranchUniversalObject` will come back empty. 
In this case, skip the migration flow and immediately call AppsFlyer SDK `start`.

## Deep linking 

The migration flow is relevant when a deep linking was the trigger for the app open.
- Deferred deep linking: when the app was installed was a click on a Branch link
- Direct deep linking: when the app was already installed, and a branch click opened it, via Android App Links.

If `onInitFinished` was called with a non-empty `BranchUniversalObject`, this is a deep linking flow.
The normal deep linking flow should proceed normaly after the described migration flow.

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
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        if (intent != null && intent.hasExtra("branch_force_new_session") && intent.getBooleanExtra("branch_force_new_session",false)) {
            Branch.sessionBuilder(this).withCallback(new Branch.BranchReferralInitListener() {
                @Override
                public void onInitFinished(JSONObject referringParams, BranchError error) {
                    if (error != null) {
                        Log.i("BranchSDK_Tester", "onNewIntent onInitFinished: error found!");
                        Log.e("BranchSDK_Tester", error.getMessage());
                    } else if (referringParams != null) {
                        Log.i("BranchSDK_Tester", "@@@@ onNewIntent onInitFinished: referringParams not null");
                        Log.i("BranchSDK_Tester", referringParams.toString());
                    }
                }
            }).reInit();
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

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