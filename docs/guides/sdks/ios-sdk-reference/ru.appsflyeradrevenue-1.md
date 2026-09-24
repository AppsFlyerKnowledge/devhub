---
title: 'AppsFlyerAdenue [LEGACY]'
slug: appsflyeradrevenu-1
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

<span class="annotation-deprecated">Устарел в версии 6.15.0</span>  
(поддерживается до версии 6.14.6 SDK в том числе и выше версии 6.15.0, используйте [`logAdRevenue`](doc:ios-sdk-reference-appsflyerlib#logadrevenue))

[block:api-header]
{
"title": "Overview"
}
[/block]
AppsFlyerAdenue является родительским классом для рекламного дохода SDK.
[block:api-header]
{
"title": "Properties"
}
[/block]

### Тип медиации

#### Константы

| Тип                                                                                       | Наименование                | Описание                                                                                   |
| :---------------------------------------------------------------------------------------- | :-------------------------- | :----------------------------------------------------------------------------------------- |
| `Строка`                                                                                  | `ironsource`                | Название сети медиации.                                                    |
| `Строка`                                                                                  | `applovinmax`               | Название сети медиации.                                                    |
| `Строка`                                                                                  | `googleadmob`               | Название сети медиации.                                                    |
| `Строка`                                                                                  | `fyber`                     | Название сети медиации.                                                    |
| `Строка`                                                                                  | `appodeal`                  | Название сети медиации.                                                    |
| `Строка`                                                                                  | `admost`                    | Название сети медиации.                                                    |
| `Строка`                                                                                  | `topon`                     | Название сети медиации.                                                    |
| `Строка`                                                                                  | `tradplus`                  | Название сети медиации.                                                    |
| `Строка`                                                                                  | `yandex`                    | Название сети медиации.                                                    |
| `Строка`                                                                                  | `chartboost`                | Название сети медиации.                                                    |
| `Строка`                                                                                  | `единство`                  | Название сети медиации.                                                    |
| `Строка`                                                                                  | `customMediation`           | Медиационное решение не входит в список поддерживаемых партнеров медиации. |
| `Строка`                                                                                  | `directMonetizationNetwork` | Приложение напрямую интегрируется с сетями монетизации без медиации.       |
| [block:api-заголовок] |                             |                                                                                            |
| {                                                                                         |                             |                                                                                            |
| "title": "Методы"                                                         |                             |                                                                                            |
| }                                                                                         |                             |                                                                                            |
| [/block]                              |                             |                                                                                            |

### старт

**Метод подписи**

```swift
(void)start;
```

**Описание**
Инициализует рекламный доход SDK.

**Input arguments**

Этот метод не принимает входные аргументы.

**Returns**
`void`.

### logAdRevenue

**Метод подписи**

```swift
(void)logAdRevenueWithMonetizationNetwork:(NSString * _Nonnull)monetizationNetwork
      mediationNetwork:(AppsFlyerAdRevenueMediationNetworkType)mediationNetwork
      eventenueReven:(NSNumber * _Nonnull)eventenue
      revenueCurrency:(NSString * _Nonnull)revenueCurrency
      additionalParameters:(NSDictionary * _Nullable)additionalParameters
```

**Описание**
Регистрирует впечатление от рекламы.

**Input arguments**

| Тип                                                                                                       | Наименование               | Описание                                                                                                                           |
| :-------------------------------------------------------------------------------------------------------- | :------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `Строка`                                                                                                  | `monetizationNetwork`      | Название сети монетизации.                                                                                         |
| [\`\`MediationNetworkType\`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#mediationnetworktype) | `mediationNetwork`         | Энум медиации.                                                                                                     |
| `Строка`                                                                                                  | `revenueCurrency`          | Валюта события «Доход».                                                                                            |
| `NSNumber`                                                                                                | `eventRevenue`             | Сумма рекламного дохода.                                                                                           |
| `НSDictionary`                                                                                            | «дополнительные параметры» | Содержит родные и настраиваемые поля для полезной нагрузки рекламы, как описано в следующем примере использования. |

**Returns**
`void`.

**Пример использования**

```swift
let adRevenueParams:[AnyHashable: Any] = [
            kAppsFlyerAdRevenueCountry : "нас",
            kAppsFlyerAdRevenueAdUnit : "02134568", //Добавить! Здесь
            kAppsFlyerAdRevenueAdType : "Баннер", //Добавить! Здесь
            kAppsFlyerAdRevenuePlacement : "place",
            "foo" : "testcustom",
            "bar" : "testcustom2"
        ]
        
        AppsFlyerAdRevenue. hared(). ogAdRevenue(
            monetizationNetwork: "facebook",
            mediationNetwork: MediationNetworkType. oPub,
            eventRevenue: 0. 26,
            выручка: "USD",
            дополнительные параметры: adRevenueParams)
```
