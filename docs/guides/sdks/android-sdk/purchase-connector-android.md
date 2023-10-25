---
title: "Purchase Connector"
slug: "purchase-connector-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
order: 8
---

## Prerequistes

- Android AppsFlyer SDK **6.12.2** and above

## ⚠️ Important Note ⚠️️

Purchase Connector v2.0.0 can only be used with SDK v6.12.2 (and above), as this is the setup that supports Billing Library v5.2.x.
Using Purchase Connector v2.0.0 with an older SDK version will cause the server to reject the Purchase requests.

## Adding The Connector To Your Project

1. Add to your build.gradle file:

```groovy
implementation 'com.appsflyer:purchase-connector:2.0.0'
implementation 'com.android.billingclient:billing:$play_billing_version'
```

   Where `play_billing_version` is 5.2.x.
2.  If you are using ProGuard, add following keep rules to your `proguard-rules.pro` file:

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.Intrinsics{ *; }
-keep class kotlin.collections.**{ *; }
```

## Basic Integration

### Create PurchaseClient Instance

Create an instance of this Connector to configure (in the following steps) for observing and validating transactions in your app.
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

### Start Observing Transactions

Start the SDK instance to observe transactions. </br>

> **⚠️ Please Note**
> This should be called right after calling the Android SDK's [`start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk) method.
> Calling `startObservingTransactions` activates a listener that automatically observes new billing transactions. This includes new and existing subscriptions and new in app purchases.
> The best practice is to activate the listener as early as possible, preferably in the `Application` class.

```java
// start
afPurchaseClient.startObservingTransactions();
```
```kotlin
// start
afPurchaseClient.startObservingTransactions()
```


### Stop Observing Transactions

Stop the SDK instance from observing transactions. </br>
**⚠️ Please Note**
> This should be called if you would like to stop the Connector from listening to billing transactions. This removes the listener and stops observing new transactions. 
> An example for using this API is if the app wishes to stop sending data to AppsFlyer due to changes in the user's consent (opt-out from data sharing). Otherwise, there is no reason to call this method.
> If you do decide to use it, it should be called right before calling the Android SDK's [`stop`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#stop) API

```java
// start
afPurchaseClient.stopObservingTransactions();
```
```kotlin
// start
afPurchaseClient.stopObservingTransactions()
```

### Log Subscriptions

Enables automatic logging of subscription events. </br>
Set true to enable, false to disable.</br>
If this API is not used,  by default, the connector will not record Subscriptions.</br>

```java
builder.logSubscriptions(true);
```
```kotlin
builder.logSubscriptions(true)
```

### Log In App Purchases

Enables automatic logging of In-App purchase events</br>
Set true to enable, false to disable.</br>
If this API is not used,  by default, the connector will not record In App Purchases.</br>

```java
builder.autoLogInApps(true);
```
```kotlin
builder.autoLogInApps(true)
```

## Register Purchase Event Data Source

Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers to let the developer add extra parameters to the payload.

### Subscription Purchase Event Data Source

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

### In Apps Purchase Event Data Source

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

## Register Validation Results Listeners

You can register listeners to get the validation results once getting a response from AppsFlyer servers to let you know if the purchase was validated successfully.

| Listener Method               | Description  |
|-------------------------------|--------------|
| `onResponse(result: Result?)` | Invoked when we got 200 OK response from the server (INVALID purchase is considered to be successful response and will be returned to this callback) |
|`onFailure(result: String, error: Throwable?)`|Invoked when we got some network exception or non 200/OK response from the server.|

### Subscription Validation Result Listener

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

### In Apps Validation Result Listener

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

## Testing The Integration

You can select which environment will be used for validation **production** or **sandbox** (production by default). The sandbox environment should be used while testing your [Google Play Billing Library integration](https://developer.android.com/google/play/billing/test).
To set the environment to sandbox, call the following builder method with `true` value. Make sure to set the environment to production before uploading your app to the plat store (call the method with `false` or completely remove this call).

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

## Full Code Example

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
