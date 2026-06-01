---
title: Android SDK 7
slug: android-sdk-7
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk
privacy:
  view: public
position: 1
---

Android SDK v7 gives you explicit control over when the SDK fires a session, aligns the Android and iOS APIs, and lets you declare build-time settings in a JSON file, so you can build more predictable, consent-aware integrations.

## What's new in v7

SDK v7 gives you explicit control over when the SDK fires a session. In previous versions, the SDK started automatically on foreground. This made it difficult to gate the session on conditions such as CMP consent, or a customer user ID that needed to be included in the install event.

v7 replaces automatic startup with a session readiness listener. You register it after `init()`, then call `start()` inside it, or after your own pre-start conditions are met.

This release also resolves long-standing inconsistencies between Android and iOS. Setter persistence, deep linking APIs, and SDK configuration are now aligned across both platforms.

A new file-based configuration, `af_init_config.json` in your assets folder, lets you declare build-time constants without setting them in code.

## In this section

- [Migrate to Android SDK v7](https://dev.appsflyer.com/hc/docs/migrate-android-sdk-to-v7) — Review breaking changes and update your existing integration before upgrading.
- [Install Android SDK v7](https://dev.appsflyer.com/hc/docs/install-android-sdk-7) — Add the SDK to your project and complete the initial setup.
- [Integrate Android SDK v7](https://dev.appsflyer.com/hc/docs/integrate-android-sdk-7) — Configure the SDK and implement the features you need.

> 🚧 Important
>
> v7 includes breaking changes. Review [Migrate to Android SDK v7](https://dev.appsflyer.com/hc/docs/migrate-android-sdk-to-v7) before upgrading.