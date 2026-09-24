---
title: Данные преобразования
slug: conversion-data-android
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-6
privacy:
  view: публичный
position: 3
---

В этом руководстве вы узнаете, как получить данные о преобразовании с помощью [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener), а также [examples](doc:conversion-data-android#accessing-attribution-data) для использования данных о конверсии.

Узнайте больше о [данных о конвертации](doc:conversion-data).

## Прежде чем начать

Следующие примеры кода требуют импорта [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib) и [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener):

```java Java
импортировать com.appsflyer.AppsFlyerLib;
импортировать com.appsflyer.AppsFlyerConversionListener;
```

## Настройка AppsFlyerConversionListener в Android SDK

### Обзор AppsFlyerConversionListener

Интерфейс [\`\`AppsFlyerConversionListener\`](doc:android-sdk-reference-appsflyerconversionlistener) позволяет прослушивать преобразования.

Если вы осуществляете и регистрируете [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener) при вызове [`init`](doc:android-sdk-reference-appsflyerlib#init), вызывается [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) откуда угодно:

- Пользователь открывает приложение
- Пользователь перемещает приложение на передний план

Если по какой причине SDK не может получить данные о конвертации, вызывается [`onConversionDataFail`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatafail).

## Доступ к данным атрибутов

При вызове, [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) возвращает `Map` (называемый `conversionDataMap` в примере `conversionDataMap`), который содержит данные преобразования для этой установки. Вызываются данные о преобразовании в первый раз [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) и будут идентичны при последовательных вызовах.

### Органическое и неорганическое преобразование

Конверсия может быть **органичная** или **неорганичная**:

- Органическое преобразование - это преобразование без привязки, которое обычно является результатом прямой установки из магазина приложений.
- Неорганическое преобразование — это преобразование, которое отнесено к [источнику медиа](https://support.appsflyer.com/hc/en-us/articles/212188826-Types-of-media-sources).

Тип преобразования можно получить, просмотрев значение `af_status` в файле [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess)'s payload. Это может быть одно из следующих значений:

- «Органический»
- `Non-organic`

#### Пример

```java
импортировать com.appsflyer.AppsFlyerConversionListener;
импортировать com.appsflyer.AppsFlyerLib;
импортировать com.appsflyer.AppsFlyerLibCore. OG_TAG;

AppsFlyerConversionListener conversionListener = new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionDataMap) {
        для (String attrName : conversionDataMap. eySet())
            Лог. (LOG_TAG, "атрибут конверсии: " + attrName + " = " + conversionDataMap.get(attrName));
        Статус строки = Объекты. equireNonNull(conversionDataMap.get("af_status")).toString();
        if(status quals("Organic"){
            // Business logic for Organic conversion goes here.
        }
        else {
            // Business logic for Non-organic conversion goes here.
        }
    }

    @Override
    public void onConversionDataFail(String errorMessage) {
      Log. (LOG_TAG, "Ошибка получения данных о конверсии: " + errorMessage);
    }

    @Override
    public void onAppOpenAttribution(Map<String, String> attributionData) {
      // Должно быть переопределено, чтобы соответствовать интерфейсу AppsFlyerConversionListener.
      // Бизнес-логика идет здесь, когда UDL не реализована.
    }

    @Override
    public void onAttributionFailure(String errorMessage) {
      // Должно быть переопределено, чтобы соответствовать интерфейсу AppsFlyerConversionListener.
      // Бизнес-логика идет здесь, когда UDL не реализуется.
      Log. (LOG_TAG, "error onAttributionFailure : " + errorMessage);
    }

};
```

```kotlin
импортировать com.appsflyer.AppsFlyerConversionListener
import com.appsflyer.AppsFlyerLib
import com.appsflyer.AppsFlyerLibCore.LOG_TAG
  
class AFApplication : Application() {
    // ...
    переопределяет веселье onCreate() {
        super. nCreate()
        val conversionDataListener = object : AppsFlyerConversionListener{
            переопределить веселье onConversionDataSuccess(данные: MutableMap<String, Any>? {
                // . .
            }
            переопределить удовольствие onConversionDataFail(ошибка: строка? {
                Журнал. (LOG_TAG, "error onAttributionFailure :  $error")
            }
            переопределить fun onAppOpenAttribution(data: MutableMap<String, String>? {
                // Должен быть переопределен для удовлетворения интерфейса AppsFlyerConversionListener.
                // Бизнес-логика идет здесь, когда UDL не реализуется.
                данные?. ap {
                    Журнал. (LOG_TAG, "onAppOpen_attribute: ${it.key} = ${it.value}")
                }
            }
            переопределить веселье onAttributionFailure(ошибка: строка? {
                // Должен быть переопределен для удовлетворения интерфейса AppsFlyerConversionListener.
                // Бизнес-логика идет здесь, когда UDL не реализована.
                Журнал. (LOG_TAG, "error onAttributionFailure :  $error")
            }
        }
        AppsFlyerLib. etInstance().init(devKey, conversionDataListener, applicationContext)
        AppsFlyerLib.getInstance().start(this)
    }

}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/80763ef8c93c49b1f0226455ae35d089f7968ede/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L99-L143)

## Отложенная глубокая связь (устаревший метод)

Когда приложение открыто через отсроченные глубокие ссылки, [`onConversionDataSuccess`](doc:android-sdk-reference-appsflyerconversionlistener#onconversiondatasuccess) загрузка возвращает глубокие данные, а также данные об атрибутах.

- Рекомендуется использовать глубокие связи [Unified Deep Linking (UDL)](doc:unified-deep-linking-udl)
- Для существующих клиентов и ссылок, вот наш [путеводитель по глубоким связям Android](doc:dl_android_gcd_legacy#deferred-deep-linking), используя [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener).
