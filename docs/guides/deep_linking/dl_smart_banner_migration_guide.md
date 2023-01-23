---
title: Smart Banner migration guide v1 to v2
category: 6384c30e5a754e005f668a74
parentDoc: 63ccfdc2635a53004ab874f0
order: 2
hidden: true
---

## Overview

Upgrading your SDK to a new version can be a simple process, but it is important to understand the changes that have been made. In this tutorial, we will go over the steps to upgrade your current SDK to the new version, and how to adjust your code to accommodate the changes.

## Prerequisites

1. Make sure to download the latest version of the SDK.
If you already have the standalone PBA Web SDK, remove it and replace it with the Web SDK for both Smart Banners and People-based Attribution; do not simply add the standalone Web SDK for Smart Banners.

You can find both SDK snippets here (please choose the one that fits you):
    1. [Using the Web SDK for Smart Banners only](dl_smart_banner_v2).
    2. [Using the Web SDK for both Smart Banners and People-based Attribution](https://support.appsflyer.com/hc/en-us/articles/4410472474001#appsflyer-web-sdk-for-smart-banners-and-peoplebased-attribution).

## Installation

Replace the old SDK snippet on your website with the [new one](dl_smart_banner_v2#code-example).
Simply replace the old code snippet in the `<head>` tag of every page displaying your mobile banners with the new SDK snippet.

## SDK methods

1. Once the new SDK is in place, you will need to adjust your code to reflect the changes.
In this case, the old SDK included deprecated functions such as: 
`disableBanners()`
`disableTracking()` 
`getAdditionalParams()`
`setAdditionalParams()`

These functions have been removed in the new SDK, so you will need to remove any references to them in your code.

### showBanner

In the old SDK, the showBanner function was called like this:
```js
showBanner({ bannerContainerQuery: "#container-id",
              bannerZIndex: 1000,
              additionalParams: { deep_link_value: "flights", deep_link_sub1: "london"}});
```

In the new SDK, the [`showBanner`](dl_smart_banner_v2#showbanner) function is called like this:
```js
AF('banners', 'showBanner', { bannerContainerQuery: "#container-id",
              bannerZIndex: 1000,
              additionalParams: { deep_link_value: "flights", deep_link_sub1: "london"}});
```

### hideBanner
The `hideBanner` function has also changed, going from:
```js
hideBanner()
```
to the [new version](dl_smart_banner_v2#hidebanner)
```js
AF('banners', 'hideBanner')
```

### updateParams

The [new SDK](dl_smart_banner_v2#updateparams) allows you to programmatically add up to 10 parameters to the OneLink URL assigned to the call-to-action (CTA) button, after the banner displays. This is useful for tracking or other purposes where you need to pass dynamic data to your OneLink.

Example:
```js
AF ("banners", "updateParams", {af_ad: "my_new_ad", deep_link_sub8: "promo_summer"})
```

**It is important to note that this method doesn't work with the deprecated Smart Banner web SDK.**