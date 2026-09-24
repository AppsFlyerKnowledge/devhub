---
title: 'Android: Задайте параметры на основе кликнутого домена URL'
slug: dl_android_attr_params_based_click
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Общий обзор

Органический атрибут поиска может быть установлен с AppsFlyer без обновления SDK. [Подробнее](https://support.appsflyer.com/hc/en-us/articles/15123194526353#setup).

Используйте метод `appendParametersToDeepLinkingURL` для динамического задания источника медиа и других параметров, основанных на имени домена с кликом.

## Предпосылки

- Android SDK 6.0.1+.
- Вызовите этот метод перед вызовом [`start`](#start).

## Использование

### Параметры ввода

| Тип                   | Наименование | Описание                                                           |
| :-------------------- | :----------- | :----------------------------------------------------------------- |
| `Строка`              | `contains `  | Доменное имя для идентификации URL                                 |
| `Map<String, String>` | `parameters` | Параметры для добавления к deeplink URL после прохождения проверки |

Предоставьте следующие параметры в `Map`:

- `pid`
- `is_retargeting=true`

### Пример использования

```java
HashMap<String, String> urlParameters = new HashMap<>();
parameters.put("pid", "exampleDomain"); // Обязательные
parameters.put("is_retargeting", "true"); // Обязательные
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com", параметры);
```

```kotlin
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com",
mapOf("pid" к "exampleDomain", "is_retargeting" к "true")) // Требуется
```

В приведенном выше примере URL атрибуции, отправленный на серверы AppsFly:

```
example.com?pid=exampleDomain&is_retargeting=true
```
