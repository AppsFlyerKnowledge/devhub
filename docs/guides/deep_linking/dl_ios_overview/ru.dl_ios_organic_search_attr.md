---
title: 'iOS: задать параметры на основе кликнутого домена URL'
slug: dl_ios_attr_параметры based_click
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

## Общий обзор

Органический атрибут поиска может быть установлен с AppsFlyer без обновления SDK. [Подробнее](https://support.appsflyer.com/hc/en-us/articles/15123194526353#setup).

Используйте метод `appendParametersToDeepLinkingURL` для динамического задания источника медиа и других параметров, основанных на имени домена с кликом.

## Предпосылки

- iOS SDK 6.0.8+.
- Вызовите этот метод перед вызовом [`start`](#start).

## Использование

### Параметры ввода

| Тип            | Наименование | Описание                                                           |
| :------------- | :----------- | :----------------------------------------------------------------- |
| `NSString`     | «содержит»   | Доменное имя для идентификации URL                                 |
| `НSDictionary` | `parameters` | Параметры для добавления к deeplink URL после прохождения проверки |

Предоставьте следующие параметры в `Map`:

- `pid`
- `is_retargeting=true`

### Пример использования

```swift
AppsFlyerLib.shared().appendParametersToDeeplinkURL(содержит "example.com", параметры: ["pid" : "exampleDomain", "is_retargeting" : true])
```

```Obj-c
[[AppsFlyerLib shared] appendParametersToDeepLinkingWithString:@"example.com" @{@"pid" : @"exampleDomain", @"is_retargeting" : @YES}]
```

В приведенном выше примере URL атрибуции, отправленный на серверы AppsFly:

```
example.com?pid=exampleDomain&is_retargeting=true
```
