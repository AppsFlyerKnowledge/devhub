---
title: "Overview"
slug: "app-clip-overview"
category: 5f849793f6d5d2006de9d826 
hidden: false
createdAt: "2020-10-26T08:06:50.776Z"
updatedAt: "2021-08-25T08:12:21.763Z"
---
**At a glance**: App Clips enable users with iOS 14 or later to quickly access and experience your app. AppsFlyer SDK integration gives you valuable App Clip attribution data. And OneLink configuration lets you automatically redirect users who can't use App Clips to the places defined in your OneLink settings. [Learn more](https://www.appsflyer.com/resources/guides/ios-14-app-clips/) 
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/5bc87f6-app_clip_flow_2.png",
        "app clip flow 2.png",
        751,
        422,
        "#efeff0"
      ]
    }
  ]
}
[/block]
To integrate the AppsFlyer SDK with App Clips, you need to:

- [Add the SDK to the App Clip](https://dev.appsflyer.com/docs/app-clip-sdk-integration).
- [Optional] [Have in-app events set up (in the full app and/or App Clip](https://dev.appsflyer.com/docs/in-app-events). 
- [Configure both the App Clip and full app to measure App Clip-to-full app installs.](https://dev.appsflyer.com/docs/app-clip-to-full-app-install)

[block:api-header]
{
  "title": "Considerations"
}
[/block]
App Clips:

- App Clips can be up to 10 MB in size. The AppsFlyer SDK is ~1.5 MB. 
- No advertising identifiers available.
- App Clips are deleted by the OS automatically after a 30-day period of inactivity.
- SKAdNetwork functionality isn’t available.