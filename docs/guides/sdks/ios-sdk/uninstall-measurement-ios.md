---
title: "Uninstall measurement"
slug: "uninstall-measurement-ios"
category: 5f9705393c689a065c409b23
parentDoc: 5fa043dd3b65b20045e35597
hidden: false
createdAt: "2021-11-07T14:29:45.902Z"
updatedAt: "2023-04-16T07:22:58.517Z"
order: 8
---
## Overview

Complete the following sections to set up, integrate, and test iOS uninstall measurement:

1. Creating a `.p12` certificate and sending it to the marketer.
2. Configuring the SDK for uninstall measurement.
3. Testing uninstall measurement.

## Creating a `.p12` certificate

To enable uninstall measurement, a `.p12` certificate is required.

> 📘 Note
> 
> Currently, `.p8` certificates are not supported.

**To create a `.p12` certificate:**  
**Step 1: Create a Certificate Signing Request (CSR)**  
**1.1.** On your Mac, open Keychain Access. Go to **Keychain Access** > **Certificate Assistant** > **Request a Certificate From a Certificate Authority**.

![](https://files.readme.io/affd946-cert_assistant.png "cert_assistant.png")

**1.2.** Fill the form. Select **Saved to disk** and click **Continue**. 

![](https://files.readme.io/8f9c3e3-2-c.png "2-c.png")

**Step 2: Select App ID**  
**2.1.** Locate your Apple App ID in [Apple Developer Members Center](https://developer.apple.com/account/overview.action), or create one.

To create an App ID, in the Apple Developer Members Center, Go to **Identifiers** and click **+**.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/24870fc-1-b_blur.png",
        "1-b (blur).png",
        878
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**2.2** Choose **App IDs** and click **continue**

![](https://files.readme.io/b6e8a6b-Screenshot_2023-04-16_at_10.19.00.png)

**2.3** Choose **App** and click **continue**

![](https://files.readme.io/261e5e0-Screenshot_2023-04-16_at_10.19.07.png)

**2.4.** In the Register an App ID view, Under **Capabilities**, check **Push Notifications** and click **Configure** (**Edit** if it was previously configured). If the Configure/Edit button is not available, you might not have the required permissions.

![](https://files.readme.io/bbdd1b8-1-c-1.png "1-c-1.png")

**Step 3: Upload CSR**  
**3.1.** Choose whether to create a Production or a Development SSL Certificate (see note) and click **Create Certificate**.

![](https://files.readme.io/c3276fd-create_cert.png "create_cert.png")

> 📘 Note
> 
> Use a **Production SSL Certificate** for published apps. If your app is unpublished and is in active development, you might want to work with a **Development SSL Certificate**. For example, if your app isn't ready to be published yet, a Development SSL Certificate would let you test Push-related functionalities in TestFlight.

**3.2.** Upload the CSR you created in step 1 and click **Continue**.

![](https://files.readme.io/d8324c4-2-b-d.png "2-b-d.png")

**3.3.** Once the **Download** button appears, you are ready to download. You may need to reload the page for this to update. Download the newly created certificate.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/1d95e58-2-a.png",
        "2-a.png",
        1006
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**Step 4: Create a .p12 file**  
**4.1.** Open the `.cer` certificate. Opening the certificate will open Keychain Access.  
**4.2.** In the Keychain Access, your certificate is shown under **My Certificates**. Select the certificate that was just added to Keychain Access.  
**4.3.** Right-click on your certificate and select **Export**.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/a149ab0-9-4-a-b.png",
        "9-4-a-b.png",
        670
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



**4.4.** Click save. Make sure to use the **Personal Information Exchange (.p12)** format.

[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/41c7e37-274ce9d-4-c.png",
        "274ce9d-4-c.png",
        774
      ],
      "align": "center",
      "sizing": "80"
    }
  ]
}
[/block]



> 📘 Note
> 
> If you are renewing either your Development or Production Push SSL Certificate, follow the steps listed previously. There is no need to revoke the previous certificate to make this change. Two production certificates can be in use at the same time, allowing you to continue using the old certificate while uploading the new one.

**Step 5: Upload `.p12` to AppsFlyer**  
Send the `.p12` certificate to the marketer to [upload to AppsFlyer](https://support.appsflyer.com/hc/en-us/articles/4408933557137#configure-uninstall-measurement-in-appsflyer).

## SDK setup

Add the following code to your AppDelegate:

```swift
    	//add UserNotifications.framework
import UserNotifications
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // ...
        application.registerForRemoteNotifications()        
        return true
      }
    
     // Called when the application sucessfuly registers for push notifications
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        AppsFlyerLib.shared().registerUninstall(deviceToken)
      }
```
```objc
// AppDelegate.h
#import <AppsFlyerLib/AppsFlyerLib.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, AppsFlyerLibDelegate>

// AppDelegate.m
- #import <UserNotifications/UserNotifications.h>
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // The userNotificationTypes below is just an example and may be changed depending on the app
     UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
              center.delegate = self;
              [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
              }];
       [[UIApplication sharedApplication] registerForRemoteNotifications];
        // if you do not use push notificaiton in your app, uncomment the following line
        //application.applicationIconBadgeNumber = 0;
      }
      - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
        [[AppsFlyerLib shared] registerUninstall:deviceToken];
      }
}
```



## Enabling push notifications in background mode

If you are only using silent push notifications, make sure to enable **Remote Notifications** in **Background Modes** in your app's **Capabilities**:

1. In XCode, select your project.
2. Select your target.
3. Switch to **Capabilities** tab.
4. Toggle **Background Modes** on.
5. Check **Remote notifications**.

![](https://files.readme.io/f056d19-161fa905216345.png "161fa905216345.png")

![](https://files.readme.io/65c8bf6-161fa90521b616.png "161fa90521b616.png")

## Testing uninstall measurement

**To test iOS uninstall measurement:**

1. Install the app.
2. Uninstall the app.  **Note**! You can uninstall the app immediately after installing it. 

When testing uninstalls from XCode or TestFlight it is important to let our SDK know that the token is generated from a Sandbox environment. Use the following APIs:

```swift
AppsFlyerLib.shared().useUninstallSandbox = true
```
```objc
[AppsFlyerLib shared].setUseUninstallSandbox = true;
```



> 📘 Note
> 
> `setUseUninstallSandbox` must be called **before** calling `registerUninstall`.

## Considerations

Uninstalls do not immediately appear in the AppsFlyer dashboard. Due to the Apple Push Notification service:

- It takes 9 days on average for iOS uninstalls to appear in reports.
- It can take more than a month for iOS uninstalls originating from sandbox environments to appear in reports.
- The date of the uninstall is the **date on which the uninstall is reported**. For example:
  - Day 1: a user installs your app
  - Day 4: a user uninstalls your app
  - Day 12: Apple Push Notification Service reports app removal 8 days after the uninstall
  - Day 13: Uninstall data appear on AppsFlyer dashboard and raw data