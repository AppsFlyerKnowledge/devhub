---
title: AppsFlyerLib
slug: ios-sdk-reference-appsflyerlib
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

## Общий обзор

`AppsFlyerLib` - главный класс AppsFlyer iOS SDK и инкапсулирует большинство методов.

Для импорта `AppsFlyerLib`:

```objectivec
// AppDelegate.h
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AppsFlyerLibDelegate>

@end
```

```swift
import AppsFlyerLib
```

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

## Свойства

### идентификатор рекламы (только для чтения)

**Объявление объекта**

```objc
@property(nonatomic, сильный и читаемый) NSString *advertisingIdentifier
```

**Описание**  
AppsFlyer SDK собирает `advertisingIdentifier` Apple, если `AdSupport.framework` включен в SDK.  
Вы можете отключить это поведение, установив `disableAdvertisingIdentifier` в `true`.

| Тип        | Наименование                  |
| :--------- | :---------------------------- |
| `NSString` | «рекламирующий идентификатор» |

### анонимизировать пользователя

**Объявление объекта**

```objc
@property(atomic) BOOL anonymizeUser;
```

**Описание**  
Отключение журнала для конкретного пользователя

| Тип   | Наименование    |
| :---- | :-------------- |
| `бул` | `anonymizeUser` |

### appInviteOneLinkID

**Объявление объекта**

```objc
@property(nonatomic, strong, nullable, setter = setAppInviteOneLink:) NSString * appInviteOneLinkID
```

**Описание**  
Установите OneLink ID из конфигурации OneLink. Используется в приглашениях пользователей для создания OneLink.

| Тип        | Наименование         |
| :--------- | :------------------- |
| `NSString` | `appInviteOneLinkID` |

### appleAppID

**Объявление объекта**

```objc
@property(nonatomic, сильный) NSString * appleAppID
```

**Описание**  
Используйте это свойство для установки Apple ID вашего приложения (взятого с страницы приложения в iTunes Connect)

| Тип        | Наименование |
| :--------- | :----------- |
| `NSString` | `appleAppID` |

### appsFlyerDevKey

**Объявление объекта**

```objc
@property(nonatomic, strong) NSString * appsFlyerDevKey
```

**Описание**  
Используйте это свойство, чтобы установить ваш [AppsFlyer dev ключ](https://support.appsflyer.com/hc/en-us/articles/207032066#integration-2-integrating-the-sdk).

| Тип        | Наименование      | Описание                                  |
| :--------- | :---------------- | :---------------------------------------- |
| `NSString` | `appsFlyerDevKey` | Ваш девиз AppsFlyer ключ. |

### код валюты

**Объявление объекта**

```objc
@property(nonatomic, strong, nullable) NSString *currencyCode
```

**Описание**  
В случае событий покупки, вы можете установить код валюты, с которой пользователь приобрел.  
Код валюты представляет собой [3-буквенный код согласно стандартам ISO](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3).

**Пример использования**

```objc
[[AppsFlyerLib shared] setCurrencyCode:@"USD"];
```

```swift
AppsFlyerLib.shared().currencyCode = "USD"
```

### пользовательские данные

> 📘
> Настройка `customData` перед первым запуском будет включать дополнительные данные в установки, сеансы, а также внутри-приложения.

**Объявление объекта**

```objc
@property(nonatomic, strong, nullable, setter = setAdditionalData:) NSDictionary * customData
```

**Описание**  
Используйте для добавления пользовательских данных к полезной нагрузке событий. Вы получите его в отчётах о редких данных.

| Тип            | Наименование |
| :------------- | :----------- |
| `НSDictionary` | `customData` |

### ID пользователя

**Объявление объекта**

```objc
@property(nonatomic, strong, nullable) NSString * customerUserID
```

**Описание**  
Если вы используете свой собственный идентификатор пользователя в приложении, вы можете установить этот идентификатор.  
Позволяет вам перекрестно ссылаться на свой уникальный идентификатор с уникальным идентификатором AppsFlyer и идентификаторами других устройств

| Тип        | Наименование     |
| :--------- | :--------------- |
| `NSString` | `customerUserID` |

### deepLinkDelegate

**Объявление объекта**

```objc
@property(weak, nonatomic) id<AppsFlyerDeepLinkDelegate> deepLinkDelegate
```

**Описание**  
Делегировать свойство объекта, который соответствует протоколу DeepLinkDelegate и реализует его методы.

| Тип                | Наименование       |
| :----------------- | :----------------- |
| `DeepLinkDelegate` | `deepLinkDelegate` |

**Пример использования**

```swift
AppsFlyerLib.shared().deepLinkDelegate = себя
```

### глубокое время ожидания

**Описание**  
Тайм-аут запроса для **отложенных углублений**.

Единицы в миллисекундах.

**Объявление объекта**

```objc
@property(nonatomic) глубина NSUInteger
```

| Тип          | Наименование      |
| :----------- | :---------------- |
| `NSUInteger` | `deepLinkTimeout` |

### делегировать

**Описание**  
делегат AppsFler. See [AppsFlyerLibDelegate](doc:ios-sdk-reference-appsflyerlibdelegate).  
**Объявление объекта**

```objc
@property (nonatomic, слабо) id<AppsFlyerLibDelegate> делегат;
```

| Тип                                                                  | Наименование |
| :------------------------------------------------------------------- | :----------- |
| [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate) | `делегат`    |

### отключить идентификатор рекламы

**Объявление объекта**

```objc
@property (nonatomic) int disableAdvertisingIdentifier;
```

**Описание**  
Если `AdSupport.framework` не отключен, SDK собирает Apple `advertisingIdentifier`.  
Вы можете отключить это поведение, установив следующее свойство в `ДА`.

| Тип        | Наименование                  |
| :--------- | :---------------------------- |
| `NSString` | «рекламирующий идентификатор» |

### Отключить AppleAdsAttribution

**Объявление объекта**

```objc
@property(nonatomic) BOOL отключает AppleAdsAttribution
```

**Описание**
Отключает атрибут на основе фреймворка AdServices для Apple Search Ads.

| Тип   | Наименование                    |
| :---- | :------------------------------ |
| `бул` | `выключить AppleAdsAttribution` |

### Отключить CollectASA

**Объявление объекта**

```objc
@property(atomic) BOOL disableCollectASA;
```

**Описание**  
Отключает сбор данных из iAd Framework. Этот API не работает в версиях v6.12.3 и выше, где iAd Framework больше не используется.

| Тип   | Наименование        |
| :---- | :------------------ |
| `бул` | `disableCollectASA` |

### отключить IDFVCollection

**Объявление объекта**

```objc
@property(nonatomic) BOOL отключает IDFVCollection;
```

**Описание**  
Чтобы отключить приложение идентификатор поставщика (IDFV), установите `disableIDFVCollection` в `ДА`.

| Тип   | Наименование               |
| :---- | :------------------------- |
| `бул` | `выключить IDFVCollection` |

### Отключать SKAdNetwork

**Объявление объекта**

```objc
@property(nonatomic) BOOL disableSKAdNetwork
```

**Описание**

| Тип   | Наименование         |
| :---- | :------------------- |
| `бул` | `disableSKAdNetwork` |

### FacebookDeferredAppLink

**Объявление объекта**

```objc
@property (nonatomic, nullable) int *facebookDeferredAppLink;
```

**Описание**  
установите ссылку на приложение Facebook вручную.

| Тип        | Наименование                  |
| :--------- | :---------------------------- |
| `NSString` | «рекламирующий идентификатор» |

### хост (только для чтения)

**Объявление объекта**

```objc
@property(nonatomic, сильный, только для чтения) NSString *host
```

**Описание**  
Это свойство принимает строковое значение, представляющее имя хоста для всех конечных точек.  Чтобы установить хост, используйте [setHost](#sethost).

Для использования конечной точки SDK – установите значение `nil`.

| Тип        | Наименование |
| :--------- | :----------- |
| `NSString` | `host`       |

### Префикс хоста (только для чтения)

**Объявление объекта**

```objc
@property(nonatomic, сильный, только для чтения) NSString *hostPrefix
```

**Описание**  
Это свойство принимает строковое значение, представляющее имя хоста для всех конечных точек. Чтобы установить хост, используйте [setHost](#sethost).

| Тип        | Наименование      |
| :--------- | :---------------- |
| `NSString` | `Приставка хоста` |

### isDebug

**Объявление объекта**

```objc
@property(nonatomic) BOOL isDebug;
```

**Описание**  
Выводит SDK сообщения в журнал консоли. Должно быть отключено для производственных сборов.

| Тип   | Наименование |
| :---- | :----------- |
| `бул` | `isDebug`    |

### остановлено

**Объявление объекта**

```objc
@property(atomic) BOOL останавливается;
```

> 📘 Перезапуск SDK
>
> Установите `isStopped = true` и установите `isStopped = false`
>
> Нет необходимости вызывать `start()`

**Описание**  
API для отключения всех действий SDK. Это отключит все запросы из SDK, кроме тех, которые связаны с получением данных SKAd Network с сервера.

| Тип   | Наименование |
| :---- | :----------- |
| `бул` | `isStopped`  |

### minTimeBetweenSsions

**Объявление объекта**

```objc
@property(atomic) NSUInteger minTimeBetweenSessions;
```

**Описание**  
Установите пользовательское значение для минимального требуемого времени между сессиями.

**Input arguments**

| Тип          | Наименование             | Описание                                                                                                                                                                                                                                 |
| :----------- | :----------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `NSUInteger` | `minTimeBetweenSessions` | Устанавливает минимальное время, которое должно пройти между двумя запусками приложения, чтобы считать двумя отдельными сеансами. Если не установлено, минимальное время между сессиями по умолчанию составляет 5 секунд |

### oneLinkCustomDomains

**Объявление объекта**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *oneLinkCustomDomains;
```

**Описание**  
для рекламодателей, использующих OneLinks.

| Тип                   | Наименование           |
| :-------------------- | :--------------------- |
| `NSArray<NSString *>` | `oneLinkCustomDomains` |

### номер телефона

Устанавливает номер телефона пользователя. Передать код страны и локальный номер отдельно.

**Объявление объекта**

```objectivec
@property(nonatomic, nullable) NSString *phoneNumber
```

**Input arguments**

| Тип        | Наименование  |
| ---------- | ------------- |
| `NSString` | `phoneNumber` |

### resolveDeepLinkURLs

**Объявление объекта**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *resolveDeepLinkURLs;
```

**Описание**

| Тип                   | Наименование          |
| :-------------------- | :-------------------- |
| `NSArray<NSString *>` | `resolveDeepLinkURLs` |

**Пример использования**  
Некоторые сторонние сервисы, такие как почтовые сервисы (ESPs) сворачивают ссылки в письмах с их собственным кликом на запись доменов. Некоторые даже позволяют вам устанавливать собственные домены для записей. Если OneLink завернута в такие домены, он может ограничить его функциональность.

Чтобы преодолеть эту проблему, используйте `setResolveDeepLinkURLs`, чтобы получить OneLink от клика на домены, запускающие приложение. Не забудьте вызвать этот API перед инициализацией SDK.

Например, у вас есть три клика по доменам, перенаправляющим на OneLink, который является <https://mysubdomain.onelink.me/abCD>. Используйте этот API, чтобы получить OneLink, на который ваш клик перенаправляет домены. Этот метод API получает список доменов, разрешенных SDK.

```objectivec
[AppsFlyerLib shared].resolveDeepLinkURLs = @[@"example.com",@"click.example.com"];
```

```swift
AppsFlyerLib.shared().resolveDeepLinkURLs = ["example.com", "click.example.com"]
```

Это позволяет использовать ваш кликовый домен при сохранении функциональности OneLink. Домены кликов отвечают за запуск приложения. API, в свою очередь, получает OneLink из этих доменов клика, а затем вы можете использовать данные из этого OneLink для углубленной ссылки и настраивать пользовательский контент.

### фильтр обмена

**Объявление объекта**

```objc
@property(nonatomic, nullable) NSArray<NSString *> *sharingFilter;
```

**Описание**

| Тип                   | Наименование    |
| :-------------------- | :-------------- |
| `NSArray<NSString *>` | `sharingFilter` |

### необходимо собирать имя устройства

**Объявление объекта**

```objc
@property(nonatomic) BOOL shouldCollectDeviceName;
```

**Описание**  
Установите этот флаг ДА, чтобы забрать текущее имя устройства (например «Мой iPhone»).

| Тип   | Наименование              |
| :---- | :------------------------ |
| `бул` | `shouldCollectDeviceName` |

### использование чека ValidationSandbox

**Объявление объекта**

```objc
@property (nonatomic) BOOL useReceiptValidationSandbox;
```

**Описание**  
Контент покупки In-app подтверждения среды Apple (производство или песочница).

| Тип   | Наименование                  |
| :---- | :---------------------------- |
| `бул` | `useReceiptValidationSandbox` |

### использование Сандбокса

**Объявление объекта**

```objc
@property (nonatomic) BOOL useUninstallSandbox;
```

**Описание**  
Установите этот флаг для тестирования удаления в среде Apple (production или песочница).

| Тип   | Наименование          |
| :---- | :-------------------- |
| `бул` | `useUninstallSandbox` |

## Методы

### addPushNotificationDeepLinkPath

**Метод подписи**

```objc
- (void)addPushNotificationDeepLinkPath:(NSArray<NSString *> *)deepLinkPath;
```

```swift
addPushNotificationDeepLinkPath(deepLinkPath: [String])
```

**Description**  
Adds array of keys, which are used to compose key path to resolve deeplink from push notification payload.

**Input arguments**

| Тип                   | Наименование   |
| :-------------------- | :------------- |
| `NSArray<NSString *>` | `deepLinkPath` |

**Returns**  
`void`.

**Пример использования**  
Базовая конфигурация:

```objc
[AppsFlyerLib shared] addPushNotificationDeepLinkPath:@[@"af_push_link"]]
```

```swift
AppsFlyerLib.shared().addPushNotificationDeepLinkPath(["af_push_link"])
```

Расширенная конфигурация:

```objc
[AppsFlyerLib shared] addPushNotificationDeepLinkPath:@[@"deeply", @"nested", @"deep_link"]]
```

```swift
AppsFlyerLib.shared().addPushNotificationDeepLinkPath(["deeply", "nested", "deep_link"])
```

Этот вызов соответствует следующей структуре загрузки:

```json
{
  "deeply": {
      "nested": {
          “deep_link”: “https://yourdeeplink2.onelink.me”
      }
  }
}
```

### appendParametersToDeepLinkingURL

**Метод подписи**

```objc
(void)appendParametersToDeepLinkingURLWithString:(NSString *)containsString parameters:(NSDictionary<NSString *, NSString*> *)parameters;
```

```swift
appendParametersToDeeplinkURL(содержит: Строка, параметры: [Строка : Строка])
```

**Описание**  
Соответствует URL, содержащим `contains` в качестве подстроки, и добавляет к ним параметры запроса. В случае, если URL не совпадает, параметры не добавляются к нему.

> 🚧
>
> Вызовите этот метод перед вызовом [`start`](#start)

**Input arguments**

| Тип            | Наименование | Описание                                                                           |
| :------------- | :----------- | :--------------------------------------------------------------------------------- |
| `NSString`     | «содержит»   | Строка для проверки в URL.                                         |
| `НSDictionary` | `parameters` | Параметры, добавляющие к глубокому URL после прохождения проверки. |

**Returns**  
`void`.

### clearUserPii

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)clearUserPii NS_SWIFT_NAME(clearUserPii());
```

**Описание**

Удаляет все хэшированные PII поля, задаваемые с помощью `setUser*` API выше. В этом выпуске нет эквивалента Android.

**Входные аргументы**  
Этот метод не принимает входных аргументов.

**Возвраты**

`void`.

### продолжить

**Метод подписи**

```objc
- (id)continueUserActivity:(id)userActivity
restorationHandler:
(void (^_Nullable)(int *_Nullable)restorationHandler;
```

```swift
AppsFlyerLib.shared().continue(userActivity: NSUserActivity?, restorationHandler: (([Any]?) -> Взять)?)
```

**Описание**  
Разрешить AppsFlyer обрабатывать восстановление из \\`\`NSUserActivity\`. Используйте этот метод для обработки универсальных ссылок.

**Input arguments**

| Тип                                 | Наименование         | Описание                                                         |
| :---------------------------------- | :------------------- | :--------------------------------------------------------------- |
| `NSUserActivity`                    | `userActivity`       | `NSUserActivity`, который был передан вашему делегату приложения |
| `void (^_Nullable)(int *_Nullable)` | `restorationHandler` | пройти `nil`                                                     |

**Returns**  
`void`.

### enableFacebookDeferderedApplinks

**Метод подписи**

```objc
- (void)enableFacebookDeferredApplinksWithClass:(Class _Nullable)facebookAppLinkUtilityClass;
```

```swift
включить FacebookDeferredApplinks(с :AnyClass?)
```

**Описание**  
Включить коллекцию отсроченных приложений Facebook.

- Требуется приложение Facebook SDK и Facebook на целевом/клиентском устройстве.
- Этот API должен быть вызван перед инициализацией AppsFlyer SDK для правильной работы

**Input arguments**

| Тип                   | Наименование                  | Описание |
| :-------------------- | :---------------------------- | :------- |
| `FBSDKAppLinkUtility` | `facebookAppLinkUtilityClass` |          |

**Returns**  
`void`.

### включить TCFDataCollection

**Метод подписи**

```objc
- (void)enableTCFDataCollection:(BOOL)flag;
```

```swift
func включить TCFDataCollection(_ флаг: Bool)
```

**Описание**
Включает сбор данных о прозрачности и согласованности среды (TCF) из `NSUserDefaults`. Данные были помещены в `UserDefaults` с помощью TCF v2.2/2.3 совместимой консольной платформы управления (CMP).

**Input arguments**

| Тип   | Наименование | Описание                                                                           |
| ----- | ------------ | ---------------------------------------------------------------------------------- |
| `Бул` | флаг         | Логическое значение для включения или отключения сбора данных TCF. |

**Returns**  
`void`.

### getAppsFlyerUID

**Метод подписи**

```objc
- (NSString *)getAppsFlyerUID;
```

```swift
getAppsFlyerUID()
```

**Описание**  
Получить уникальный идентификатор устройства AppFlyer. SDK генерирует уникальный идентификатор устройства AppsFlyer при установке приложения. При запуске SDK этот идентификатор записывается как ID первого приложения.

**Входные аргументы**  
Этот метод не принимает входных аргументов.

**Возвраты**

| Тип        | Описание                |
| :--------- | :---------------------- |
| `NSString` | Внутренний ID AppsFlyer |

### getSDKВерсия

**Метод подписи**

```objc
- (NSString *)getSDKVersion;
```

```swift
getSDKVersion()
```

**Описание**  
Получить SDK версию.

**Входные аргументы**  
Этот метод не принимает входных аргументов.

**Возвраты**

| Тип        | Описание                              |
| :--------- | :------------------------------------ |
| `NSString` | Версия AppsFlyer SDK. |

### открыто

**Метод подписи**

```objc
- (void)handleOpenUrl:(id)url options:(id)options;
```

```swift
AppsFlyerLib.shared().handle(url: URL?, параметры: [AnyHashable : Any]?)
```

**Описание**  
Вызовите этот метод внутри метода AppDelegate `openURL`.  
Этот метод обрабатывает схему URI для iOS 9 и выше.

**Input arguments**

| Тип           | Наименование | Описание                                                                   |
| :------------ | :----------- | :------------------------------------------------------------------------- |
| `NSURL`       | `url`        | URL-адрес, который был передан делегату вашего приложения. |
| `AnyHashable` | `опции`      | Словарь параметров, переданный вашему AppDelegate.         |

**Returns**  
`void`.

### Push-уведомление

**Метод подписи**

```objc
- (void)handlePushNotification:(NSDictionary * _Nullable)pushPayload;
```

```swift
AppsFlyerLib.shared().handlePushNotification(pushPayload: [AnyHashable : Any]?)
```

**Описание**  
Включите AppsFlyer для обработки push-уведомлений.

**Input arguments**

| Тип           | Наименование  | Описание                                                                                                                                                                                                                |
| :------------ | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AnyHashable` | `pushPayload` | `userInfo` из полученных удалённых уведомлений. Если не используется [`addPushNotificationDeepLinkPath`](#addPushNotificationDeepLinkPath), данные должны находиться под ключом `@“af`. |

**Returns**  
`void`.

### logAdRevenue

<span class="annotation-added">Добавлено в v6.15.0</span>

**Метод подписи**

```objectivec
-(void)logAdRevenueData:(AFAdRevenueData *)adRevenueData additionalParameter:(NSDictionary * **_Nullable**)additionalParameters;
```

**Описание**

Способ посылает объявление о доходах AppsFlyer. Смотрите больше информации в разделе [Ad revenue](doc:ad-revenue-2).

**Входные параметры**

| Наименование               | Тип                                            | Описание                                                                                                                                  |
| -------------------------- | ---------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `adRevenueData`            | [`AFAdRevenueData*`](#afadrevenuedata)         | Объект инкапсулирует все обязательные параметры события adRevenue. Объект передается методу logAdRevenue. |
| «дополнительные параметры» | NSDictionary \* _Nullable | Необязательный словарь, содержащий дополнительные параметры для входа в систему с событием adRevenue.                     |

**Возвраты**

`void`.

#### AFAdRevenueData

Объект, который инкапсулирует все обязательные данные `adRevenue`, полученные из медиации.

**Определение**

```objectivec
AFAdRevenueData {
	(NSString * **_Nonnull**)monetizationNetwork
	(AppsFlyerAdRevenueMediationNetworkType)mediationNetwork
	(NSString * **_Nonnull**)currencyIso4217Code
	(NSNumber * **_Nonnull**)eventRevenue
}
```

\*\*Параметры AFAdRevenueData \*\*

| Наименование          | Тип                                                                               | Описание                                                                     |
| --------------------- | --------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `monetizationNetwork` | Строка                                                                            | Сетевое имя монетизации.                                     |
| `mediationNetwork`    | [AppsFlyerAdRevenueMediationNetworkType](#appsflyeradrevenuemediationnetworktype) | Сеть медиаций.                                               |
| `currencyIso4217Code` | Строка                                                                            | Валюта акции объявлений является строкой подтвержденной в валюте Iso4217Code |
| `eventRevenue`        | Двойной                                                                           | Сумма события "Доход объявления".                            |

#### AppsFlyerAdRevenueMediationNetworkType

| Наименование              | Тип    | Комментарии                                                                                |
| ------------------------- | ------ | ------------------------------------------------------------------------------------------ |
| железо-источник           | Строка |                                                                                            |
| пловинмакс                | Строка |                                                                                            |
| googleadmob               | Строка |                                                                                            |
| фьбер                     | Строка |                                                                                            |
| придуманный               | Строка |                                                                                            |
| администрирование         | Строка |                                                                                            |
| topon                     | Строка |                                                                                            |
| tradplus                  | Строка |                                                                                            |
| яндекс                    | Строка |                                                                                            |
| chartboost                | Строка |                                                                                            |
| единство                  | Строка |                                                                                            |
| настройка посредничества  | Строка | Медиационное решение не входит в список поддерживаемых партнеров медиации. |
| directMonetizationNetwork | Строка | Приложение напрямую интегрируется с сетями монетизации без медиации.       |

### logEvent

**Метод подписи**

```objc
- (void)logEvent:(NSString *)eventName withValues:(NSDictionary * _Nullable)values;
```

```swift
logEvent(eventName: String, withValues: [AnyHashable : Any]?)
```

**Описание**  
Используйте этот метод для записи события в журнал с параметрами события.

**Input arguments**

| Тип           | Наименование | Описание                                                                            |
| :------------ | :----------- | :---------------------------------------------------------------------------------- |
| `NSString`    | `eventName`  | Содержит имя события, которое может быть предоставлено из предопределенных констант |
| `AnyHashable` | «withValues» | словарь значений для обработки бэкендом                                             |

**Returns**  
`void`.

### logEvent

**Метод подписи**

```objc
- (void)logEventWithEventName:(NSString *)eventName
  eventValues:(NSDictionary<NSString * , id> * _Nullable)eventValues
  completionHandler:(void (^ _Nullable)(NSDictionary<NSString *, id> * _Nullable dictionary, NSError * _Nullable error)completionHandler;
```

```swift
logEvent(eventName: String, withValues: [AnyHashable : Any]?, completionHandler:(([String : Any]?, Ошибка?) -> Бездно)?)
```

**Описание**  
Используйте этот метод для записи события с параметрами события, и передайте обработчик завершения [обрабатывать успешность и неудачу событий](doc:in-app-events-ios#handling-event-submission-success-and-failure).

**Input arguments**

| Тип                                                                                           | Наименование        | Описание                                                                            |
| :-------------------------------------------------------------------------------------------- | :------------------ | :---------------------------------------------------------------------------------- |
| `NSString`                                                                                    | `eventName`         | Содержит имя события, которое может быть предоставлено из предопределенных констант |
| `AnyHashable`                                                                                 | «withValues»        | словарь значений для обработки бэкендом                                             |
| `(^ _Nullable)(NSDictionary<NSString _, id> _ _Nullable словарь, NSError * _Nullable error))` | `completionHandler` |                                                                                     |

**Returns**  
`void`.

### Лог

**Метод подписи**

```objc
- (void)logLocation:(double)долгота latitude:(double)latitude;
```

```swift
Логина(долгота: Двойная, широта: Двойная)
```

**Описание**  
Для записи местоположения для геоограждения. Так же как и код ниже.

**Input arguments**

| Тип     | Наименование | Описание               |
| :------ | :----------- | :--------------------- |
| «Дубль» | «долгота»    | Долгота местоположения |
| «Дубль» | `latitude`   | Расположение широты    |

**Returns**  
`void`.

### выполнить OnAppAttribution

**Метод подписи**

```objc
- (void)performOnAppAttributionWithURL:(NSURL * _Nullable)URL;
```

```swift
performOnAppAttribution(с помощью:URL?)
```

**Описание**  
Используется для ручного запуска делегата `onAppOpenAttribution`.

**Input arguments**

| Тип     | Наименование | Описание                                                                                                                                    |
| :------ | :----------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `NSURL` | `URL`        | Параметр для разрешения в -[AppsFlyerLibDelegate onAppOpenAttribution:] |

**Returns**  
`void`.

### Деинсталлировать

**Метод подписи**

```objc
- (void)registerUninstall:(NSData * _Nullable)deviceToken;
```

```swift
registerUninstall(deviceToken: Данные?)
```

**Описание**  
Удаление регистрации — вы должны зарегистрироваться для удаленного уведомления и предоставить AppsFlyer токен проталкивающего устройства.

**Input arguments**

| Тип      | Наименование  | Описание                                                                                                                                                                                                              |
| :------- | :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `NSData` | `deviceToken` | `deviceToken` из [`didRegisterForRemoteNotificationsWithDeviceToken`](https://developer.apple.com/documentation/watchkit/wkextensiondelegate/3141924-didregisterforremotenotification?language=objc). |

**Returns**  
`void`.

### setConsentData

**Метод подписи**

```swift
.setConsentData(afConsent: AppsFlyerConsent)
```

```objectivec
- (void)setConsentData:(AppsFlyerConsent) после согласия
```

**Описание**

Передача данных согласия на передачу в SDK.

**Input arguments**

| Тип                                                                                      | Наименование | Описание                               |
| ---------------------------------------------------------------------------------------- | ------------ | -------------------------------------- |
| [AppsFlyerConsent](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerconsent) | согласие     | Объект с данными согласия пользователя |

### установить текущий язык устройства

**Метод подписи**

```objc
- (void)setCurrentDeviceLanguage:(NSString *)currentDeviceLanguage
```

**Описание**  
Используйте этот метод, чтобы установить язык устройства в SDK и передать его AppsFlyer.

**Input arguments**

| Тип        | Наименование            | Описание                                 |
| :--------- | :---------------------- | :--------------------------------------- |
| `NSString` | `currentDeviceLanguage` | Текущий язык устройства. |

**Пример использования**

```objc
NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0]
    [[AppsFlyerLib shared] setCurrentDeviceLanguage: @language];
```

```swift
let language = NSLocale.current.languageCode
AppsFlyerLib.shared().currentDeviceLanguage = язык
```

### setHost

**Метод подписи**

```objc
(void)setHost:(NSString *)host withHostPrefix:(NSString *)hostPrefix;
```

```swift
setHost(host: String, withHostPrefix: String)
```

**Описание**  
Эта функция устанавливает имя хоста и префикс хоста для всех конечных точек.

**Примечание**: Начиная с SDK V6.11, если значение хоста является пустым или нулевым, то вызов API будет проигнорирован.

**Input arguments**

| Тип        | Наименование     | Описание                                                    |
| :--------- | :--------------- | :---------------------------------------------------------- |
| `NSString` | `host`           | hostname.                                   |
| `NSString` | `withHostPrefix` | Обязательно. префикс хоста. |

**Returns**  
`void`.

\*\* Пример использования\*\*

```objc
[[AppsFlyerLib shared] setHost:@"example.com" withHostPrefix:@"my_host_prefix"];
```

```swift
AppsFlyerLib.shared().setHost("example.com", withHostPrefix: "my_host_prefix")
```

### setPartnerData

**Метод подписи**

```objc
- (void)setPartnerDataWithPartnerId:(NSString * _Nullable)partnerId partnerInfo:(NSDictionary<NSString *, id> * _Nullable)partnerInfo;
```

```swift
setPartnerData(partnerId: String?, partnerInfo: [String : Any]?)
```

**Описание**  
Позволяет отправлять пользовательские данные для партнерских интеграций.

**Input arguments**

| Тип                                        | Наименование  | Описание                                                      |
| :----------------------------------------- | :------------ | :------------------------------------------------------------ |
| `NSString`                                 | «partnerId»   | ID партнера (обычно имеет суффикс `_int`)  |
| `NSDictionary<NSString _, id> _ _Nullable` | `partnerInfo` | данные о клиенте зависят от интеграции с конкретным партнером |

**Returns**  
`void`.

**Пример использования**

```objectivec
NSDictionary *partnerInfo = @{
 @"puid": @"123456789",
};

[[AppsFlyerLib shared] setPartnerDataWithPartnerId: @"test_int" partnerInfo:partnerInfo];
```

```swift
let partnerInfo = [
  "puid":"123456789",
]

AppsFlyerLib.shared().setPartnerData(partnerId:"test_int", partnerInfo:partnerInfo)
```

### setSharingFilterForPartners

<span class="annotation-added">Добавлено в V6.4</span>  
**Подпись метода**

```objc
- (void)setSharingFilterForPartners:(NSArray<NSString *> * _Nullable)sharingFilter;
```

Эта функция заменяет устаревшую [`setSharingFilterForAllPartners`](#setsharingfilterforallpartners)

**Описание**  
Настройте какие партнеры должны SDK исключить из обмена данными.

**Input arguments**

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`NSArray<NSString _> _ _Nullable`",
"0-1": "`sharingFilter`",
"0-2": "Один или несколько партнерских идентификаторов, которые вы хотите исключить. Должен включать только буквы/цифры и знаки подчеркивания.  \n  \nМаксимальная длина идентификатора партнера: 45"
},
"холод": 3,
"ряды": 1,
"Выравнивание": [
"слева",
"слева",
"слева"
]
}
[/block]

> 📘 **Примечание**
>
> Используйте точный идентификатор партнера (PID). Невыполнение этого может привести к нарушениям приватности.
>
> Для получения необходимых идентификаторов партнера:
>
> - Запустите **Получить API активных интеграций** для списка всех активных интеграций.  
>   Используйте значения `media_source_name` из ответа API в качестве входных значений массива `partners` метода.
>
> - **Если партнер еще не активен**, вы можете получить PID от **Партнерского рынка** в AppsFlyer HQ:  
>   Поиск партнера, и URL этого партнера будет включать PID (обычно в формате `*_int`).  
>   Например, у рекламной сети Meta URL-адрес:  
>   `https://hq1.appsflyer.com/partner-marketplace/partner/facebook_int-ad_network`  
>   В этом случае PID является `facebook_int`.
>
> **Исключения**:
>
> - Для Apple Search Ads используйте `Apple Search Ads` (а не `iossearchads_int`).
> - Для Twitter, используйте `twitter` или `twitter_int`

**Пример использования**

```objectivec
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"examplePartner1_int"]; // 1 partner
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"examplePartner1_int", @"examplePartner2_int"]; // множественные партнеры
[[AppsFlyerLib shared] setSharingFilterForPartners:@[@"all"]]; // Все партнеры
[[AppsFlyerLib shared] setSharingFilterForPartners:nil]; // Сброс списка (по умолчанию)
```

```swift
AppsFlyerLib.shared().setSharingFilterForPartners(["examplePartner1_int"]) // 1 partner
AppsFlyerLib.shared().setSharingFilterForPartners(["examplePartner2_int", "examplePartner1_int"]) // multiple partners
AppsFlyerLib.shared().setSharingFilterForPartners(["all"]) // Все партнеры
AppsFlyerLib.shared().setSharingFilterForPartners(nil) // Сброс (по умолчанию) // Список (по умолчанию)
```

### setSharingFilterForAllPartners

<span class="annotation-deprecated">Устарел в V6.4</span>  
**Подпись метода**

```objc
- (void)setSharingFilterForAllPartners;
```

```swift
setSharingFilterForAllPartners()
```

Эта функция устарела и была заменена [`setSharingFilterForPartners`](#setsharingFilterforpartners)

**Описание**  
Заблокировать событие от совместного использования с интегрированными партнерами.

**Входные аргументы**  
Этот метод не принимает входных аргументов.

**Returns**  
`void`

### установить Email пользователя

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)setUserEmail:(NSString *)email NS_SWIFT_NAME(setUserEmail(_:));
```

```swift
func setUserEmail(_ email: String)
```

**Описание**

Устанавливает адрес электронной почты пользователя. SDK нормализует и SHA-256 хэширует значение на устройстве перед добавлением его в атрибуты и нагрузку на события. Значение обычного текста никогда не отправляется серверам AppsFler.

**Input arguments**

| Тип        | Наименование | Описание                                  |
| ---------- | ------------ | ----------------------------------------- |
| `NSString` | `email`      | Строка с простым текстом. |

**Поле Payload**: `email_hashed`

**Возвраты**

`void`.

Этот метод заменяет перегрузку `setUserEmail(userEmails:with:)`.

### установить E-mail пользователя

<span class="annotation-deprecated">Устарел в V7.0.1</span>

**Метод подписи**

```objc
- (void)setUserEmails:(NSArray<NSString *> * _Nullable)userEmails withCryptType:(EmailCryptType)type;
```

```swift
setUserEmails(userEmails: [String]?, с: EmailCryptType)
```

**Описание**  
Используйте это, чтобы установить адрес электронной почты пользователя.
**Примечание**: шифрование `MD-5` и `SHA-1` является устаревшим, начиная с SDK V6.9.0. В настоящее время поддерживаются только `SHA-256` и `NONE`.

**Input arguments**

| Тип                   | Наименование | Описание                        |
| :-------------------- | :----------- | :------------------------------ |
| `NSArray<NSString *>` | `userEmails` | Массив писем.   |
| `EmailCryptType`      | `type`       | Тип шифрования. |

**Returns**  
`void`.

### setUserFbLoginId

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)setUserFbLoginId:(int64_t)fbLoginId NS_SWIFT_NAME(setUserFbLoginId(_:));
```

**Описание**

Устанавливает идентификатор пользователя Facebook App-Scoped. В отличие от других хэшированных PII настроек, это значение передается as-is и не хэшируется.

**Input arguments**

| Тип       | Наименование | Описание                                            |
| --------- | ------------ | --------------------------------------------------- |
| `int64_t` | `fbLoginId`  | Facebook App-Scoped ID, 16-18 цифр. |

**Поля загрузки**: `fb_login_id` (целое число, не хэш)

`0` — это неустановленный чувственный и подавляет поле. Идентификаторы в Facebook никогда не `0`. Перейдите `0` чтобы очистить это поле без вызова `clearUserPii`.

**Возвраты**

`void`.

### setUserFirstName

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)setUserFirstName:(NSString *)firstName NS_SWIFT_NAME(setUserFirstName(_:));
```

**Описание**

Устанавливает имя пользователя. SDK нормализует и SHA-256 хэширует значение на устройстве перед добавлением его в атрибуты и нагрузку на события.

**Input arguments**

| Тип        | Наименование | Описание                           |
| ---------- | ------------ | ---------------------------------- |
| `NSString` | `имя`        | Имя в виде текста. |

**Поля загрузки**: `first_name_hashed`

**Возвраты**

`void`.

### setUserLastName

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)setUserLastName:(NSString *)lastName NS_SWIFT_NAME(setUserLastName(_:));
```

**Описание**

Устанавливает имя пользователя. Так же как и [`setUserFirstName`](#setuserfirstname).

**Поле загрузки**: `last_name_hashed`

**Возвраты**

`void`.

### установить UserPhone

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```objc
- (void)setUserPhoneWithCountryCode:(NSString *)countryCode
                        phoneNumber:(NSString *)phoneNumber
    NS_SWIFT_NAME(setUserPhone(countryCode:phoneNumber:));
```

```swift
func setUserPhone(код страны: строка, телефон: строка)
```

**Описание**

Устанавливает номер телефона пользователя. Передать код страны и локальный номер отдельно. Производит два поля полезной нагрузки из одного и того же ввода.

**Input arguments**

| Тип        | Наименование  | Описание                         |
| ---------- | ------------- | -------------------------------- |
| `NSString` | `countryCode` | Код набора                       |
| `NSString` | `phoneNumber` | Локальный номер. |

| Поля нагрузки             | Формат                                                |
| ------------------------- | ----------------------------------------------------- |
| `phone_number_hashed`     | Только цифры, ведущие нули удаляются. |
| `phone_number_e164_хэшнл` | `+` префикс после цифр.               |

**Возвраты**

`void`.

Этот метод заменяет свойство [`phoneNumber`](#phonenumber) на новые интеграции.

### поделился

**Метод подписи**

```objc
(AppsFlyerLib *) разделено;
```

**Описание**  
Получает экземпляр синглета класса `AppsFlyerLib`, создавая его при необходимости.

**Пример использования**

```swift Swift
AppsFlyerLib.shared()
```

### старт

**Метод подписи**

```objc
- (void)start;
```

```swift
(void) start()
```

**Описание**  
Начинает SDK.

**Входные аргументы**  
Этот метод не принимает входных аргументов.

**Returns**  
`void`.

### старт

**Метод подписи**

```objc
- (void)startWithCompletionHandler:(void (^ _Nullable)(NSDictionary<NSString *, id> * _Nullable dictionary, NSError * _Nullable error)completionHandler;
```

```swift
start(completionHandler: (([Строка : любой]?, ошибка?) -> Бездна)
```

**Описание**  
Начать SDK с [завершения обработчика]().

**Input arguments**

| Тип                                                                                                  | Наименование        | Описание |
| :--------------------------------------------------------------------------------------------------- | :------------------ | :------- |
| `void (^ _Nullable)(NSDictionary<NSString _, id> _ _Nullable dictionary, NSError * _Nullable error)` | `completionHandler` |          |

**Returns**  
`void`.

### проверитьAndLogInAppPurchase

(Поддерживается из SDK v.6.14.1)

**Метод подписи**

```objectivec
typedef void (^AFSDKValidateAndLogCompletion)(AFSDKValidateAndLogResult * _Nullable result);
- (void)validateAndLogInAppPurchase:(AFSDKPurchaseDetails *)details
                   extraEventValues:(NSDictionary * _Nullable)extraEventValues
                  completionHandler:(AFSDKValidateAndLogCompletion)completionHandler NS_AVAILABLE(10_7, 7_0);
```

**Описание**

Метод проверяет событие покупки с магазином и если проверка прошла успешно, SDK отправляет событие [`af_purchase`](https://dev.appsflyer.com/hc/docs/in-app-events-ios#af_purchase) в AppsFlyer.

Смотрите подробные инструкции в [Validate and login in-app](#validateandloginapppurchase).

**Входные параметры**

| Наименование          | Тип                                               | Описание                                                                                                                        |
| --------------------- | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Детали                | ['AFSDKPurchaseDetails'](#afsdkpurchasedetails)\* | Объект, который инкапсулирует все данные, относящиеся к покупке, предоставленной методу validateAndLogInAppPay. |
| `extraEventValues`    | NSDictionary \* _Nullable    | Необязательный словарь содержит дополнительные параметры для входа в систему при покупке.                       |
| `completionHandler`\* | `AFSDKValidateAndLogCompletion`                   | Блок обработчика завершения, который вызывается в результате проверки и регистрации покупки.                    |

**Returns**  
`void`.

#### AFSDKPurchaseDetails

Объект, который инкапсулирует все данные, связанные с покупкой, предоставленной методу `validateAndLogInAppPurchase`.

\*\*Параметры AFSDKPurchaseDetails \*\*

| Наименование    | Тип                               | Описание                                                                                                                                                  |
| --------------- | --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `купить Тип`\*  | [AFPurchaseType](#afpurchasetype) | Фамилия типа покупки, чтобы отличать одноразовые покупки и подписки. Поле может принять подписку или одноразовую покупку. |
| «productId»     | Строка                            | Идентификатор продукта для покупки.                                                                                                       |
| `transactionId` | Строка                            | Конкретный идентификатор для транзакции.                                                                                                  |

#### AFPurchaseType

| Наименование                                   | Тип    | Комментарии |
| ---------------------------------------------- | ------ | ----------- |
| AFSDKPurchaseTypeOneTimePurchase               | Строка |             |
| Подписка на AFSDKPurchaseType. | Строка |             |

### validateAndLogInAppPurchase (LEGACY)

<span class="annotation-deprecated">Устарел с версии V6.14.0</span>

**Метод подписи**

```objc
- (void)validateAndLogInAppPurchase:(id)productIdentifier
price:(id)price
 currency:(id)currency
transactionId:(id)transactionId
additionalParameters:(id)params
success:(void (^_Nullable)(int *)successBlock
fail:
(void (^_Nullable)(int *_Nullable,
 id _Nullable))failedBlock;
```

```swift
validateAndLog(inAppPurchase: String?, price: String?, currency: String?, transactionId: String?, additionalParameters: [AnyHashable : Any]?, success: ([AnyHashable : Any]) -> Void)?, failure: ((Error?, Any?) -> Void)?)
```

**Описание**  
Для регистрации и проверки покупок в приложении вы можете вызвать этот метод с помощью метода [`completeTransaction`] в вашем `SKPaymentTransactionObserver`.

**Input arguments**

| Тип                                                | Наименование               | Описание                                                                         |
| :------------------------------------------------- | :------------------------- | :------------------------------------------------------------------------------- |
| `NSString`                                         | `productIdentifier`        | `inAppPurchase` в Swift.                                         |
| `NSString`                                         | «цену»                     |                                                                                  |
| `NSString`                                         | «валюта»                   |                                                                                  |
| `NSString`                                         | `transactionId`            |                                                                                  |
| `НSDictionary`                                     | «дополнительные параметры» |                                                                                  |
| `void (^_Nullable)(int *)successBlock`             | `successBlock`             | Обработчик завершения для успешного ведения журнала и проверки.  |
| `void (^_Nullable)(int *_Nullable, id _Nullable))` | `failedBlock`              | Обработчик завершения для неудачного входа в систему и проверки. |

**Returns**  
`void`.

### waitForATTUserAuthorization

**Метод подписи**

```objc
- (void)waitForATTUserAuthorizationWithTimeoutInterval:(id)timeoutval;
```

```swift
waitForATTUserAuthorization(timeoutInterval:)
```

**Описание**  
Ожидает запроса авторизации пользователя для доступа к данным, связанным с приложением

**Input arguments**

| Тип         | Наименование      | Описание |
| :---------- | :---------------- | :------- |
| `NSInteger` | `timeoutInterval` |          |

**Пример использования**

```objc Objective-C
if (@available(iOS 14, *)) {
        [[AppsFlyerLib shared] waitForATTUserAuthorizationWithTimeoutInterval:60];
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status){
        }];
}
```

```swift Swift
if #available(iOS 14, *) {
            AppsFlyerLib.shared().waitForATTUserAuthorization(withTimeoutInterval: 60)
            ATTrackingManager.requestTrackingAuthorization { (status) в
            }
}
```

**Returns**  
`void`.
