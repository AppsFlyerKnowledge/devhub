---
title: 'AppsFlyerAdenue [LEGACY]'
slug: appsflyeradrevenue
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

<span class="annotation-deprecated">Устарел в версии 6.15.0</span>

(Поддерживается до SDK v6.14.2 Для версий, включая v6.15.0, используйте [`logAdRevenue`](doc:android-sdk-reference-appsflyerlib#logadrevenue))

[block:api-header]
{
"title": "Overview"
}
[/block]
AppsFlyerAdenue является родительским классом для рекламного дохода SDK.
[block:api-header]
{
"title": "Методы"
}
[/block]

### инициализировать

**Метод подписи**

```java
публичная инициализация пустоты (доход от AppsFlyerAdRevenue)
```

**Описание**
Инициализует рекламный доход SDK.

**Input arguments**

| Тип                  | Наименование | Описание                                                                      |
| :------------------- | :----------- | :---------------------------------------------------------------------------- |
| `AppsFlyerAdRevenue` | `revenue`    | Создает и инициализирует объект в одиночном режиме AdRevenue. |

**Returns**
`void`.

**Пример использования**

```java
AppsFlyerAdRevenue.Builder afRevenueBuilder = новый AppsFlyerAdRevenue.Builder( это);
AppsFlyerAdRevenue.initialize(afRevenueBuilder.build());
```

### logAdRevenue

**Метод подписи**

```java
public static void logAdRevenue(@NonNull String monetizationNetwork, @NonNull MediationNetwork mediationNetwork, @NonNull Currency eventRevenueCurrency, @NonNull Double eventRevenue, @Nullable Map<String, String> nonMandatory)
```

**Описание**
Регистрирует впечатление от рекламы.

**Input arguments**

| Тип                                                                                         | Наименование           | Описание                                                                                                                           |
| :------------------------------------------------------------------------------------------ | :--------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `Строка`                                                                                    | `monetizationNetwork`  | Название сети монетизации.                                                                                         |
| [`MediationNetwork`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#mediationnetwork) | `mediationNetwork`     | Энум медиации.                                                                                                     |
| [`Валюта`](https://docs.oracle.com/javase/8/docs/api/java/util/Currency.html)               | `eventRevenueCurrency` | Валюта события «Доход».                                                                                            |
| «Дубль»                                                                                     | `eventRevenue`         | Сумма рекламного дохода.                                                                                           |
| `Map<String, String>`                                                                       | `nonMandatory`         | Содержит родные и настраиваемые поля для полезной нагрузки рекламы, как описано в следующем примере использования. |

**Returns**
`void`.

**Пример использования**

```java
// Creating optional customParams
        Map<String, String> customParams = new HashMap<>();
        customParams.put(Scheme.COUNTRY, "US");
        customParams.put(Scheme.AD_UNIT, "89b8c0159a50ebd1");
        customParams.put(Scheme.AD_TYPE, AppsFlyerAdNetworkEventType.BANNER.toString());
        customParams.put(Scheme.PLACEMENT, "place");
        customParams.put(Scheme.ECPM_PAYLOAD, "encrypt");
        customParams.put("foo", "test1");
        customParams.put("bar", "test2");

        // Actually recording a single impression
        AppsFlyerAdRevenue.logAdRevenue(
                "ironsource",
                MediationNetwork.googleadmob,
                Currency.getInstance(Locale.US),
                0.99,
                customParams
        );
```

[block:api-header]
{
"title": "Переменные"
}
[/block]

### Медиасеть

#### Константы

| Тип      | Наименование                | Описание                                                                                   |
| :------- | :-------------------------- | :----------------------------------------------------------------------------------------- |
| `Строка` | `ironsource`                | Название сети медиации.                                                    |
| `Строка` | `applovinmax`               | Название сети медиации.                                                    |
| `Строка` | `googleadmob`               | Название сети медиации.                                                    |
| `Строка` | `fyber`                     | Название сети медиации.                                                    |
| `Строка` | `appodeal`                  | Название сети медиации.                                                    |
| `Строка` | `admost`                    | Название сети медиации.                                                    |
| `Строка` | `topon`                     | Название сети медиации.                                                    |
| `Строка` | `tradplus`                  | Название сети медиации.                                                    |
| `Строка` | `yandex`                    | Название сети медиации.                                                    |
| `Строка` | `chartboost`                | Название сети медиации.                                                    |
| `Строка` | `единство`                  | Название сети медиации.                                                    |
| `Строка` | `customMediation`           | Медиационное решение не входит в список поддерживаемых партнеров медиации. |
| `Строка` | `directMonetizationNetwork` | Приложение напрямую интегрируется с сетями монетизации без медиации.       |
