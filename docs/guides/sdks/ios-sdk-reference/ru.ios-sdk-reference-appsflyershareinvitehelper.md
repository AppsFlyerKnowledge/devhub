---
title: AppsFlyerShareInviteHelper
slug: ios-sdk-референц-appsflyershareinvitehelper
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

## Общий обзор

Класс `AppsFlyerShareInviteHelper` предоставляет структурированный способ построения URL-адресов для различных сценариев.

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

## Методы

### генерировать приглашённый Url

**Метод подписи**

```objc
(void)generateInviteUrlWithLinkGenerator:(AppsFlyerLinkGenerator *(^)(AppsFlyerLinkGenerator *generatorCreator completionHandler:(void (^)(NSURL *_Nullable url))completionHandler;
```

**Описание**
Генерирует OneLink.

**Input arguments**

| Тип                                | Наименование        | Описание                                                                                                                              |
| :--------------------------------- | :------------------ | :------------------------------------------------------------------------------------------------------------------------------------ |
| `AppsFlyerLinkGenerator`           | `генератор`         |                                                                                                                                       |
| `(void (^)(NSURL *_Nullable url))` | `completionHandler` | Необязательно. Если установлено, SDK попытается сгенерировать короткую ссылку, используя OneLink API. |

**Returns**
`void`.

### logInvite

**Метод подписи**

```objc
(void)logInvite:(nullable NSString *)channel parameters:(nullable NSDictionary *)parameters;
```

**Описание**
Используйте для регистрации события приглашения пользователя в приложении ([`af_invite`](doc:in-app-events-ios#af_invite)).

**Input arguments**

**Returns**
`void`.
