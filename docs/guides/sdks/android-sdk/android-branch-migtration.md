---
title: "Branch migration"
slug: "branch-migration-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
excerpt: "Migrate your Android app from Branch"
hidden: true
order: 90
---

# Overview

To ensure a smooth handoff of data from Branch to AppsFlyer, your app should collect attribution data from Branch and pass it to AppsFlyer during the first session. In case of direct deep linking (Android App Links or URI scheme) the app should also collect the deep linkind data and pass it to AppsFlyer. `Migration Helper`, which is a new module in AppsFlyer SDK suite facilitates passing the data to AppsFlyer.

# Data flow

Before implementing the flow it is important to understand the rational behind it. 
The code described in the snippets below is a reference for implementing the follow flow. Any other implementation is accepted, as long as you follow this rational.

> ⚠️ In the code below we have implented a persistent mechanism to flag a first install, since we have seen a few discrepencies in the `+is_first_session` parameter in the incoming `Branch Universal Object`.
>

## Application install (deferred deep linking or organic)

When the application is installed *organically* (without clicking a Branch.io link), or with *deferred deep linking* (by clicking on a Branch.io), take the following steps:
1. Wait 3 seconds from the return of Branch.io callback `onInitFinished()`.
2. Call from Branch.io SDK the method `getLastAttributedTouchData()`
3. Inside the `getLastAttributedTouchData()` callback, call AppsFlyer SDK's  `AppsFlyerMigrationHelper.setAttributionData()` and then `start()`.
calling `start` from AppsFlyer SDK. 

## Direct deep linking

In case of direct deep linking (Android App Links or URI scheme) call AppsFlyer SDK's `AppsFlyerMigrationHelper.setDeepLinkingData()` and then `start()`. 

## Application launch without deep linking

When the application is launched without clicking on a Branch.io link, no special action should be taken other than calling `start` from AppsFlyer SDK. 

# Code example reference

---

## When & Where It Happens

In `application` context:
- Both SDKs are **initialized once globally**.
- The **AppsFlyer SDK is not started here** — it's only initialized. This is important because you delay the actual `start()` call until Branch provides attribution or deep link data.
- This allows the app to **control when AppsFlyer starts** based on LATD availability (from Branch).


In `MainActivity.java`:
- `onStart()` registers the callback `onInitFinished`, which handles session init and deep link resolution. `onInitFinished also holds conditional logic whcih forwards **Branch deep link data** to AppsFlyer on re-engagement.
- `collectLatdAndStartAppsFlyer()` ensures AppsFlyer only starts after attribution data is collected from Branch and passed to AppsFlyer.
- `collectLatdFromBranch()` fetches LATD from Branch.

---

## Lifecycle Integration in `MainActivity.java` 

### `onStart()`: Session Init and Attribution Flow

```java
@Override
protected void onStart() {
    super.onStart();
    Branch.sessionBuilder(this)
        .withCallback(new Branch.BranchUniversalReferralInitListener() {
            @Override
            public void onInitFinished(BranchUniversalObject branchUniversalObject, LinkProperties linkProperties, BranchError error) {

                // Check if app was opened via deep link
                boolean isDeeplinkScenario = branchUniversalObject != null;

                if (isBranchLATDCollected(MainActivity.this) && isDeeplinkScenario) {
                    // Not a first session: Forward deep link data to AppsFlyer
                    AppsFlyerMigrationHelper.setDeepLinkingData(Branch.getInstance().getLatestReferringParams());
                }

                // Collect LATD and start AppsFlyer SDK
                collectLatdAndStartAppsFlyer();

                if (error != null) {
                    Log.e("BranchSDK_Tester", "branch init failed. Caused by -" + error.getMessage());
                } else {
                    Log.i("BranchSDK_Tester", "branch init complete!");
                }
            }
        })
        .withData(this.getIntent().getData())
        .init();
}
```

---

## Collecting LATD and Starting AppsFlyer

### `collectLatdAndStartAppsFlyer()`

```java
public void collectLatdAndStartAppsFlyer() {
    if (isBranchLATDCollected(this)) {
        // Not first session: just start AppsFlyer
        AppsFlyerLib.getInstance().start(this);
    } else {
        // First session: collect LATD first
        collectLatdFromBranch(() -> {
            AppsFlyerLib.getInstance().start(this);
        });
        setBranchLATDCollected(this, true); // Mark as collected
    }
}
```

This method ensures that AppsFlyer doesn't start until **Branch attribution data (LATD)** is collected — but only on the first session.

---

##  Collecting LATD from Branch

### `collectLatdFromBranch()`

```java
private void collectLatdFromBranch(Runnable onCollected) {
    new Handler(Looper.getMainLooper()).postDelayed(() -> {
        Branch.getInstance().getLastAttributedTouchData((jsonObject, error) -> {
            AppsFlyerMigrationHelper.setAttributionData(jsonObject);
            onCollected.run();
        }, 7);
    }, 3000); // 3-second delay to ensure data is ready
}
```

- Introduces a slight delay before requesting attribution data from Branch.
- Once retrieved, the LATD is passed to AppsFlyer using:

```java
AppsFlyerMigrationHelper.setAttributionData(jsonObject);
```

---

## Handling Deep Links on Re-engagement

In addition to LATD collection, the app handles **re-engagement via deep links** (when the app is reopened through a Branch link):

```java
boolean isDeeplinkScenario = branchUniversalObject != null;
if (isBranchLATDCollected(MainActivity.this) && isDeeplinkScenario) {
    AppsFlyerMigrationHelper.setDeepLinkingData(Branch.getInstance().getLatestReferringParams());
}
```

### What this does:

- ✅ `isBranchLATDCollected == true`: Ensures this is not the first launch (AppsFlyer is already running).
- ✅ `isDeeplinkScenario == true`: Ensures the app was opened via a Branch deep link.
- ✅ Result: Branch deep link metadata is forwarded to AppsFlyer for proper **re-engagement attribution**.

---

## SDK Initialization Flow (Application Context)

Both the Branch and AppsFlyer SDKs are initialized in the Application class: AppsflyerBasicApp.java.

```java
public class AppsflyerBasicApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        // Enable Branch debug logs
        Branch.enableLogging();

        // Initialize Branch SDK
        Branch.getAutoInstance(this);

        // Initialize AppsFlyer SDK
        String afDevKey = AppsFlyerConstants.afDevKey;
        AppsFlyerLib.getInstance().setDebugLog(true);
        AppsFlyerLib.getInstance().init(afDevKey, null, this);
    }
}
```

### Key Points

| SDK           | Init Location             | Purpose                                                                 |
|---------------|---------------------------|-------------------------------------------------------------------------|
| **Branch**     | `Branch.getAutoInstance()` | Prepares the Branch SDK for handling deep links and collecting data    |
| **AppsFlyer**  | `AppsFlyerLib.init(...)`  | Initializes AppsFlyer with your dev key; SDK is ready but not started yet |

---

## Summary

| What                               | When                    | How                                                 |
|------------------------------------|--------------------------|------------------------------------------------------|
| Collect LATD from Branch           | First session only       | `collectLatdFromBranch()` → `setAttributionData()`  |
| Start AppsFlyer SDK                | Concluding every flow    | `AppsFlyerLib.getInstance().start()`                |
| Send deep link data to AppsFlyer   | On app re-open via link  | `setDeepLinkingData()`                              |

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

                // This condition is true in case of direct deep linking
                boolean isDeeplinkScenario = branchUniversalObject != null;
                if (isBranchLATDCollected(MainActivity.this) && isDeeplinkScenario) {
                    // Not a first start, need to collect deep linking data
                    AppsFlyerMigrationHelper.setDeepLinkingData(Branch.getInstance().getLatestReferringParams());
                }

                // This method will collect the LATD (if this is the first session) and start the AF SDK
                collectLatdAndStartAppsFlyer();

                if (error != null) {
                    Log.e("BranchSDK_Tester", "branch init failed. Caused by -" + error.getMessage());
                } else {
                    Log.i("BranchSDK_Tester", "branch init complete!");
                    if (branchUniversalObject != null) {
                        Log.i("BranchSDK_Tester", "title " + branchUniversalObject.getTitle());
                        Log.i("BranchSDK_Tester", "CanonicalIdentifier " + branchUniversalObject.getCanonicalIdentifier());
                        Log.i("BranchSDK_Tester", "metadata " + branchUniversalObject.getContentMetadata().convertToJson());

                        JSONObject sessionParams = branchUniversalObject.getContentMetadata().convertToJson();

                        try {
                            goToFruit(sessionParams.getString("fruit_name"));
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }

                    } else {
                        Log.i("BranchSDK_Tester", "@@@@ branchUniversalObject came back null");
                    }

                    if (linkProperties != null) {
                        Log.i("BranchSDK_Tester", "Channel " + linkProperties.getChannel());
                        Log.i("BranchSDK_Tester", "control params " + linkProperties.getControlParams());
                    } else {
                        Log.i("BranchSDK_Tester", "@@@@ linkProperties came back null");
                    }
                }
            }
        }).withData(this.getIntent().getData()).init();
        // init the LATD call from inside the session initialization callback

//        getFirstReferringBranchUniversalObject();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    public void collectLatdAndStartAppsFlyer() {
        if (isBranchLATDCollected(this)) {
            // This is not the first session, no need to collect LATD, start AF SDK right away
            AppsFlyerLib.getInstance().start(this);
        } else {
            // This is the first session, need to collect LATD. then start AF SDK
            collectLatdFromBranch(() -> {
                // On LATD collected start AF SDK
                AppsFlyerLib.getInstance().start(this);
            });
            // Mark LATD collected in the shared preferences
            setBranchLATDCollected(this, true);
        }
    }

    private void collectLatdFromBranch(Runnable onCollected) {
        new Handler(Looper.getMainLooper()).postDelayed(() -> {
            Branch.getInstance().getLastAttributedTouchData((jsonObject, error) -> {
                // Read the data from the jsonObject
                AppsFlyerMigrationHelper.setAttributionData(jsonObject);
                onCollected.run();
            }, 7);
        }, 3000);
    }
}
```

## PreferencesHelper

```java
public class PreferencesHelper {

    private static final String PREFS_NAME = "app-preferences";
    private static final String IS_LATD_COLLECTED_KEY = "pref-branch-latd-collected";

    private static SharedPreferences getSharedPreferences(Context context) {
        return context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
    }

    public static boolean isBranchLATDCollected(Context context) {
        return getSharedPreferences(context).getBoolean(IS_LATD_COLLECTED_KEY, false);
    }

    public static void setBranchLATDCollected(Context context, boolean isCollected) {
        getSharedPreferences(context).edit().putBoolean(IS_LATD_COLLECTED_KEY, isCollected).apply();
    }
}
```