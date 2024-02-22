---
title: "Overview"
slug: "click-sign-api-overview"
category: 65a5059cbcfe3400421aa9cc
hidden: false
order: 0
---

**At a glance:**

Add signature validation to clicks to avoid fraud liabilities so fraudulent clicks aren't attributed to your ad network.

## **About click signing**

With minimal tech, fraudsters can send clicks on behalf of an ad network and create thousands, or even millions, of fake clicks that get sent to AppsFlyer. Sometimes, the ad networks themselves aren't aware of the issue.

- Click signing prevents the ad network’s traffic from being blocked due to click flooding.
- Signatures enable AppsFlyer to validate the clicks and make sure that the click information hasn't been manipulated by fraudsters.
- Validated clicks are recorded, and attributed to the ad network.
- Ad networks should sign their clicks with [HMAC-SHA256](https://en.wikipedia.org/wiki/HMAC) signatures.
- Invalidated clicks are rejected and:
    - Are made available in Protect360 reports for ad networks (not advertisers). [Learn more](https://support.appsflyer.com/hc/en-us/articles/4420246395793#failed-click-signatures)
    - Do not impact the conversion rate or click-blocking threshold of the ad network

[Click here](https://support.appsflyer.com/hc/en-us/articles/360017831497-Click-signing-for-ad-networks) for more information on click signing and the set up procedure.