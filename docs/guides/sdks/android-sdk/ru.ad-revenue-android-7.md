---
title: Доход от рекламы
slug: ad-revenue-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: in-app-events-android-7
content:
  excerpt: Отчет об объявленных доходах SDK
privacy:
  view: публичный
position: 3
---

## Рекомендовано

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Мы рекомендуем использовать наш мастер интеграции SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=ad-revenue-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_adrevenue', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

Приложение отправляет данные о доходах в SDK, которые затем отправляют их в AppsFlyer. Данные о доходах собираются и обрабатываются в AppsFlyer, и доход присваивается первоначальному источнику UA. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners).

Есть два способа для SDK генерировать рекламный доход в зависимости от вашей SDK версии. Используйте правильный метод для вашей версии SDK:

- [Для SDK 6.15.0 и выше](#log-ad-revenue-for-sdk-6150-and-above). Использует рекламный доход SDK API.
- [Для SDK 6.14.2 и ниже](#legacy-log-ad-revenue-for-sdk-6142-and-below). Использует рекламный разъем SDK.

## Доход от журнала объявлений (для SDK 6.15.0 и выше)

При появлении впечатления о доходах вызовите метод [`logAdRevenue`](doc:android-sdk-reference-appsflyerlib#logadrevenue) с данными о доходах.

> 📘 Заметка
>
> Если вы используете коннектор AdRevenue, пожалуйста, удалите его перед тем, как переключиться на новый метод `logAdRevenue`. Если это не сделано, это может привести к неожиданному поведению.

**Для реализации метода:**

1. Создайте экземпляр [`AFAdRevenueData`](doc:android-sdk-reference-appsflyerlib#afadrevenuedata) с подробной информацией о доходах для регистрации. ersion 6.15.0 SDK снимает необходимость использования коннектора для отправки данных Ad Revenue в AppsFlyer.
2. Если вы хотите добавить дополнительные детали к событию рекламного дохода, то заполняйте карту парой ключевой стоимости.
3. Вызовите метод `logAdRevenue` со следующими аргументами:
   - Объект `AFAdRevenueData`, который вы создали в шаге 1.
   - Экземпляр `Map` с дополнительными деталями, которые вы создали на шаге 2.

### Пример кода

```java
импортировать com.appsflyer.AFAdRevenueData;
импортировать com.appsflyer.MediationNetwork;
импортировать com.appsflyer.AppsFlyerLib;
импортировать java.util.HashMap;
импортировать java.util.Map;

AppsFlyerLib appsflyer = AppsFlyerLib. etInstance();

// Создание экземпляра AFAdRevenueData
AFAdRevenueData adRevenueData = new AFAdRevenueData(
          "ironsource", // монетизационная сеть
          MediationNetwork. OOGLE_ADMOB, // mediationNetwork
          "USD", // currencyIso4217Code
          0. 015 // доход
  );

Карта<String, Object> дополнительных Параметры = новый HashMap<>();
дополнительных параметров. ut(AdRevenueScheme. OUNTRY, "US");
additionalParameters.put(AdRevenueScheme.AD_UNIT, "89b8c0159a50ebd1");
additionalParameters.put(AdRevenueScheme.AD_TYPE, "Banner");
additionalParameters.put(AdRevenueScheme.PLACEMENT, "place");

appsflyer.logAdRevenueData, additionalParameter);
```

> 📘 Note
> The AdMob iLTV SDK reports impression revenue in micro-units. Для отображения правильной суммы дохода в USD в AppsFlyer, разделить сумму, извлеченную из обработчика событий iLTV, на 1 миллион перед отправкой ее на AppsFlyer.

## [LEGACY] Доход от журнала рекламы (для SDK 6.14.2 и ниже)

Для SDK v6.14.2 и ниже - коннектор AdRevenue должен использоваться вдоль сбоку от AppsFlyer SDK для отправки данных Ad Revenue в AppsFlyer.

### Импортировать Android рекламный доход SDK

1. Добавьте следующий код в раздел /**app/build.gradle** перед зависимостями:

```java
репозитории { 
  mavenCentral()
}
```

2. Добавить библиотеку Ad Revenue в качестве зависимости:

```java
dependencies {
  реализация 'com.appsflyer:adrevenue:6.9.0'
}
```

3. Синхронизация проекта для получения зависимостей.

### Инициализировать доход от рекламы Android SDK

- В глобальном классе приложения вызывайте [`initialize`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#initaliaze) и положите следующий код:

```java
импортировать com.appsflyer.adrevenue. ppsFlyerAdRevene;

public class MyApplication extends Application {
    
    @Override
    public void onCreate() {
        super. nCreate();
        
        AppsFlyerAdRevenue.Builder afRevenueBuilder = новый AppsFlyerAdRevenue. uilder(this);     
        
        AppsFlyerAdRevenue. initialize(afRevenueBuilder.build());
    }
}
```

### Запустить вызов logAdRevenue API

- Запустите [`logAdRevenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#logadrevenue) API, вызывающий все допустимые впечатления, включая обязательные и опциональные аргументы.

```java
// Убедитесь, что вы импортировали:

import com.appsflyer.adrevenue.adnetworks.AppsFlyerAdNetworkEventType;
import com.appsflyer.adrevenue.adnetworks.generic.MediationNetwork;
import com.appsflyer.adrevenue.adnetworks.generic.Scheme;

import java. til.Currency;
import java.util.HashMap;
import java.util.Locale;

// Создание факультативных customParams

Map<String, String> customParams = new HashMap<>();
customParams.put(Scheme.COUNTRY, "US");
customParams.put(Scheme. D_UNIT, "89b8c0159a50ebd1");
customParams.put(Scheme.AD_TYPE, "Banner");
customParams.put(Scheme.PLACEMENT, "place");
customParams.put(Scheme.ECPM_PAYLOAD, "encrypt");
customParams.put("foo", "test1");
customParams. ut("bar", "test2");

// Запись единого впечатления
AppsFlyerAdRevenue. ogAdRevenue(
        "ironsource",
        MediationNetwork. oogleadmob,
        Currency.getInstance(Локальная). S),
        0.99,
        customParams
);
```
