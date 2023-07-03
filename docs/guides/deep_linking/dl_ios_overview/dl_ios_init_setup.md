---
title: "iOS initial setup"
slug: "dl_ios_init_setup"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
createdAt: "2022-12-25T13:36:23.084Z"
updatedAt: "2023-01-05T09:25:21.577Z"
---
**At a glance**: The initial app setup enables the marketer to create links that send existing app users directly into the app. The initial setup is also a prerequisite for deep linking and deferred deep linking.

## App opening methods

There are two app opening methods that need to be implemented to cover your entire user base. The method used depends on the mobile platform version.

The two methods and instructions for implementation are described in detail in the following sections.

| Method | Description | iOS Versions | Procedure |
| --- | --- | --- | --- |
|**Universal Links**|Directly opens the mobile app at the default activity. Universal Links take the format of regular web links (e.g. https://yourbrand.onelink.me or https://www.yourbrand.com)|iOS 9 and above|<ol><li>[Get the app bundle ID and prefix ID.](#getting-the-app-bundle-id-and-prefix-id)</li><li> [Enable associated domains.](#enabling-associated-domains)</li></ol>|
|**URI Scheme**|Directly opens the app based on the activity path specified in the URI scheme.|[iOS all versions](https://support.appsflyer.com/hc/en-us/articles/115002366466)|<ol><li>[Decide on a URI scheme with the marketer.](#deciding-on-a-uri-scheme)</li><li> [Enable associated domains.](#adding-uri-scheme)</li><li>[Testing](#testing-the-uri-scheme)</li></ol>

## Procedures for iOS Universal Links

### Getting the app bundle ID and prefix ID

1. Log into your Apple Developer Account.
2. On the left-hand menu, select **Certificates, Identifiers & Profiles**.
3. Under **Identifiers**, select **App IDs**.
4. Click the relevant app.
5. Copy the prefix ID and app bundle ID.
6. Give the prefix ID and app bundle ID to your marketer.
The marketer will use it in the AppsFlyer dashboard to register the app.
![certs_apple_info!](https://files.readme.io/6b67004-certs_apple_info.png "certs_apple_info")

### Enabling associated domains

**To support associated domains in your app**:

Follow [the iOS instructions for associated domains](https://developer.apple.com/documentation/safariservices/supporting_associated_domains_in_your_app). 

### Configuring mobile apps to register approved domains
Configuring mobile apps to register approved domains takes place inside Xcode. It requires the OneLink subdomain that your marketer generates.

**To configure mobile apps to register approved domains**:

1. Get the OneLink subdomain from your marketer.
2. In Xcode, click on your project.
3. Click on the project target (see the screenshot that follows).
4. Switch to the **Capabilities** tab.
5. Turn on **Associated Domain**.
6. Add the subdomain that you got from your marketer.
    The format is `applinks:subdomain.onelink.me`.

![xcode-associated-domains!](https://files.readme.io/ed37397-xcode-associated-domains.png "xcode-associated-domains")

> 📘
> To associate a domain with your app, you need to have the associated domain file on your domain and the appropriate entitlement in your app. Once the OneLink is created, AppsFlyer hosts the `apple-app-site-association file`.
> When a user installs your app, the system attempts to download the associated domain file and verify the domains in your `Associated Domains Entitlement`.

### Universal Link limitations

#### Opening apps from browsers
Universal Links only work when clicked on. For example, when clicking a link in a web page or email. Pasting the link in the browser address bar doesn't deep link into the app.

#### OneLink subdomain
While the OneLink subdomain can be changed at anytime, it causes all existing OneLink URLs using the original subdomain to stop working.

#### OneLink in social network apps
Not all apps, including social networks apps, fully support Universal links. For further details, please see [this guide](https://support.appsflyer.com/hc/en-us/articles/207032246-OneLink-Basic-Setup-Guide#partners-onelink-social-apps).

#### Other limitations and issues
There may also be other limitations with Universal links. Visit [OneLink troubleshooting](https://support.appsflyer.com/hc/en-us/articles/360014821438) for more details.

## Procedures for URI scheme
A URI scheme is a URL that leads users directly to the mobile app. 

When an app user enters a URI scheme in a browser address bar box, or clicks on a link based on a URI scheme, the app launches and the user is deep-linked.

Whenever a Universal Link fails to open the app, the URI scheme can be used as a fallback to open the application.

### Deciding on a URI scheme

**To decide on a URI scheme:**
1. Contact the marketer. 
2. Choose a URI scheme. For example: `yourappname://`

> 📘
> - Use a URI scheme that is as unique as possible to your app and brand to avoid coincidental overlap with other apps in the ecosystem. Overlap with other apps is an inherent issue in the nature of URI scheme protocol.
> - The URI scheme should not start with *http* or *https*.
> - The URI scheme should be similarly defined on Android and iOS.

3. Send the URI scheme to the marketer, e.g. `afshopapp://mainactivity`.

### Adding URI scheme

**To add the URI scheme:**

1. In Xcode, open app information plist file.
2. Add a **URL types** entry.
3. Expand the **URL type** and **Item 0** rows.
4. Add a unique identifier for the app for URL identifier as a value. 
It is best to select a unique identifier that is unlikely to be used by other apps.
5. Right-click **URL identifier** and select **Add Row** > **URI Schemes**.
6. Set the **Item 0** value to your unique scheme.


![info_list_uri_schemes!](https://files.readme.io/569ae8d-info_list_uri_schemes.png "info_list_uri_schemes")

### Prerequisites:

An iOS device with the app installed. Make sure it is the app source and version where you made changes and implemented Universal Links and URI schemes.

### Testing the URI scheme:

1. Contact the marketer and get the custom link they created.
2. Send the short or long URL the marketer gives you to your phone. You can either:
   - Scan the QR code with your phone camera or QR scanner app.
   - Email or WhatsApp yourself the link, and open it on your phone.
3. Click the link on your mobile device. The app should open to its home screen.

If the link doesn't open the app, add the parameter `af_force_deeplink=true` to the custom attribution link. For example:

```text
https://demo.onelink.me/1aBC/123ab45c?af_force_deeplink=true
```

### URI scheme limitations
Neither Apple nor Google enforces unique naming for app schemes. Choose a scheme name unique to your brand to avoid conflicting schemes across different applications. A good scheme name could be your app bundle ID, for example: **com.company.app**.

To enable OneLink to serve both iOS and Android, it's important that the same scheme be defined for both platforms.

When a OneLink that has `af_force_deeplink=true` is opened in iOS 12.3.1, the following logic applies:
* A dialog is shown asking the user if the app installed:
    * If the user chooses OK (app is installed), AppsFlyer attempts to open the app using URI scheme.
    * If the user chooses Cancel (app is not installed), AppsFlyer redirects the user to the app store.
    * If the user chooses OK but the app is not installed, an error message is shown:
  
![uri_cannot_open_page!](https://files.readme.io/4bdb9ef-885402320830842.XbZXy5YrCSL3FKIBZPjn_height640.png "uri_cannot_open_page")