---
title: AppsFlyerRequestListener
slug: android-sdk-референц-appsflyerrequestlistener
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

Перехват запросов на серверы AppsFlyer через интерфейс `AppsFlyerRequestListener` и [зарегистрировать его с помощью `start`](doc:android-sdk-reference-appsflyerlib#start).

**Декларация интерфейса**

```java
публичный интерфейс AppsFlyerRequestListener {
    void onSuccess();
    void onError(int code, @NonNull String error);
}
```

**Импорт интерфейса**

```java Java
импортировать com.appsflyer.attribution.AppsFlyerRequestListener;
```

```kotlin Kotlin
импортировать com.appsflyer.attribution.AppsFlyerRequestListener
```

## Методы

### успех

**Метод подписи**

```java
void onSuccess();
```

**Callback parameters**
This callback returns no parameters.

**Description**
Triggered upon a successful response.

### на ошибке

**Метод подписи**

```java
void onError(int code, @NonNull String error);
```

**Description**
Triggered upon a successful response.

**Параметры обратного вызова**

| Тип      | Наименование | Описание                             |
| :------- | :----------- | :----------------------------------- |
| `int`    | `код`        | Код ошибки.          |
| `Строка` | `ошибка`     | Сообщение об ошибке. |
