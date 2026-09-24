---
title: Глубокая ссылка на сообщение пользователя iOS
slug: dl_ios_dl_post_event
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
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

Чтобы легко и безопасно синхронизировать событие пользователя с отложенным глубоким связующим потоком, рекомендуется [initiate](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#initializing-the-ios-sdk) и [start](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#starting-the-ios-sdk) SDK в контроллере `view controller`, где выполняется пользовательское событие. Например, контроллер главного вида, который имеет статус аутентификации. Это отличается от обычного потока, когда SDK и начался и начался в контексте приложения `. 
В контроллере `view Controller\` также следует вызвать обратные вызовы, используемые в потоке [Extended Deferred Deep Linking](dl_ios_ocds_ddl).
Ответственность за сохранение отсроченных глубоких связей и глубоких связей между данными, маршрутизирует пользователя в нужное место назначения только после выполнения события.

## Пример кода

В ветке Github [this](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/tree/DDL_after_login/swift/basic_app/basic_app) вы можете найти образец кода, который ожидает аутентификации псевдо-пользователя, прежде чем продолжить путь к глубокому направлению соединения. После проверки подлинности пользователь перенаправляется к месту назначения. Этот поток имеет значение как для отсроченных глубоких связей, так и для глубоких прямых связей (когда приложение уже установлено).
Вы можете видеть, что у [`AppDelgate`](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/d0e1eeb3da6213830684e72626af5fd1ad0cea40/swift/basic_app/basic_app/AppDelegate.swift#L20) нет инициализации AppsFlyer SDK, за исключением опционального кода `AppTrackingTransparency`. AppsFlyer SDK перемещен в [главный контроллер вида](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/d0e1eeb3da6213830684e72626af5fd1ad0cea40/swift/basic_app/basic_app/MainViewController.swift#L13), выполняющий пользовательское событие (в данном случае).
