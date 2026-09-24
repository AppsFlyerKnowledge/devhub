---
title: AppsFlyerConversionListener
slug: android-sdk-референц-appsflyerconversionlistener
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

[block:api-header]
{
"title": "Overview"
}
[/block]
`AppsFlyerConversionListener` является публичным интерфейсом, позволяющим слушать [conversions](doc:conversion-data-android).

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).

### AppsFlyerConversionListener

Интерфейс `AppsFlyerConversionListener` требует переопределения следующих методов:

- [onConversionDataSuccess](#onconversiondatasuccess)
- [onConversionDataFail](#onconversiondatafail)
- [onAppOpenAttrtibution](#onappopenattribution)
- [onAttributionFailure](#onattributionfailure)

Все методы должны быть переопределены. В противном случае выводится ошибка компиляции.
[block:api-header]
{
"title": "Public Methods"
}
[/block]

### onAppOpenAttribution

**Метод подписи**

```java
void onAppOpenAttribution(java.util.Map<java.lang.String,java.lang.String>attributionData)
```

**Описание**
Эта обратная связь НЕ будет вызвана, если используется AppsFlyerLib.subscribeForDeepLink.

**Параметры обратного вызова**

| Тип                   | имя               | Описание |
| :-------------------- | :---------------- | :------- |
| `Map<String, String>` | `attributionData` |          |

**Returns**
`void`

### onAttributionFailure

**Метод подписи**

```java
void onAttributionFailure(java.lang.String errorMessage)
```

**Описание**
Эта обратная связь НЕ будет вызвана, если используется AppsFlyerLib.subscribeForDeepLink.

**Параметры обратного вызова**

| Тип      | имя            | Описание |
| :------- | :------------- | :------- |
| `Строка` | `errorMessage` |          |

**Returns**
`void`

### onConversionDataУспешно

**Метод подписи**

```java
void onConversionDataSuccess(java.util.Map<java.lang.String,java.lang.Object>conversionData)
```

**Описание**
Срабатывает при успешном разрешении данных преобразования.

**Параметры обратного вызова**

| Тип                   | имя               | Описание                                             |
| :-------------------- | :---------------- | :--------------------------------------------------- |
| `Map<String, Object>` | `conversionData ` | Вы должны явно указать `null` ключи. |

**Returns**
`void`.

### onConversionDataОшибка

**Метод подписи**

```java
void onConversionDataFail(java.lang.String errorMessage)
```

**Описание**
Срабатывает при неудачном разрешении данных конверсии.

**Параметры обратного вызова**

| Тип      | имя            | Описание |
| :------- | :------------- | :------- |
| `Строка` | `errorMessage` |          |

**Returns**
`void`.
