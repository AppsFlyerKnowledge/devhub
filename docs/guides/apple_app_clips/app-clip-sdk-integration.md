---
title: "App Clip SDK integration"
slug: "app-clip-sdk-integration"
category: 5f849793f6d5d2006de9d826
hidden: false
createdAt: "2020-10-12T17:52:54.319Z"
updatedAt: "2021-11-16T11:52:14.714Z"
---
The developer routes the user to the correct activity using the invocation URL (the QR code, NFC tag, etc. that invokes the App Clip). 

**Before you begin**: Make sure you and the marketer already created a OneLink template with [Universal Links](https://dev.appsflyer.com/hc/docs/initial-setup-2#procedures-for-ios-universal-links), and OneLink custom link set up to direct your full app users. With the template and custom link already configured, AppsFlyer hosts and edits the AASA file to support App Clips automatically. **Note**: It may take several hours for the AASA file to update.

**To add the SDK to the App Clip and route the user**:

1. [Add the SDK to your App Clip](https://dev.appsflyer.com/hc/docs/install-ios-sdk)
2. [Integrate the SDK](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk)
3. [Optional] [Add support for scene delegate](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#add-scenedelegate-support)
4. In the **Information Property List** (`info.plist` file) for the app clip, add the following row with the key and value as detailed in the following table.
[block:parameters]
{
  "data": {
    "h-0": "Key",
    "h-1": "Type",
    "h-2": "Value",
    "0-0": "`AppsFlyerAppClip`",
    "0-1": "`Boolean`",
    "0-2": "`1`"
  },
  "cols": 3,
  "rows": 1
}
[/block]
5. Add the following code to `sceneDelegate`:
[block:code]
{
  "codes": [
    {
      "code": "func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {\n        \n    // Must for AppsFlyer attrib\n    AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)\n}\n    \nfunc scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {\n        \n    guard let _ = (scene as? UIWindowScene) else { return }\n        \n    if let userActivity = connectionOptions.userActivities.first {\n       self.scene(scene, continue: userActivity)\n    }\n    return\n}",
      "language": "swift"
    }
  ]
}
[/block]
⇲ Github links: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-apple-app-clips-sample-app/blob/01f91d8052f89baf27ad9b750e718e20b1b9d155/Fruit%20AppClip/SceneDelegate.swift#L18-L32

6. [Optional] Configure [App Clip-to-full app attribution](https://dev.appsflyer.com/hc/docs/app-clip-to-full-app-install).

7. Let the marketer know that the SDK integration is completed, and tell them to implement the App Clip experience in the OneLink custom link and App Store Connect. [Learn more](https://support.appsflyer.com/hc/en-us/articles/360014262358-Apple-App-Clips-integration-guide#app-clip-implementation) 
[block:callout]
{
  "type": "info",
  "title": "Example",
  "body": "[View our App Clip](https://github.com/AppsFlyerSDK/appsflyer-apple-app-clips-sample-app) that demonstrates the AppsFlyer app clip integration."
}
[/block]