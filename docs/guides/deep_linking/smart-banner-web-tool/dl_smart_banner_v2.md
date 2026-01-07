---
title: "OneLink Smart Banner V2"
slug: "dl_smart_banner_v2"
category: 6384c30e5a754e005f668a74
parentDoc: 63ccfdc2635a53004ab874f0
hidden: false
createdAt: "2022-12-29T10:12:10.569Z"
updatedAt: "2023-05-07T20:29:27.336Z"
order: 1
---

## Overview

AppsFlyer provides a Smart Banner SDK that advertisers integrate into their websites. The purpose of the SDK is to pull all the required data to dynamically display the Smart Banners. The Smart Banners SDK also automatically builds the proper attribution links, so you don't need to build them manually.

Therefore, **the Smart Banner SDK should be accessible from all pages displaying your mobile banners.**  
The Smart Banner SDK authenticates using the unique **Web key**, which you can get from the [Website workplace](https://support.appsflyer.com/hc/en-us/articles/360000764837#1-website-setup).

## Installation

### Smart banners only

You can either copy the smart banner script from the AppsFlyer dashboard or from below.

1. Copy the script code snippet in **one** of the following ways:

   - Copy the script from the [Smart Banner’s Website workplace](https://support.appsflyer.com/hc/en-us/articles/360000764837-Smart-Banners-mobile-web-to-app-#1-website-workplace-setup) in the AppsFlyer dashboard. Your web key is already included in the script.
   - Copy the script from the the code snippet below and replace YOUR_WEB_KEY placeholder in the script with your **Web key**. The web key is created when you create a new [Website workplace](https://support.appsflyer.com/hc/en-us/articles/360000764837-Smart-Banners-mobile-web-to-app-#1-website-workplace-setup).

```js
<script>
!function(t,e,n,s,a,c,i,o,p){t.AppsFlyerSdkObject=a,t.AF=t.AF||function(){
(t.AF.q=t.AF.q||[]).push([Date.now()].concat(Array.prototype.slice.call(arguments)))},
t.AF.id=t.AF.id||i,t.AF.plugins={},o=e.createElement(n),p=e.getElementsByTagName(n)[0],o.async=1,
o.src="https://websdk.appsflyer.com?"+(c.length>0?"st="+c.split(",").sort().join(",")+"&":"")+(i.length>0?"af_id="+i:""),
p.parentNode.insertBefore(o,p)}(window,document,"script",0,"AF","banners",{banners: {key: ">>>>>YOUR_WEB_KEY<<<<"}});
// Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner.
AF('banners', 'showBanner');
</script>
```

2. Paste the code snippet in the `head` tag on your website. Make sure to paste it near the top of the `head` tag.

> 📘 Note
> 
> - The `showBanner` method at the end of installation code can take more parameters. [Learn more](#showbanner).
> - To overcome iOS 26/Safari storage limitations, declare the storage-mode flag as a global variable before SDK initialization to control how the web SDK stores data for Smart Banners. See [Set storage mode](#set-storage-mode-optional) below.

### Smart banners and People-Based Attribution

1. Replace the _YOUR_WEB_KEY_ placeholder in the script with your **Web key**. The web key is created when you create a new Website workplace.
2. Replace the _YOUR_PBA_KEY_ placeholder in the script with your **web dev key**. The web dev key is created when you create a brand bundle. 
3. Paste this code snippet in the head tag on your website. Make sure to paste it near the top of the head tag.

```js
<script>
!function(t,e,n,s,a,c,i,o,p){t.AppsFlyerSdkObject=a,t.AF=t.AF||function(){
(t.AF.q=t.AF.q||[]).push([Date.now()].concat(Array.prototype.slice.call(arguments)))},
t.AF.id=t.AF.id||i,t.AF.plugins={},o=e.createElement(n),p=e.getElementsByTagName(n)[0],o.async=1,
o.src="https://websdk.appsflyer.com?"+(c.length>0?"st="+c.split(",").sort().join(",")+"&":"")+(i.length>0?"af_id="+i:""),
p.parentNode.insertBefore(o,p)}(window,document,"script",0,"AF", "pba,banners",{pba: {webAppId: "YOUR_PBA_KEY"}, banners: {key: "YOUR_WEB_KEY"}});
// Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner.
AF('banners', 'showBanner', { bannerZIndex: 1000, additionalParams: { p1: "v1", p2: "v2"}});
</script>
```

#### Set Storage Mode (Optional)

Smart Banners use browser storage to handle banner state and functionality. With the release of iOS 26, Safari introduced changes that affect how browser storage behaves. To help websites maintain consistent Smart Banner behavior in these environments, you can configure the storage method with the `storage-mode` flag.

- **local (default):** Uses browser `localStorage` / `sessionStorage`. This is the default mode and does not require any changes to your cookie consent or privacy setup. 
- **cookie:** Uses first-party cookies (on your domain) to overcome iOS 26/Safari storage limitations.

> ⚠️ Important
> 
> If you enable **cookie** mode, your website may be subject to additional cookie consent and disclosure requirements under privacy regulations (e.g., GDPR, ePrivacy). It is the website owner’s responsibility to ensure their consent management platform (CMP) and privacy policy are updated accordingly.

```js
<script>
  // Optional: configure storage mode before SDK initialization
  // Options: "local" (default) or "cookie"
  window.AF_SB_STORAGE_MODE = "cookie";
</script>

<script>
  // Smart Banners Web SDK initialization
  // Use the snippet provided in the Installation section above
</script>

```

## Control Smart Banner font

Using the same font in the smart banner as the rest of the website creates a consistent and cohesive visual identity for your brand. 

In order to change the default font in the Smart Banner, you need to add the following rule to your **CSS**

```css
[data-af-custom-fonts="af-creatives-text"] {
    font-family: PUT-YOUR-CUSTOM-FONT-HERE !important;
}
```

For example:

```css
[data-af-custom-fonts="af-creatives-text"] {
    font-family: museo-sans !important;
}
```

> 🚧 
> 
> - The `!important` is required
> - Make sure that the font is already loaded in your website
> - The custom font will apply to **all** banners on the website
> - If the font doesn't display correctly, resave your banner in the [creative editor](https://support.appsflyer.com/hc/en-us/articles/360000764837#3-banner-setup)

## SDK functions

### showBanner

**Method signature**

```JavaScript
AF('banners', 'showBanner', { bannerContainerQuery: String,
              bannerZIndex: Integer,              
              additionalParams: <Key, Value Dictionary>);
```

**Description**  
Start showing the Smart Banner according to the banner key provided in the snippet.

> ℹ️ **Note**
> 
> Don't use this function when implementing Smart Banners in a wrapper/hybrid app to load the banner page from the app (and not from the browser), as using `showBanner` will display the banner within the app. If you do use `showBanner` for a wrapper/hybrid app, use `hideBanner` for mobile app loads.

**Input arguments**

| Type                      | Name                   | Description                                                                                                                                                                                     |
| :------------------------ | :--------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `String`                  | `bannerContainerQuery` | If passed, the SDK tries to locate an element in the page with this query and treats it as the entry point for the banner placement. Otherwise, `document.body` is used.                        |
| `Integer`                 | `bannerZIndex`         | Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner. |
| `<Key, Value Dictionary>` | `additionalParams`     | If passed, these keys and values (for example, `deep_link_value: apples`) are added as query parameters to the OneLink URL.                                                                     |

**Usage examples**

- Add parameters to the OneLink URL

```js
AF('banners', 'showBanner', { additionalParams: { deep_link_value: "apples", deep_link_sub1: "22", af_adset: "my_adset"}});
```

- Set Z-index of this banner and a container Id for its placement

```js
AF('banners', 'showBanner', { bannerContainerQuery: "#my-container-id"
                              bannerZIndex: 999});
```

### updateParams

**Method signature**

```js
AF('banners', 'updateParams', { <Key, Value Dictionary> });
```

**Description**  
Programmatically add up to 10 parameters (for example, `deep_link_value`) to the OneLink URL assigned to the call-to-action (CTA) button, after the banner displays. 

The input is an object with parameter keys and values.

A key can’t have an empty value.  
A key can’t be named: undefined, null, NaN, or arg  
Invalid characters:  
Key: ```/, \, *, !, @, #, ?, $, %, ^, &, ~, ``, =, +, ', ", ;, :, >, <```  
Value = ```\, ;, $, >, <, ^, #, `` ```

- The parameters are added as query parameters to the OneLink URL. 
- When you use updateParams to add parameters, the impression URL is different than the click URL.
- Parameters added don’t replace those on the original OneLink URL. If the parameter you add is already in the OneLink URL, it doesn’t change. 
- If updateParams is called more than once, only the parameters from the last call are added to the URL.

**Input arguments**

| Type                      | Name | Description                                                                                                      |
| :------------------------ | :--- | :--------------------------------------------------------------------------------------------------------------- |
| `<Key, Value Dictionary>` | N/A  | These keys and values (for example, `deep_link_value: apples`) are added as query parameters to the OneLink URL. |

**Usage examples**

- Add parameters to the OneLink URL

```js
AF('banners', 'updateParams', { deep_link_value: "new_param", deep_link_sub4: "gg_77", af_ad: "new_ad_param"});
```

### hideBanner

**Method signature**

```js
AF('banners', 'hideBanner');
```

**Description**  

Programmatically remove any displayed banner from the page (e.g. after a certain user input). 

**Input arguments**

none

**Usage examples**

- Hide banner

```js
AF('banners', 'hideBanner');
```

## Traits and Limitations

| Trait                         | Remarks                                                                                                                                                                                                                                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Single page application (SPA) | Smart Banners are by default only displayed once, even if users navigate between pages.<br> To display banners when users navigate between pages, you need to manually call hideBanner and showBanner for every navigation that doesn't reload the page and trigger the Smart Banners default logic. |
| Click ID auto forwarding | The following click IDs are automatically forwarded to the outgoing URL when they are present on the incoming URL:<br> - Google: `gclid`, `gbraid`, `wbraid`<br> - Facebook: `fbclid`<br> - TikTok: `ttclid`<br> - X (formerly Twitter): `twclid`<br> - Snap: `ScCid` |