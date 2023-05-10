---
title: "App Clip-to-full app install configuration"
slug: "app-clip-to-full-app-install"
category: 5f849793f6d5d2006de9d826
parentDoc: 5f8497f614361a0019bd00f2 
hidden: false
createdAt: "2020-10-12T18:03:56.249Z"
updatedAt: "2022-12-21T11:17:05.497Z"
---
App owners/advertisers can attribute user downloads of the full app from the App Clip. To do so, the developer needs to configure both the App Clip and the full app. 
[block:api-header]
{
  "title": "Procedures"
}
[/block]
To configure App Clip-to-full app install attribution in the App Clip and full app, the following action checklist of procedures need to be completed. 

**Important**! The same steps need to be followed in both the App Clip and the full app. 
[block:parameters]
{
  "data": {
    "h-0": "Procedure checklist",
    "0-0": "1. In the App Clip, activate the App Groups Entitlement.",
    "1-0": "2. In the App Clip, create an App Group for passing data between the App Clip and full app.",
    "2-0": "3. In the App Clip, update the Information Property List (`info.plist` file).",
    "3-0": "4. In the full app, repeat steps 1-3, using the same App Group name as for the App Clip."
  },
  "cols": 1,
  "rows": 4
}
[/block]
### Activate the App Groups Entitlement

**To activate the App Groups Entitlement**: 

1. In Xcode, go to your Project Page. 
2. In the **Targets** section, select either your App Clip or full app target (depending on what you are configuring).
3. Click the **Signing & Capabilities** tab.
4. Click **+Capability**.
The Capabilities menu opens.
5. In the menu, select App Groups.

### Create an App Group

**To create an App Group for passing data between the App Clip and full app**:

1. In Xcode, go to your Project Page.
2. In the **Targets** section, select either your App Clip or full app target (depending on what you are configuring).
3. Click the **Signing & Capabilities** tab.
3. In the **Signing & Capabilities** tab, go to the **App Groups** section.
4. Click **+**.
The **Add a new container** window opens. 
5. In the opened window, enter a name for your App Group, with the following naming convention:
[block:code]
{
  "codes": [
    {
      "code": "group.YourAppGroupName.appClipToFullApp",
      "language": "text"
    }
  ]
}
[/block]
### Example
[block:image]
{
  "images": [
    {
      "image": [
        "https://files.readme.io/cddf2e3-App_Group_Name.png",
        "App Group Name.png",
        524,
        177,
        "#394148"
      ]
    }
  ]
}
[/block]
### Update the Information Property List

**To update the Information Property List (`info.plist` file)**:

- In the **Information Property List** (`info.plist` file), add a row with the key and value as detailed in the following table.
[block:parameters]
{
  "data": {
    "h-0": "Key",
    "h-1": "Type",
    "h-2": "Value",
    "0-0": "AppsFlyerAppGroupName",
    "0-1": "String",
    "0-2": "The name you gave the App Group in the previous step."
  },
  "cols": 3,
  "rows": 1
}
[/block]
### Configure the full app

**To configure your full app**:

- Repeat all of the previous steps for the full app.