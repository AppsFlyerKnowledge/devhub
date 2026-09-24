---
title: AppsFlyerConsent
slug: android-sdk-референц-appsflyerconsent
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

«AppsFlyerConsent» инкапсулирует методы получения данных согласия, требуемых Законом о цифровом маркетинге (DMA).

### Конструктор

```java
public AppsFlyerConsent(
    Boolean isUserSubjectToGDPR,
    Boolean hasConsentForDataUsage,
    Boolean hasConsentForAdsPersonalization,
    Boolean hasConsentForAdStorage
)
```

### Параметры

| Параметр                          | Тип     | Описание                                                                                                                     |
| --------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `isUserSubjectToGDPR`             | Boolean | Указывает, применим ли GDPR к пользователю.                                                                  |
| `hasConsentForDataUsage`          | Boolean | Указывает, дал ли пользователь согласие на использование своих данных в рекламных целях.                     |
| `hasConsentForAdsPersonalization` | Boolean | Указывает, дал ли пользователь согласие на использование своих данных в персонализированных рекламных целях. |
| `hasConsentForAdStorage`          | Boolean | Указывает, дал ли пользователь согласие на хранение или доступ к информации на устройстве.                   |

### Пример использования

```java
// Пример для пользователя НЕ subject to GDPR
AppsFlyerConsent nonGdprUser = new AppsFlyerConsent(false, false, false, false);
AppsFlyerLib.getInstance(). etConsentData(nonGdprUser);

// Пример для пользователя под GDPR
AppsFlyerConsent gdprUser = new AppsFlyerConsent(true, true, true, false);
AppsFlyerLib.getInstance().setConsentData(gdprUser);
```

## Методы

### форGDPRПользователь

<span class="annotation-deprecated">Устарел с версии V6.16.1</span>

**Метод подписи**

```java
Публичное AppsFlyerConsent forGDPRUser(Boolean hasConsentForDataUsage, Boolean hasConsentForAdsPersonalization)
```

**Описание**  
приобретает согласие пользователя на использование данных и персонализацию объявлений. Вызывать функцию, когда DMA применима к пользователю.

**Input arguments**

| Тип     | Наименование                    | Описание                                                                                                  |
| ------- | ------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Boolean | есть в наличии данные           | Указывает, дает ли пользователь согласие на отправку данных своего пользователя в Google. |
| Boolean | есть персонализация предложения | Указывает, согласился ли пользователь использовать свои данные для персональной рекламы.  |

**Возвраты**

| Тип              | Описание                               |
| ---------------- | -------------------------------------- |
| AppsFlyerConsent | Объект с данными согласия пользователя |

**Пример использования**

```java
AppsFlyerConsent gdprUserConsent = AppsFlyerConsent.forGDPRUser(hasConsentForDataUsage, hasConsentForAdsPersonalization); 
```

### forNonGDPRUser

<span class="annotation-deprecated">Устарел с версии V6.16.1</span>

**Метод подписи**

```java
public AppsFlyerConsent forNonGDPRUser()
```

**Описание**  
Вернуть пустой объект AppsFlyerConsent без каких-либо данных согласия. Вызов метода, когда DMA не применима к пользователю.

**Возвраты**

| Тип              | Описание                                                      |
| ---------------- | ------------------------------------------------------------- |
| AppsFlyerConsent | Пустой объект без каких-либо данных согласия. |

**Пример использования**

```java
val nonGdprUser = AppsFlyerConsent.forNonGDPRUser() 
```
