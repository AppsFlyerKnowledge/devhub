---
title: "iOS deferred deep linking with iOS Private Relay"
slug: "dl_ios_private_relay"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
createdAt: "2022-12-29T10:31:18.696Z"
updatedAt: "2023-01-05T09:11:09.808Z"
---
With the launch of 1OS 15, Apple provides iCloud+ users with a feature called Private Relay, which gives them the option to encrypt their web-browsing traffic and hide their exact location, IP address, and the contents of their browsing traffic. If users opt-in to Private Relay, this could interfere with attribution and deferred deep linking. Meaning, once a new user without the app goes to the App Store, and installs and launches the app, Private Relay could prevent them from being sent to a specific page in the app.

To ensure that deferred deep linking (DDL) continues to work as expected, you need to implement one of the following AppsFlyer solutions:

- **[Recommended] App Clip-based solution**: Create an App Clip that gives you user attribution data, and directs users to a customized App Clip experience similar to the one you want DDL to achieve. The app clip can also include a flow to direct users from your App Clip to your full app.
- **Clipboard-based solution**: Create a web landing page that copies the deferred deep linking data from the URL and correctly redirects the user to the app. Note: This solution does not help with attribution.
[block:api-header]
{
  "title": "App Clip-based solution"
}
[/block]
**Prerequisites**: AppsFlyer SDK V6.4.0+

**To set up the App Clip-based DDL solution**:

1. Follow the [Apple instructions](https://developer.apple.com/documentation/app_clips) and develop an App Clip that provides the desired user journey.
2. [Integrate the AppsFlyer SDK for App Clips](https://dev.appsflyer.com/hc/docs/app-clip-sdk-integration), including [App Clip-to-full app attribution](https://dev.appsflyer.com/hc/docs/app-clip-to-full-app-install).
3. In the App Clip `sceneDelegate`:
    - Replace `scene` `continue userActivity` with the following function:
[block:code]
{
  "codes": [
    {
      "code": "func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {\n  // Must for AppsFlyer attrib\n  AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)\n\n  //Get the invocation URL from the userActivity in order to add it to the shared user default\n  guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,\n  let invocationURL = userActivity.webpageURL else {\n    return\n  }\n  addDlUrlToSharedUserDefaults(invocationURL)        \n}",
      "language": "swift"
    }
  ]
}
[/block]
⇲ Github links: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app_AppClip/SceneDelegate.swift#L17-L28  

* Add the following method: 
[block:code]
{
  "codes": [
    {
      "code": "func addDlUrlToSharedUserDefaults(_ url: URL){\n  guard let sharedUserDefaults = UserDefaults(suiteName: \"group.<your_app>.appClipToFullApp\") else {\n    return\n  }\n  //Add invocation URL to the app group\n  sharedUserDefaults.set(url, forKey: \"dl_url\")\n  //Enable sending events\n  sharedUserDefaults.set(true, forKey: \"AppsFlyerReadyToSendEvents\")\n}",
      "language": "swift"
    }
  ]
}
[/block]
⇲ Github links: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app_AppClip/SceneDelegate.swift#L70-L78

4. In the full app:
    * In `appDelegate`, add the following method:
[block:code]
{
  "codes": [
    {
      "code": "func deepLinkFromAppClip() {\n  guard let sharedUserDefaults = UserDefaults(suiteName: \"group.<your_app>.appClipToFullApp\"),\n  let dlUrl = sharedUserDefaults.url(forKey: \"dl_url\")\n  else {\n    NSLog(\"Could not find the App Group or the deep link URL from the app clip\")\n    return\n  }\n  AppsFlyerLib.shared().performOnAppAttribution(with: dlUrl)\n  sharedUserDefaults.removeObject(forKey: \"dl_url\")\n}",
      "language": "swift"
    }
  ]
}
[/block]

⇲ Github links: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app/AppDelegate.swift#L123-L134

  * At the end of the `application didFinishLaunchingWithOptions launchOptions` method, call `deepLinkFromAppClip`: 
[block:code]
{
  "codes": [
    {
      "code": "func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {\n\n  // ...\n\n  deepLinkFromAppClip()\n\n  return true\n}",
      "language": "swift"
    }
  ]
}
[/block]
⇲ Github links: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app/AppDelegate.swift#L54
[block:api-header]
{
  "title": "Clipboard-based solution"
}
[/block]
**To set up the clipboard-based solution**:

1. Enter the following code in `appDelegate`.
[block:code]
{
  "codes": [
    {
      "code": "NSString *pasteboardUrl = [[UIPasteboard generalPasteboard] string];\nNSString *checkParameter = @\"cp_url=true\";\n\nif ([pasteboardUrl containsString:checkParameter]) {\n  [[AppsFlyerLib shared] performOnAppAttributionWithURL:[NSURL URLWithString:pasteboardUrl]];\n}",
      "language": "objectivec"
    },
    {
      "code": "var pasteboardUrl = UIPasteboard.general.string ?? \"\"\nlet checkParameter = \"cp_url=true\"\n\nif pasteboardUrl.contains(checkParameter) {\n    AppsFlyerLib.shared().performOnAppAttribution(with: URL(string: pasteboardUrl))\n}",
      "language": "swift"
    }
  ]
}
[/block]
2. Implement code that pastes the deferred deep link data in the URL from the clipboard. This is not part of the AppsFlyer SDK.