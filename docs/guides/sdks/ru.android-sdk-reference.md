---
title: Ссылка на Android SDK
slug: android-sdk-reference
category:
  uri: SDK AppsFlyer
parent:
  uri: Андроид-сдк
content:
  excerpt: Документация AppsFlyer Android SDK .
privacy:
  view: публичный
position: 4
---

## Общий обзор

Это документ для Android SDK. В этом разделе вы найдете технические описания классов и методов, которые входят в SDK.

Нужно реализовать специфические возможности? Смотрите [руководства SDK](doc:android-sdk).

## Иерархия пакетов

- `com.appsflyer`
  - [\`\`AppsFlyerLib\`](doc:android-sdk-reference-appsflyerlib): Этот класс содержит большую часть функциональности SDK.
  - [\`\`DeepLinkListener\`](doc:android-sdk-reference-deeplinklistener): Публичный интерфейс, который содержит метод обратного вызова для [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).
  - [`DeepLink`](doc:android-sdk-reference-deeplink): Объект с глубокими ссылками.
  - [\`\`DeepLinkResult\`](doc:android-sdk-reference-deeplinkresult): Публичный класс, который держит результат глубокого разрешения ссылок. В случае успеха она содержит глубокие данные о ссылках.
  - [\`\`AppsFlyerConversionListener\`](doc:android-sdk-reference-appsflyerconversionlistener): Публичный интерфейс, позволяющий слушать [conversions](https://dev.appsflyer.com/hc/docs/conversion-data-android).
  - [\`\`AppsFlyerInAppPurchaseValidatorListener\`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener): Интерфейс, который обрабатывает проверку успешности и неудачи.
  - `attribution`
    - [\`\`AndroidRequestListener\`](doc:android-sdk-reference-appsflyerrequestlistener): Интерфейс, получающий результаты запросов к серверам AppsFler.
  - `поделиться`
    - [`CrossPromotionHelper`](doc:android-sdk-reference-sharecrosspromotionhelper): Android SDK кросс-промо-помощник класса.
    - [\`\`ShareInviteHelper\`](doc:android-sdk-reference-shareinvitehelper): Помощь классу в создании пригласительных адресов.
    - [`LinkGenerator`](doc:android-sdk-reference-linkgenerator): Объект используется для создания одноплатформенных и OneLink.

## SDK коннекторы

- [`AppsFlyerAdenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue): Родительский класс для рекламы дохода SDK.
