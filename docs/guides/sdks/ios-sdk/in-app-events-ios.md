---
title: "In-app events"
slug: "in-app-events-ios"
excerpt: "Learn how to work with in-app events in the iOS SDK."
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2021-05-10T10:41:46.430Z"
updatedAt: "2023-05-07T09:13:55.637Z"
order: 5
---
## Overview

This document is a guide on implementing in-app events in the iOS SDK. For an introduction to in-app events for developers, see [in-app events](doc:in-app-events-sdk).

## Before you begin

You must [integrate the SDK](doc:integrate-ios-sdk).

## Logging in-app events

The SDK lets you log user actions happening in the context of your app. These are commonly referred to as **in-app events**.

### The `logEvent` method

The [`logEvent`](doc:ios-sdk-reference-appsflyerlib#logevent) method lets you log in-app events and send them to AppsFlyer for processing.

[`AppsFlyerLib`](ios-sdk-reference-appsflyerlib) exposes [`logEvent`](doc:ios-sdk-reference-appsflyerlib#logevent), predefined [event name](#predefined-event-names) constants and predefined [event parameter](#predefined-event-parameters) constants.

[`logEvent`](doc:ios-sdk-reference-appsflyerlib#logevent) takes 3 arguments:

```objectivec
- (void)logEventWithEventName:(NSString *)eventName
        eventValues:(NSDictionary<NSString * , id> * _Nullable)eventValues
        completionHandler:(void (^ _Nullable)(NSDictionary<NSString *, id> * _Nullable dictionary, NSError * _Nullable error))completionHandler;
```

- The first argument (`eventName`) is the event name
- The second argument (`eventValues`) is the event parameters `NSDictionary`
- The third argument (`completionHandler`) is an optional completion handler (useful for [Handling event submission success/failure](docs:in-app-events-ios#handling-event-submission-success-and-failure))

> 📘 Note
> 
> `eventValues` (second argument) must be a valid `NSDictionary`. For more information, see [Foundation JSONSerialization](https://developer.apple.com/documentation/foundation/jsonserialization).

### Example: Send "add to wishlist" event

For example, to log that a user added an item to their wishlist:

```objectivec
[[AppsFlyerLib shared]  logEvent: AFEventAddToWishlist withValues: @{
    AFEventParamPrice: @20,
    AFEventParamContentId: @"123456"
}]
```
```swift
AppsFlyerLib.shared().logEvent(AFEventAddToWishlist,
  withValues: [
     AFEventParamPrice: 20,
     AFEventParamContentId: "123456"
]);
```

In the above [`logEvent`](doc:ios-sdk-reference-appsflyerlib#logevent) invocation:

- The event name is [`AFEventAddToWishlist`](#af_add_to_wishlist)
- The event value is a `NSDictionary` containing these event parameters:
  - [AFEventParamPrice](#af_price): The item price the user added to their wishlist
  - [AFEventParamContentId](#af_content_id): The identifier of the added item

### Implementing in-app event definitions

Based on the example definition provided in [Understanding event structure definitions](doc:in-app-events-sdk#understanding-event-structure-definitions), the event should be implemented as follows:

```objectivec
[[AppsFlyerLib shared]  logEvent: AFEventContentView withValues: @{
    AFEventParamContentId: <ITEM_SKU>,
    AFEventParamContentType: <ITEM_TYPE>,
    AFEventParamPrice: <ITEM_PRICE>
}]
```
```swift
AppsFlyerLib.shared().logEvent(AFEventAddToCart,
  withValues: [
    AFEventParamContent: <ITEM_NAME>
    AFEventParamContentId: <ITEM_SKU>
    AFEventParamPrice: <ITEM_PRICE>
]);
```

### Handling event submission success and failure

You can pass a `completionHandler` to [`logEvent`](doc:ios-sdk-reference-appsflyerlib#logevent) when recording in-app events. The handler allows you to define logic for two scenarios:

- An in-app event recorded successfully
- An error occurred when recording the in-app event

```objectivec
[[AppsFlyerLib shared] logEventWithEventName:AFEventPurchase
        eventValues: @{
          AFEventParamRevenue: @200,
          AFEventParamCurrency: @"USD",
          AFEventParamQuantity: @2,
          AFEventParamContentId: @"092",
          AFEventParamReceiptId: @"9277"
        }
        completionHandler:^(NSDictionary<NSString *,id> * _Nullable dictionary, NSError * _Nullable error){
            if(dictionary != nil) {
                NSLog(@"In app callback success:");
                for(id key in dictionary){
                    NSLog(@"Callback response: key=%@ value=%@", key, [dictionary objectForKey:key]);
                }
            }
            if(error != nil) {
                NSLog(@"In app callback error:", error);
            }
    }];
```
```swift
AppsFlyerLib.shared().logEvent(name: AFEventAddToWishlist,
          values: [
             AFEventParamPrice: 20,
             AFEventParamContentId: "123456"
          ],
          completionHandler: { (response: [String : Any]?, error: Error?) in
            if let response = response {
              print("In app event callback Success: ", response)
            }
            if let error = error {
              print("In app event callback ERROR:", error)
            }
          });
```

In the event that an error occurs when recording the in-app event, an error code and string description are provided, as indicated in the table that follows.

| Error code | Description (NSError)                                        |
| :--------- | :----------------------------------------------------------- |
| `10`       | "Event timeout. Check 'minTimeBetweenSessions' param"        |
| `11`       | "Skipping event because 'isStopTracking' enabled"            |
| `40`       | Network error: Error description comes from iOS          |
| `41`       | "No dev key"                                                 |
| `50`       | "Status code failure" + actual response code from the server |

### Recording offline events

The SDK can record events that occur when no internet connection is available. See [Offline in-app events](https://dev.appsflyer.com/hc/docs/in-app-events-sdk#offline-in-app-events) for details.

### Logging events before calling `start`

If you [initialized the SDK](doc:integrate-ios-sdk#initializing-the-ios-sdk) but didn't call [`start`](doc:ios-sdk-reference-appsflyerlib#start), the SDK will cache in-app events until [`start`](doc:ios-sdk-reference-appsflyerlib#start) is invoked.

If there are multiple events in the cache, they are sent to the server one after another (unbatched, one network request per event).

> 📘 Note
> 
> If the SDK is initialized, `logEvent` invocations will call SKAdNetwork's [`updateConversionValue`](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue) even if `start` wasn't called or `isStopped` is set to `true` (in both SDK and S2S modes).

## Logging revenue

[`af_revenue`](#af_revenue) is the only event parameter that AppsFlyer counts as real revenue in the dashboard and reports.  
You can send revenue with any in-app event. Use the [`AFEventParameterRevenue`](#af_revenue) constant to include revenue in the in-app event. You can populate it with any numeric value, positive or negative.

The revenue value should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

### Example: Purchase event with revenue

```objectivec
[[AppsFlyerLib shared] logEvent: AFEventPurchase 
withValues:@{
	AFEventParamContentId:@"1234567",
	AFEventParamContentType : @"category_a",
	AFEventParamRevenue: @200,
	AFEventParamCurrency:@"USD"
}];
```
```swift
AppsFlyerLib.shared().logEvent(AFEventPurchase, 
withValues: [
	AFEventParamContentId:"1234567",
	AFEventParamContentType : "category_a",
	AFEventParamRevenue: 200,
	AFEventParamCurrency:"USD"
]);
```

> 📘 Note
> 
> Do not add currency symbols to the revenue value.

### Configuring revenue currency

You can set the currency code for an event's revenue by using the [`af_currency`](#af_currency) predefined event parameter:

```objectivec
[[AppsFlyerLib shared] logEvent: AFEventPurchase
withValues:@{
	AFEventParamRevenue: @200,
	AFEventParamCurrency:@"USD"
}];
```
```swift
AppsFlyerLib.shared().logEvent(AFEventPurchase, 
withValues: [
	AFEventParamRevenue: 200,
	AFEventParamCurrency:"USD"
]);
```

- The currency code should be a 3 character [ISO 4217 code](https://en.wikipedia.org/wiki/ISO_4217)
- The default currency is USD

To learn about currency settings, display, and currency conversion, see our guide on revenue currency.

### Logging negative revenue

There may be situations where you want to record negative revenue. For example, a user receives a refund or cancels a subscription.

To log negative revenue:

```objectivec
[[AppsFlyerLib shared] logEvent: @"cancel_purchase" 
withValues:@{
	AFEventParamContentId:@"1234567",
	AFEventParamContentType : @"category_a",
	AFEventParamRevenue: @-1.99,
	AFEventParamCurrency:@"USD"
}];
```
```swift
AppsFlyerLib.shared().logEvent("cancel_purchase", 
withValues: [
	AFEventParamContentId:"1234567",
	AFEventParamContentType : "category_a",
	AFEventParamRevenue: -1.99,
	AFEventParamCurrency:"USD"
]);
```

Notice the following in the code above:

- The revenue value is preceded by a minus sign
- The event name is a [custom event](doc:in-app-events#custom-events-and-event-parameters) called `cancel_purchase` - that's how the marketer identifies negative revenue events in the dashboard and raw-data reports

## Validating purchases

AppsFlyer provides server verification for in-app purchases. The [`validateAndLogInAppPurchase`](doc:ios-sdk-reference-appsflyerlib#validateandlog) method takes care of validating and logging the purchase event.

> 📘 Note
> 
> The legacy function [`validateAndLogInAppPurchase`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#validateandlogloginapppurchase) can be replaced by the newer and fully automatic purchase SDK connector. To learn how to integrate the connector, see in Github [iOS purchase SDK connector](https://github.com/AppsFlyerSDK/appsflyer-apple-purchase-connector)

### Purchase validation using validateAndLogInAppPurchase

`validateAndLoginInAppPurchase` takes these arguments:

```objectivec
- (void) validateAndLogInAppPurchase:(NSString *) productIdentifier,
                  price:(NSString *) price
                  currency:(NSString *) currency
                  transactionId:(NSString *) tranactionId
                  additionalParameters:(NSDictionary *) params
                  success:(void (^)(NSDictionary *response)) successBlock
                  failure:(void (^)(NSError *error, id reponse)) failedBlock;
```
```swift
validateAndLog(inAppPurchase: String?,
               price: String?,
               currency: String?,
               transactionId: String?,
               additionalParameters: [AnyHashable : Any]?,
               success: ([AnyHashable : Any]) -> Void)?,
               failure: ((Error?, Any?) -> Void)?)
```

Upon successful validation, a `NSDictionary` is returned with the receipt validation data (provided by Apple servers).

> 📘 Note
> 
> Calling [`validateAndLogInAppPurchase`](doc:ios-sdk-reference-appsflyerlib#validateandlog) generates an [`af_purchase`](#af_purchase) in-app event upon successful validation. Sending this event yourself creates duplicate event reporting.

### Example: Validate in-app purchase

```objectivec
[[AppsFlyerLib shared] validateAndLogInAppPurchase:@"ProductIdentifier" price:@"price"
    currency:@"USD"
    transactionId:@"transactionID"
    additionalParameters:@{@"test": @"val" , @"test1" : @"val 1"}
    success:^(NSDictionary *result){
      NSLog(@"Purchase succeeded And verified! response: %@", result[@"receipt"]);
    } failure:^(NSError *error, id response) {
      NSLog(@"response = %@", response);
      if([response isKindOfClass:[NSDictionary class]]) {
        if([response[@"status"] isEqualToString:@"in_app_arr_empty"]){
          // retry with 'SKReceiptRefreshRequest' because
          // Apple has returned an empty response
          // <YOUR CODE HERE>
        }

      } else {
        //handle other errors
        return;
      }
  }];
```
```swift
AppsFlyerLib.shared().validateAndLogInAppPurchase (
  inAppPurchase: "productIdentifier",
  price: "price",
  currency: "currency",
  transactionId: "transactionId",
  additionalParameters: [:],
  success: {
      guard let dictionary = $0 as? [String:Any] else { return }
      dump(dictionary)
    }, 
  failure: { error, result in
      guard let emptyInApp = result as? [String:Any],
      let status = emptyInApp["status"] as? String,
      status == "in_app_arr_empty" else {
      // Try to handle other errors
      return
    }     
    })
```

#### Testing purchase validation in Sandbox mode

To test purchase validation using a sandboxed environment, add the following code:

```objectivec
[AppsFlyerLib shared].useReceiptValidationSandbox = YES;
```
```swift
AppsFlyerLib.shared().useReceiptValidationSandbox = true
```

> 📘 Note
> 
> This code must be removed from your production builds.

Validating an in-app purchase automatically generates and sends an in-app purchase event to AppsFlyer. Its `eventValues` will look something like this:

```json
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

Predefined event name constants follow a `AFEventEventName` naming convention. For example, [`AFEventAddToCart`](#af_add_to_cart).

| Event name                                                                            | iOS constant name                   |
| :------------------------------------------------------------------------------------ | :---------------------------------- |
| <div id="af_level_achieved">`"af_level_achieved"`</div>                               | `AFEventLevelAchieved`              |
| <div id="af_add_payment_info">`"af_add_payment_info"`</div>                           | `AFEventAddPaymentInfo`             |
| <div id="af_add_to_cart">`"af_add_to_cart"`</div>                                     | `AFEventAddToCart`                  |
| <div id="af_add_to_wishlist">`"af_add_to_wishlist"`</div>                             | `AFEventAddToWishlist`              |
| <div id="af_complete_registration">`"af_complete_registration"`</div>                 | `AFEventCompleteRegistration`       |
| <div id="af_tutorial_completion">`"af_tutorial_completion"`</div>                     | `AFEventTutorial_completion`        |
| <div id="af_initiated_checkout">`"af_initiated_checkout"`</div>                       | `AFEventInitiatedCheckout`          |
| <div id="af_purchase">`"af_purchase"`</div>                                           | `AFEventPurchase`                   |
| <div id="af_rate">`"af_rate"`</div>                                                   | `AFEventRate`                       |
| <div id="af_search">`"af_search"`</div>                                               | `AFEventSearch`                     |
| <div id="af_spent_credits">`"af_spent_credits"`</div>                                 | `AFEventSpentCredits`               |
| <div id="af_achievement_unlocked">`"af_achievement_unlocked"`</div>                   | `AFEventAchievementUnlocked`        |
| <div id="af_content_view">`"af_content_view"`</div>                                   | `AFEventContentView`                |
| <div id="af_list_view">`"af_list_view"`</div>                                         | `AFEventListView`                   |
| <div id="af_travel_booking">`"af_travel_booking"`</div>                               | `AFEventTravelBooking`              |
| <div id="af_share">`"af_share"`</div>                                                 | `AFEventShare`                      |
| <div id="af_invite">`"af_invite"`</div>                                               | `AFEventInvite`                     |
| <div id="af_login">`"af_login"`</div>                                                 | `AFEventLogin`                      |
| <div id="af_re_engage">`"af_re_engage"`</div>                                         | `AFEventReEngage`                   |
| <div id="af_update">`"af_update"`</div>                                               | `AFEventUpdate`                     |
| <div id="af_opened_from_push_notification">`"af_opened_from_push_notification"`</div> | `AFEventOpenedFromPushNotification` |
| <div id="af_location_coordinates">`"af_location_coordinates"`</div>                   | `AFEventLocation`                   |
| <div id="af_customer_segment">`"af_customer_segment"`</div>                           | `AFEventCustomerSegment`            |
| <div id="af_subscribe">`"af_subscribe"`</div>                                         | `AFEventSubscribe`                  |
| <div id="af_start_trial">`"af_start_trial"`</div>                                     | `AFEventStartTrial`                 |
| <div id="af_ad_click">`"af_ad_click"`</div>                                           | `AFEventAdClick`                    |
| <div id="af_ad_view">`"af_ad_view"`</div>                                             | `AFEventAdView`                     |

### Predefined event parameters

Predefined event parameter constants follow a `AFEventParamParameterName` naming convention. For example, [`AFEventParamRevenue`](#af_revenue).

| Event parameter name                                                              | iOS constant name | Type |
| :-------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------- | :----------- |
| <div id="af_content">`"af_content"`</div> | `AFEventParamContent` | `String`                                   |
| <div id="af_achievement_id">`"af_achievement_id"`<div>  | `AFEventParamAchievementId`  |`String`                                   |
| <div id="af_level">`"af_level"`</div>  | `AFEventParamLevel` | `String`                                   |
| <div id="af_score">`"af_score"`</div>  | `AFEventParamScore`  | `String`                                   |
| <div id="af_success">`"af_success"`</div>  | `AFEventParamSuccess`  | `String`                                   |
| <div id="af_price">`"af_price"`</div>  | `AFEventParamPrice`  | `float`                                   |
| <div id="af_content_type">`"af_content_type"`</div>  | `AFEventParamContentType`  | `String`                                   |
| <div id="af_content_id">`"af_content_id"`</div>  | `AFEventParamContentId`  | `String`                                   |
| <div id="af_content_list">`"af_content_list"`</div> | `AFEventParamContentList` | `String[]`                                   |
| <div id="af_currency">`"af_currency"`</div> | `AFEventParamCurrency` | `String`                                   |
| <div id="af_quantity">`"af_quantity"`</div> | `AFEventParamQuantity` | `int`                                   |
| <div id="af_registration_method">`"af_registration_method"`</div> | `AFEventParamRegistrationMethod` | `String`                                   |
| <div id="af_payment_info_available">`"af_payment_info_available"`</div> | `AFEventParamPaymentInfoAvailable`  | `String`                                   |
| <div id="af_max_rating_value">`"af_max_rating_value"`</div> | `AFEventParamMaxRatingValue` | `String`                                   |
| <div id="af_rating_value">`"af_rating_value"`</div> | `AFEventParamRatingValue` | `String`                                   |
| <div id="af_search_string">`"af_search_string"`</div> | `AFEventParamSearchString` | `String`                                   |
| <div id="af_date_a">`"af_date_a"`</div>  | `AFEventParamDateA` | `String`                                   |
| <div id="af_date_b">`"af_date_b"`</div> | `AFEventParamDateB` | `String`                                   |
| <div id="af_destination_a">`"af_destination_a"`</div> | `AFEventParamDestinationA` | `String`                                   |
| <div id="af_destination_b">`"af_destination_b"`</div> | `AFEventParamDestinationB` | `String`                                   |
| <div id="af_description">`"af_description"`</div>  | `AFEventParamDescription` | `String`                                   |
| <div id="af_class">`"af_class"`</div> | `AFEventParamClass` | `String`                                   |
| <div id="af_event_start">`"af_event_start"`</div> | `AFEventParamEventStart` | `String`                                   |
| <div id="af_event_end">`"af_event_end"`</div> | `AFEventParamEventEnd` | `String`                                   |
| <div id="af_lat">`"af_lat"`</div> | `AFEventParamLat` | `String`                                   |
| <div id="af_long">`"af_long"`</div>  | `AFEventParamLong` | `String`                                   |
| <div id="af_customer_user_id">`"af_customer_user_id"`</div>  | `AFEventParamCustomerUserId` | `String`                                   |
| <div id="af_validated">`"af_validated"`</div> | `AFEventParamValidated` | `boolean`                                   |
| <div id="af_revenue">`"af_revenue"`</div>  | `AFEventParamRevenue` | `float`                                   |
| <div id="af_projected_revenue">`"af_projected_revenue"`</div> | `AFEventProjectedParamRevenue` | `float`                                   |
| <div id="af_receipt_id">`"af_receipt_id"`</div> |  `AFEventParamReceiptId` | `String`                                   |
| <div id="af_tutorial_id">`"af_tutorial_id"`</div> | `AFEventParamTutorialId` | `String`                                   |
| <div id="af_virtual_currency_name">`"af_virtual_currency_name"`</div> |  `AFEventParamVirtualCurrencyName` |
| <div id="af_deep_link">`"af_deep_link"`</div> | `AFEventParamDeepLink` | `String`                                   |
| <div id="af_old_version">`"af_old_version"`</div> | `AFEventParamOldVersion` | `String` |
| <div id="af_new_version">`"af_new_version"`</div> | `AFEventParamNewVersion` | `String` |
| <div id="af_review_text">`"af_review_text"`</div> | `AFEventParamReviewText` | `String` |
| <div id="af_coupon_code">`"af_coupon_code"`</div> | `AFEventParamCouponCode` | `String` |
| <div id="af_order_id">`"af_order_id"`</div> | `AFEventParamOrderId` | `String` |
| <div id="af_param_1">`"af_param_1"`</div> | `AFEventParam1` | `String` |
| <div id="af_param_2">`"af_param_2"`</div> | `AFEventParam2` | `String` |
| <div id="af_param_3">`"af_param_3"`</div>  | `AFEventParam3` | `String` |
| <div id="af_param_4">`"af_param_4"`</div> | `AFEventParam4` | `String` |
| <div id="af_param_5">`"af_param_5"`</div> | `AFEventParam5` | `String` |
| <div id="af_param_6">`"af_param_6"`</div> | `AFEventParam6` | `String` |
| <div id="af_param_7">`"af_param_7"`</div>  | `AFEventParam7` | `String` |
| <div id="af_param_8">`"af_param_8"`</div> | `AFEventParam8` | `String` |
| <div id="af_param_9">`"af_param_9"`</div> | `AFEventParam9` | `String` |
| <div id="af_param_10">`"af_param_10"`</div> | `AFEventParam10`| `String` |
| <div id="af_departing_departure_date">`"af_departing_departure_date"`</div> | `AFEventParamDepartingDepartureDate` | `String` |
| <div id="af_returning_departure_date">`"af_returning_departure_date"`</div> | `AFEventParamReturningDepartureDate` | `String` |
| <div id="af_destination_list">`"af_destination_list"`</div> | `AFEventParamDestinationList` | `String[]` |
| <div id="af_city">`"af_city"`</div>  | `AFEventParamCity` | `String` |
| <div id="af_region">`"af_region"`</div> | `AFEventParamRegion` | `String` |
| <div id="af_country">`"af_country"`</div> | `AFEventParamCountry` | `String` |
| <div id="af_departing_arrival_date">`"af_departing_arrival_date"`</div> | `AFEventParamDepartingArrivalDate` | `String` |
| <div id="af_returning_arrival_date">`"af_returning_arrival_date"`</div> | `AFEventParamReturningArrivalDate` | `String` |
| <div id="af_suggested_destinations">`"af_suggested_destinations"`</div> | `AFEventParamSuggestedDestinations` | `String[]` |
| <div id="af_travel_start">`"af_travel_start"`</div> | `AFEventParamTravelStart` | `String` |
| <div id="af_travel_end">`"af_travel_end"`</div> | `AFEventParamTravelEnd` | `String` |
| <div id="af_num_adults">`"af_num_adults"`</div>  | `AFEventParamNumAdults` | `String` |
| <div id="af_num_children">`"af_num_children"`</div>  | `AFEventParamNumChildren` | `String` |
| <div id="af_num_infants">`"af_num_infants"`</div> | `AFEventParamNumInfants` | `String` |
| <div id="af_suggested_hotels">`"af_suggested_hotels"`</div> | `AFEventParamSuggestedHotels` | `String[]` |
| <div id="af_user_score">`"af_user_score"`</div> | `AFEventParamUserScore` | `String` |
| <div id="af_hotel_score">`"af_hotel_score"`</div> | `AFEventParamHotelScore`  | `String` |
| <div id="af_purchase_currency">`"af_purchase_currency"`</div> | `AFEventParamPurchaseCurrency` | `String` |
| <div id="af_preferred_neighborhoods">`"af_preferred_neighborhoods"`</div> | `AFEventParamPreferredNeighborhoods //array of string` | `String[]` |
| <div id="af_preferred_num_stops">`"af_preferred_num_stops"`</div> | `AFEventParamPreferredNumStops` | `String` |
| <div id="af_adrev_ad_type">`"af_adrev_ad_type"`</div> | `AFEventParamAdRevenueAdType` | `String` |
| <div id="af_adrev_network_name">`"af_adrev_network_name"`</div>  | `AFEventParamAdRevenueNetworkName` | `String` |
| <div id="af_adrev_placement_id">`"af_adrev_placement_id"`</div> | `AFEventParamAdRevenuePlacementId` | `String` |
| <div id="af_adrev_ad_size">`"af_adrev_ad_size"`</div>  | `AFEventParamAdRevenueAdSize` | `String` |
| <div id="af_adrev_mediated_network_name">`"af_adrev_mediated_network_name"`</div> | `AFEventParamAdRevenueMediatedNetworkName` | `String` |
| <div id="af_preferred_price_range">`"af_preferred_price_range"`</div> | `AFEventParamPreferredPriceRange` | `int[]` - basically a `tuple(min,max)` but we'll use array of `int` and use two values |
| <div id="af_preferred_star_ratings">`"af_preferred_star_ratings"`</div> | `AFEventParamPreferredStarRatings` |  `int[]` - basically a `tuple(min,max)` but we'll use array of `int` and use two values |