---
title: "Push notifications"
slug: "push-notifications-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
metadata: 
  description: "Learn how to configure push notification measurement in the AppsFlyer iOS SDK."
createdAt: "2021-06-15T13:14:54.732Z"
updatedAt: "2023-04-18T11:44:28.141Z"
order: 7
---
## Overview

The following guide covers the configuration of the iOS SDK for processing incoming push notifications and sending extracted attribution data to AppsFlyer.

There are 2 methods of implementing the integration:

- By utilizing OneLink in the push payload (recommended method). [Step 3](#addpushnotificationdeeplinkpath-recommended) is required only if implementing this solution.
- By using plain JSON in the push payload (legacy method).

Choose the right method for you [based on how the marketer structures the push notification](https://support.appsflyer.com/hc/en-us/articles/207364076#1-creating-the-push-notification).

## Integrating AppsFlyer with iOS push notifications

Integrating AppsFlyer with iOS push notifications consists of the following:

- Configuring the AppsFlyer SDK.
- Configuring a `UNUserNotificationCenter` delegate.

### Prerequisites

Before you continue, make sure you have:

1. An iOS app with [push notifications enabled](https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications).
2. [Integrated the SDK](doc:integrate-ios-sdk#initializing-the-ios-sdk).
3. If implementing the [recommended OneLink-based solution](https://support.appsflyer.com/hc/en-us/articles/207364076#using-onelink-recommended), you need the name of the key inside the push notification payload that contains the OneLink (provided by the app marketer).

### Steps

1. Configure the app to use the `UNUserNotificationCenter` delegate:

   ```swift
   if #available(iOS 10.0, *) {
             // For iOS 10 display notification (sent via APNS)
             UNUserNotificationCenter.current().delegate = self

             let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
             UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: { _, _ in }
             )
           } else {
             let settings: UIUserNotificationSettings =
               UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
             application.registerUserNotificationSettings(settings)
           }

           application.registerForRemoteNotifications()
   }
   ```
2. Implement the `UNUserNotificationCenter` delegate. In the `didReceive` method, call [`handlePushNotification`](doc:ios-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath):

   ```swift Swift
   @available(iOS 10, *)
   extension AppDelegate: UNUserNotificationCenterDelegate {
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 didReceive response: UNNotificationResponse,
                                 withCompletionHandler completionHandler: @escaping () -> Void) {
       let userInfo = response.notification.request.content.userInfo
       print(userInfo)
       completionHandler()
       AppsFlyerLib.shared().handlePushNotification(userInfo)
     }
     
     // Receive displayed notifications for iOS 10 devices.
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 willPresent notification: UNNotification,
                                 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                   -> Void) {
       let userInfo = notification.request.content.userInfo
       print(userInfo)

       // Change this to your preferred presentation option
       completionHandler([[.alert, .sound]])
     }
   }
   ```
3. <span id="addpushnotificationdeeplinkpath-recommended"></span>**This step is required only if you're implementing the [recommended OneLink-based solution](<>)**.  
   In `didFinishLaunchingWithOptions`, call [`addPushNotificationDeepLinkPath`](doc:ios-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath) **before** calling [`start`](doc:ios-sdk-reference-appsflyerlib#start):
   ```swift
   AppsFlyerLib.shared().addPushNotificationDeepLinkPath(["af_push_link"])
   ```
      In this example, the SDK is configured to look for the `af_push_link` key in the push notification payload.  
      When calling [`addPushNotificationDeepLinkPath`](doc:ios-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath) the SDK verifies that:
   - The required key exists in the payload.
   - The key contains a valid OneLink URL.

> 📘 Note
> 
> [`addPushNotificationDeepLinkPath`](doc:ios-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath) accepts an array of strings too, to allow you to extract the relevant key from nested JSON structures. For more information, see [`addPushNotificationDeepLinkPath`](doc:ios-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath).