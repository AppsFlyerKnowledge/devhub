---
title: Overview
slug: net-revenue-overview
category:
  uri: ROI360 Net Revenue API (v2.0)
privacy:
  view: public
position: 0
---

ROI360 automatically calculates net in-app purchase (IAP) and subscription revenue. It does this by deducting store commissions and local taxes from the gross amount.

The default configuration reflects standard App Store and Google Play fees and tax rules. App Store defaults are region-specific. If your store commission differs (for example, Apple's Small Business Program charges 15 percent, or 12 percent in Greater China) or if you operate in a country with special tax treatment, use the Net Revenue API to override the defaults.

ROI360 applies the following default store commissions:

| Platform | Region | IAP (one-time purchases) | Subscriptions, months 1–12 | Subscriptions, month 13+ |
| :--- | :--- | :--- | :--- | :--- |
| iOS | Japan | 26% | 26% | 15% |
| iOS | Greater China | 25% | 25% | 12% |
| iOS | Rest of the world | 30% | 30% | 15% |
| Android | All regions | 30% | 15% | 15% |

Default tax rates are listed in <a href="https://docs.google.com/document/d/e/2PACX-1vSl3DwlK2Gt2aa5gmDzD3-K3CtnIM85oMNrqx3PCTamwCERWYU48GugNpD31BFjA2PJjZnqaXIVe2Hx/pub">True Revenue - default tax rates</a>

> ⚠️ **Deprecation Notice**
> 
> API v1.0 (`/api/stores-taxes/v1.0/`) is deprecated. Please migrate to v2.0 (`/api/net-revenue/v2.0/`).