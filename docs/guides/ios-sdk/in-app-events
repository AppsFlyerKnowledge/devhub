## Overview
The `logEvent` method and predefined event name/parameter constants are made available to you by importing `AppsFlyerLib`:
```objc Objective-C
#import <AppsFlyerLib/AppsFlyerLib.h>
```
```swift Swift
import AppsFlyerLib
```
 * [Predefined event name](https://dev.appsflyer.com/hc/docs/in-app-events-ios#predefined-event-names) constants follow a `AFEventEventName` naming convention. For example, `AFEventAddToCart`
 * [Predefined event parameter](https://dev.appsflyer.com/hc/docs/in-app-events-ios#predefined-event-parameters) constants follow a `AFEventParamParameterName` naming convention. For example, `AFEventParamRevenue`

For an introduction to in-app events for developers, see [In-app events](doc:in-app-events-2).

## Logging in-app events

### The `logEvent` method
To log events that occur within your app, use the `logEvent` method.
`logEvent` takes 3 arguments:
 * The first argument is the **event name**
 * The second argument is the **event value**
 * The third event is an optional completion handler (useful for [Handling event submission success/failure](docs:in-app-events-ios#handling-event-submission-success-and-failure)

### Example: Log an add to cart event
For example, to log that a user added an item to their shopping cart:
```objc Objective-C
[[AppsFlyerLib shared]  logEvent: AFEventAddToCart withValues: @{
    AFEventParamRevenue: @200,
    AFEventParamCurrency: @"USD",
    AFEventParamQuantity: @2,
    AFEventParamContentId: @"092",
    AFEventParamReceiptId: @"9277"
  }]
```
```swift Swift
AppsFlyerLib.shared().logEvent(AFEventAddToCart,
  withValues: [
     AFEventParamRevenue: "200",
     AFEventParamCurrency: "USD",
     AFEventParamQuantity: 2,
     AFEventParamContent: "shoes",
     AFEventParamContentId: "092",
     AFEventParamReceiptId: "9277"]);
```
In the above `logEvent` invocation:
 * The event name is `AFEventAddToCart`
 * The event value is a `NSDictionary` (verify actual data structure) containing these event parameters:
      * AF
      * AF
      * AF

## Logging revenue

You can send revenue with any in-app event. Use the `AFEventParameterRevenue` event parameter to include revenue in the in-app event. You can populate it with any numeric value, positive or negative.

The revenue value should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

af_revenue is the only event parameter that AppsFlyer counts as real revenue in the dashboard and reports. For more details click here.

### Example: Purchase event with revenue
```objc Objective-C
[[AppsFlyerLib shared] logEvent: @"purchase" 
withValues:@{
	AFEventParamContentId:@"1234567",
	AFEventParamContentType : @"category_a",
	AFEventParamRevenue: @200,
	AFEventParamCurrency:@"USD"
}];
```
```swift Swift
AppsFlyerLib.shared().logEvent("purchase", 
withValues: [
	AFEventParamContentId:"1234567",
	AFEventParamContentType : "category_a",
	AFEventParamRevenue: 200,
	AFEventParamCurrency:"USD"
]);
```

The purchase event above has $200 in revenue, appearing as revenue in the dashboard.

### Configuring revenue currency
You can set the currency code for all events by setting the following property:
```objc Objective-C
[AppsFlyerLib shared].currencyCode = @"ZZZ";
```
```swift Swift
AppsFlyerLib.shared().currencyCode = "ZZZ"
```

 * The currency code should be a 3 character ISO 4217 code
 * The default currency is USD

To learn about currency settings, display, and currency conversion, see our guide on revenue currency.

### Logging negative revenue
There may be situations where you want to record negative revenue. For example, a user receives a refund or cancels a subscription.
To log negative revenue:
```objc Objective-C
[[AppsFlyerLib shared] logEvent: @"cancel_purchase" 
withValues:@{
	AFEventParamContentId:@"1234567",
	AFEventParamContentType : @"category_a",
	AFEventParamRevenue: @-1.99,
	AFEventParamCurrency:@"USD"
}];
```
```swift Swift
AppsFlyerLib.shared().logEvent("cancel_purchase", 
withValues: [
	AFEventParamContentId:"1234567",
	AFEventParamContentType : "category_a",
	AFEventParamRevenue: -1.99,
	AFEventParamCurrency:"USD"
]);
```

> ℹ️ Note
> Notice the following in the code above:
> * The revenue value is preceded by a minus sign
> * The event name has a unique value of "cancel_purchase" - to allow you to identify negative revenue events in the dashboard and raw data reports


### Purchase validation using `validateAndLogInAppPurchase`
AppsFlyer provides server verification for in-app purchases. The `validateAndLogInAppPurchase` method takes care of validating and logging the purchase event.
`validateAndLoginInAppPurchase` takes these arguments:
```objc Objective-C 
- (void) validateAndLogInAppPurchase:(NSString *) productIdentifier
price:(NSString *) price
currency:(NSString *) currency
transactionId:(NSString *) tranactionId
additionalParameters:(NSDictionary *) params
success:(void (^)(NSDictionary *response)) successBlock
failure:(void (^)(NSError *error, id reponse)) failedBlock;
```

On success, a `NSDictionary` is returned with the receipt validation data (provided by Apple servers).

### Example: Validate an in-app purchase


```objc Objective-C
[[AppsFlyerLib shared] validateAndLogInAppPurchase:@"ProductIdentifier" price:@"price"
    currency:@"USD"
    transactionId:@"transactionID"
    additionalParameters:@{@"test": @"val" , @"test1" : @"val 1"}
    success:^(NSDictionary *result){
      NSLog(@"Purchase succeeded And verified!!! response: %@", result[@"receipt"]);
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
```swift Swift
AppsFlyerLib
      .shared()?
      .validateAndLogInAppPurchase ("productIdentifier",
                   price: "price",
                  currency: "currency",
               transactionId: "transactionId",
            additionalParameters: [:],
                  success: {
      guard let dictionary = $0 as? [String:Any] else { return }
      dump(dictionary)
    }, failure: { error, result in
      guard let emptyInApp = result as? [String:Any],
           let status = emptyInApp["status"] as? String,
             status == "in_app_arr_empty" else {
                // Try to handle other errors
                 return
               }
         
      // retry with 'SKReceiptRefreshRequest' because
      // Apple has returned an empty response
      // <YOUR CODE HERE>
    })
```

#### Testing purchase validation in Sandbox mode
To test purchase validation using a sandboxed environemnt, add the following code:
```objc Objective-C
[AppsFlyerLib shared].useReceiptValidationSandbox = YES;
```
```swift Swift
AppsFlyerLib.shared().useReceiptValidationSandbox = true
```

> ℹ️ Note
> This code must be removed from your production builds.

Validating an in-app purchase automatically sends an in-app purchase event to AppsFlyer. See the following sample data that is passed in the event_value parameter:

{
   "some_parameter":"some_value", // from additional_event_values
   "af_currency":"USD", // from currency
   "af_content_id":"test_id", // from purchase
   "af_revenue":"10", // from revenue
   "af_quantity":"1", // from purchase
   "af_validated":true // flag that AF verified the purchase
}

 Note

Calling validateAndLogInAppPurchase automatically generates an af_purchase in-app event. Sending this event yourself creates double duplicate event reporting.

5.4 In-app events limitations
5.5 Examples for recording in-app events

Example: In-app purchase event

Objective-C Swift
[[AppsFlyerLib shared] logEvent:AFEventPurchase
   withValues: @{
    AFEventParamRevenue: @200,
    AFEventParamCurrency: @"USD",
    AFEventParamQuantity: @2,
    AFEventParamContentId: @"092",
    AFEventParamReceiptId: @"9277"
  }];

 Note
The event value dictionary passed to the event SDK must be valid for JSON conversion by NSJSONSerialization. For more information, see here.
For revenue, do not add any currency symbols as these are not recognized.
AppsFlyerLib.shared().logEvent(AFEventPurchase,
  withValues: [
     AFEventParamRevenue: "200",
     AFEventParamCurrency: "USD",
     AFEventParamQuantity: 2,
     AFEventParamContent: "shoes",
     AFEventParamContentId: "092",
     AFEventParamReceiptId: "9277"]);

5.6 Record offline in-app events

If a user initiates an event when the internet connection is unavailable, AppsFlyer is still able to record it. This is how it works:

SDK sends the events to AppsFlyer servers and waits for a response.
If the SDK doesn’t receive a 200 response, the event is stored in the cache.
Once the next 200 response is received, the stored event is re-sent to the server.
If there are multiple events in the cache, they are sent to the server one promptly after another.
 Note

The SDK cache can store up to 40 events, which means that only the first 40 events that happen offline are saved. Everything that comes afterward until the next 200 response, gets discarded.

The event time that appears in the raw data is the time the event is sent to AppsFlyer after the device goes online again. It is not the actual time that the event takes place.

## Handling event submission success and failure
You can set a handler when recording in-app events. The handler allows you to define logic for two scenarios:
An in-app event recorded successfully.
An error occurred when recording the in-app event.
Objective C Swift
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
    
AppsFlyerLib.shared().logEvent(name: "In app event name", values: ["id": 12345, "name": "John doe"], completionHandler: { (response: [String : Any]?, error: Error?) in
             if let response = response {
               print("In app event callback Success: ", response)
             }
             if let error = error {
               print("In app event callback ERROR:", error)
             }
           })
        }
            

In the event that an error occurs when recording the in-app event, an error code and string description are provided, as indicated in the table that follows.

Error code	String description
10 "Event timeout. Check 'minTimeBetweenSessions' param"
11  "Skipping event because 'isStopTracking' enabled"
40 Network error: Error description comes from Android
41 "No dev key"
50 "Status code failure" + actual response code from the server 

## Event constants

### Predefined event names
| iOS constant name | Event type name |
| :----------------------------: | :-------------------: |
| <h4>`AFEventLevelAchieved`<h4> | `"af_level_achieved"` |
| <h4>`AFEventAddPaymentInfo`<h4> | `"af_add_payment_info"` |
| <h4>`AFEventAddToCart`<h4> | `"af_add_to_cart"` |
| <h4>`AFEventAddToWishlist`<h4> | `"af_add_to_wishlist"` |
| <h4>`AFEventCompleteRegistration`<h4> | `"af_complete_registration"` |
| <h4>`AFEventTutorial_completion`<h4> | `"af_tutorial_completion"` |
| <h4>`AFEventInitiatedCheckout`<h4> | `"af_initiated_checkout"` |
| <h4>`AFEventPurchase`<h4> | `"af_purchase"` |
| <h4>`AFEventRate`<h4> | `"af_rate"` |
| <h4>`AFEventSearch`<h4> | `"af_search"` |
| <h4>`AFEventSpentCredits`<h4> | `"af_spent_credits"` |
| <h4>`AFEventAchievementUnlocked`<h4> | `"af_achievement_unlocked"` |
| <h4>`AFEventContentView`<h4> | `"af_content_view"` |
| <h4>`AFEventListView`<h4> | `"af_list_view"` |
| <h4>`AFEventTravelBooking`<h4> | `"af_travel_booking"` |
| <h4>`AFEventShare`<h4> | `"af_share"` |
| <h4>`AFEventInvite`<h4> | `"af_invite"` |
| <h4>`AFEventLogin`<h4> | `"af_login"` |
| <h4>`AFEventReEngage`<h4> | `"af_re_engage"` |
| <h4>`AFEventUpdate`<h4> | `"af_update"` |
| <h4>`AFEventOpenedFromPushNotification`<h4> | `"af_opened_from_push_notification"` |
| <h4>`AFEventLocation`<h4> | `"af_location_coordinates"` |
| <h4>`AFEventCustomerSegment`<h4> | `"af_customer_segment"` |
| <h4>`AFEventSubscribe`<h4> | `"af_subscribe"` |
| <h4>`AFEventStartTrial`<h4> | `"af_start_trial"` |
| <h4>`AFEventAdClick`<h4> | `"af_ad_click"` |
| <h4>`AFEventAdView`<h4> | `"af_ad_view"` |

### Predefined event parameters
| iOS constant name | Event parameter name |
| :----------------------------: | :-------------------: |
| <h4>`AFEventParamContent`<h4> | `"af_content"` |
| <h4>`AFEventParamAchievementId`<h4> | `"af_achievement_id"` |
| <h4>`AFEventParamLevel`<h4> | `"af_level"` |
| <h4>`AFEventParamScore`<h4> | `"af_score"` |
| <h4>`AFEventParamSuccess`<h4> | `"af_success"` |
| <h4>`AFEventParamPrice`<h4> | `"af_price"` |
| <h4>`AFEventParamContentType`<h4> | `"af_content_type"` |
| <h4>`AFEventParamContentId`<h4> | `"af_content_id"` |
| <h4>`AFEventParamContentList`<h4> | `"af_content_list"` |
| <h4>`AFEventParamCurrency`<h4> | `"af_currency"` |
| <h4>`AFEventParamQuantity`<h4> | `"af_quantity"` |
| <h4>`AFEventParamRegistrationMethod`<h4> | `"af_registration_method"` |
| <h4>`AFEventParamPaymentInfoAvailable`<h4> | `"af_payment_info_available"` |
| <h4>`AFEventParamMaxRatingValue`<h4> | `"af_max_rating_value"` |
| <h4>`AFEventParamRatingValue`<h4> | `"af_rating_value"` |
| <h4>`AFEventParamSearchString`<h4> | `"af_search_string"` |
| <h4>`AFEventParamDateA`<h4> | `"af_date_a"` |
| <h4>`AFEventParamDateB`<h4> | `"af_date_b"` |
| <h4>`AFEventParamDestinationA`<h4> | `"af_destination_a"` |
| <h4>`AFEventParamDestinationB`<h4> | `"af_destination_b"` |
| <h4>`AFEventParamDescription`<h4> | `"af_description"` |
| <h4>`AFEventParamClass`<h4> | `"af_class"` |
| <h4>`AFEventParamEventStart`<h4> | `"af_event_start"` |
| <h4>`AFEventParamEventEnd`<h4> | `"af_event_end"` |
| <h4>`AFEventParamLat`<h4> | `"af_lat"` |
| <h4>`AFEventParamLong`<h4> | `"af_long"` |
| <h4>`AFEventParamCustomerUserId`<h4> | `"af_customer_user_id"` |
| <h4>`AFEventParamValidated`<h4> | `"af_validated"` |
| <h4>`AFEventParamRevenue`<h4> | `"af_revenue"` |
| <h4>`AFEventProjectedParamRevenue`<h4> | `"af_projected_revenue"` |
| <h4>`AFEventParamReceiptId`<h4> | `"af_receipt_id"` |
| <h4>`AFEventParamTutorialId`<h4> | `"af_tutorial_id"` |
| <h4>`AFEventParamVirtualCurrencyName`<h4> | `"af_virtual_currency_name"` |
| <h4>`AFEventParamDeepLink`<h4> | `"af_deep_link"` |
| <h4>`AFEventParamOldVersion`<h4> | `"af_old_version"` |
| <h4>`AFEventParamNewVersion`<h4> | `"af_new_version"` |
| <h4>`AFEventParamReviewText`<h4> | `"af_review_text"` |
| <h4>`AFEventParamCouponCode`<h4> | `"af_coupon_code"` |
| <h4>`AFEventParamOrderId`<h4> | `"af_order_id"` |
| <h4>`AFEventParam1`<h4> | `"af_param_1"` |
| <h4>`AFEventParam2`<h4> | `"af_param_2"` |
| <h4>`AFEventParam3`<h4> | `"af_param_3"` |
| <h4>`AFEventParam4`<h4> | `"af_param_4"` |
| <h4>`AFEventParam5`<h4> | `"af_param_5"` |
| <h4>`AFEventParam6`<h4> | `"af_param_6"` |
| <h4>`AFEventParam7`<h4> | `"af_param_7"` |
| <h4>`AFEventParam8`<h4> | `"af_param_8"` |
| <h4>`AFEventParam9`<h4> | `"af_param_9"` |
| <h4>`AFEventParam10`<h4> | `"af_param_10"` |
| <h4>`AFEventParamDepartingDepartureDate`<h4> | `"af_departing_departure_date"` |
| <h4>`AFEventParamReturningDepartureDate`<h4> | `"af_returning_departure_date"` |
| <h4>`AFEventParamDestinationList`<h4> | `"af_destination_list  //array of string"` |
| <h4>`AFEventParamCity`<h4> | `"af_city"` |
| <h4>`AFEventParamRegion`<h4> | `"af_region"` |
| <h4>`AFEventParamCountry`<h4> | `"af_country"` |
| <h4>`AFEventParamDepartingArrivalDate`<h4> | `"af_departing_arrival_date"` |
| <h4>`AFEventParamReturningArrivalDate`<h4> | `"af_returning_arrival_date"` |
| <h4>`AFEventParamSuggestedDestinations`<h4> | `"af_suggested_destinations //array of string"` |
| <h4>`AFEventParamTravelStart`<h4> | `"af_travel_start"` |
| <h4>`AFEventParamTravelEnd`<h4> | `"af_travel_end"` |
| <h4>`AFEventParamNumAdults`<h4> | `"af_num_adults"` |
| <h4>`AFEventParamNumChildren`<h4> | `"af_num_children"` |
| <h4>`AFEventParamNumInfants`<h4> | `"af_num_infants"` |
| <h4>`AFEventParamSuggestedHotels`<h4> | `"af_suggested_hotels //array of string"` |
| <h4>`AFEventParamUserScore`<h4> | `"af_user_score"` |
| <h4>`AFEventParamHotelScore`<h4> | `"af_hotel_score"` |
| <h4>`AFEventParamPurchaseCurrency`<h4> | `"af_purchase_currency"` |
| <h4>`AFEventParamPreferredStarRatings`<h4> | `"af_preferred_star_ratings    //array of int (basically a tuple (min,max) but we'll use array of int and instruct the developer to use two values)"` |
| <h4>`AFEventParamPreferredPriceRange`<h4> | `"af_preferred_price_range    //array of int (basically a tuple (min,max) but we'll use array of int and instruct the developer to use two values)"` |
| <h4>`AFEventParamPreferredNeighborhoods`<h4> | `"af_preferred_neighborhoods //array of string"` |
| <h4>`AFEventParamPreferredNumStops`<h4> | `"af_preferred_num_stops"` |
| <h4>`AFEventParamAdRevenueAdType`<h4> | `"af_adrev_ad_type"` |
| <h4>`AFEventParamAdRevenueNetworkName`<h4> | `"af_adrev_network_name"` |
| <h4>`AFEventParamAdRevenuePlacementId`<h4> | `"af_adrev_placement_id"` |
| <h4>`AFEventParamAdRevenueAdSize`<h4> | `"af_adrev_ad_size"` |
| <h4>`AFEventParamAdRevenueMediatedNetworkName`<h4> | `"af_adrev_mediated_network_name"` |
