---
title: Проверка AppsFlyerInAppPurchaseCallback
slug: android-sdk-reference-appsflyerinapppurchasevalidationcallback
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

Реализовать интерфейс `AppsFlyerInAppPurchaseValidationCallback` для обработки проверки успешности и неудачи.

**Декларация интерфейса**

```Java
interface AppsFlyerInAppPurchaseValidationCallback {
    void onInInAppPurchaseValidationFinished(validationResult: Map<String, Any?>)
    void onInAppPurchaseValidationError(validationError: Map<String, Any?>)
}
```

## Методы

### onInAppPurchaseValidationЗакончено

**Метод подписи**

```java
void onInAppPurchaseValidationFinished(Map<String, Any?> validationResult)
```

**Описание**
Вызывается по завершении проверки покупки приложением, предоставление результатов проверки (успеха или неудачи) и объекта JSON с деталями проверки успеха или неудачи. Объект

**Параметры обратного вызова**

| Тип                                          | Наименование               | Описание                                                                  |
| :------------------------------------------- | :------------------------- | :------------------------------------------------------------------------ |
| Карта<String, Any?> | `validationFinishedResult` | Результат проверки (успех или провал). |

**Returns**
`void`

### Ошибка проверки покупки

**Метод подписи**

```java
void onInAppPurchaseError(Map<String, Any?> validationErrorResult)
```

**Описание**
Срабатывает при неудачной проверке покупки.

**Параметры обратного вызова**

| Тип                                          | Наименование            | Описание                                                         |
| :------------------------------------------- | :---------------------- | :--------------------------------------------------------------- |
| Карта<String, Any?> | `validationErrorResult` | Тип ошибки, которая произошла во время проверки. |

**Returns**
`void`

