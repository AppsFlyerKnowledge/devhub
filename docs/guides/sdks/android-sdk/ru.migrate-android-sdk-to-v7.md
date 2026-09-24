---
title: Перенести Android SDK в V7
slug: migrate-android-sdk-to-v7
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-7
privacy:
  view: публичный
position: 1
---

## Прежде чем начать

В этом руководстве вы можете перенести ваше Android приложение с AppsFlyer SDK 6 на SDK 7. SDK 7 вводит новую сессионную модель управления, удаляет несколько устаревших API и выравнивает поведение Android с iOS. Используйте это руководство, чтобы определить, что нужно изменить, понять, почему каждое изменение было сделано, и обновить вашу интеграцию в правильном порядке.

> 📘 Заметка
>
> Подавляющее большинство методов `AppsFlyerLib` остаются неизменными между SDK 6 и SDK 7. В этом руководстве описываются только те изменения, которые вам необходимо сделать. Вам не нужно переписать интеграцию с нуля.

### Политика поддержки SDK 6

SDK 6 продолжает поддерживаться, но только для исправления критических ошибок. Все новые возможности запланированы только для SDK 7. Мы рекомендуем переходить как можно скорее, чтобы оставаться в курсе новых возможностей.

### Требования к версии Kotlin

Если ваше приложение использует Kotlin 1.9, вы можете столкнуться с ошибками метаданных при построении на SDK 7 AAR. Обновите до Kotlin 2.0 или выше перед миграцией.

### Минимальная версия SDK

SDK 7 повышает минимальный уровень Android API с 19 до 21. Обновите `build.gradle` перед продолжением.

**SDK 6**

```groovy
minSdk 19
```

**SDK 7**

```groovy
minSdk 21
```

Большинство приложений уже выше API 21, так как многие библиотеки Google требуют API 25 или выше.

### Сфера охвата статьи

Эта статья охватывает только Android. Для iOS, см. [Перенос iOS SDK на V7](doc:migrate-ios-sdk-to-v7).

---

## Сессионная модель SDK 7

Основная тема SDK 7 позволяет вам контролировать время отправки первой сессии и любой последующей сессии. В SDK 6 SDK прислал сессию автоматически, когда приложение перешло на передний план. В SDK 7, эта ответственность переходит к вам как к разработчику.

Это изменение отражает реальную потребность в мире: многие приложения должны выполнить шаги перед отправкой события запуска AppsFlyer, Например, сбор согласия пользователя, получение идентификатора пользователя (CUID) или завершение авторизации на ATT. Решение SDK 7 разработано с учетом этого требования.

SDK 7 также содержит давние несоответствия между iOS и Android. Наиболее значимым выравниванием поведения является установленная стойкость: в SDK 6 многие значения параметра `AppsFlyerLib` были сохранены на диске на Android и перезапущен выживший процесс. В SDK 7, Android выравнивается с iOS, что означает, что все значения, установленные только для выполнения и должны быть повторно применены при каждом холодном запуске.

---

## Обновить контрольный список

Работайте над ними по порядку — в первую очередь меняются повышенные риски. Столбец Риск говорит вам, вызывает ли пропуск шага **скомпилированную ошибку** (пойманную в момент сборки) или **беззвучную регрессию** (компилирует, но неправильно работает во время запуска).

| #                               | Действие                                                                                                                                                                                                                                                                               | Риск                    | §                                                                        |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | ------------------------------------------------------------------------ |
| **Требования**                  |                                                                                                                                                                                                                                                                                        |                         |                                                                          |
| 1                               | Обновите до Kotlin 2.0 или выше, если ваше приложение использует Kotlin 1.9.                                                                                                                                                           | Необходимые предпосылки | [До начала](#before-you-begin)                                           |
| 2                               | Установите `minSdkVersion` как минимум 21 в вашем `build.gradle`.                                                                                                                                                                                                      | Необходимые предпосылки | [До начала](#before-you-begin)                                           |
| **Очень рискованные изменения** |                                                                                                                                                                                                                                                                                        |                         |                                                                          |
| 3                               | Обновите все импортируемые из предыдущих пакетов на `com.appsflyer.share`. Используйте автоматический импорт Android Studio, чтобы разрешить их.                                                                                                       | Ошибка компиляции       | [§1](#1-update-class-imports)                                            |
| 4                               | Удалите ключ `Context` и dev из `start()`. Используйте только `start()` или `start(AppsFlyerRequestListener)`.                                                                                                                                         | Ошибка компиляции       | [§2](#2-update-the-start-method)                                         |
| 5                               | Обновление `registerConversionListener`: удалите параметр `Context`, удалите `onAppOpenAttribution` и `onAttributionFailure` и обновите импорт до `com.appsflyer.share.AppsFlyerConversionListener`.                                                   | Ошибка компиляции       | [§4](#4-update-the-conversion-listener)                                  |
| 6                               | Добавить `registerSessionReadyListener` после `init()`. Вызовите `start()` внутри callback, или используйте шаблон координатора, если в вашем приложении есть условия предварительного запуска.                                                        | Беззвучная регрессия    | [§3](#3-add-a-session-ready-listener)                                    |
| 7                               | Повторно примените все значения установок `AppsFlyerLib` после каждого холодного запуска, или переместите постоянные значения в `af_init_config.json`.                                                                                                                 | Беззвучная регрессия    | [Часть 2 §1](#1-setter-values-are-no-longer-persisted-between-sessions)  |
| **Глубокая связь**              |                                                                                                                                                                                                                                                                                        |                         |                                                                          |
| 8                               | Замените `performOnDeepLinking` и `performOnAppAttribution` на `performDeepLinking(String, boolean)`. Замените `subscribeForDeepLink(listener, timeout)` на `setDeepLinkTimeout(long)`, затем `subscribeForDeepLink(listener)`.                        | Ошибка компиляции       | [§5](#5-update-deep-linking)                                             |
| **Устаревшее удаление API**     |                                                                                                                                                                                                                                                                                        |                         |                                                                          |
| 9                               | Удалите из вашего манифеста `SingleInstallBroadcastReceiver` и `MultipleInstallBroadcastReceiver`. Добавьте `implementation 'com.android.installreferrer:installreferrer:2.2'` в `build.gradle`.                                                       | Ошибка компиляции       | [§8](#8-remove-legacy-broadcast-receivers)                               |
| 10                              | Обновите `setUserEmails`: замените MD5 или SHA1 `SHA256` или `NONE` и обновите импорт до `com.appsflyer.share.EmailsCryptType`.                                                                                                                        | Ошибка компиляции       | [§7](#7-update-the-user-emails-method)                                   |
| 11                              | Удалить или заменить: `waitForCustomerUserId`, `setCustomerIdAndLogSession`, `setCollectIMEI`, `setCollectOaid`, `setExtension`, `registerValidatorListener`, `validateAndLogInAppPurchase` V1, `setSharingFilter` и `setSharingFilterForAllPartners`. | Ошибка компиляции       | [§9](#9-remove-or-replace-other-removed-apis)                            |
| **Необязательно**               |                                                                                                                                                                                                                                                                                        |                         |                                                                          |
| 12                              | Вызовите `collectDataFromLauncherActivity(this)` из `onCreate` вашего запуска для выбора коллекции app-open и web referr.                                                                                                                                              | —                       | [Часть 2 §3](#3-opt-in-to-app-open-referrer-and-web-referrer-collection) |
| 13                              | Если вы распространяете на магазинах Samsung, Xiaomi или Huawei, добавьте соответствующую библиотеку рефереров магазинов в зависимости вашего приложения.                                                                                                              | —                       | [§11](#11-add-optional-store-referrer-libraries)                         |

## Часть 1: Деление изменений

Следующие изменения вызовут ошибки компиляции, если они не будут устранены. Работайте по ним в следующем порядке, так как некоторые шаги зависят от других.

### 1. Обновить импорт классов

**Что изменилось:** Все публичные классы с интерфейсом пользователя переместились из подпакетов `com.appsflyer` в `com.appsflyer.share`.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

| SDK 6 импорт                                                                                                                                                               | Импорт SDK 7                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `com.appsflyer.AppsFlyerConversionListener`                                                                                                                                | `com.appsflyer.share.AppsFlyerConversionListener`                             |
| `com.appsflyer.attribution.AppsFlyerRequestListener`                                                                                                                       | `com.appsflyer.share.attribution.AppsFlyerRequestListener`                    |
| `com.appsflyer.attribution.RequestError`                                                                                                                                   | `com.appsflyer.share.attribution.RequestError`                                |
| `com.appsflyer.deeplink.DeepLinkListener`                                                                                                                                  | `com.appsflyer.share.deeplink.DeepLinkListener`                               |
| `com.appsflyer.deeplink.DeepLinkResult`                                                                                                                                    | `com.appsflyer.share.deeplink.DeepLinkResult`                                 |
| `com.appsflyer.internal.platform_extension.PluginInfo`                                                                                                                     | `com.appsflyer.share.platform_extension.PluginInfo`                           |
| `com.appsflyer.AFAdRevenueData`, `AFInAppEventType`, `AFInAppEventParameterName`, `AFPurchaseDetails`, `AdRevenueScheme`, `MediationNetwork`, `AppsFlyerConsent`, и другие | `com.appsflyer.share.*` (те же имена классов, новый пакет) |

> 📘 Заметка
>
> Android Studio может разрешить эти изменения при импорте автоматически. Удалите старый импорт и пусть IDE предложит корректную замену из `com.appsflyer.share`.

---

### 2. Обновить метод запуска

**Что изменилось:** `start()` больше не принимает ключ `Context` или dev.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

Ключевые параметры `Context` и dev были удалены из `start()`. Оба уже предоставлены в `init()` и не нужно переключаться снова. SDK 7 поддерживает только две подписи `start()`: одна с без аргументов, а другая с `AppsFlyerRequestListener`.

**SDK 6**

```java Java
// Application.onCreate or Activity
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

AppsFlyerLib.getInstance().start(this);
AppsFlyerLib.getInstance().start(this, devKey);
AppsFlyerLib.getInstance().start(this, devKey, requestListener);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

AppsFlyerLib.getInstance().start(this)
AppsFlyerLib.getInstance().start(this, devKey)
AppsFlyerLib.getInstance().start(devthis, devthis, requestListener)
```

**SDK 7**

```java Java
// Application.onCreate — Контекст передается только init
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

// После registerSessionReadyListener (см. §3):
AppsFlyerLib.getInstance().start();
AppsFlyerLib.getInstance().start().Listener);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

// После регистрации ReadyListener (см. §3):
AppsFlyerLib.getInstance().start()
AppsFlyerLib.getInstance().start().start(requestListener)
```

---

### 3. Добавить слушателя с сессией

**Что изменилось:** `start()` теперь требует вызова `registerSessionReadyListener`. Без зарегистрированного слушателя SDK записывает предупреждение и не запускает сессию.

Слушатель запускает после завершения внутренних проверок SDK и готов начать сеанс. С этого момента вам предстоит решить, когда на самом деле звонить «start()» на основе требований вашего приложения.

Доступны два шаблона в зависимости от потребностей вашего приложения.

#### Запуск без предварительных условий

Используйте этот шаблон, если у вашего приложения нет условий предварительного запуска, что означает, что вам не нужно ждать согласия, CUID или любые другие ворота перед отправкой первой сессии.

> 📘 SDK 6
>
> В SDK 6 нет `SessionReadyListener` API. `start()` можно вызвать непосредственно после `init`.

**SDK 7**

```java Java
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance(). tart();
});

// Необязательный при разрыве (например, в Activity.onDestroy()):
// AppsFlyerLib.getInstance().unregisterSessionReadyListener();

boolean ready = AppsFlyerLib.getInstance().isSessionReady();
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(devKey, conversionListener, applicationContext)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance(). tart()
}

// Дополнительно, когда вы разрываете (например, в Activity.onDestroy()):
// AppsFlyerLib.getInstance().unregisterSessionReadyListener()

подготавливается = AppsFlyerLib.getInstance().isSessionReady
```

#### Начать с предварительных условий

Используйте этот шаблон, если ваше приложение должно удовлетворять условиям перед отправкой первой сессии, например, сбор согласия пользователя или ожидание CUID от вашего бэкэнда. Класс координатора синхронизирует сигнал готовности SDK с готовностью вашего приложения и вызывает `start()` только при соблюдении обоих условий.

**`AfSdkStartupManager`**

```java Java
package com.yourapp;

import android.util.Log;
import com.appsflyer.AppsFlyerLib;
import com.appsflyer.share.attribution. ppsFlyerRequestListener;

public final class AfSdkStartupManager {
    private boolean isConsentReady;
    private boolean isSdkReadyToStart;

    public void onConsentReady() {
        isConsentReady = true;
        startAfSdkIfAllConditionsAreMet();
    }

    public void onAfSdkReadyToStart() {
        isSdkReadyToStart = true;
        startAfSdkIfAllConditionsAreMet();
    }

    private void startAfSdkIfAllConditionsAreMet() {
        if (isConsentReady && isSdkReadyToStart) {
            AppsFlyerLib. etInstance(). tart(new AppsFlyerRequestListener() {
                @Override
                public void onSuccess() {
                    Log. ("AppsFlyer", "AppsFlyerRequestListener: onSuccess");
                }

                @Override
                публичная отмена onError(int code, String error) {
                    Log. ("AppsFlyer", "AppsFlyerRequestListener: onError. Код: " + код + ", ошибка: " + ошибка);
                }
            });
            isSdkReadyToStart = false;
        }
    }

    public void reset() {
        isConsentReady = false;
        isSdkReadyToStart = false;
    }
}
```

```kotlin Kotlin
package com.yourapp

import android.util.Log
import com.appsflyer.AppsFlyerLib
import com.appsflyer.share.attribution. ppsFlyerRequestListener

класс AfSdkStartupManager {
    private var isConsentReady = false
    private var isSdkReadyToStart = false

    fun onConsentReady() {
        isConsentReady = true
        startAfSdkIfAllConditionsAreMet()
    }

    fun onAfSdkReadyToStart() {
        isSdkReadyToStart = true
        startAfSdkIfAllConditionsAreMet()
    }

    private fun startAfSdkIfAllConditionsAreMet() {
        if (isConsentReady && isSdkReadyToStart) {
            AppsFlyerLi etInstance(). tart(object : AppsFlyerRequestListener {
                override fun onSuccess() {
                    Log. ("AppsFlyer", "AppsFlyerRequestListener: onSuccess")
                }

                переопределить веселую onError(код: Int, ошибка: String) {
                    Log. ("AppsFlyer", "AppsFlyerRequestListener: onError. Код: $code, error: $error")
                }
            })
            isSdkReadyToStart = false
        }
    }

    fun reset() {
        isConsentReady = false
        isSdkReadyToStart = false
    }
}
```

Найди координатор вашего класса `Application`:

```java Java
AfSdkStartupManager = новый AfSdkStartupManager();

AppsFlyerLib.getInstance().init(devKey, conversionListener, this);
AppsFlyerLib.getInstance(). egisterSessionReadyListener(() -> {
    startupManager.onAfSdkReadyToStart();
});

// Когда процесс вашего согласия завершается:
// startupManager.onConsentReady();
```

```kotlin Kotlin
val startupManager = AfSdkStartupManager()

AppsFlyerLib.getInstance().init(devKey, conversionListener, this)
AppsFlyerLib.getInstance().registerSessionReadyListener {
    startupManager.onAfSdkReadyToStart()
}

// Когда ваш поток завершается:
// startupManager.onConsentReady()
```

> ⚠️ Предупреждение
>
> Обратный вызов `SessionReadyListener` стреляет в фоновом потоке. Если ваше согласие также работает в фоновом потоке, убедитесь, что флаги в классе координатора являются потоком безопасным. Минимум пометьте их `volatile` на Java или `@Volatile` в Kotlin.

---

### 4. Обновить слушателя преобразования

**Что изменилось:** `registerConversionListener` больше не принимает параметр `Context`, а вызовы `onAppOpenAttribution` и `onAttributionFailure` были удалены. Unified Deep Linking (UDL) теперь является необходимым путем обработки глубоких ссылок после открытия приложения.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

**SDK 6**

```java Java
импортировать com.appsflyer.AppsFlyerConversionListener;

AppsFlyerLib.getInstance(). egisterConversionListener(контекст), new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionData) { }

    @Override
    public void onConversionDataFail(String errorMessage) { }

    @Override
    public void onAppOpenAttribution(Map<String, String> attributionData) { }

    @Override
    public void onAttributionFailure(String errorMessage) { }
});
```

```kotlin Kotlin
импортировать com.appsflyer.AppsFlyerConversionListener

AppsFlyerLib.getInstance(). egisterConversionListener(
    контекст,
    объект : AppsFlyerConversionListener {
        переопределить удовольствие onConversionDataSuccess(conversionData: MutableMap<String, Any>? { }
        переопределить веселье onConversionDataFail(errorMessage: строка? { }
        переопределить веселье onAppOpenAttribution(attributionData: MutableMap<String, String>? { }
        переопределяет анимацию onAttributionFailure(errorMessage: строка? { }
    }
)
```

**SDK 7**

```java Java
импортировать com.appsflyer.share.AppsFlyerConversionListener;

AppsFlyerLib.getInstance(). egisterConversionListener(new AppsFlyerConversionListener() {
    @Override
    public void onConversionDataSuccess(Map<String, Object> conversionData) { }

    @Override
    public void onConversionDataFail(String errorMessage) { }
});
```

```kotlin Kotlin
импортировать com.appsflyer.share.AppsFlyerConversionListener

AppsFlyerLib.getInstance(). egisterConversionListener(
    объект : AppsFlyerConversionListener {
        переопределить веселье onConversionDataSuccess(conversionData: MutableMap<String, Any>? { }
        переопределить веселье onConversionDataFail(errorMessage: строка? { }
    }
)
```

> 📘 Заметка
>
> Если ваше приложение использует Само-Отчетность Сети (SRN), вам все равно нужно `onConversionDataSuccess` для потока Расширенной Глубокой Связывания (EDDL). Только `onAppOpenAttribution` и `onAttributionFailure` удаляются. Переместите любую логику из этих двух обратных вызовов в вашу UDL реализацию, используя `subscribeForDeepLink`.

---

### 5. Обновление глубокой связи

#### 5a. Новый метод глубокой связи заменяет два удаленных метода

**Что изменилось:** `performOnDeepLinking` и `performOnAppAttribution` были удалены.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

Замените оба на новый метод `performDeepLinking(String url, boolean shouldTriggerSession)`. Этот метод принимает глубокое соединение как обычное напряжение, поддерживает как основанные, так и ненамеренные источники, такие как служба сообщений Firebase, и дает вам явный контроль над отправкой события запуска на AppsFlyer.

| Параметр               | Описание                                                                                                                                                                                                                                                        |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `url`                  | Для разрешения глубокой строки ссылок: полный URL, OneLink, `Intent` `data`.                                                                                                                                                    |
| `shouldTriggerSession` | `false`: решите `url` для `DeepLinkListener` без дополнительного запуска. `true`: также добавьте в очередь запуска для повторного вовлечения, даже если в этой сессии уже вызывается `start()`. |

**SDK 6**

```java Java
AppsFlyerLib.getInstance().subscribeForDeepLink(listener, 3000L);
AppsFlyerLib.getInstance().performOnDeepLinking(intent, context);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().subscribeForDeepLink(listener, 3000L)
AppsFlyerLib.getInstance().performOnDeepLinking(intent, context)
```

**SDK 7**

```java Java
AppsFlyerLib.getInstance().setDeepLinkTimeout(3000L);
AppsFlyerLib.getInstance().subscribeForDeepLink(listener);
AppsFlyerLib.getInstance().performDeepLinking("https://your.onelink/...", true);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().setDeepLinkTimeout(3000L)
AppsFlyerLib.getInstance().subscribeForDeepLink(listener)
AppsFlyerLib.getInstance().performDeepLinking("https://your.onelink/...", true)
```

#### 5b. Установите тайм-аут глубокой ссылки отдельно

**Что изменилось:** Перегрузка `subscribeForDeepLink(DeepLinkListener, long)` была удалена.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

Установите тайм-аут отдельно, используя `setDeepLinkTimeout`, затем вызовите `subscribeForDeepLink` без параметра тайм-аута. Это выравнивает Android API с iOS.

#### 5c. UDL больше не требует начала

**Что изменилось:** В SDK 6 перед тем, как будет решена глубокая ссылка, UDL потребовал вызова `start()`. В SDK 7 SDK подписывается на жизненный цикл Android из «init()» и может отловить первое создание или возобновление активности.

Теперь вы можете зарегистрироваться на глубокие ссылки перед вызовом `start()`, и ваш `DeepLinkListener` будет выстреливать, даже если `start()` еще не вызван.

Рекомендуемая последовательность инициализации в вашем классе `Application`:

1. Звонок `init()`.
2. Звоните `subscribeForDeepLink()`.
3. Вызов `registerSessionReadyListener()`.
4. Вызовите `start()` внутри прослушивающего обратного вызова или позже, когда выполняются условия вашего приложения.

Это также означает глубокое соединение пользователя без запуска сеанса теперь является потоком с первым классом. Если пользователь еще не дал согласия на отправку данных в AppsFler, но вы все еще хотите маршрутизировать их внутри приложения, вызовите `performDeepLinking` с параметром `shouldTriggerSession` в `false`. Глубокая ссылка разрешает и достигает вашего слушателя без запуска события.

---

### 6. Обработка уведомлений при обновлении

**Что изменилось:** Существующий `sendPushNotificationData(Activity)` API не изменился. SDK 7 добавляет новую перегрузку, которая позволяет вручную предоставлять данные с использованием объекта `AFPushData`. Это полезно, когда ваша полезная нагрузка разрешается за пределами `Intent`, например, непосредственно из службы сообщений Firebase Messaging.

```java Java
импорт com.appsflyer.share.AFPushData;

import java.util.HashMap;
import java.util.Map;

// Точно же, как в SDK 6
AppsFlyerLib. etInstance().sendPushNotificationData(activity);

Map<String, Object> extras = new HashMap<>();
extras. ut("ключ1", "value1");

AFPushData pushData = новые AFPushData(
        "Кампания1",
        «Огненная база», истина,

        дополнения
);
AppsFlyerLib. etInstance().sendPushNotificationData(pushData);
```

```kotlin Kotlin
импортировать com.appsflyer.share.AFPushData

// То же, что и в SDK 6
AppsFlyerLib.getInstance().sendPushNotificationData(activity)

AppsFlyerLib.getInstance(). endPushNotificationData(
    кампания AFPushData(
        = "Кампания1",
        pid = "Firebase",
        исцеление = true,
        дополнительных параметров = mapOf("key1" к "value1")
    )
)
```

---

### 7. Изменить способ электронной почты пользователя

**Что изменилось:** Два изменения применимы к `setUserEmails`:

- Типы шифрования SHA1 и MD5 удалены. Только `NONE` и `SHA256` поддерживаются в SDK 7. Если вы использовали MD5 или SHA1, обновите свой код, чтобы использовать `SHA256` или `NONE`.
- `EmailsCryptType` переместился из `AppsFlyerProperties` в `com.appsflyer.share`. Обновить импорт.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

**SDK 6**

```java Java
AppsFlyerLib.getInstance().setUserEmails(
    AppsFlyerProperties.EmailsCryptType.SHA256,
    "user@example.com"
);
// Также: NONE, SHA1, MD5 под AppsFlyerProperties.EmailsCryptType
```

```kotlin Kotlin
AppsFlyerLib.getInstance().setUserEmails(
    AppsFlyerProperties.EmailsCryptType.SHA256,
    "user@example.com"
)
// Также: NONE, SHA1, MD5 под AppsFlyerProperties.EmailsCryptType
```

**SDK 7**

```java Java
импортировать com.appsflyer.share.EmailsCryptType;

AppsFlyerLib.getInstance().setUserEmails(
    EmailsCryptType.SHA256,
    "user@example.com"
);
// Остается только NONE и SHA256
```

```kotlin Kotlin
import com.appsflyer.share.EmailsCryptType

AppsFlyerLib.getInstance().setUserEmails(
    EmailsCryptType.SHA256,
    "user@example.com"
)
// Only NONE and SHA256 remain
```

---

### 8. Удалить устаревшие широковещательные приемники

**Что изменилось:** `SingleInstallBroadcastReceiver` и `MultipleInstallBroadcastReceiver` были удалены.

**Ошибка компиляции:** Существующий код прерывается при обновлении.

На миграцию:

1. Удалите любые записи `<receiver>в вашем `AndroidManifest.xml`, чей `android:name`является`com.appsflyer.SingleInstallBroadcastReceiver`или`com.appsflyer.MultipleInstallBroadcastReceiver`, а также их `INSTALL_REFERRER\` intent filter блоки. Оставляя их, ломает слияние манифеста.
2. Добавьте в Google Play библиотеку источников, как зависимость `implementation` в `build.gradle` модуля вашего приложения. AppsFlyer SDK объявляет это как `compileOnly` внутри, так что вы должны добавить его явно в ваше приложение.

```groovy
реализация 'com.android.installreferrer:installreferrer:2.2'
```

> ⚠️ Предупреждение
>
> Оставляя старые записи \`<receiver>в вашем манифесте вызывает ошибку время сборки, а не ошибку во время запуска. Ваше приложение не будет построено, пока вы не удалите их.

---

### 9. Удалить или заменить другие удаленные API

**Что изменилось:** Было удалено несколько устаревших API.

**Ошибка компиляции:** Существующий код, вызывающий эти API при обновлении.

| Удалённый API                                                     | Замена                                                                                                                                                                                                                                 |
| ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `waitForCustomerUserId(boolean)` / `setCustomerIdAndLogSession()` | Замена не требуется. См. примечание ниже.                                                                                                                                              |
| `setCollectIMEI(boolean)`                                         | Используйте «setImeiData(String)», чтобы предоставить IMEI вручную, когда это необходимо.                                                                                                           |
| `setCollectOaid(boolean)`                                         | Используйте `setDisableAdvertisingIdentifiers` и другие поддерживаемые API идентификаторов.                                                                                                                            |
| `setExtension(String)`                                            | Используйте `PluginInfo` (импортируется из `com.appsflyer.share.platform_extension`).                                                                                                               |
| `registerValidatorListener` / `validateAndLogInAppPurchase` V1    | Используйте `validateAndLogInAppPurchase(AFPurchaseDetails, Map, AppsFlyerInAppPurchaseValidationCallback)` с помощью `com.appsflyer.share.AFPurchaseDetails`. V2 API имеет встроенный прослушиватель. |
| `setSharingFilter(tring...)` / `setSharingFilterForAllPartners()` | Используйте `setSharingFilterForPartners(String...)`. Передайте «все» чтобы заблокировать всех партнеров.                                                                                              |

> 📘 Поток идентификатора клиента в SDK 7
>
> В SDK 6, так как сессия началась автоматически, вам пришлось вызвать `waitForCustomerUserId(true)`, чтобы дать SDK удержать до тех пор, пока не будет доступен CUID, затем позвоните `setCustomerIdAndLogSession()`, чтобы выпустить его. Забыли второй звонок, вызвавший бессрочное ожидание SDK, что является общим источником проблем интеграции. В SDK 7, вы контролируете, когда вызывается `start()`. Если вам нужно включить CUID в первую сессию, вызовите `setCustomerUserId()` перед вызовом `start()`. Никакой механизм ожидания не требуется.

> 📘 удалён `AppsFlyerProperties`
>
> `AppsFlyerProperties` больше не доступен в SDK 7. Если ваше приложение использовало `AppsFlyerProperties.getInstance().set()` для настройки поведения SDK, свяжитесь с поддержкой AppsFlyer для руководства по вашей конкретной конфигурации.

> 🚧 Предупреждение
>
> `setSharingFilter`, `setSharingFilterForAllPartners`, и `validateAndLogInAppPurchase` V1 были устаревшими в SDK 6, но некоторые приложения продолжали использовать их. Обновление до SDK 7 вызывает скомпилирование ошибок на любом из устаревших API, что дает вам четкий сигнал о том, что нужно обновить.

---

### 10. Обновить обработчик ответа генератора ссылок

**Что изменилось:** «onResponse» теперь стреляет только при создании истинного короткого OneLink. `onResponseError` обрабатывает все другие результаты, включая сетевые сбои и long-link fallback. Убрана устаревшая перегрузка `CreateOneLinkHttpTask.ResponseListener`.

**Ошибка компиляции:** Существующий код, реализующий `CreateOneLinkHttpTask.ResponseListener` прерывается при обновлении.

**API (без изменений подписи на поддерживаемом пути)**

`com.appsflyer.share.LinkGenerator#generateLink(android.content.Context, com.appsflyer.share.LinkGenerator.ResponseListener)`

|                           | SDK 6                                                                                                                                                                                                                                     | SDK 7                                                                                                                                                                                                                                                        |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `onResponse(String)`      | Вызывается для нескольких исходов: короткая ссылка, когда OneLink API успешен, и также длинная (стиль запроса) ссылка, когда задача не полна с удобным для использования коротким URL. | Вызывается только тогда, когда HTTP-запрос OneLink заканчивается с успешным телом ответа — коротким URL-адресом из API.                                                                                                                      |
| `onResponseError(String)` | Используется в основном, когда SDK не смог разобрать ответ, например «ParsingException» на теле, который выглядел успешно.                                                                                                | Звонил для всех других исходов. Параметр является длинной файловой строкой из `LinkGenerator.generateLink()`. Ваше приложение решает, приемлема ли эта строка для отображения или совместного использования. |

> ⚠️ Предупреждение
>
> Не используйте и не реализуйте `com.appsflyer.CreateOneLinkHttpTask.ResponseListener` или `LinkGenerator.generateLink(Context, CreateOneLinkHttpTask.ResponseListener)` — оба удаляются в SDK 7. Миграция только на `LinkGenerator.ResponseListener`.

> 📘 Заметка
>
> И `onResponse` и `onResponseError` запускаются на `@WorkerThread`. Если вы обновите интерфейс изнутри в главном потоке, напишите в главный поток.

---

### 11. Добавить необязательные хранилища библиотек рефереров

<span class="annotation-optional">Optional</span>

**Что изменилось:** Поддержка Samsung, Xiaomi, и Huawei store referrer больше не входит в основной артефакт `af-android-sdk` в SDK 7. Если вы распространяете приложение через любой из этих магазинов и нуждаетесь в данных о реферере, добавьте соответствующую библиотеку в качестве отдельной зависимости от Gradle.

**Gradle — Билл о материалах (рекомендуется)**

Прикрепите все артефакты AppsFlyer к одному релизу через BOM, затем перечислите только то, что вам нужно без повторяющихся версий:

```groovy
dependencies {
    implementation platform("com.appsflyer:af-android-sdk-bom:<SDK_VERSION>")

    реализация "com. ppsflyer:af-android-sdk"

    // Необязательные — только для магазинов, которые вы публикуете на:
    реализацию "com. ppsflyer:samsung-referrer"
    реализация "com.appsflyer:xiaomi-referrer"
    реализации "com.appsflyer:huawei-referrer"
}
```

**Gradle — откровенные версии (без BOM)**

Держите ту же версию на `af-android-sdk` и каждой библиотеке AppsFlyer реферера, которую вы используете:

```groovy
dependencies {
    implementation "com.appsflyer:af-android-sdk:<SDK_VERSION>"

    implementation "com.appsflyer:samsung-referrer:<SDK_VERSION>"
    implementation "com.appsflyer:xiaomi-referrer:<SDK_VERSION>"
    implementation "com.appsflyer:huawei-referrer:<SDK_VERSION>"
}
```

Добавьте только строки реферера, которые вам действительно нужны.

Дополнительный код инициализации AppsFlyer не требуется. Как только эти библиотеки зависят от вашего приложения, они автоматически регистрируются в SDK при запуске.

> 📘 зависимости от третьих сторон
>
> - **Xiaomi / GetApps:** Добавьте `com.miui.referrer:homereferrer` в качестве дополнительной зависимости `implementation` (не описана BOM).
> - **Huawei / AppGallery:** Следуйте руководству по интеграции AppsFlyer + Huawei AppGallery для хранилищ Maven и HMS зависимостей (не покрыто BOM).
> - **Samsung:** Для большинства приложений достаточно добавить `samsung-referrer`.

---

## Часть 2: Изменения в поведении и добавках

Следующие изменения не вызывают ошибок компиляции, но влияют на поведение рабочего времени. Рассмотрение каждого из них тщательно, так как некоторые могут вызвать молчание потерю данных, если их не принять.

### 1. Значения настроек между сессиями больше не сохраняются

В SDK 6 многие значения установки `AppsFlyerLib` были записаны на диск на Android и выжил процесс перезапуска. В SDK 7 все настройки доступны только во время выполнения. После холодного запуска любое значение, которое вы задаете через опцию `AppsFlyerLib` недоступно.

Вы должны повторно применить любые значения, на которые вы полагаетесь после каждого холодного запуска, обычно после `init()`. Если вы полагались на стойкость, не понимая ее, ваша интеграция может отправить неполные данные после обновления.

| Метод API                                              | Настройка                                       | Статус в SDK 7                                                                                                                                              |
| ------------------------------------------------------ | ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `anonymizeUser(boolean)`                               | Анонимность пользователей                       | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `enableTCFDataCollection(boolean)`                     | Флаг сбора данных TCF                           | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setDisableNetworkData(boolean)`                       | Отключить исходящие сетевые приложения          | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setCustomerUserId(String)`                            | ID пользователя клиента                         | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setOutOfStore(String)`                                | Выход из магазина / переопределение магазина    | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setAppInviteOneLink(String)`                          | Приглашение пользователя OneLink ID             | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setAdditionalData(Map)`                               | Пользовательское событие и запуск карты         | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setUserEmails(...)`                                   | Скрытые письма                                  | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setCollectAndroidID(boolean)`                         | Собрать Android ID                              | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setImeiData(String)`                                  | Ручной IMEI                                     | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setOaidData(String)`                                  | Ручной OAID                                     | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setAppId(String)`                                     | Переопределение ID приложения                   | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setIsUpdate(boolean)`                                 | Свежая установка и обновление флага             | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setCurrencyCode(String)`                              | Валюта приложения                               | Только Runtime. Или установите `currency_code` в файле `af_init_config.json` (см. ниже). |
| `setPreinstallAttribution(String...)`                  | OEM / предварительная установка переопределения | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setLogLevel(AFLogger.LogLevel)`                       | Уровень журнала                                 | Только в режиме Runtime, повторно примените каждый холодный старт                                                                                           |
| `setDebugLog(boolean)`                                 | Ярлык для журнала отладки                       | Только Runtime. Или установите `debug_mode` в `af_init_config.json` (см. ниже).          |
| `waitForCustomerUserId` / `setCustomerIdAndLogSession` | Поток ожидания CUID                             | Удалено. См. часть 1, пункт 9.                                                                              |
| `setCollectIMEI` / `setCollectOaid` / `setExtension`   | Различные                                       | Удалено. См. часть 1, пункт 9.                                                                              |

---

### 2. Использовать конфигурационный файл JSON для значений констант

SDK 7 представляет помощник по инициализации на основе JSON. Если вы поместите файл `af_init_config. son` в папке `src/main/assets/`, SDK читает его во время `init()` и применяет поддерживаемые ключи как если бы вызывались соответствующие установки.

Это рекомендуемый подход для любого значения конфигурации, которое является постоянным и известным во время сборки. Вместо вызова сеттера при каждом холодном запуске поставьте значение в файл один раз.

| JSON ключ                         | Тип                                           | Эквивалентные настройки            | Пример значения                          |
| --------------------------------- | --------------------------------------------- | ---------------------------------- | ---------------------------------------- |
| `debug_mode`                      | boolean                                       | Журнал отладки                     | `true`                                   |
| `disable_advertising_identifiers` | boolean                                       | `setDisableAdvertisingIdentifiers` | `true`                                   |
| `currency_code`                   | строка                                        | `setCurrencyCode`                  | `"USD"`                                  |
| `host`                            | object `{ "prefix": строка, "host": string }` | `setHost`                          | `{ "prefix": "", "host": "af-sdk.net" }` |
| `min_time_between_sessions`       | число (int)                | `setMinTimeBetweenSessions`        | `1`                                      |
| `ddlTimeout`                      | число (int, ms)            | `setDeepLinkTimeout`               | `3000`                                   |

> 📘 SDK 6
>
> В SDK 6 не было инициализации на основе файлов. Все настройки были выполнены в коде.

**Example `src/main/assets/af_init_config.json`**

```json
{
  "disable_advertising_identifiers": true,
  "debug_mode": true,
  "currency_code": "USD",
  "host": {
    "prefix": "",
    "host": "af-sdk. et"
  },
  "min_time_between_sessions": 1,
  "ddlTimeout": 3000
}
```

Если файл отсутствует, инициализация продолжается нормально. Неизвестные ключи игнорируются с помощью строки журнала. Несовпадения типов пойманы и регистрируются.

---

### 3. Выберите в app-open referrer и web referrer collection

<span class="annotation-optional">Optional</span>

В SDK 6 SDK SDK автоматически собирает данные app-open referrer и web referrer для всех клиентов в рамках стартового потока. В SDK 7 эта коллекция является выбором.

Если вы хотите, чтобы SDK собирал эти данные, вызовите `collectDataFromLauncherActivity(Activity)` из метода `onCreate` вашего запуска, прежде чем запускать `start()` для этого холодного запуска.

```java Java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    AppsFlyerLib.getInstance().collectDataFromLauncherActivity(this);
}
```

```kotlin Kotlin
переопределить веселье onCreate(savedInstance: Bundle?) {
    super.onCreate(savedInstance)
    AppsFlyerLib.getInstance().collectDataFromLauncherActivity(this)
}
```

> ⚠️ Предупреждение
>
> Данные реферера доступны только на действие, которое получило первоначальное намерение запуска, которое обычно является вашей основной или заставкой активности. Если вы вызываете этот метод вторичной активности, или ваше приложение использует trampoline или навигации, которые создают другие действия, данные о реферерах уже будут утеряны, и ничего не будет собрано. Вызовите этот метод один раз, пока не начнется любая другая деятельность.

---

## Устранение проблем

Следующие сообщения журнала указывают на общие проблемы интеграции. Ищите в вашем логкоте вывод для этих подстрок.

| Симптом                                             | Записывать сообщение для поиска                                                                                                |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `start()` вызван без `registerSessionReadyListener` | `Сессия ReadyListener не зарегистрирована! — Вы должны вызвать registerSessionReadyListener(essionReadyListener) до старта().` |
| API был вызван перед `init()`                       | `AppsFlyer SDK не инициализирован! API вызов '…' должен быть вызван после 'init(String, AppsFlyerConversionListener)'`         |
| Отсутствует ключ 'init()'        | \`Вы должны предоставить AppsFlyer Dev-Key в методе API 'init'                                                                 |
| `init()` вызывается с нулевым контекстом            | `AppsFlyer SDK требует действительного контекста!`                                                                             |
| `start()` вызывается дважды в той же сессии         | `AppsFlyer SDK сессия уже запущена. Пропуск вызова дубликата.`                                                                 |
| Сессия не началась при завершении                   | `AppsFlyer SDK сессия не запущена. Завершение сеанса.`                                                                         |

Включить подробное или отладочное журналирование для вашей интеграции, если сообщения не появляются на уровне по умолчанию.