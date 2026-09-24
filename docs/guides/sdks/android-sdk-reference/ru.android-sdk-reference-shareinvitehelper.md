---
title: ShareInviteHelper
slug: android-sdk-референц-shareinvitehelper
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

**Заявление Класса**

```java
публичный класс ShareInviteHelper
```

**Импортировать класс**

```java Java
импортировать com.appsflyer.share.ShareInviteHelper;
```

```kotlin Kotlin
импортировать com.appsflyer.share.ShareInviteHelper
```

## Методы

### генерировать приглашённый Url

**Метод подписи**

```java
публичный статический генератор LinkGenerator generateInviteUrl(контекст)
```

**Описание**

**Input arguments**

| Тип        | Наименование | Описание                                        |
| :--------- | :----------- | :---------------------------------------------- |
| «Контекст» | `context`    | Контекст приложения / действия. |

**Возвраты**
`LinkGenerator`.

### logInvite

**Метод подписи**

```java
публичный статический отказ logInvite(контекст строки, канал карты<String, String> eventParameters)
```

**Описание**

**Input arguments**

| Тип                   | Наименование      | Описание                                        |
| :-------------------- | :---------------- | :---------------------------------------------- |
| «Контекст»            | `context`         | Контекст приложения / действия. |
| `Строка`              | `канал`           |                                                 |
| `Map<String, String>` | `eventParameters` |                                                 |

**Returns**
`void`.
