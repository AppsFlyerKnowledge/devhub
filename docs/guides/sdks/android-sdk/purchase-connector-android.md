---
title: "Purchase connector"
slug: "purchase-connector-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
order: 10
---

## Prerequistes

- AppsFlyer Android SDK **6.12.2** and above

## ⚠️ Important note ⚠️️

Purchase Connector v2.0.0 (and above) can only be used with SDK v6.12.2 (and above), as this is the setup that supports Billing Library v5.x.x and V6.x.x.

Using the purchase connector v2.0.0 with an older SDK version will cause the server to reject the purchase requests.

| Purchase connector version   |      Supported billing library version      |  Supported AppsFlyer SDK version |
|----------|-------------|------|
|v2.0.0|  v5.x.x | v6.12.2 and above|
| v2.0.1 |    v5.x.x - v6.x.x   |   v6.12.2 and above |

## Adding the connector to your project

1. Add the following to your build.gradle file, where `play_billing_version`  is 5.x.x or 6.x.x:

```groovy
implementation 'com.appsflyer:purchase-connector:2.0.1'
implementation 'com.android.billingclient:billing:$play_billing_version'
```

2. If you are using ProGuard, add following keep rules to your `proguard-rules.pro` file:

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.Intrinsics{ *; }
-keep class kotlin.collections.**{ *; }
```

## Basic integration

### Create PurchaseClient instance

Create an instance of this connector to observe and validate transactions in your app.
**Make sure to save a reference to the built object. If the object is not saved, it could lead to unexpected behavior and memory leaks.**

```java
// init
PurchaseClient.Builder builder = new PurchaseClient.Builder(context, Store.GOOGLE);
// Make sure to keep this instance
PurchaseClient purchaseClient = builder.build();
```
```kotlin
// init
val builder = PurchaseClient.Builder(this, Store.GOOGLE)
// Make sure to keep this instance
val afPurchaseClient = builder.build()
```

### Start observing transactions

Start the SDK instance to observe transactions. </br>

> **⚠️ Note**
> This should be called right after calling the Android SDK [`start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk) method.
> Calling `startObservingTransactions` activates a listener that automatically observes new billing transactions. This includes new and existing subscriptions and new in-app purchases.
> The best practice is to activate the listener as early as possible, preferably in the `Application` class.

```java
// start
afPurchaseClient.startObservingTransactions();
```
```kotlin
// start
afPurchaseClient.startObservingTransactions()
```


### Stop observing transactions

Stop the SDK instance from observing transactions. </br>
**⚠️ Note**
> This should be called if you want to stop the connector from listening to billing transactions. This removes the listener and stops the observation of new transactions. 
> Use this API when, for example, you want the app to stop sending data to AppsFlyer due to changes in user consent (opt-out from data sharing). Otherwise, there is no reason to call this method.
> If you decide to use this API, it should be called right before calling the Android SDK [`stop`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#stop) API.

```java
// start
afPurchaseClient.stopObservingTransactions();
```
```kotlin
// start
afPurchaseClient.stopObservingTransactions()
```

### Log subscriptions

Enables the automatic logging of subscription events. </br>
Set `true` to enable, `false` to disable.</br>
If this API isn't used, then by default, the connector doesn't record subscriptions.</br>

```java
builder.logSubscriptions(true);
```
```kotlin
builder.logSubscriptions(true)
```

### Log in-app purchases

Enables the automatic logging of in-app purchase events</br>
Set `true` to enable, `false` to disable.</br>
If this API isn't used, then by default, the connector doesn't record in-app purchases.</br>

```java
builder.autoLogInApps(true);
```
```kotlin
builder.autoLogInApps(true)
```

## Register purchase event data source

The purchase event data source listener is invoked before sending data to AppsFlyer servers, to let the developer add extra parameters to the payload.

### Subscription purchase event data source

```java
builder.setSubscriptionPurchaseEventDataSource(new PurchaseClient.SubscriptionPurchaseEventDataSource() {
    @NonNull
    @Override
    public Map<String, Object> onNewPurchases(@NonNull List<? extends SubscriptionPurchaseEvent> purchaseEvents) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("some key", "value");
        return map;
    }
});

// or use lambda 
builder.setSubscriptionPurchaseEventDataSource(purchaseEvents -> {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("some key", "value");
    return map;
});
```
```kotlin
builder.setSubscriptionPurchaseEventDataSource(object : PurchaseClient.SubscriptionPurchaseEventDataSource{
    override fun onNewPurchases(purchaseEvents: List<SubscriptionPurchaseEvent>): Map<String, Any> {
        return mapOf("some key" to "some value")
    }
})

// or use lambda
builder.setSubscriptionPurchaseEventDataSource {
    mapOf(
        "some key" to "some value",
        "another key" to it.size
    )
}
```

### In-apps purchase event data source

```java
builder.setInAppPurchaseEventDataSource(new PurchaseClient.InAppPurchaseEventDataSource() {
    @NonNull
    @Override
    public Map<String, Object> onNewPurchases(@NonNull List<? extends InAppPurchaseEvent> purchaseEvents) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("some key", "value");
        return map;
    }
});

// or use lambda 
builder.setInAppPurchaseEventDataSource(purchaseEvents -> {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("some key", "value");
    return map;
});
```
```kotlin
builder.setInAppPurchaseEventDataSource(object :
    PurchaseClient.InAppPurchaseEventDataSource {
    override fun onNewPurchases(purchaseEvents: List<InAppPurchaseEvent>): Map<String, Any> {
        return mapOf(
            "some key" to "some value",
            "another key" to purchaseEvents.size
        )
    }
})

// or use lambda
builder.setInAppPurchaseEventDataSource { 
    mapOf(
        "some key" to "some value",
        "another key" to it.size
    )
}
```

## Register validation result listeners

You can register listeners to get the validation results after getting a response from AppsFlyer servers to know if the purchase was validated successfully.

| Listener Method               | Description  |
|-------------------------------|--------------|
| `onResponse(result: Result?)` | Invoked when we got 200 OK response from the server (INVALID purchase is considered to be successful response and will be returned to this callback) |
|`onFailure(result: String, error: Throwable?)`|Invoked when we got some network exception or non 200/OK response from the server.|

### Subscription validation result listener

```java
builder.setSubscriptionValidationResultListener(new PurchaseClient.SubscriptionPurchaseValidationResultListener() {
    @Override
    public void onResponse(@Nullable Map<String, ? extends SubscriptionValidationResult> result) {
        if (result == null) {
            return;
        }
        result.forEach((k, v) -> {
            if (v.getSuccess()) {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " was validated successfully");
                SubscriptionPurchase subscriptionPurchase = v.getSubscriptionPurchase();
                Log.d(TAG, subscriptionPurchase.toString());
            } else {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " wasn't validated successfully");
                ValidationFailureData failureData = v.getFailureData();
                Log.d(TAG, failureData.toString());
            }
        });
    }

    @Override
    public void onFailure(@NonNull String result, @Nullable Throwable error) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
        if (error != null) {
            error.printStackTrace();
        }
    }
});
```
```kotlin
builder.setSubscriptionValidationResultListener(object :
    PurchaseClient.SubscriptionPurchaseValidationResultListener {
    override fun onResponse(result: Map<String, SubscriptionValidationResult>?) {
        result?.forEach { (k: String, v: SubscriptionValidationResult?) ->
            if (v.success) {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID $k was validated successfully")
                val subscriptionPurchase = v.subscriptionPurchase
                Log.d(TAG, subscriptionPurchase.toString())
            } else {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID $k wasn't validated successfully")
                val failureData = v.failureData
                Log.d(TAG, failureData.toString())
            }
        }
    }

    override fun onFailure(result: String, error: Throwable?) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
        error?.printStackTrace()
    }
})
```

### In-app purchase validation result listener

```java
builder.setInAppValidationResultListener(new PurchaseClient.InAppPurchaseValidationResultListener() {
    @Override
    public void onResponse(@Nullable Map<String, ? extends InAppPurchaseValidationResult> result) {
        if (result == null) {
            return;
        }
        result.forEach((k, v) -> {
            if (v.getSuccess()) {
                Log.d(TAG, "[PurchaseConnector]: Product with Purchase Token " + k + " was validated successfully");
                ProductPurchase productPurchase = v.getProductPurchase();
                Log.d(TAG, productPurchase.toString());
            } else {
                Log.d(TAG, "[PurchaseConnector]: Subscription with Purchase Token " + k + " wasn't validated successfully");
                ValidationFailureData failureData = v.getFailureData();
                Log.d(TAG, failureData.toString());
            }
        });
    }

    @Override
    public void onFailure(@NonNull String result, @Nullable Throwable error) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
        if (error != null) {
            error.printStackTrace();
        }
    }
});
```
```kotlin
builder.setInAppValidationResultListener(object :
    PurchaseClient.InAppPurchaseValidationResultListener {
    override fun onResponse(result: Map<String, InAppPurchaseValidationResult>?) {
        result?.forEach { (k: String, v: InAppPurchaseValidationResult?) ->
            if (v.success) {
                Log.d(TAG, "[PurchaseConnector]:  Product with Purchase Token$k was validated successfully")
                val productPurchase = v.productPurchase
                Log.d(TAG, productPurchase.toString())
            } else {
                Log.d(TAG, "[PurchaseConnector]:  Product with Purchase Token $k wasn't validated successfully")
                val failureData = v.failureData
                Log.d(TAG, failureData.toString())
            }
        }
    }

    override fun onFailure(result: String, error: Throwable?) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
        error?.printStackTrace()
    }
})
```

## Test the integration

You can select which environment will be used for validation, either **production** or **sandbox** (production is the default). The sandbox environment should be used while testing your [Google Play Billing Library integration](https://developer.android.com/google/play/billing/test).
To set the environment to sandbox, call the following builder method with `true` as the value. Make sure to set the environment to production before uploading your app to the platform store, either by calling this method with `false` as the value or completely removing this call.

```java
// sandbox environment
builder.setSandbox(true);
// production environment
builder.setSandbox(false);

```
```kotlin
// sandbox environment
builder.setSandbox(true)
// production environment
builder.setSandbox(false)

```

## Full code example

```java
@Override
public void onCreate() {
    super.onCreate();
    AppsFlyerLib.getInstance().init("YOUR_DEV_KEY", listener, getApplicationContext());
    AppsFlyerLib.getInstance().start(getApplicationContext());
    // init - Make sure to save a reference to the built object. If the object is not saved,
    // it could lead to unexpected behavior and memory leaks.
    PurchaseClient afPurchaseClient = new PurchaseClient.Builder(getApplicationContext(), Store.GOOGLE)
            // Enable Subscriptions auto logging
            .logSubscriptions(true)
            // Enable In Apps auto logging
            .autoLogInApps(true)
            // set production environment
            .setSandbox(false)
            // Subscription Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
            // to let customer add extra parameters to the payload
            .setSubscriptionPurchaseEventDataSource(purchaseEvents -> {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("somekey", "value");
                map.put("type", "Subscription");
                return map;
            })
            // In Apps Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
            // to let customer add extra parameters to the payload
            .setInAppPurchaseEventDataSource(purchaseEvents -> {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("somekey", "value");
                map.put("type", "InApps");
                return map;
            })
            // Subscriptions Purchase Validation listener. Invoked after getting response from AppsFlyer servers
            // to let customer know if purchase was validated successfully
            .setSubscriptionValidationResultListener(new PurchaseClient.SubscriptionPurchaseValidationResultListener() {
                @Override
                public void onResponse(@Nullable Map<String, ? extends SubscriptionValidationResult> result) {
                    if (result == null) {
                        return;
                    }
                    result.forEach((k, v) -> {
                        if (v.getSuccess()) {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " was validated successfully");
                            SubscriptionPurchase subscriptionPurchase = v.getSubscriptionPurchase();
                            Log.d(TAG, subscriptionPurchase.toString());
                        } else {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " wasn't validated successfully");
                            ValidationFailureData failureData = v.getFailureData();
                            Log.d(TAG, failureData.toString());
                        }
                    });
                }

                @Override
                public void onFailure(@NonNull String result, @Nullable Throwable error) {
                    Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
                    if (error != null) {
                        error.printStackTrace();
                    }
                }
            })
            // In Apps Purchase Validation listener. Invoked after getting response from AppsFlyer servers
            // to let customer know if purchase was validated successfully
            .setInAppValidationResultListener(new PurchaseClient.InAppPurchaseValidationResultListener() {
                @Override
                public void onResponse(@Nullable Map<String, ? extends InAppPurchaseValidationResult> result) {
                    if (result == null) {
                        return;
                    }
                    result.forEach((k, v) -> {
                        if (v.getSuccess()) {
                            Log.d(TAG, "[PurchaseConnector]: Product with Purchase Token " + k + " was validated successfully");
                            ProductPurchase productPurchase = v.getProductPurchase();
                            Log.d(TAG, productPurchase.toString());
                        } else {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with Purchase Token " + k + " wasn't validated successfully");
                            ValidationFailureData failureData = v.getFailureData();
                            Log.d(TAG, failureData.toString());
                        }
                    });
                }

                @Override
                public void onFailure(@NonNull String result, @Nullable Throwable error) {
                    Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
                    if (error != null) {
                        error.printStackTrace();
                    }
                }
            })
            // Build the client
            .build();

    // Start the SDK instance to observe transactions.
    afPurchaseClient.startObservingTransactions();
}
 
```
```kotlin
override fun onCreate() {
    super.onCreate()
    // init and start the native AppsFlyer Core SDK
    AppsFlyerLib.getInstance().apply {
        init("YOUR_DEV_KEY", listener, applicationContext)
        start(applicationContext)
    }
    // init - Make sure to save a reference to the built object. If the object is not saved, 
    // it could lead to unexpected behavior and memory leaks.
    val afPurchaseClient = PurchaseClient.Builder(applicationContext, Store.GOOGLE)
        // Enable Subscriptions auto logging
        .logSubscriptions(true)
        // Enable In Apps auto logging
        .autoLogInApps(true)
        // set production environment
        .setSandbox(false)
        // Subscription Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
        // to let customer add extra parameters to the payload
        .setSubscriptionPurchaseEventDataSource {
            mapOf(
                "some key" to "some value",
                "another key" to it.size
            )
        }
        // In Apps Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
        // to let customer add extra parameters to the payload
        .setInAppPurchaseEventDataSource {
            mapOf(
                "some key" to "some value",
                "another key" to it.size
            )
        }
        // Subscriptions Purchase Validation listener. Invoked after getting response from AppsFlyer servers
        // to let customer know if purchase was validated successfully
        .setSubscriptionValidationResultListener(object :
            PurchaseClient.SubscriptionPurchaseValidationResultListener {
            override fun onResponse(result: Map<String, SubscriptionValidationResult>?) {
                result?.forEach { (k: String, v: SubscriptionValidationResult?) ->
                    if (v.success) {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]: Subscription with ID $k was validated successfully"
                        )
                        val subscriptionPurchase = v.subscriptionPurchase
                        Log.d(TAG, subscriptionPurchase.toString())
                    } else {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]: Subscription with ID $k wasn't validated successfully"
                        )
                        val failureData = v.failureData
                        Log.d(TAG, failureData.toString())
                    }
                }
            }

            override fun onFailure(result: String, error: Throwable?) {
                Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
                error?.printStackTrace()
            }
        })
        // In Apps Purchase Validation listener. Invoked after getting response from AppsFlyer servers
        // to let customer know if purchase was validated successfully
        .setInAppValidationResultListener(object :
            PurchaseClient.InAppPurchaseValidationResultListener {
            override fun onResponse(result: Map<String, InAppPurchaseValidationResult>?) {
                result?.forEach { (k: String, v: InAppPurchaseValidationResult?) ->
                    if (v.success) {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]:  Product with Purchase Token$k was validated successfully"
                        )
                        val productPurchase = v.productPurchase
                        Log.d(TAG, productPurchase.toString())
                    } else {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]:  Product with Purchase Token $k wasn't validated successfully"
                        )
                        val failureData = v.failureData
                        Log.d(TAG, failureData.toString())
                    }
                }
            }

            override fun onFailure(result: String, error: Throwable?) {
                Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
                error?.printStackTrace()
            }
        })
        // Build the client
        .build()

    // Start the SDK instance to observe transactions.
    afPurchaseClient.startObservingTransactions()
}
```
