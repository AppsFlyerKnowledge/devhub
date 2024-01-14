---
title: "In-app events"
slug: "in-app-events-android"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2020-11-02T18:39:02.209Z"
updatedAt: "2023-05-07T09:04:30.642Z"
order: 5
---
## Overview

For an introduction to in-app events for developers, see [In-app events](doc:in-app-events-sdk).

## Before you begin

You must [integrate the SDK](doc:integrate-android-sdk).

## Logging in-app events

The SDK lets you log user actions happening in the context of your app. These are commonly referred to as **in-app events**.

### The `logEvent` method

The [`logEvent`](doc:android-sdk-reference-appsflyerlib#logevent) method lets you log in-app events and send them to AppsFlyer for processing.

To access the `logEvent` method, import [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib):

```java Java
import com.appsflyer.AppsFlyerLib;
```
```kotlin Kotlin
import com.appsflyer.AppsFlyerLib
```

To access [predefined event constants](#event-constants), import `AFInAppEventType` and `AFInAppEventParameterName`:

```java Java
import com.appsflyer.AFInAppEventType; // Predefined event names
import com.appsflyer.AFInAppEventParameterName; // Predefined parameter names
```
```kotlin Kotlin
import com.appsflyer.AFInAppEventType // Predefined event names
import com.appsflyer.AFInAppEventParameterName // Predefined parameter names
```

`logEvent` takes 4 arguments:

```java
void logEvent(Context context,
              java.lang.String eventName,
              java.util.Map<java.lang.String,java.lang.Object> eventValues,
              AppsFlyerRequestListener listener)
```

- The first argument (`context`) is the Application/Activity Context
- The second argument (`eventName`) is the In-app event name
- The third argument (`eventValues`) is the event parameters `Map`
- The fourth argument (`listener`) is an optional `AppsFlyerRequestListener` (useful for [Handling event submission success/failure](#handling-event-submission-success-and-failure))

### Example: Send "add to wishlist" event

For example, to log that a user added an item to their wishlist:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.PRICE, 1234.56);
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567");

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.ADD_TO_WISHLIST , eventValues);
```
```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.PRICE, 1234.56)
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567")

AppsFlyerLib.getInstance().logEvent(getApplicationContext() ,
                                    AFInAppEventType.ADD_TO_WISHLIST , eventValues)
```

In the above `logEvent` invocation:

- The event name is [`AFInAppEventType.ADD_TO_WISHLIST`](#af_add_to_wishlist)
- The event value is a `Map` containing these event parameters:
  - [AFInAppEventParameterName.PRICE](#af_price): The price that's associated with the event
  - [AFInAppEventParameterName.CONTENT_ID](#af_content_id): The identifier of the added item

### Implementing event structure definitions

Based on the example definition provided in [Understanding event structure definitions](https://dev.appsflyer.com/hc/docs/in-app-events-sdk#understanding-event-structure-definitions), the event should be implemented as follows:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.PRICE, <ITEM_PRICE>);
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>);
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>);

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.CONTENT_VIEW, eventValues);
```
```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.PRICE, <ITEM_PRICE>)
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>)
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>)

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.CONTENT_VIEW, eventValues)
```

### Handling event submission success and failure

You can provide [`logEvent`](doc:android-sdk-reference-appsflyerlib#logevent) with a [`AppsFlyerRequestListener`](doc:android-sdk-reference-appsflyerrequestlistener) object when recording in-app events. The handler allows you to define logic for two scenarios:

- An in-app event is recorded successfully
- An error occurred when recording the in-app event

```java
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.PURCHASE,
                                    eventValues,
                                    new AppsFlyerRequestListener() {
                    @Override
                    public void onSuccess() {
                        Log.d(LOG_TAG, "Event sent successfully");
                    }
                    @Override
                    public void onError(int i, @NonNull String s) {
                        Log.d(LOG_TAG, "Event failed to be sent:\n" +
                                "Error code: " + i + "\n"
                                + "Error description: " + s);
                    }
                });
```
```kotlin
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.PURCHASE,
                                    eventValues,
                                    object : AppsFlyerRequestListener {
            override fun onSuccess() {
                Log.d(LOG_TAG, "Event sent successfully")
            }
            override fun onError(errorCode: Int, errorDesc: String) {
                Log.d(LOG_TAG, "Event failed to be sent:\n" +
                        "Error code: " + errorCode + "\n"
                        + "Error description: " + errorDesc)
            }
        })
```

In the event that an error occurs when recording the in-app event, an error code and string description are provided, as indicated in the table that follows.

| Error code | Description (NSError)                                        |
| :--------- | :----------------------------------------------------------- |
| `10`       | "Event timeout. Check 'minTimeBetweenSessions' param"        |
| `11`       | "Skipping event because 'isStopTracking' enabled"            |
| `40`       | Network error: Error description comes from Android          |
| `41`       | "No dev key"                                                 |
| `50`       | "Status code failure" + actual response code from the server |

### Recording offline events

The SDK can record events that occur when no internet connection is available. See [Offline in-app events](https://dev.appsflyer.com/hc/docs/in-app-events-sdk#offline-in-app-events) for details.

### Logging events before calling `start`

If you initialized the SDK but didn't call `start`, the SDK will cache in-app events until [`start`](doc:android-sdk-reference-appsflyerlib#start) is invoked.

If there are multiple events in the cache, they are sent to the server one after another (unbatched, one network request per event).

## Logging revenue

You can send revenue with any in-app event. Use the [`AFInAppEventParameterName.REVENUE`](#af_revenue) event parameter to include revenue in the in-app event. You can populate it with any numeric value, positive or negative.

The revenue value should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

### Example: Purchase event with revenue

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>);
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>);
eventValues.put(AFInAppEventParameterName.REVENUE, 200);

AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues);
```
```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>)
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>)
eventValues.put(AFInAppEventParameterName.REVENUE, 200)

AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues)
```

The purchase event above has $200 in revenue, appearing as revenue in the dashboard.

> 📘 Note
> 
> Do not add currency symbols to the revenue value.

### Configuring revenue currency

You can set the currency code for an event's revenue by using the `af_currency` predefined event parameter:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.CURRENCY, "USD");
eventValues.put(AFInAppEventParameterName.REVENUE, <TRANSACTION_REVENUE>);
AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues);
```
```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.REVENUE, <TRANSACTION_REVENUE>)
eventValues.put(AFInAppEventParameterName.CURRENCY,"USD")
AppsFlyerLib.getInstance().logEvent(getApplicationContext() , AFInAppEventType.PURCHASE , eventValues)
```

- The currency code should be a 3 character ISO 4217 code
- The default currency is USD

To learn about currency settings, display, and currency conversion, see our guide on [revenue currency](<>).

### Logging negative revenue

There may be situations where you want to record negative revenue. For example, a user receives a refund or cancels a subscription.

To log negative revenue:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.REVENUE, -1234.56);
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567");
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    "cancel_purchase",
                                    eventValues);
```
```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.REVENUE, -1234.56)
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567")
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    "cancel_purchase",
                                    eventValues)
```

> 📘 Note
> 
> Notice the following in the code above:
> 
> - The revenue value is preceded by a minus sign
> - The event name is a custom event name called "cancel_purchase" - it helps you easily identify negative revenue events in the dashboard and raw data reports

## Validating purchases

AppsFlyer provides server verification for in-app purchases. The [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase) method takes care of validating and logging the purchase event.

> 📘 Note
> 
> The legacy function [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase) can be replaced by the newer and fully automatic purchase SDK connector. To learn how to integrate the connector, see in Github [Android purchase SDK connector](https://github.com/AppsFlyerSDK/appsflyer-android-purchase-connector)

### The `validateAndLogInAppPurchase` method

[`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase) is exposed via [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib).

`validateAndLognInAppPurchase` takes these arguments:

```java
validateAndLogInAppPurchase(Context context,
                            java.lang.String publicKey,
                            java.lang.String signature,
                            java.lang.String purchaseData,
                            java.lang.String price, java.lang.String currency,
                            java.util.Map<java.lang.String,java.lang.String> additionalParameters)
```

- `context`: Application / Activity context
- `publicKey`: License Key obtained from the Google Play Console
- `signature`: `data.INAPP_DATA_SIGNATURE` from `onActivityResult`
- `purchaseData`: `data.INAPP_PURCHASE_DATA` from `onActivityResult`
- `price`: Purchase price, should be derived from `skuDetails.getStringArrayList("DETAILS_LIST")`
- `currency`: Purchase currency, should be derived from `skuDetails.getStringArrayList("DETAILS_LIST")`
- `additionalParameters` - Additional event parameters to log

If the validation is successful, an [`af_purchase`](#af_purchase) event is logged with the values provided to [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase).

> 📘 Note
> 
> [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase) generates an [`af_purchase`](#af_purchase) in-app event upon successful validation. Sending this event yourself will cause duplicate event reporting.

### Example: Validate an in-app purchase

```java
// Purchase object is returned by Google API in onPurchasesUpdated() callback
private void handlePurchase(Purchase purchase) {
    Log.d(LOG_TAG, "Purchase successful!");
    Map<String, String> eventValues = new HashMap<>();
    eventValues.put("some_parameter", "some_value");
    AppsFlyerLib.getInstance().validateAndLogInAppPurchase(getApplicationContext(),
                                                           PUBLIC_KEY,
                                                           purchase.getSignature(),
                                                           purchase.getOriginalJson(),
                                                           "10",
                                                           "USD",
                                                           eventValues);
}
```
```kotlin
// Purchase object is returned by Google API in onPurchasesUpdated() callback
private fun handlePurchase(Purchase purchase) {
   Log.d(LOG_TAG, "Purchase successful!")
   val eventValues = HashMap<String, String>()
   eventValues.put("some_parameter", "some_value")
   AppsFlyerLib.getInstance().validateAndLogInAppPurchase(this,
                                                          PUBLIC_KEY,
                                                          purchase.getSignature(),
                                                          purchase.getOriginalJson(),
                                                          "10",
                                                          "USD",
                                                          eventValues)
}
```

### Handling purchase validation success/failure

use [`AppsFlyerInAppPurchaseValidatorListener`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener) to subscribe to purchase validation successes/failures and [`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener) to register it in your Application class.

[`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener) is exposed via [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib). To use [`AppsFlyerInAppPurchaseValidatorListener`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener), import it:

```java Java
import com.appsflyer.AppsFlyerInAppPurchaseValidatorListener;
```
```kotlin Kotlin
import com.appsflyer.AppsFlyerInAppPurchaseValidatorListener
```

[`AppsFlyerInAppPurchaseValidatorListener`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener) has two callbacks:

- [`onValidateInApp`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener#onvalidateinapp): Triggered upon successful purchase validation
- [`onValidateInAppFailure`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener#onvalidateinappfailure): Triggered upon failed purchase validations

[`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener) takes 2 arguments:

- `context`: The Application Context
- `validationListener`: The `AppsFlyerInAppPurchaseValidatorListener` object you wish to register

```java
AppsFlyerLib.getInstance().registerValidatorListener(this,new
   AppsFlyerInAppPurchaseValidatorListener() {
     public void onValidateInApp() {
       Log.d(TAG, "Purchase validated successfully");
     }
     public void onValidateInAppFailure(String error) {
       Log.d(TAG, "onValidateInAppFailure called: " + error);
     }
});
```
```kotlin
AppsFlyerLib.getInstance().registerValidatorListener(this, object : AppsFlyerInAppPurchaseValidatorListener {
    override fun onValidateInApp() {
       	Log.d(LOG_TAG, "Purchase validated successfully")
    }

    override fun onValidateInAppFailure(error: String) {
        Log.d(LOG_TAG, "onValidateInAppFailure called: $error")
   }
})
```

Validating an in-app purchase automatically sends an in-app purchase event to AppsFlyer. See the following sample data that is passed in the event_value parameter:

```json JSON
{
   "some_parameter": "some_value", // from additional_event_values
   "af_currency": "USD", // from currency
   "af_content_id" :"test_id", // from purchase
   "af_revenue": "10", // from revenue
   "af_quantity": "1", // from purchase
   "af_validated": true // flag that AF verified the purchase
}
```

## Event constants

### Predefined event names

To use the following constants, import com.appsflyer.AFInAppEventType:

```java Java
import com.appsflyer.AFInAppEventType;
```
```kotlin Kotlin
import com.appsflyer.AFInAppEventType
```

Predefined event name constants follow a `AFInAppEventType.EVENT_NAME` naming convention. For example, `AFInAppEventType.ADD_TO_CART`

| Event name                           | Android constant name                                                                             |   |
| :----------------------------------- | :------------------------------------------------------------------------------------------------ | - |
| `"af_level_achieved"`                | <div id="af_level_achieved">`AFInAppEventType.LEVEL_ACHIEVED`</div>                               |   |
| `"af_add_payment_info"`              | <div id="af_add_payment_info">`AFInAppEventType.ADD_PAYMENT_INFO`</div>                           |   |
| `"af_add_to_cart"`                   | <div id="af_add_to_cart">`AFInAppEventType.ADD_TO_CART`</div>                                     |   |
| `"af_add_to_wishlist"`               | <div id="af_add_to_wishlist">`AFInAppEventType.ADD_TO_WISHLIST`</div>                             |   |
| `"af_complete_registration"`         | <div id="af_complete_registration">`AFInAppEventType.COMPLETE_REGISTRATION`</div>                 |   |
| `"af_tutorial_completion"`           | <div id="af_tutorial_completion">`AFInAppEventType.TUTORIAL_COMPLETION`</div>                     |   |
| `"af_initiated_checkout"`            | <div id="af_initiated_checkout">`AFInAppEventType.INITIATED_CHECKOUT`</div>                       |   |
| `"af_purchase"`                      | <div id="af_purchase">`AFInAppEventType.PURCHASE`</div>                                           |   |
| `"af_rate"`                          | <div id="af_rate">`AFInAppEventType.RATE`</div>                                                   |   |
| `"af_search"`                        | <div id="af_search">`AFInAppEventType.SEARCH`</div>                                               |   |
| `"af_spent_credits"`                 | <div id="af_spent_credits">`AFInAppEventType.SPENT_CREDITS`</div>                                 |   |
| `"af_achievement_unlocked"`          | <div id="af_achievement_unlocked">`AFInAppEventType.ACHIEVEMENT_UNLOCKED`</div>                   |   |
| `"af_content_view"`                  | <div id="af_content_view">`AFInAppEventType.CONTENT_VIEW`</div>                                   |   |
| `"af_list_view"`                     | <div id="af_list_view">`AFInAppEventType.LIST_VIEW`</div>                                         |   |
| `"af_travel_booking"`                | <div id="af_travel_booking">`AFInAppEventType.TRAVEL_BOOKING`</div>                               |   |
| `"af_share"`                         | <div id="af_share">`AFInAppEventType.SHARE`</div>                                                 |   |
| `"af_invite"`                        | <div id="af_invite">`AFInAppEventType.INVITE`</div>                                               |   |
| `"af_login"`                         | <div id="af_login">`AFInAppEventType.LOGIN`</div>                                                 |   |
| `"af_re_engage"`                     | <div id="af_re_engage">`AFInAppEventType.RE_ENGAGE`</div>                                         |   |
| `"af_update"`                        | <div id="af_update">`AFInAppEventType.UPDATE`</div>                                               |   |
| `"af_location_coordinates"`          | <div id="af_location_coordinates">`AFInAppEventType.LOCATION_COORDINATES`</div>                   |   |
| `"af_customer_segment"`              | <div id="af_customer_segment">`AFInAppEventType.CUSTOMER_SEGMENT`</div>                           |   |
| `"af_subscribe"`                     | <div id="af_subscribe">`AFInAppEventType.SUBSCRIBE`</div>                                         |   |
| `"af_start_trial"`                   | <div id="af_start_trial">`AFInAppEventType.START_TRIAL`</div>                                     |   |
| `"af_ad_click"`                      | <div id="af_ad_click">`AFInAppEventType.AD_CLICK`</div>                                           |   |
| `"af_ad_view"`                       | <div id="af_ad_view">`AFInAppEventType.AD_VIEW`</div>                                             |   |
| `"af_opened_from_push_notification"` | <div id="af_opened_from_push_notification">`AFInAppEventType.OPENED_FROM_PUSH_NOTIFICATION`</div> |   |

### Predefined event parameters

To use the following constants, import `AFInAppEventParameterName`:

```java Java
import com.appsflyer.AFInAppEventParameterName;
```
```kotlin Kotlin
import com.appsflyer.AFInAppEventParameterName
```

Predefined event parameter constants follow a `AFInAppEventParameterName.PARAMETER_NAME` naming convention. For example, `AFInAppEventParameterName.CURRENCY`

| Event parameter name               | Android constant name                                                             | Type                                         |
| :--------------------------------- | :-------------------------------------------------------------------------------- | :------------------------------------------- |
| `"af_content"`                     | <div id="af_content">`CONTENT`</div>                                              | `String[]`                                   |
| `"af_achievement_id"`              | <div id="af_achievement_id">`ACHIEVEMENT_ID`</div>                                | `String`                                     |
| `"af_level"`                       | <div id="af_level">`LEVEL`</div>                                                  | `String`                                     |
| `"af_score"`                       | <div id="af_score">`SCORE`</div>                                                  | `String`                                     |
| `"af_success"`                     | <div id="af_success">`SUCCESS`</div>                                              | `String`                                     |
| `"af_price"`                       | <div id="af_price">`PRICE`</div>                                                  | `float`                                      |
| `"af_content_type"`                | <div id="af_content_type">`CONTENT_TYPE`</div>                                    | `String`                                     |
| `"af_content_id"`                  | <div id="af_content_id">`CONTENT_ID`</div>                                        | `String`                                   |
| `"af_content_list"`                | <div id="af_content_list">`CONTENT_LIST`</div>                                    | `String[]`                                     |
| `"af_currency"`                    | <div id="af_currency">`CURRENCY`</div>                                            | `String`                                     |
| `"af_quantity"`                    | <div id="af_quantity">`QUANTITY`</div>                                            | `int`                                        |
| `"af_registration_method"`         | <div id="af_registration_method">`REGISTRATION_METHOD`</div>                      | `String`                                     |
| `"af_payment_info_available"`      | <div id="af_payment_info_available">`PAYMENT_INFO_AVAILABLE`</div>                | `String`                                     |
| `"af_max_rating_value"`            | <div id="af_max_rating_value">`MAX_RATING_VALUE`</div>                            | `String`                                     |
| `"af_rating_value"`                | <div id="af_rating_value">`RATING_VALUE`</div>                                    | `String`                                     |
| `"af_search_string"`               | <div id="af_search_string">`SEARCH_STRING`</div>                                  | `String`                                     |
| `"af_date_a"`                      | <div id="af_date_a">`DATE_A`</div>                                                | `String`                                     |
| `"af_date_b"`                      | <div id="af_date_b">`DATE_B`</div>                                                | `String`                                     |
| `"af_destination_a"`               | <div id="af_destination_a">`DESTINATION_A`</div>                                  | `String`                                     |
| `"af_destination_b"`               | <div id="af_destination_b">`DESTINATION_B`</div>                                  | `String`                                     |
| `"af_description"`                 | <div id="af_description">`DESCRIPTION`</div>                                      | `String`                                     |
| `"af_class"`                       | <div id="af_class">`CLASS`</div>                                                  | `String`                                     |
| `"af_event_start"`                 | <div id="af_event_start">`EVENT_START`</div>                                      | `String`                                     |
| `"af_event_end"`                   | <div id="af_event_end">`EVENT_END`</div>                                          | `String`                                     |
| `"af_lat"`                         | <div id="af_lat">`LAT`</div>                                                      | `String`                                     |
| `"af_long"`                        | <div id="af_long">`LONG`</div>                                                    | `String`                                     |
| `"af_customer_user_id"`            | <div id="af_customer_user_id">`CUSTOMER_USER_ID`</div>                            | `String`                                     |
| `"af_validated"`                   | <div id="af_validated">`VALIDATED`</div>                                          | `boolean`                                    |
| `"af_revenue"`                     | <div id="af_revenue">`REVENUE`</div>                                              | `float`                                        |
| `"af_projected_revenue"`           | <div id="af_projected_revenue">`PROJECTED_REVENUE`</div>                          | `float`                                        |
| `"af_receipt_id"`                  | <div id="af_receipt_id">`RECEIPT_ID`</div>                                        | `String`                                     |
| `"af_tutorial_id"`                 | <div id="af_tutorial_id">`TUTORIAL_ID`</div>                                      | `String`                                     |
| `"af_virtual_currency_name"`       | <div id="af_virtual_currency_name">`VIRTUAL_CURRENCY_NAME`</div>                  | `String`                                     |
| `"af_deep_link"`                   | <div id="af_deep_link">`DEEP_LINK`</div>                                          | `String`                                     |
| `"af_old_version"`                 | <div id="af_old_version">`OLD_VERSION`</div>                                      | `String`                                     |
| `"af_new_version"`                 | <div id="af_new_version">`NEW_VERSION`</div>                                      | `String`                                     |
| `"af_review_text"`                 | <div id="af_review_text">`REVIEW_TEXT`</div>                                      | `String`                                     |
| `"af_coupon_code"`                 | <div id="af_coupon_code">`COUPON_CODE`</div>                                      | `String`                                     |
| `"af_order_id"`                    | <div id="af_order_id">`ORDER_ID`</div>                                            | `String`                                     |
| `"af_param_1"`                     | <div id="af_param_1">`PARAM_1`</div>                                              | `String`                                     |
| `"af_param_2"`                     | <div id="af_param_2">`PARAM_2`</div>                                              | `String`                                     |
| `"af_param_3"`                     | <div id="af_param_3">`PARAM_3`</div>                                              | `String`                                     |
| `"af_param_4"`                     | <div id="af_param_4">`PARAM_4`</div>                                              | `String`                                     |
| `"af_param_5"`                     | <div id="af_param_5">`PARAM_5`</div>                                              | `String`                                     |
| `"af_param_6"`                     | <div id="af_param_6">`PARAM_6`</div>                                              | `String`                                     |
| `"af_param_7"`                     | <div id="af_param_7">`PARAM_7`</div>                                              | `String`                                     |
| `"af_param_8"`                     | <div id="af_param_8">`PARAM_8`</div>                                              | `String`                                     |
| `"af_param_9"`                     | <div id="af_param_9">`PARAM_9`</div>                                              | `String`                                     |
| `"af_param_10"`                    | <div id="af_param_10">`PARAM_10`</div>                                            | `String`                                     |
| `"af_departing_departure_date"`    | <div id="af_departing_departure_date">`DEPARTING_DEPARTURE_DATE`</div>            | `String`                                     |
| `"af_returning_departure_date"`    | <div id="af_returning_departure_date">`RETURNING_DEPARTURE_DATE`</div>            | `String`                                     |
| `"af_destination_list"`            | <div id="af_destination_list">`DESTINATION_LIST`</div>                            | `String[]`                                   |
| `"af_city"`                        | <div id="af_city">`CITY`</div>                                                    | `String`                                     |
| `"af_region"`                      | <div id="af_region">`REGION`</div>                                                | `String`                                     |
| `"af_country"`                     | <div id="af_country">`COUNTRY`</div>                                              | `String`                                     |
| `"af_departing_arrival_date"`      | <div id="af_departing_arrival_date">`DEPARTING_ARRIVAL_DATE`</div>                | `String`                                     |
| `"af_returning_arrival_date"`      | <div id="af_returning_arrival_date">`RETURNING_ARRIVAL_DATE`</div>                | `String`                                     |
| `"af_suggested_destinations"`      | <div id="af_suggested_destinations">`SUGGESTED_DESTINATIONS`</div>                | `String[]`                                   |
| `"af_travel_start"`                | <div id="af_travel_start">`TRAVEL_START`</div>                                    | `String`                                     |
| `"af_travel_end"`                  | <div id="af_travel_end">`TRAVEL_END`</div>                                        | `String`                                     |
| `"af_num_adults"`                  | <div id="af_num_adults">`NUM_ADULTS`</div>                                        | `String`                                     |
| `"af_num_children"`                | <div id="af_num_children">`NUM_CHILDREN`</div>                                    | `String`                                     |
| `"af_num_infants"`                 | <div id="af_num_infants">`NUM_INFANTS`</div>                                      | `String`                                     |
| `"af_suggested_hotels"`            | <div id="af_suggested_hotels">`SUGGESTED_HOTELS`</div>                            | `String[]`                                   |
| `"af_user_score"`                  | <div id="af_user_score">`USER_SCORE`</div>                                        | `String`                                     |
| `"af_hotel_score"`                 | <div id="af_hotel_score">`HOTEL_SCORE`</div>                                      | `String`                                     |
| `"af_purchase_currency"`           | <div id="af_purchase_currency">`PURCHASE_CURRENCY`</div>                          | `String`                                     |
| `"af_preferred_neighborhoods"`     | <div id="af_preferred_neighborhoods">`PREFERRED_NEIGHBORHOODS`</div>              | `String[]`                                   |
| `"af_preferred_num_stops"`         | <div id="af_preferred_num_stops">`PREFERRED_NUM_STOPS`</div>                      | `String`                                     |
| `"af_adrev_ad_type"`               | <div id="af_adrev_ad_type">`AD_REVENUE_AD_TYPE`</div>                             | `String`                                     |
| `"af_adrev_network_name"`          | <div id="af_adrev_network_name">`AD_REVENUE_NETWORK_NAME`</div>                   | `String`                                     |
| `"af_adrev_placement_id"`          | <div id="af_adrev_placement_id">`AD_REVENUE_PLACEMENT_ID`</div>                   | `String`                                     |
| `"af_adrev_ad_size"`               | <div id="af_adrev_ad_size">`AD_REVENUE_AD_SIZE`</div>                             | `String`                                     |
| `"af_adrev_mediated_network_name"` | <div id="af_adrev_mediated_network_name">`AD_REVENUE_MEDIATED_NETWORK_NAME`</div> | `String`                                     |
| `"af_preferred_price_range"`       | <div id="af_preferred_price_range">`PREFERRED_PRICE_RANGE`</div>                  | `String`, int tuple formatted as `(min,max)` |
| `"af_preferred_star_ratings"`      | <div id="af_preferred_star_ratings">`PREFERRED_STAR_RATINGS`</div>                | `String`, int tuple formatted as `(min,max)` |