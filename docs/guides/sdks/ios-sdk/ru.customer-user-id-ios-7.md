---
title: Установка ID пользователя клиента
slug: клиент-пользователь-id-ios-7
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-ios-7
privacy:
  view: публичный
position: 4
---

<span class="annotation-optional">Optional</span>

ID пользователя (CUID) — это уникальный идентификатор пользователя, созданный владельцем приложения за пределами SDK. Если он будет доступен в SDK, он может быть связан с установкой и другими внутри-приложенными событиями. Эти CUID события могут быть перекрестно ссылаться на данные пользователей с других устройств и приложений.

### Установить CUID

Чтобы установить CUID:

```objc Objective-C
[AppsFlyerLib shared].customerUserID = @"мой идентификатор пользователя";
```

```swift Swift
AppsFlyerLib.shared().customerUserID = "мой идентификатор пользователя"
```

> 📘 Заметка
>
> ID пользователя клиента должен быть установлен с каждым запуском приложения.

### Связать CUID с событием установки

Если вам нужен CUID для связи с событием установки, установите его перед вызовом `start`. В SDK V7, так как вы контролируете, когда вызывается `start`, установите CUID внутри вашего обратного вызова `registerSessionReadyListener` перед вызовом `start`.

### Отправить копии обратной передачи SKAN и AdAttributionKit на AppsFlyer

Если ваше приложение использует `SKAdNetwork` и `AdAttributionKit`, сконфигурируйте обе конечные точки в файле `Info.plist`.

#### Отправить копии отзыва SKAN в AppsFlyer

Используйте эту настройку для отправки архивирования SKAdNetwork на AppsFlyer.

1. Добавьте `NSAdvertisingAttributionReportEndpoint` в `info.plist` вашего приложения.
2. Установите значение ключа на `https://appsflyer-skadnetwork.com/`.

После настройки Apple будет отправлять копии обратной передачи SKAdNetwork на AppsFlyer. Копии полученных обратных сообщений доступны в [отчете об обратной копии](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).

#### Отправить копии AdAttributionKit на AppsFlyer

Используйте эту настройку для отправки копии обратной передачи AdAttributionKit на AppsFlyer.

1. В Info.plist, добавьте новый ключ.
2. Введите имя ключа `AdAttributionKit` и выберите `AdAttributionKit - Postback Copy URL` во всплывающем меню.
3. Установите значение ключа на `https://appsflyer-skadnetwork.com/`.

После настройки Apple отправит резервные копии AdAttributionKit на AppsFlyer. Копии полученных обратных сообщений доступны в [отчете об обратной копии](https://support.appsflyer.com/hc/en-us/articles/360014261518-SKAN-raw-data-reports#report-types).
