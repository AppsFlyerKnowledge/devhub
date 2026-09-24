---
title: AppsFlyerInAppPurchaseValidatorListener (LEGACY)
slug: Слушатель android-sdk-референц-appsflyerinapppurchasevalidatorlistener
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

Реализовать интерфейс `AppsFlyerInAppPurchaseValidatorListener` для обработки проверки успешности и неудачи.

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).

**Декларация интерфейса**

```java
публичный интерфейс AppsFlyerInAppPurchaseListener
```

## Методы

### onValidateInApp

**Метод подписи**

```java
void onValidateInApp()
```

**Описание**
Срабатывает при успешной проверке покупки.

**Returns**
`void`

### onValidateInAppFailure

**Метод подписи**

```java
void onValidateInAppFailure(java.lang.String ошибка)
```

**Описание**
Срабатывает при неудачной проверке покупки.

**Параметры обратного вызова**

| Тип      | Наименование | Описание                                                         |
| :------- | :----------- | :--------------------------------------------------------------- |
| `Строка` | `ошибка`     | Тип ошибки, которая произошла во время проверки. |

**Returns**
`void`
