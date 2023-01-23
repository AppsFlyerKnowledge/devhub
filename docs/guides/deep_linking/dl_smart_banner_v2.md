---
title: Smart Banner v2
category: 6384c30e5a754e005f668a74
parentDoc: 63ccfdc2635a53004ab874f0
order: 1
hidden: true
---

## Overview
AppsFlyer provides a Smart Banner SDK that advertisers integrate into their websites. The purpose of the SDK is to pull all the required data to dynamically display the Smart Banners. The Smart Banners SDK also automatically builds the proper attribution links, so you don't need to build them manually.

Therefore, **the Smart Banner SDK should be accessible from all pages displaying your mobile banners.**
The Smart Banner SDK authenticates using the unique **Web key**, which you can get from the [Website workplace](https://support.appsflyer.com/hc/en-us/articles/360000764837#1-website-setup).


## Installation

### Smart banners only

1. Replace the *YOUR_WEB_KEY* placeholder in the script with your **Web key**. The web key is created when you create a new [Website workplace](https://support.appsflyer.com/hc/en-us/articles/360000764837#1-website-setup).
2. Paste the following code snippet in the `head` tag on your website. Make sure to paste it near the top of the `head` tag.
   
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
> ℹ️ **Note**
> The `showBanner` method at the end of installation code can take more parameters. [Learn more](#showbanner)


### Smart banners and People-Based Attribution 

1. Replace the *YOUR_WEB_KEY* placeholder in the script with your **Web key**. The web key is created when you create a new Website workplace.
2. Replace the *YOUR_PBA_KEY* placeholder in the script with your **web dev key**. The web dev key is created when you create a brand bundle. 
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
> Don't use this function when implementing Smart Banners in a wrapper/hybrid app to load the banner page from the app (and not from the browser), as using `showBanner` will display the banner within the app. If you do use `showBanner` for a wrapper/hybrid app, use `hideBanner` for mobile app loads.

**Input arguments**

| Type      | Name              | Description          |
| :-------- | :---------------- | :------------------- |
| `String` | `bannerContainerQuery` | If passed, the SDK tries to locate an element in the page with this query and treats it as the entry point for the banner placement. Otherwise, `document.body` is used. |
| `Integer` | `bannerZIndex` | Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner. |
| `<Key, Value Dictionary>` | `bannerContainerQuery` | If passed, these keys and values (for example, `deep_link_value: apples`) are added as query parameters to the OneLink URL. |

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
Key: `/, \, *, !, @, #, ?, $, %, ^, &, ~, ``, =, +, ', ", ;, :, >, <`
Value = `\, ;, $, >, <, ^, #, `` `

- The parameters are added as query parameters to the OneLink URL. 
- When you use updateParams to add parameters, the impression URL is different than the click URL.
- Parameters added don’t replace those on the original OneLink URL. If the parameter you add is already in the OneLink URL, it doesn’t change. 
- If updateParams is called more than once, only the parameters from the last call are added to the URL.

**Input arguments**

| Type      | Name              | Description          |
| :-------- | :---------------- | :------------------- |
| `<Key, Value Dictionary>` | N/A | These keys and values (for example, `deep_link_value: apples`) are added as query parameters to the OneLink URL. |

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