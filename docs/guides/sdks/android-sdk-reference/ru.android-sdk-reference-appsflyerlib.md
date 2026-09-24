---
title: AppsFlyerLib
slug: android-sdk-reference-appsflyerlib
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

## Общий обзор

`AppsFlyerLib` является основным классом AppsFlyer Android SDK и инкапсулирует большинство методов.

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).

#### Импорт библиотеки

```java
импортировать com.appsflyer.AppsFlyerLib;
```

#### Доступ к экземпляру SDK

Доступ к экземпляру синглтона SDK:

```java
AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
```

## Методы

### addPushNotificationDeepLinkPath

**Метод подписи**

```java
void addPushNotificationDeepLinkPath(java.lang.String... deepLinkPath)
```

**Описание**  
Настраивает, как SDK извлекает глубокие значения ссылок из push-уведомления приложений.

**Input arguments**

| Тип         | Наименование   | Описание                                                                          |
| :---------- | :------------- | :-------------------------------------------------------------------------------- |
| `Строка...` | `deepLinkPath` | Массив «Строки», который соответствует пути JSON глубокой ссылки. |

**Returns**  
`void`.

**Пример использования**  
Базовая конфигурация:

```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link");
```

```kotlin
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link")
```

Расширенная конфигурация:

```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("deeply", "nested", "deep_link");
```

```kotlin
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("deeply", "nested", "deep_link")
```

Этот вызов соответствует следующей структуре загрузки:

```json
{
  "deeply": {
    "nested": {
      "deep_link": "https://yourdeeplink2.onelink.me"
    }
  }
}
```

### анонимизировать пользователя

**Метод подписи**

```java
void anonymizeUser(boolean shouldAnonymize)
```

**Description**  
Anonymize a user's installs, events, and sessions.

**Input arguments**

| Тип       | Наименование      | Описание                              |
| :-------- | :---------------- | :------------------------------------ |
| `boolean` | `shouldAnonymize` | По умолчанию `false`. |

**Returns**  
`void`

**Пример использования**

```java
AppsFlyerLib.getInstance().anonymizeUser(true);
```

```kotlin
AppsFlyerLib.getInstance().anonymizeUser(true)
```

### appendParametersToDeepLinkingURL

**Метод подписи**

```java
void appendParametersToDeepLinkingURL(java.lang.String содержит,
                                                      java.util.Map<java.lang.String,java.lang.String>)
```

**Описание**  
Позволяет владельцам приложений, используя App Links для глубокой связи (без OneLink) с атрибутическими сессиями, инициированными через домен, связанный с их приложением.

> 🚧
>
> Вызовите этот метод перед вызовом [`start`](#start)

Вы должны предоставить следующие параметры в `Map`:

- `pid`
- `is_retargeting` должен быть установлен в `true`

**Input arguments**

| Тип                   | Наименование | Описание                                                       |
| :-------------------- | :----------- | :------------------------------------------------------------- |
| `Строка`              | `contains `  | Строка, содержащаяся в глубоком URL ссылки                     |
| `Map<String, String>` | `parameters` | Параметры атрибутов, добавляемые к соответствующим URL-адресам |

**Returns**  
`void`

**Пример использования**

```java
HashMap<String, String> urlParameters = new HashMap<>();
urlParameters.put("pid", "exampleDomain"); // Обязательные
urlParameters.put("is_retargeting", "true"); // Обязательные
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com", urlParameters);
```

```kotlin
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com",
mapOf("pid" к "exampleDomain", "is_retargeting" к "true")) // Требуется
```

В приведенном выше примере URL атрибуции, отправленный на серверы AppsFly:

```
example.com?pid=exampleDomain&is_retargeting=true
```

### выключить AppSetId

<span class="annotation-added">Добавлено в v6.17.0</span>

**Метод подписи**

```java
void disableAppSetId()
```

**Описание**
Отключите коллекцию ID AppSet.

**Returns**
`void`

### включить FacebookDeferredApplinks

**Метод подписи**

```java
void enableFacebookDeferredApplinks(boolean isabed)
```

**Описание**  
Включить коллекцию отсроченных приложений Facebook. Требуется приложение Facebook SDK и Facebook на целевом/клиентском устройстве.

Этот API должен быть вызван перед инициализацией AppsFlyer SDK для правильной работы.  
**Input arguments**

| Тип       | Наименование  | Описание                                                                           |
| :-------- | :------------ | :--------------------------------------------------------------------------------- |
| `boolean` | `не включена` | Если отсроченные приложения Facebook обрабатываются AppsFlyer SDK. |

**Returns**  
`void`

### включить Подборку Местов

<span class="annotation-removed">удалён в V6.8.0</span>

**Метод подписи**

```java
AppsFlyerLib включён LocationCollection(логический флаг)
```

**Описание**  
Включите AppsFlyer SDK для сбора последнего известного местоположения. Требуется права доступа `ACCESS_COARSE_LOCATION` и манифеста `ACCESS_FINE_LOCATION`.

**Input arguments**

| Тип       | Наименование | Описание |
| :-------- | :----------- | :------- |
| `boolean` | `флаг`       |          |

**Returns**  
`void`

### включить TCFDataCollection

**Метод подписи**

```java
AppsFlyerLib включён TCFDataCollection (логический флаг)
```

**Описание**

Включите сбор данных о прозрачности и согласованности среды (TCF) из «SharedPreferences». Данные были помещены в «SharedPreferences» устройством TCF v2.2/2.3 совместимой консольной платформы управления (CMP).

**Input arguments**

| Тип     | Наименование | Описание                                                                                                                                                                                                                 |
| ------- | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| boolean | флаг         | Логическое значение для включения (`true`) или отключения (`false`) коллекции данных TCF. SDK собирает данные TCF, когда флаг установлен в «true». |

**Returns**
`void`

### getAppsFlyerUID

**Метод подписи**

```java
java.lang.String getAppsFlyerUID(контекст)
```

**Описание**  
Получить уникальный идентификатор устройства AppFlyer. SDK генерирует уникальный идентификатор устройства AppsFlyer при установке приложения. При запуске SDK этот идентификатор записывается как ID первого приложения.

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| «Контекст» | `context `   | Контекст приложения / Активности. |

**Returns**  
AppsFlyer's unique device ID.

**Пример использования**

```java Java
Строка appsFlyerId = AppsFlyerLib.getInstance().getAppsFlyerUID(это);
```

```kotlin Kotlin
Строка appsFlyerId = AppsFlyerLib.getInstance().getAppsFlyerUID(это)
```

### getAttributionId

**Метод подписи**

```java
java.lang.String getAttributionId(контекст)
```

**Описание**  
Получить идентификатор атрибута Facebook, если таковой существует.

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| «Контекст» | `context`    | Контекст приложения / Активности. |

**Returns**  
`void`

**Пример использования**

```java Java
ID строки = AppsFlyerLib.getInstance().getAttributionId(this);
```

```kotlin Kotlin
ID строки = AppsFlyerLib.getInstance().getAttributionId(this)
```

### getHostName

**Метод подписи**

```java
java.lang.String getHostName()
```

**Описание**  
Получить имя хоста.  
Значение по умолчанию: "appsflyer.com"

**Входные аргументы**  
Эта функция не принимает параметров.

**Возвраты**

| Тип      | Описание                               |
| :------- | :------------------------------------- |
| `Строка` | Установка имени хоста. |

**Пример использования**

### getHostPrefix

**Метод подписи**

```java
java.lang.String getHostPrefix()
```

**Описание**  
Получить пользовательский префикс хостов.

**Входные аргументы**  
Эта функция не принимает параметров.

**Возвраты**  
префикс хоста.

### getInstance

**Метод подписи**

```java
AppsFlyerLib getInstance()
```

**Описание**  
возвращает экземпляр SDK, с помощью которого вы можете получить доступ к методам, описанным в этом документе.

**Входные аргументы**  
Эта функция не принимает параметров.

**Возвращает**  
AppsFlyerLib экземпляр синглтона.

### getOutOfStore

**Метод подписи**

```java
java.lang.String getOutOfStore(контекст)
```

**Description**  
Get the third-party app store referrer value.

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| «Контекст» | `context `   | Контекст приложения / Активности. |

**Returns**  
`AF_Store` value.

### getSdkVersion

**Метод подписи**

```java
java.lang.String getSdkVersion()
```

**Описание**  
Получить версию AppsFlyer SDK, используемую в приложении.

**Входные аргументы**  
Эта функция не принимает параметров.

**Возвраты**  
AppsFlyer SDK версии.

### init

**Метод подписи**

```java
AppsFlyerLib init(java.lang.String key,
                                  AppsFlyerConversionListener conversionDataListener,
                                  Контекстный контекст)
```

**Описание**  
Используйте этот метод для инициализации AppsFlyer SDK. Этот API должен называться внутри метода «onCreate».

**Input arguments**

| Тип                               | Наименование             | Описание                                                                                                                                                                            |
| :-------------------------------- | :----------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Строка`                          | `ключ`                   | AppSFlyer dev ключ                                                                                                                                                                  |
| `AppsFlyerConversionDataListener` | `conversionDataListener` | (Необязательно) реализовать AppsFlyerConversionDataListener для доступа к данным о преобразовании AppsFlyer. Может быть нулевым. |
| «Контекст»                        | `context`                | Контекст приложения.                                                                                                                                                |

**Returns**  
`void`

**Пример использования**  
Смотрите [инициализация SDK](doc:integrate-android-sdk#initializing-the-android-sdk).

### isPreInstalledApp

**Метод подписи**

```java
boolean isPreInstalledApp(Context context)
```

**Описание**  
Boolean индикатор предварительной установки производителем.

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| «Контекст» | `context `   | Контекст приложения / Активности. |

**Returns**  
`boolean`.

**Пример использования**

### остановлено

**Метод подписи**

```java
boolean isStopped()
```

**Описание**  
Проверьте, было ли остановлено SDK.

**Входные аргументы**  
Эта функция не принимает параметров.

**Возвраты**

| Тип        | Описание                                               |
| :--------- | :----------------------------------------------------- |
| `boolean ` | `true` если остановлен, `false` иначе. |

**Пример использования**

### logAdRevenue

<span class="annotation-added">Добавлено в v6.15.0</span>
**Способная подпись**

```java

публичный абстрактный отказ logAdRevenue(
            @NonNull AFAdRevenueData adRevenueData, 
            @Nullable Map<String, Object> additionalParameters
);
```

**Описание**

Способ посылает объявление о доходах AppsFlyer. Смотрите больше информации в разделе [Ad revenue](doc:ad-revenue-1).

**Входные параметры**

| Наименование               | Тип                                            | Описание                                                                                                                                  |
| -------------------------- | ---------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `adRevenueData`            | [`AFAdRevenueData`](#afadrevenuedata)          | Объект инкапсулирует все обязательные параметры события adRevenue. Объект передается методу logAdRevenue. |
| «дополнительные параметры» | Карта<String, Object> | Необязательный словарь, содержащий дополнительные параметры для входа в систему с событием adRevenue.                     |

**Возвраты**

`void`.

#### AFAdRevenueData

Объект, который инкапсулирует все обязательные данные `adRevenue`, полученные из медиации.

**Определение**

```kotlin
data class AFAdRevenueData(
    val monetizationNetwork: String,
    val mediationNetwork: MediationNetwork,
    val currencyIso4217Code: String,
    val revenue: Double
)
```

\*\*Параметры AFAdRevenueData \*\*

| Наименование          | Тип                                     | Описание                                                                     |
| --------------------- | --------------------------------------- | ---------------------------------------------------------------------------- |
| `monetizationNetwork` | Строка                                  | Сетевое имя монетизации.                                     |
| `mediationNetwork`    | [`MediationNetwork`](#mediationnetwork) | Сеть медиаций.                                               |
| `currencyIso4217Code` | Строка                                  | Валюта акции объявлений является строкой подтвержденной в валюте Iso4217Code |
| `revenue`             | Двойной                                 | Сумма события "Доход объявления".                            |

#### Медиасеть

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

```java
void logEvent(Context context,
                              java.lang.String eventName,
                              java.util.Map<java.lang.String,java.lang.Object>eventValues)
```

**Описание**  
Войти в приложение.

**Input arguments**

| Тип        | Наименование   | Описание                       |
| :--------- | :------------- | :----------------------------- |
| «Контекст» | `context `     | Контекст приложения / действия |
| `Строка`   | `eventName `   | Название события               |
| `Карта`    | `eventValues ` | Значения событий               |

**Returns**  
`void`

**Пример использования**

### logEvent

**Метод подписи**

```java
void logEvent(Context context,
                              java.lang.String eventName,
                              java.util.Map<java.lang.String,java.lang.Object>eventValues,
                              AppsFlyerRequestListener слушателю)
```

**Описание**  
так же, как logEvent, с AppsFlyerRequestListener. `HttpURLConnection.HTTP_OK` с сервера  
вызовет метод AppsFlyerRequestListener#onSuccess()  
. AppsFlyerRequestListener#onError(int, String) вернет  
в случае возникновения ошибки

**Входные аргументы**  
Эта функция не принимает параметров.  
**Returns**  
`void`

**Пример использования**

### Лог

**Метод подписи**

```java
void logLocation(Context context
                                 double latitude,
                                 double longitude)
```

**Описание**  
Ручной журнал местоположения пользователя.

Этот метод создает событие `af_location_coordinates` внутри приложения с параметрами события `af_lat` и `af_long`.

**Input arguments**

| Тип         | Наименование | Описание                       |
| :---------- | :----------- | :----------------------------- |
| «Контекст»  | `context `   | Контекст приложения / действия |
| `удваивать` | «широта»     | Широта                         |
| `удваивать` | «Долгота »   | Долгота                        |

**Returns**  
`void`

**Пример использования**

### logSession

**Метод подписи**

```java
void logSession(Context ctx)
```

**Описание**  
Если ваше приложение является фоновой утилитой, вы можете использовать этот API в onCreate() вашей деятельности для ручного ведения журнала и отправки сеанса.

**Input arguments**

| Тип        | Наименование | Описание                       |
| :--------- | :----------- | :----------------------------- |
| «Контекст» | `ctx`        | Контекст приложения / действия |

**Пример использования**

```java Java
публичная logSession(контекст контекста);
```

```kotlin Kotlin
публичная сессия void logSession(контекст)
```

**Returns**  
`void`

### onPause

**Метод подписи**

```java
void onPause(контекст)
```

**Описание**  
Для платформы Cocos2dx только  
Cocos2dx имеет свое собственное приложениеDidEnterBackground событие.  
Поэтому 'onPause' будет вызван JNI с C++

**Input arguments**

| Тип        | Наименование | Описание                       |
| :--------- | :----------- | :----------------------------- |
| «Контекст» | `context `   | Контекст приложения / действия |

**Returns**  
`void`

**Пример использования**

### выполнить OnAppAttribution

<span class="annotation-deprecated">Устарел с V6.3.2</span>  
**Способ подписи**

```java
void performOnAppAttribution(Context context,
                                             java.net.URI link)
```

**Описание**  
Используется для ручного разрешения глубинных ссылок.

**Input arguments**

| Тип            | Наименование | Описание                       |
| :------------- | :----------- | :----------------------------- |
| «Контекст»     | `context `   | Контекст приложения / действия |
| `java.net.URI` | `link `      | Ссылка для разрешения          |

**Returns**  
`void`

**Пример использования**

```java Java
AppsFlyerLib.getInstance().performOnAppAttribution(context uri);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().performOnAppAttribution(context uri)
```

### performOnDeepLinking

<span class="annotation-added">Added in V6.3.1+</span>

**Метод подписи**

```java
 public void performOnDeepLinking(@NonNull Intent intent, @NonNull Context);
```

**Описание**  
Включает ручной вызов глубокого разрешения ссылок. Этот метод позволяет приложениям, которые задерживают вызов, начать разрешать глубокие ссылки до запуска SDK.

- Если зарегистрирован `DeepLinkListener`, поддерживает как отложенные, так и прямые глубокие связи
- Если `AppsFlyerConversionListener` зарегистрирован, поддерживается только глубокая прямая связь

Рекомендуется назвать это из "onResume" "Activity" для мероприятий, которые могут быть запущены с помощью глубоких связей.  
**Примечание**: Прямые глубокие ссылки, обработанные этим API, не будут доведены до сведения сервера.

**Пример использования**

```java
@Override
protected void onResume() {
  super.onResume();

  AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
  appsflyer.performOnDeepLinking(getIntent(),this);
}
```

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| `Intent`   | `intent `    |                                                   |
| «Контекст» | `context `   | Контекст приложения / Активности. |

**Returns**  
`void`

### зарегистрировать ConversionListener

**Метод подписи**

```java
void registerConversionListener(Контекстный контекст,
                                                AppsFlyerConversionListener conversionDataListener)
```

**Описание**  
Зарегистрировать [слушателя данных преобразования](doc:conversion-data-android). Вы также можете использовать [`init`](#init) для регистрации слушателя.

**Input arguments**

| Тип                           | Наименование             | Описание                                                              |
| :---------------------------- | :----------------------- | :-------------------------------------------------------------------- |
| «Контекст»                    | `context `               | Контекст приложения / Активности.                     |
| `AppsFlyerConversionListener` | `conversionDataListener` | Объект `AppsFlyerConversionListener` для регистрации. |

**Returns**  
`void`

**Пример использования**

```java Java
// conversionDataListener является объектом типа AppsFlyerConversionListener.
AppsFlyerLib.getInstance().registerConversionListener(getApplicationContext(), conversionDataListener);
```

```kotlin Kotlin
// преобразование DataListener является объектом типа AppsFlyerConversionListener.
AppsFlyerLib.getInstance().registerConversionListener(getApplicationContext(), conversionDataListener)
```

Вот [пример реализации](doc:conversion-data-android#organic-vs-non-organic-conversions) из `AppsFlyerConversionListener`.

### registerValidatorListener (LEGACY)

**Метод подписи**

```java
void registerValidatorListener(Контекст,
                                               AppsFlyerInAppPurchaseValidatorListener validationListener)
```

**Описание**  
Зарегистрируйте прослушиватель проверки API `validateAndLogInAppPurchase`.

**Input arguments**

| Тип                                       | Наименование         | Описание                                                                          |
| :---------------------------------------- | :------------------- | :-------------------------------------------------------------------------------- |
| «Контекст»                                | `context`            | Контекст приложения / Активности.                                 |
| `AppsFlyerInAppPurchaseValidatorListener` | `validationListener` | Объект `AppsFlyerInAppPurchaseValidatorListener` для регистрации. |

**Returns**  
`void`

**Пример использования**

### sendAdRevenue (LEGACY)

<span class="annotation-deprecated">Устарел в версии 6.15.0</span>

(Поддерживается до SDK v6.14.2 Для версий, включая v6.15.0, используйте [`logAdRevenue`](#logadrevenue))

**Метод подписи**

```java
void sendAdRevenue(Контекст,
                                   java.util.Map<java.lang.String,java.lang.Object>eventValues)
```

**Описание**

**Input arguments**

| Тип                   | Наименование         | Описание                                          |
| :-------------------- | :------------------- | :------------------------------------------------ |
| «Контекст»            | `context`            | Контекст приложения / Активности. |
| `Map<String, Object>` | `validationListener` |                                                   |

**Returns**  
`void`

### sendPushNotificationData

**Метод подписи**

```java
void sendPushNotificationData(Активность)
```

**Description**  
Measure and get data from push-notification campaigns. Вызовите этот метод внутри метода `onCreate` из push-уведомлений "Activity".

**Input arguments**

| Тип          | Наименование | Описание                                                               |
| :----------- | :----------- | :--------------------------------------------------------------------- |
| `Активность` | `activity`   | `Activity`, который запускается с помощью уведомления. |

**Returns**  
`void`.

### setAdditionalData

> 📘
> Calling `setAdditionalData` before first launch will have the additional data included in installs, sessions, as well as in-app events.

**Метод подписи**

```java
void setAdditionalData(java.util.Map<java.lang.String,java.lang.Object>customData)
```

**Описание**  
Используйте для добавления пользовательских данных к полезной нагрузке событий. Она появится в ретро-отчетах.  
**Input arguments**

| Тип       | Наименование | Описание |
| :-------- | :----------- | :------- |
| `HashMap` | `customData` |          |

**Returns**  
`void`.

### setAndroidIdData

**Метод подписи**

```java
void setAndroidIdData(java.lang.String aAndroidId)
```

**Описание**  
По умолчанию, IMEI и Android ID не собираются SDK, если версия Android выше, чем KitKat (4. ) и устройство содержит Google Play Services. Используйте этот API для явной отправки Android ID AppsFlyer.

**Input arguments**

| Тип      | Наименование | Описание                               |
| :------- | :----------- | :------------------------------------- |
| `Строка` | `aAndroidId` | ID устройства Android. |

**Returns**  
`void`

### setAppId

**Метод подписи**

```java
void setAppId(java.lang.String id)
```

**Описание**

**Input arguments**

| Тип      | Наименование | Описание                        |
| :------- | :----------- | :------------------------------ |
| `Строка` | `id`         | Android App ID. |

**Returns**  
`void`

### setAppInviteOneLink

**Метод подписи**

```java
void setAppInviteOneLink(java.lang.String oneLinkId)
```

**Описание**  
Установите идентификатор OneLink, который должен использоваться для атрибуции приглашения пользователя. Ссылка, созданная для приглашения пользователя будет использовать эту OneLink в качестве базовой ссылки. См. [установка атрибута приглашения пользователя в OneLink](https://support.appsflyer.com/hc/en-us/articles/115004480866-User-invite-attribution-#setting-onelink).

**Input arguments**

| Тип      | Наименование | Описание                                                              |
| :------- | :----------- | :-------------------------------------------------------------------- |
| `Строка` | `oneLinkId`  | ID OneLink, полученный из панели управления AppsFler. |

**Returns**  
`void`.

### setCollectAndroidID

**Метод подписи**

```java
void setCollectAndroid(boolean isCollect)
```

**Описание**  
Опция к коллекции Android ID. Принудительно собирать Android ID.

**Input arguments**

| Тип       | Наименование | Описание                                        |
| :-------- | :----------- | :---------------------------------------------- |
| `boolean` | `isCollect`  | Установите в `true` как opt-in. |

**Returns**  
`void`.

### setCollectIMEI

**Метод подписи**

```java
void setCollectIMEI(boolean isCollect)
```

**Описание**  
Опция к набору IMEI. Принуждает SDK собирать IMEI.

**Input arguments**

| Тип       | Наименование | Описание                                        |
| :-------- | :----------- | :---------------------------------------------- |
| `boolean` | `isCollect`  | Установите в `true` как opt-in. |

**Returns**  
`void`.

### setCollectOaid

**Метод подписи**

```java
void setCollectOaid(boolean isCollect)
```

**Описание**  
Отмена/отказ от коллекции OAID. По умолчанию SDK пытается собрать ОИД.

**Input arguments**

| Тип       | Наименование | Описание                                                                                               |
| :-------- | :----------- | :----------------------------------------------------------------------------------------------------- |
| `boolean` | `isCollect`  | По умолчанию `true`. Установите значение «false» на отказ от удаления. |

**Returns**  
`void`.

### setConsentData

**Метод подписи**

```java
AppsFlyerLib.getInstance().setConsentData(AppsFlyerConsent afConsent)
```

**Описание**

Передача данных согласия на передачу в SDK.

**Input arguments**

| Тип                                                                                          | Наименование | Описание                               |
| -------------------------------------------------------------------------------------------- | ------------ | -------------------------------------- |
| [AppsFlyerConsent](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerconsent) | согласие     | Объект с данными согласия пользователя |
|                                                                                              |              |                                        |

### установить Валюту Код

**Метод подписи**

```java
void setCurrencyCode(java.lang.String currencyCode)
```

**Описание**  
Устанавливает валюту для покупок в приложении. Код валюты должен быть 3 символа ISO 4217.

**Input arguments**

| Тип      | Наименование   | Описание                                                                         |
| :------- | :------------- | :------------------------------------------------------------------------------- |
| `Строка` | `currencyCode` | 3 character ISO 4217 code. По умолчанию `"USD"`. |

**Returns**  
`void`.

### Настройка пользовательского IdAndLogSession

> ⚠️ Перед вызовом этому методу нужно вызвать метод [`waitForCustomerUserId`](#waitforcustomeruserid)

**Метод подписи**

```java
void setCustomerIdAndLogSession(java.lang.String id,
                                                контекст)
```

**Описание**  
Используйте для задания идентификатора пользователя и запустите SDK.

**Input arguments**

| Тип      | Наименование | Описание                                          |
| :------- | :----------- | :------------------------------------------------ |
| `Строка` | `id`         | ID клиента для клиента.           |
| `Строка` | `context`    | Контекст приложения / Активности. |

**Returns**  
`void`

### setCustomerID пользователя

**Метод подписи**

```java
void setCustomerUserId(java.lang.String id)
```

**Описание**  
Установка собственного ID клиента позволяет вам перекрестно ссылаться на свой уникальный идентификатор с уникальным идентификатором и идентификаторами других устройств.  
Этот ID доступен в отчетах редких данных и Postback API для перекрестной ссылки с вашими внутренними идентификаторами.

**Input arguments**

| Тип      | Наименование | Описание                                |
| :------- | :----------- | :-------------------------------------- |
| `Строка` | `id`         | ID клиента для клиента. |

**Returns**  
`void`.

### setDebugLog

**Метод подписи**

```java
void setDebugLog(boolean shouldEnable)
```

**Описание**  
Включает отладочные журналы для AppsFlyer SDK. Должно быть установлено только в среде разработки.

**Input arguments**

| Тип       | Наименование | Описание                              |
| :-------- | :----------- | :------------------------------------ |
| `boolean` | `shouldable` | По умолчанию `false`. |

**Returns**  
`void`.

**Пример использования**

### setDisableAdvertisingIdentifiers

<span class="annotation-added">Добавлено в V6.3.2</span>  
**Подпись метода**

```java
void setDisableAdvertisingIdentifiers(boolean disable);
```

**Описание**  
Отключает сбор различных рекламных идентификаторов SDK. Это включает в себя Google Advertising ID (GAID), OAID и Amazon Advertising ID (AAID).

**Input arguments**

| Тип       | Наименование | Описание                              |
| :-------- | :----------- | :------------------------------------ |
| `boolean` | `выключить`  | По умолчанию `false`. |

**Returns**  
`void`.

### настройка Отключены Сетевые Данные

<span class="annotation-added">Добавлено в V6.7.0</span>  
**Подпись метода**

```java
void setDisableNetworkData(логическое значение отключено);
```

**Описание**  
Используйте для отказа от сбора имени оператора сети (перевозчика) и имени оператора sim из устройства.

**Input arguments**

| Тип       | Наименование | Описание                              |
| :-------- | :----------- | :------------------------------------ |
| `boolean` | `выключить`  | По умолчанию `false`. |

**Returns**  
`void`.

### setExtension

**Метод подписи**

```java
void setExtension(java.lang.String расширение)
```

**Описание**  
SDK плагины и расширения устанавливают это поле.

**Input arguments**

| Тип      | Наименование | Описание                             |
| :------- | :----------- | :----------------------------------- |
| `Строка` | `расширение` | Название расширения. |

**Returns**  
`void`.

### setHost

**Метод подписи**

```java
void setHost(java.lang.String имя хоста,
                             java.lang.String hostName)
```

**Описание**  
установить свой хост. **Примечание**: Начиная SDK V6.10, если узел отправлен с пустым или нулевым значением, то вызов API игнорируется.

**Input arguments**

| Тип      | Наименование | Описание                       |
| :------- | :----------- | :----------------------------- |
| `Строка` | `Имя хоста`  | Префикс хоста. |
| `Строка` | `hostName`   | Имя хоста.     |

**Returns**  
`void`.

### setImeiData

**Метод подписи**

```java
void setImeiData(java.lang.String aImei)
```

**Описание**  
По умолчанию, IMEI и Android ID не собираются SDK, если версия ОС выше, чем KitKat (4. ) и устройство содержит Google Play Services.

**Input arguments**

| Тип      | Наименование | Описание        |
| :------- | :----------- | :-------------- |
| `Строка` | `aImei`      | IMEI устройства |

**Returns**  
`void`.

### setIsUpdate

**Метод подписи**

```java
void setIsUpdate(boolean isUpdate)
```

**Description**  
Manually set that the application was updated.

**Input arguments**

| Тип       | Наименование | Описание |
| :-------- | :----------- | :------- |
| `boolean` | `isUpdate`   |          |

**Returns**  
`void`.

### setLogLevel

**Метод подписи**

```java
void setLogLevel(AFLogger.Level loglevel)
```

**Описание**  
Установите уровень записи в SDK.

**Input arguments**

| Тип      | Наименование | Описание                         |
| :------- | :----------- | :------------------------------- |
| `Строка` | `logLevel`   | Уровень журнала. |

**Returns**  
`void`.

### setMinTimeBetweenSsions

**Метод подписи**

```java
void setMinTimeBetweenSessions(int seconds)
```

**Описание**  
Установите пользовательское значение для минимального требуемого времени между сессиями.

**Input arguments**

| Тип   | Наименование | Описание                                                                                                                                                                                                                                                     |
| :---- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `int` | `секунды`    | Устанавливает минимальное время, которое должно пройти между двумя запусками приложения, чтобы считать двумя отдельными сеансами. Если не установлено, то минимальное время между сессиями по умолчанию составляет 5 секунд. |

**Returns**  
`void`.

### setOaidData

**Метод подписи**

```java
void setOaidData(java.lang.String oaid)
```

**Описание**  
По умолчанию, OAID не собирается SDK.  Используйте этот API для явной отправки OAID AppsFlyer.

**Input arguments**

| Тип      | Наименование | Описание                         |
| :------- | :----------- | :------------------------------- |
| `Строка` | `oaid`       | Устройство OAID. |

**Returns**  
`void`.

### setOneLinkCustomDomain

**Метод подписи**

```java
void setOneLinkCustomDomain(java.lang.String... доменов)
```

**Описание**  
Для того, чтобы AppsFlyer SDK успешно обнаружил скрытые (декодированные в параметры шорт-ссылки), любой домен, который настроен в качестве фирменного домена в приборной панели AppsFlyer должен быть предоставлен этому методу.

**Input arguments**

| Тип         | Наименование | Описание                                                                                                                                               |
| :---------- | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Строка...` | `домены`     | Массив доменов, к которым SDK должен относиться как к фирменным доменам (SDK попытается разрешить их как OneLinks). |

**Returns**  
`void`.

### setOutOfStore

**Метод подписи**

```java
void setOutOfStore(java.lang.String sourceName)
```

**Описание**  
Укажите альтернативный магазин приложений, с которого скачивается приложение.

**Input arguments**

| Тип      | Наименование | Описание                                                |
| :------- | :----------- | :------------------------------------------------------ |
| `Строка` | `sourceName` | Название магазина сторонних приложений. |

**Returns**  
`void`.

**Пример использования**

```java Java
AppsFlyerLib.getInstance().setOutOfStore("baidu");
```

```kotlin Kotlin
AppsFlyerLib.getInstance().setOutOfStore("baidu")
```

### setPartnerData

**Метод подписи**

```java
void setPartnerData(@NonNull String partnerId, Map<String, Object> data);
```

**Описание**  
Позволяет отправлять пользовательские данные для партнерских интеграций.

**Input arguments**

| Тип      | Наименование | Описание                                                                                       |
| :------- | :----------- | :--------------------------------------------------------------------------------------------- |
| `Строка` | «partnerId»  | ID партнера (обычно суффикс "\_int"). |
| `Карта`  | `данные`     | Данные о клиенте зависят от конфигурации интеграции с конкретным партнером.    |

**Returns**  
`void`.

**Пример использования**

```java Java
Map<String, Object> partnerData = new HashMap();
partnerData.put("puid", "123456789");
AppsFlyerLib.getInstance().setPartnerData("test_int", partnerData);
```

```kotlin Kotlin
val partnerData = mapOf("puid" to "123456789")
AppsFlyerLib.getInstance().setPartnerData("test_int", partnerData)
```

### setPhoneНомер

<span class="annotation-removed">удалён в версии 7.0.1</span>

`setPhoneNumber` полностью удален, не является устаревшим, начиная с v7.0.1. Использующие его приложения должны мигрировать на [`setUserPhone`](#setuserphone).

### setPreinstallAttribution

**Метод подписи**

```java
void setPreinstallAttribution(java.lang.String mediaSource,
                                              java.lang.String campaign,
                                              java.lang.String siteId)
```

**Описание**  
Укажите имя производителя или источника медиа, к которому атрибут предустановки.  
**Input arguments**

| Тип      | Наименование  | Описание                                                                                      |
| :------- | :------------ | :-------------------------------------------------------------------------------------------- |
| `Строка` | `mediaSource` | Имя производителя или источника медиа для атрибута предварительной установки. |
| `Строка` | `кампания`    | Название кампании для атрибута предварительной установки.                     |
| `Строка` | `siteId`      | ID сайта для атрибута предварительной установки.                              |

**Returns**  
`void`.

### setResolveDeepLinkURLs

**Метод подписи**

```java
void setResolveDeepLinkURLs(java.lang.String... urls)
```

**Описание**  
Рекламодатели могут обернуть AppsFlyer OneLink в другую универсальную ссылку. Универсальная ссылка вызовет приложение, но все данные о ссылках не будут распространяться на AppsFlyer.

`setResolveDeepLinkURLs` позволяет настроить SDK для разрешения завернутых OneLink URL, так что глубокая ссылка может произойти правильно.

**Input arguments**

| Тип         | Наименование | Описание                                       |
| :---------- | :----------- | :--------------------------------------------- |
| `Строка...` | `urls`       | Не забудьте указать явные URL. |

**Returns**  
`void`

**Пример использования**

```java
AppsFlyerLib.getInstance().setResolveDeepLinkURLs("clickdomain.com", "myclickdomain.com", "anotherclickdomain.com");
```

### setSharingFilterForPartners

<span class="annotation-added">Добавлено в V6.4</span>  
**Подпись метода**

```java
void setSharingFilterForPartners(java.lang.String... partners)
```

Эта функция заменяет устаревший [`setSharingFilter`](#setsharingfilter) и [`setSharingFilterForAllPartners`](#setsharingfilterforallpartners)

**Описание**  
Давайте настроим способ исключения SDK из обмена данными.

**Input arguments**

| Тип         | Наименование | Описание                                                                                                                                                                                                               |
| :---------- | :----------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Строка...` | «партнеры»   | Один или несколько идентификаторов партнера, которые вы хотите исключить. Должен включать только буквы/цифры и знаки подчеркивания. Максимальная длина ID партнера: 45 |

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
> - Для Twitter, используйте `twitter` или `twitter_int`

**Пример использования**

```java
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int"); // Single partner
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int", "partner2_int"); // Multiple partners
AppsFlyerLib.getInstance().setSharingFilterForPartners("all"); // Все партнеры
AppsFlyerLib.getInstance().setSharingFilterForPartners(); // Сброс списка (по умолчанию)
```

```kotlin
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int") // Single partner
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int", "partner2_int") // Multiple partners
AppsFlyerLib.getInstance().setSharingFilterForPartners("all") // Все партнеры
AppsFlyerLib.getInstance().setSharingFilterForPartners("") // Сброс списка (по умолчанию)
```

### настройки Фильтра Обмена

<span class="annotation-deprecated">Устарел в V6.4</span>  
**Подпись метода**

```java
void setSharingFilter(java.lang.String... партнеры)
```

Эта функция устарела и была заменена [`setSharingFilterForPartners`](#setsharingfilterforpartners)

**Описание**  
Останавливает распространение событий в указанных партнерах AppsFler.
(Устаревшие и замененные setSharingFilterForPartners)
**Входные аргументы**

| Тип         | Наименование | Описание                                                                                                                                                                      |
| :---------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Строка...` | «партнеры»   | Один или несколько идентификаторов партнера. Должен включать только буквы/цифры и знаки подчеркивания. Максимальная длина: 45 |

**Returns**  
`void`

### setSharingFilterForAllPartners

<span class="annotation-deprecated">Устарел в V6.4</span>  
**Подпись метода**

```java
void setSharingFilterForAllPartners()
```

Эта функция устарела и была заменена [`setSharingFilterForPartners`](#setsharingfilterforpartners)

**Описание**  
Останавливает распространение событий среди всех партнеров AppsFler. Overwrites [`setSharingFilter`](#setsharingfilter).

**Входные аргументы**  
Эта функция не принимает параметров.

**Returns**  
`void`

### установить Email пользователя

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```kotlin
fun setUserEmail(email: String)
```

**Описание**

Устанавливает адрес электронной почты пользователя. SDK нормализует и SHA-256 хэширует значение на устройстве перед добавлением его в нагрузку на событие. Значение обычного текста никогда не отправляется серверам AppsFler.

**Input arguments**

| Тип      | Наименование | Описание                                  |
| -------- | ------------ | ----------------------------------------- |
| `Строка` | `email`      | Строка с простым текстом. |

**Поле Payload**: `email_hashed`

**Нормализация**: Строчный регистр; полосовый/прицеп/внутренний пробел; скрытые/непечатные символы полосы (например, пробелы в нулевой ширине, контрольные символы Юникода). Normalize, then SHA-256, then hex encode.

**Возвраты**

`void`.

Этот метод заменяет удалённые `setUserEmail(cryptMethod, email)` перегрузку и `setUserEmails`.

### установить E-mail пользователя

<span class="annotation-removed">удалён в версии 7.0.1</span>

`setUserEmails` полностью удален, не является устаревшим, начиная с v7.0.1. Использующие его приложения должны перейти на [`setUserEmail`](#setuseremail).

### setUserFbLoginId

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```kotlin
fun setUserFbLoginId(fbLoginId: Long)
```

**Описание**

Устанавливает идентификатор пользователя Facebook App-Scoped. В отличие от других хэшированных PII настроек, это значение передается as-is и не хэшируется.

**Input arguments**

| Тип      | Наименование | Описание                                            |
| -------- | ------------ | --------------------------------------------------- |
| «Долгое» | `fbLoginId`  | Facebook App-Scoped ID, 16-18 цифр. |

**Поля загрузки**: `fb_login_id` (целое число, не хэш)

**Returns**  
`void`.

### setUserFirstName

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```kotlin
fun setFirstName (имя: строка)
```

**Описание**

Устанавливает имя пользователя. SDK нормализует и SHA-256 хэширует значение на устройстве перед добавлением его в нагрузку на событие.

**Input arguments**

| Тип      | Наименование | Описание                           |
| -------- | ------------ | ---------------------------------- |
| `Строка` | `имя`        | Имя в виде текста. |

**Поля загрузки**: `first_name_hashed`

**Нормализация**: Нижний регистр, специальные символы и кодировка UTF-8. Normalize, then SHA-256 of the UTF-8 bytes, then hex encode.

**Returns**  
`void`.

### setUserLastName

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```kotlin
fun setLastName пользователя (фамилия: строка)
```

**Описание**

Устанавливает имя пользователя. Аналогичная нормализация и обработка как [`setUserFirstName`](#setuserfirstname).

**Поле загрузки**: `last_name_hashed`

**Returns**  
`void`.

### установить UserPhone

<span class="annotation-added">Добавлено в v7.0.1</span>

**Метод подписи**

```kotlin
fun setUserPhone(код страны: строка, номер телефона: строка)
```

**Описание**

Устанавливает номер телефона пользователя. Передать код страны и локальный номер отдельно. SDK объединяет `countryCode` и `phoneNumber` в одну строку перед нормализацией, затем генерирует два хэшированных поля загрузки из этой строки.

**Input arguments**

| Тип      | Наименование  | Описание                                                                           |
| -------- | ------------- | ---------------------------------------------------------------------------------- |
| `Строка` | `countryCode` | Код набора номера, например «1», «44», «380».                      |
| `Строка` | `phoneNumber` | Локальный номер. Может включать пробелы и символы. |

| Поля нагрузки             | Нормализация                                                                  |
| ------------------------- | ----------------------------------------------------------------------------- |
| `phone_number_hashed`     | Выделить символы и буквы, полоски ведущие нули, только цифры. |
| `phone_number_e164_хэшнл` | Выделяйте все нецифровые символы, а затем добавляйте `+`.     |

**Пример использования**

```kotlin
AppsFlyerLib.getInstance().setUserPhone("1", "(650) 555-1212")
```

хэши `phone_number_hashed` `165055512`. хэш `phone_number_e164_hashed` `+16505551212`.

**Returns**  
`void`.

Этот метод заменяет удалённый `setPhoneNumber`.

### старт

**Метод подписи**

```java
void start(Контекст,
                           java.lang.String key,
                           AppsFlyerRequestListener слушателя)
```

**Описание**  
Начинает SDK.

**Input arguments**

| Тип                        | Наименование | Описание                                                                                                           |
| :------------------------- | :----------- | :----------------------------------------------------------------------------------------------------------------- |
| «Контекст»                 | `context`    | Контекст приложения при вызове метода «onCreate», контекста действия при вызове метода «onResume». |
| `Строка`                   | `ключ`       | Ваш девиз ключ AppsFlyer                                                                                           |
| `AppsFlyerRequestListener` | `слушатель`  | (Необязательно) Слушатель для получения статуса запроса.                        |

**Returns**  
`void`.

**Пример использования**  
Смотрите пример [интеграции SDK](doc:integrate-ios-sdk).

### остановить

**Метод подписи**

```java
void stop(boolean shouldStop,
                          Context context)
```

**Описание**  
После вызова этого API наш SDK больше не взаимодействует с нашими серверами и останавливает работу.  
Полезно при реализации пользовательского выбора/отключения.

> 📘 перезагрузка SDK
>
> После вызова `stop(true)` вам нужно вызвать `stop(false)` и только потом вызвать `start()`

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| `boolean`  | `shouldStop` | должны быть остановлены.          |
| «Контекст» | `context`    | Контекст приложения / Активности. |

**Returns**  
`void`.

### подписаться на DeepLink

**Метод подписи**

```java
void subscribeForDeepLink(DeepLinkListener deepLinkListener,
                                          Долгое время ожидания)
```

**Описание**

**Input arguments**

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`DeepLinkListener`",
"0-1": "`deepLinkListener`",
"0-2": "",
"1-0": "`long`",
"1-1": "`timeout`",
"1-2": "Необязательно.  \nUnits in milliseconds"
},
"cols": 3,
"rows": 2,
"align": [
"left",
"left",
"left"
]
}
[/block]

**Returns**  
`void`

### удалить ConversionListener

**Метод подписи**

```java
void unregisterConversionListener()
```

**Описание**  
Отменить регистрацию ранее зарегистрированного `AppsFlyerConversionListener`.

**Входные аргументы**  
Эта функция не принимает параметров.

**Returns**  
`void`

### updateServerUninstallToken

**Метод подписи**

```java
void updateServerUninstallToken(Контекстный контекст,
                                                java.lang.String token)
```

**Описание**  
Для разработчиков, использующих Firebase для других целей, помимо измерения удаления. Дополнительную информацию можно найти в [измерении удаления](https://support.appsflyer.com/hc/en-us/articles/360017822118).

**Input arguments**

| Тип        | Наименование | Описание                                          |
| :--------- | :----------- | :------------------------------------------------ |
| «Контекст» | `context`    | Контекст приложения / Активности. |
| `Строка`   | «Токен»      | Токен устройства Firebase.        |

**Returns**  
`void`

**Пример использования**

```java Java
AppsFlyerlib.getInstance().updateServerUninstallToken(getApplicationContext(), <TOKEN>);
```

```kotlin Kotlin
AppsFlyerlib.getInstance().updateServerUninstallToken(getApplicationContext(), <TOKEN>);
```

### проверитьAndLogInAppPurchase

<span class="annotation-added">Добавлено в v6.14.0</span>

**Метод подписи**

```java
публичная абстрактная недействительна validateAndLogInAppPurchase(@NonNull AFPurchaseDetails приобретенные детали,
                                                 @Nullable Map<String, String> additionalParameters,
                                                 @Nullable AppsFlyerInAppPurchaseValidationCallback validationCallback);
```

**Описание**
Метод проверяет событие покупки с магазином и если проверка прошла успешно, SDK отправляет событие [`af_purchase`](https://dev.appsflyer.com/hc/docs/in-app-events-android#af_purchase) в AppsFlyer.

Смотрите подробные инструкции в [Validate and login in-app](#validateandloginapppurchase).

**Input arguments**

| Наименование               | Тип                                                                                                                   | Описание                                                                                                                        |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `purchaseDetails` \*       | [`AFPurchaseDetails`](#afpurchasedetails)                                                                             | Объект, который инкапсулирует все данные, относящиеся к покупке, предоставленной методу validateAndLogInAppPay. |
| «дополнительные параметры» | Карта<String, String>                                                                        | Дополнительные параметры для входа в систему с покупкой.                                                        |
| `validationCallback` \*    | [\`\`AppsFlyerInAppPurchaseValidationCallback`](#appsflyerinapppurchasevalidationcallback)` | Обратный вызов для получения результатов проверки.                                                              |

**Возвраты**
void

#### Информация о покупке

Объект, который инкапсулирует все данные, относящиеся к покупке, предоставленной методу validateAndLogInAppPay.

```kotlin
data class AFPurchaseDetails(
    val purchaseType: AFPurchaseType,
    val purchaseToken: String,
    val productId: String,

```

\*\*Параметры AFPurchaseDetails \*\*

| Наименование    | Тип              | Описание                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `purchaseType`  | `AFPurchaseType` | Обязательное поле для разграничения разовых покупок и подписки. Поле может принять подписку или одноразовую покупку.                                                                                                                                                                                                                                                                                                            |
| `purchaseToken` | Строка           | Токен, который уникально идентифицирует покупку для данного предмета и для пользовательской пары. Часть Библиотеки Биллинга [`Purchase class`](https://developer.android.com/reference/com/android/billingclient/api/Purchase). Для получения токена вызовите [`getPurchaseToken` API](https://developer.android.com/reference/com/android/billingclient/api/Purchase#getPurchaseToken()) |
| «productId»     | Строка           | Код купленного товара. Также часть Биллинговой Библиотеки [`Purchase class`](https://developer.android.com/reference/com/android/billingclient/api/Purchase).                                                                                                                                                                                                                                                                   |

### validateAndLogInAppPurchase (LEGACY)

<span class="annotation-deprecated">Устарел в версии 6.4</span>

**Метод подписи**

```java
void validateAndLogInAppPurchase(Контекстный контекст,
                                                 java.lang.String publicKey,
                                                 java.lang.String signature,
                                                 java.lang.String purchaseData,
                                                 java.lang.String price,
                                                 java.lang.String currency,
                                                 java.util.Map<java.lang.String,java.lang.String>additionalParameters)
```

**Описание**  
API для проверки покупок в приложениях. Событие `af_purchase` с соответствующими значениями будет автоматически зарегистрировано, если проверка прошла успешно.

См. подробные инструкции в [validating purchases](doc:in-app-events-android#validating-purchases).

**Input arguments**

| Тип                   | Наименование               | Описание                                                                                                                                                                 |
| :-------------------- | :------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| «Контекст»            | `context`                  | Контекст приложения / Активности.                                                                                                                        |
| `Строка`              | `publicKey`                | Лицензионный ключ, полученный из консоли Google Play.                                                                                                    |
| `Строка`              | `Подпись`                  | data.INAPP_DATA_SIGNATURE от onActivityResult(int requestCode, int resultCode, Intent data) |
| `Строка`              | `purchaseData`             | data.INAPP_PURCHASE_DATA от onActivityResult(int requestCode, int resultCode, Intent data)  |
| `Строка`              | «цену»                     | Цена покупки должна быть взята из skuDetails.getStringArrayList("DETAILS_LIST")                                  |
| `Строка`              | «валюта»                   | Покупка валюты, должна происходить из skuDetails.getStringArrayList("DETAILS_LIST")                              |
| `Map<String, String>` | «дополнительные параметры» | Параметры для регистрации при покупке (если подтверждено).                                                                            |

**Returns**  
`void`.

### waitForCustomerID пользователя

**Метод подписи**

```java
void waitForCustomerUserId(boolean wait)
```

**Описание**  
Этот метод защищает инициализацию SDK до тех пор, пока не будет указан `customerUserID`.  
Все события внутри приложения и любые другие вызовы SDK API удаляются до тех пор, пока не будет указан и зарегистрирован `customerUserID`.

**Input arguments**

| Тип       | Наименование | Описание |
| :-------- | :----------- | :------- |
| `boolean` | `подождите`  |          |

**Returns**  
`void`.

**Пример использования**

```java Java
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
```
