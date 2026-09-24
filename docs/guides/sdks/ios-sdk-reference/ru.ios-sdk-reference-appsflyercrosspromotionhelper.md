---
title: AppsFlyerCrossPromotionHelper
slug: ios-sdk-референц-appsflyercrosspromotionhelper
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

## Общий обзор

AppsFlyer позволяет регистрировать и атрибутировать установки, созданные на основе кросс-раскрутки ваших приложений. Это позволяет маркетологам оптимизировать кросс-пропагандистские кампании для достижения лучших результатов.

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

**Декларация интерфейса**

```objc
@интерфейс AppsFlyerCrossPromotionHelper
```

Для доступа к `AppsFlyerCrossPromotionHelper`, импортируйте [`AppsFlyerLib`](doc:ios-sdk-reference-appsflyerlib).

## Методы

### logCrossPromoteImpression

**Метод подписи**

```objc
(void)logCrossPromoteImpression:(id)appID
                         campaign:(id)campaign
                       parameters:(id)parameters;
```

**Description**
logs an impression as part of a cross-promotion campaign. Не забудьте использовать продвигаемый App ID в панели управления AppsFler.

**Input arguments**

| Тип            | Наименование | Описание                             |
| :------------- | :----------- | :----------------------------------- |
| `NSString`     | `appID`      | Продвинутый ID приложения            |
| `NSString`     | `кампания`   | Название кросс-кампании              |
| `НSDictionary` | `parameters` | Дополнительные параметры для журнала |

**Returns**
`void`.

### logAndOpenStore

**Метод подписи**

```objc
(void)logAndOpenStore:(id)appID
               campaign:(id)campaign
             parameters:(id)parameters
              openStore:(void (^)(int *, int *))openStoreBlock;
```

**Описание**
Вы можете использовать компонент StoreKit для открытия App Store, оставаясь в контексте вашего приложения. Узнайте больше в [присвоении перекрестных показов](https://support.appsflyer.com/hc/en-us/articles/115004481946-Cross-Promotion-Tracking#attributing-crosspromotion-impressions).

**Input arguments**

| Тип                      | Наименование     | Описание                                                      |
| :----------------------- | :--------------- | :------------------------------------------------------------ |
| `NSString`               | `appID`          | Продвинутый ID приложения.                    |
| `NSString`               | `кампания`       | Название кампании по перекрестной пропаганде. |
| `НSDictionary`           | `parameters`     | Дополнительные параметры для журнала.         |
| `void (^)(int *, int *)` | `openStoreBlock` | Содержит повышенный клик.                     |

**Returns**
`void`.
