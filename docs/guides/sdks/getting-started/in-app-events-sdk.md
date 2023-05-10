---
title: "In-app events"
slug: "in-app-events-sdk"
excerpt: "Learn about basic concepts and terminology relating to in-app events."
category: 5f9705393c689a065c409b23
parentDoc: 609a858fb96cee00165e8fca
hidden: false
createdAt: "2021-05-10T19:12:47.385Z"
updatedAt: "2022-08-25T17:31:26.899Z"
---
In-app events provide insights into how users interact with your app. AppsFlyer SDKs enable you to easily log these interactions.

## In-app events SDK guides
[block:html]
{
  "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/in-app-events-android\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/in-app-events-ios\">iOS SDK</a>\n</div>\n\n<style>\n  .button-container {\n  \tdisplay: flex;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    width: 150px;\n\t  border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n\t}\n  \n  .button:before {\n  \tmargin-right: 4px;\n  }\n  .button.android {\n    border: solid 2px #3DDC84;\n  }\n  .ios {\n  \tborder-radius: 6px;\n    padding: 8px;\n    border: solid 2px #7D7D7D;\n  }\n  .ios:before {\n        content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\");\n  }\n\n  .android:before {\n        content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\");\n  }\n</style>"
}
[/block]
## Anatomy of an event
In-app events consist of 2 parts:
 * **Event name**: The unique event identifier. It is usually how marketers see the event in the dashboard.
 * **Event values**: An object that consists of key-value pairs called **event parameters**. Event parameters provide additional context and information about the occurring event.

Event names and event parameters can be either **predefined** or **custom**.

[block:callout]
{
  "type": "success",
  "title": "Tip",
  "body": "Quickly define and generate in-app events code for all major platforms using our [in-app event generator tool](https://evgen.appsflyer.com?utm_medium=referral&utm_source=devhub)."
}
[/block]
## Event constants
In the SDKs, [predefined events and parameters](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-for-Android-and-iOS#introduction-predefined-and-custom-events) are exposed as constants.

When sending events, it's recommended to use the constants instead of raw strings:
 * It reduces the chance to introduce naming discrepancies.
 * Changes to the underlying event/parameter names are transparent to you and require less maintenance.

Technically, predefined event names/parameters are strings prefixed with `af_`.

## Custom events and event parameters
Custom event names and parameters are user-defined and usually describe scenarios that are specific to your app's business logic and your users' interaction with the app.
[block:callout]
{
  "type": "warning",
  "body": "To avoid confusion with [predefined events](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-for-Android-and-iOS#introduction-predefined-and-custom-events), don't prefix custom event names with `af_`.",
  "title": "Attention"
}
[/block]
### Valid custom event names
Custom event names should follow these rules:
 * Be up to 100 characters long. 
 * Non-English characters are supported.

### Valid custom event parameters
Custom event parameters:
 * Must not exceed 1000 characters; if longer, it might be truncated
 * Pricing and revenue: use only digits and decimals, for example, 5 or 5.2
 * Pricing and revenue values can have up to 5 digits after the period, for example, 5.12345

## Understanding event structure definitions
Ideally, the marketer should provide you with clear event structure definitions, based on the instructions in [Defining In-app events](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-guide#introduction-defining-an-inapp-event). For example, a definition of an `af_content_view` event for an eCommerce app would look something like this:
[block:parameters]
{
  "data": {
    "h-0": "Event name",
    "h-1": "Event parameters",
    "h-2": "Parameter values",
    "0-0": "`af_content_view`",
    "0-1": "`af_price`\n`af_content_type`\n`af_content_id`",
    "0-2": "`af_price`: Item price\n`af_content_type`: Item category.\n`af_content_id`: Item SKU.",
    "h-3": "Where/When (Optional)",
    "0-3": "When a user navigates to an item view."
  },
  "cols": 4,
  "rows": 1
}
[/block]
 * The first column (Event name) is the value you pass as `logEvent`'s second argument. 

    `af_content_view` is how marketers see the event in the dashboard. It's recommended to use the [predefined event constants]() instead of the raw string values marketers provide.
 * The second column (Event parameters) lists the event parameters associated with the event. In this case, you should pass the following event parameters to `logEvent`:
    * `af_price`
    * `af_content_type`
    * `af_content_id`

 * The third column (Parameter values) contains additional information about particular values assigned to event parameters. In the example above, the marketer clearly communicates that the `af_content_id` event parameter value should be the viewed item's SKU.
 * The fourth column is where the marketer describes where and when in the app should the event occur

See how the example definition above is implemented on [Android](https://dev.appsflyer.com/hc/docs/in-app-events-android#implementing-event-structure-definitions) and [iOS](https://dev.appsflyer.com/hc/docs/in-app-events-ios#implementing-in-app-event-definitions).
## Offline in-app events
The SDK can cache in-app events that occur when no internet connection is available:
 * The SDK sends the events to AppsFlyer servers and waits for a response
 * If the SDK doesn’t receive a 200 response, the events are cached
 * Once the next 200 response is received, the stored events are re-sent to the server
 * If there are multiple events in the cache, they are sent to the server one after another (unbatched, one network request per event).

The SDK can cache up to 40 events. Only the first 40 offline events are stored. Everything that comes afterward (until the next successful response), gets discarded.