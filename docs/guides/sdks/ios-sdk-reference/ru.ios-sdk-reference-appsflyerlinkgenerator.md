---
title: AppsFlyerLinkGenerator
slug: ios-sdk-референц-appsflyerlinkgenerator
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

## Общий обзор

Экземпляры класса `AppsFlyerLinkGenerator` представлены в качестве входных данных для [\`\`generateInviteUrl`](doc:ios-sdk-reference-appsflyershareinvitehelper#generateinviteurl) из [`AppsFlyerShareInviteHelper\`](doc:ios-sdk-reference-appsflyershareinvitehelper).

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

**Декларация**

```objc
@interface AppsFlyerLinkGenerator : NSObject
```

Для доступа к `AppsFlyerLinkGenerator`, импортируйте [`AppsFlyerLib`](doc:ios-sdk-reference-appsflyerlib).

## Свойства

### брэндомен

**Объявление объекта**

```objc
@property(nonatomic, nullable) NSString *brandDomain;
```

## Методы

### настройки канала

**Метод подписи**

```objc
- (void)setChannel :(nonnull NSString *)канал;
```

**Input arguments**

| Тип        | Наименование | Описание                                                       |
| :--------- | :----------- | :------------------------------------------------------------- |
| `NSString` | `канал`      | Канал, через который отправляется приглашение. |

**Returns**
`void`.

### setReferrerCustomerID

**Метод подписи**

```objc
- (void)setReferrerCustomerId:(nonnull NSString *)referrerCustomerId;
```

**Input arguments**

| Тип        | Наименование         | Описание |
| :--------- | :------------------- | :------- |
| `NSString` | `referrerCustomerId` |          |

**Returns**
`void`.

### настройки Кампании

**Метод подписи**

```objc
- (void)setCampaign          :(nonnull NSString *)campaign;
```

**Input arguments**

| Тип        | Наименование | Описание |
| :--------- | :----------- | :------- |
| `NSString` | `кампания`   |          |

**Returns**
`void`.

### setReferrerUID

**Метод подписи**

```objc
- (void)setReferrerUID :(nonnull NSString *)referrerUID;
```

**Input arguments**

| Тип        | Наименование  | Описание |
| :--------- | :------------ | :------- |
| `NSString` | `referrerUID` |          |

**Returns**
`void`.

### setReferrerName

**Метод подписи**

```objc
- (void)setReferrerName :(nonnull NSString *)referrerName;
```

**Input arguments**

| Тип        | Наименование   | Описание |
| :--------- | :------------- | :------- |
| `NSString` | `referrerName` |          |

**Returns**
`void`.

### setReferrerImageURL

**Метод подписи**

```objc
- (void)setReferrerImageURL :(nonnull NSString *)referrerImageURL;
```

**Input arguments**

| Тип        | Наименование       | Описание                                               |
| :--------- | :----------------- | :----------------------------------------------------- |
| `NSString` | `referrerImageURL` | URL-адрес аватара пользователя referr. |

**Returns**
`void`.

### setAppleAppID

**Метод подписи**

```objc
- (void)setAppleAppID :(nonnull NSString *)appleAppID;
```

**Input arguments**

| Тип        | Наименование | Описание     |
| :--------- | :----------- | :----------- |
| `NSString` | `appleAppID` | Apple App ID |

**Returns**
`void`.

### setDeeplinkPath

**Метод подписи**

```objc
- (void)setDeeplinkPath      :(nonnull NSString *)deeplinkPath;
```

**Input arguments**

| Тип        | Наименование   | Описание                              |
| :--------- | :------------- | :------------------------------------ |
| `NSString` | `deeplinkPath` | Глубокообразный путь. |

**Returns**
`void`.

### setBaseDeeplink

**Метод подписи**

```objc
- (void)setBaseDeeplink      :(nonnull NSString *)baseDeeplink;
```

**Input arguments**

| Тип        | Наименование   | Описание                                |
| :--------- | :------------- | :-------------------------------------- |
| `NSString` | `baseDeeplink` | Базовый глубинный путь. |

**Returns**
`void`.

### addParameterValue

**Метод подписи**

```objc
- (void)addParameterValue :(nonnull NSString *)value forKey:(NSString *)key;
```

**Input arguments**

| Тип        | Наименование | Описание                                |
| :--------- | :----------- | :-------------------------------------- |
| `NSString` | `значение`   | Значение параметра URL. |
| `NSString` | `ключ`       | Имя параметра URL.      |

**Returns**
`void`.

### addParameters

**Метод подписи**

```objc
- (void)addParameters :(nonnull NSDictionary *)parameter;
```

**Input arguments**

| Тип            | Наименование | Описание                                |
| :------------- | :----------- | :-------------------------------------- |
| `НSDictionary` | `parameters` | словарь параметров URL. |

**Returns**
`void`.
