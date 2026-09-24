---
title: Событие пользователя для Глубокой связи Android
slug: dl_android_dl_post_event
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Общий обзор

В некоторых случаях пользователю необходимо пройти какое-то мероприятие, прежде чем продолжить работу на странице приложения, указываемой глубоким связыванием назначения.
Примеры для таких событий пользователя:

1. Процесс входа
2. Заставки
3. Согласие с условиями использования

## Осуществление

Чтобы легко и безопасно синхронизировать событие пользователя с отложенным глубоким связующим потоком, рекомендуется [initiate](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#initializing-the-android-sdk) и [start](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#deferring-sdk-start) SDK в контексте `activity context`, где выполняется пользовательское событие. Например, вид, который реализует процесс входа. Это отличается от обычного потока, когда SDK запускается и запускается в контексте приложения `. 
В контексте `activity context\` также следует вызвать обратные вызовы, используемые в потоке [Extended Deferred Deep Linking](dl_android_ocds_ddl).
Ответственность за сохранение отсроченных глубоких связей и глубоких связей между данными, маршрутизирует пользователя в нужное место назначения только после выполнения события.

## Пример кода

В ветке Github [this](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/tree/DDL_after_Login/java/basic_app) вы можете найти образец кода, ожидающий аутентификации псевдо-пользователя, прежде чем продолжить путь к глубокому направлению ссылки. После проверки подлинности пользователь перенаправляется к месту назначения. Этот поток имеет значение как для отсроченных глубоких связей, так и для глубоких прямых связей (когда приложение уже установлено).
Вы можете видеть, что [контекст приложения](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/8dcb03c48199d5123e776463ae74e7dd274c6fdc/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L11) не имеет кода AppsFlyer SDK. The AppsFlyer code moved entirely into the [activity](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/8dcb03c48199d5123e776463ae74e7dd274c6fdc/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/LoginActivity.java#L29) which perform the user event.
