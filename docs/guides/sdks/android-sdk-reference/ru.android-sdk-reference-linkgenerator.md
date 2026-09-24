---
title: Генератор ссылок
slug: android-sdk-референц-linkgenerator
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

**Публичный строитель**

```java
публичный LinkGenerator(String mediaSource)
```

**Импортировать класс**

```java Java
импортировать com.appsflyer.share.LinkGenerator;
```

```kotlin Kotlin
импортировать com.appsflyer.share.LinkGenerator
```

## Методы

### setBrandDomain

**Методы подписи**

```java
публичный LinkGenerator setBrandDomain(String brandDomain)
```

**Возвраты**
`LinkGenerator`.

### Домен getBranddomain

**Метод подписи**

```java
публичная строка getBrandDomain()
```

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`String`.

### setDeeplinkPath

**Метод подписи**

```java
Public LinkGenerator setDeeplinkPath(tring deeplinkPath)
```

**Описание**

**Input arguments**

| Тип      | Наименование   | Описание |
| :------- | :------------- | :------- |
| `Строка` | `deeplinkPath` |          |

**Возвраты**
`LinkGenerator`.

### setBaseDeeplink

**Метод подписи**

```java
Public LinkGenerator setBaseDeeplink(String baseDeeplink)
```

**Описание**

**Input arguments**

| Тип      | Наименование   | Описание |
| :------- | :------------- | :------- |
| `Строка` | `baseDeeplink` |          |

**Возвраты**
`LinkGenerator`.

### getChannel

**Метод подписи**

```java
публичная строка getChannel()
```

**Описание**

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`String`.

### настройки канала

**Метод подписи**

```java
публичный файл LinkGenerator setChannel(канал tring)
```

**Описание**

**Input arguments**

| Тип      | Наименование | Описание |
| :------- | :----------- | :------- |
| `Строка` | `канал`      |          |

**Возвраты**
`LinkGenerator`.

### setReferrerCustomerID

**Метод подписи**

```java
публичный LinkGenerator setReferrerCustomerId(String referrerCustomerId)
```

**Описание**

**Input arguments**

| Тип      | Наименование         | Описание |
| :------- | :------------------- | :------- |
| `Строка` | `referrerCustomerId` |          |

**Возвраты**
`LinkGenerator`.

### getMediaSource

**Метод подписи**

```java
публичная строка getMediaSource()
```

**Описание**

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`String`.

### getUserParams

> **Примечание** — метод называется `getParameters` до версии SDK 6.4.2

**Метод подписи**

```java
public Map<String, String> getUserParams()
```

**Описание**

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`Map<String, String>`.

### getКампания

**Метод подписи**

```java
публичная строка getCampaign()
```

**Описание**

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`String`.

### настройки Кампании

**Метод подписи**

```java
кампания по созданию публичных LinkGenerator (String)
```

**Описание**

**Input arguments**

| Тип      | Наименование | Описание |
| :------- | :----------- | :------- |
| `Строка` | `кампания`   |          |

**Возвраты**
`LinkGenerator`.

### addParameter

**Метод подписи**

```java
public LinkGenerator addParameter(String key, String value)
```

**Описание**

**Input arguments**

| Тип      | Наименование | Описание                            |
| :------- | :----------- | :---------------------------------- |
| `Строка` | `ключ`       | Имя параметра.      |
| `Строка` | `значение`   | Значение параметра. |

**Возвраты**
`LinkGenerator`.

### addParameters

**Метод подписи**

```java
публичные addParameters(параметры Map<String, String>)
```

**Описание**

**Input arguments**

| Тип                   | Наименование | Описание |
| :-------------------- | :----------- | :------- |
| `Map<String, String>` | `parameters` |          |

**Возвраты**
`LinkGenerator`.

### setReferrerUID

**Метод подписи**

```java
публичный LinkGenerator setReferrerUID (String referrerUID)
```

**Описание**

**Input arguments**

| Тип      | Наименование  | Описание |
| :------- | :------------ | :------- |
| `Строка` | `referrerUID` |          |

**Возвраты**
`LinkGenerator`.

### setReferrerName

**Метод подписи**

```java
Public LinkGenerator setReferrerName(String referrerName)
```

**Описание**

**Input arguments**

| Тип      | Наименование   | Описание |
| :------- | :------------- | :------- |
| `Строка` | `referrerName` |          |

**Возвраты**
`LinkGenerator`.

### setReferrerImageURL

**Метод подписи**

```java
public LinkGenerator setReferrerImageURL (String referrerImageURL)
```

**Описание**

**Input arguments**

| Тип      | Наименование       | Описание |
| :------- | :----------------- | :------- |
| `Строка` | `referrerImageURL` |          |

**Возвраты**
`LinkGenerator`.

### setBaseURL

**Метод подписи**

```java
public LinkGenerator setBaseURL(String onelinkID, String domain, String appPackage)
```

**Описание**

**Input arguments**

| Тип      | Наименование | Описание |
| :------- | :----------- | :------- |
| `Строка` | `onelinkID`  |          |
| `Строка` | `Домен`      |          |
| `Строка` | `appPackage` |          |

**Возвраты**
`LinkGenerator`.

### генерировать ссылку

**Метод подписи**

```java
публичная строка generateLink()
```

**Описание**
Генерирует длинную ссылку.

**Входные аргументы**
Этот метод не содержит входных аргументов.

**Возвращается**
`String`.

### генерировать ссылку

**Метод подписи**

```java
публичная void generateLink(контекст, CreateOneLinkHttpTask.ResponseListener слушателя)
```

**Описание**
Генерирует короткую ссылку, используя OneLink API.

**Input arguments**

| Тип                                      | Наименование | Описание                       |
| :--------------------------------------- | :----------- | :----------------------------- |
| «Контекст»                               | `context`    | Контекст приложения / действия |
| `CreateOneLinkHttpTask.ResponseListener` | `слушатель`  |                                |

**Returns**
`void`.
