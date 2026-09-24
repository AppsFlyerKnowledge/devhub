---
title: AppsFlyerConsent
slug: ios-sdk-ссылка-appsflyerconsent
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

### Общий обзор

AppsFlyerConsent инкапсулирует свойства для получения данных согласия, требуемых Законом о цифровом маркетинге (DMA) и соблюдением GDPR.

```swift
public struct AppsFlyerConsent {
    public let isUserSubjectToGDPR: Bool
    public let hasConsentForDataUsage: Bool
    public let hasConsentForAdsPersonalization: Bool
    public let hasConsentForAdStorage: Bool
}
```

### Параметры

| Наименование                    | Тип     | Описание                                                                                                             |
| ------------------------------- | ------- | -------------------------------------------------------------------------------------------------------------------- |
| isUserSubjectToGDPR             | Boolean | Указывает, применим ли GDPR к пользователю.                                                          |
| есть в наличии данные           | Boolean | Указывает, дал ли пользователь согласие на использование своих данных в рекламных целях.             |
| есть персонализация предложения | Boolean | Указывает, дал ли пользователь свое согласие на использование своих данных для персональной рекламы. |
| имеет Хранилище Предложений     | Boolean | Указывает, дал ли пользователь согласие на хранение или доступ к данным на устройстве.               |

### Примеры использования

### Проворно

```swift
// Если пользователь подпадает под действие DMA - собирает данные согласия
// или извлекает их из хранилища

// Установить данные согласия на SDK:
// Пример для пользователя, субъекта GDPR
var gdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: true, 
	hasConsentForDataUsage: false, 
	hasConsentForAdsPersonalization: true, 
	hasConsentForAdStorage: false
)
AppsFlyerLib. hared(). etConsentData(gdprUser)

// Пример для пользователя, не подверженного GDPR        
var nonGdprUser = AppsFlyerConsent(
	isUserSubjectToGDPR: false, 
	has ConsentForDataUsage: false, 
	has ConsentForAdsPersonalization: false, 
	has ConsentForAdStorage: false
)
AppsFlyerLib. hared().setConsentData(nonGdprUser)

```

## Initializers

### initForGDPRUser

<span class="annotation-deprecated">Устарел с версии V6.16.1</span>

**Input arguments**

| Тип     | Наименование                          | Описание                                                                                                  |
| ------- | ------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| Boolean | forGDPRUserWithHasConsentForDataUsage | Указывает, дает ли пользователь согласие на отправку данных своего пользователя в Google. |
| Boolean | есть персонализация предложения       | Указывает, согласился ли пользователь использовать свои данные для персональной рекламы.  |

**Примеры использования**

```swift
// Если пользователь подпадает под действие DMA - собирает данные согласия
// или извлекает их из хранилища

// Установить данные согласия в SDK:
var gdprConsent = AppsFlyerConsent(forGDPRUserWithHasConsentForDataUsage: true, hasConsentForAdsPersonalization: true) 
AppsFlyerLib. hared().setConsentData(gdprConsent)
```

### initForNonGDPRUser

<span class="annotation-deprecated">Устарел с версии V6.16.1</span>

**Input arguments**

Нет

**Примеры использования**

```swift
// Если пользователь не подпадает под действие DMA:
var nonGdprUser = AppsFlyerConsent(nonGDPRUser: ()) 
AppsFlyerLib.shared().setConsentData(nonGdprUser)
```
