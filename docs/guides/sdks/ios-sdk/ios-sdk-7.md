---
title: iOS SDK 7
slug: ios-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: ios-sdk
privacy:
  view: public
position: 1
---

---
title: iOS SDK v7
slug: ios-sdk-7
category:
  uri: AppsFlyer SDKs
content:
  excerpt: Get started with AppsFlyer iOS SDK v7, a major release that introduces manual session control, unified cross-platform APIs, and file-based configuration.
privacy:
  view: public
position: 1
---

iOS SDK v7 gives you explicit control over when the SDK fires a session, aligns the iOS and Android APIs, and lets you declare build-time settings in a plist file, so you can build more predictable, consent-aware integrations.

## What's new in v7

SDK v7 gives you explicit control over when the SDK fires a session. In previous versions, the SDK started automatically when you called `start()` in `didBecomeActive`. This made it difficult to gate the session on conditions such as ATT authorization, CMP consent, or a customer user ID that needed to be included in the install event.

v7 replaces automatic startup with a session readiness listener. You register it after `init()`, then call `start()` inside it, or after your own pre-start conditions are met.

This release also resolves long-standing inconsistencies between iOS and Android. Setter persistence, deep linking APIs, and SDK configuration are now aligned across both platforms.

A new file-based configuration, `AppsFlyerLibConfig.plist`, lets you declare build-time constants without setting them in code.

## In this section

- [Migrate to iOS SDK v7](https://dev.appsflyer.com/hc/docs/migrate-ios-sdk-to-v7) — Review breaking changes and update your existing integration before upgrading.
- [Install iOS SDK v7](https://dev.appsflyer.com/hc/docs/install-ios-sdk-7) — Add the SDK to your project and complete the initial setup.
- [Integrate iOS SDK v7](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk-7) — Configure the SDK and implement the features you need.

> 🚧 Important
>
> v7 includes breaking changes. Review [Migrate to iOS SDK v7](https://dev.appsflyer.com/hc/docs/migrate-ios-sdk-to-v7) before upgrading.