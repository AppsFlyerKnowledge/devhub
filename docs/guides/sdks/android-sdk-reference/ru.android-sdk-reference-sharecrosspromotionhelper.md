---
title: Кросс-PromotionHelper
slug: android-sdk-референц-sharecrosspromotionhelper
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

Android SDK кросс-промо-помощник класса.

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).

**Заявление Класса**

```java
общественный класс CrossPromotionHelper
```

**Импортировать класс**

```java Java
импортировать com.appsflyer.share.CrossPromotionHelper;
```

```kotlin Kotlin
импортировать com.appsflyer.share.CrossPromotionHelper
```

## Методы

### logAndOpenStore

**Метод подписи**

```java
публичная статическая некоррекция logAndOpenStore(@NonNull контекст,
                                       String promoted_app_id,
                                       String кампания,
                                       Map<String, String> userParams)
```

**Описание**

**Input arguments**

| Тип                   | Наименование      | Описание                                                      |
| :-------------------- | :---------------- | :------------------------------------------------------------ |
| «Контекст»            | `context`         | Контекст приложения / действия.               |
| `Строка`              | `promoted_app_id` |                                                               |
| `Строка`              | `кампания`        | Название кампании по перекрестной пропаганде. |
| `Map<String, String>` | `userParams`      | Необязательно.                                |

**Returns**
`void`.

### logCrossPromoteImpression

**Метод подписи**

```java
публичный статический избег logCrossPromoteImpression(@NonNull контекст,
                                                 String appID,
                                                 String campaign,
                                                 Map<String, String> userParams)
```

**Описание**

**Input arguments**

| Тип                   | Наименование | Описание                                                      |
| :-------------------- | :----------- | :------------------------------------------------------------ |
| «Контекст»            | `context`    | Контекст приложения / действия.               |
| `Строка`              | `appID`      |                                                               |
| `Строка`              | `кампания`   | Название кампании по перекрестной пропаганде. |
| `Map<String, String>` | `userParams` | Необязательно.                                |

**Returns**
`void`.

### setUrl

**Метод подписи**

```java
публичная статическая недействительная setUrl(Map<String, String> mapOfURLs)
```

**Описание**

**Input arguments**

| Тип                   | Наименование | Описание |
| :-------------------- | :----------- | :------- |
| `Map<String, String>` | `mapOfURLs`  |          |

**Returns**
`void`.
