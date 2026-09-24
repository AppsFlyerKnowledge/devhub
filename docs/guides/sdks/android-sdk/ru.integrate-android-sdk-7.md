---
title: Интеграция Android SDK 7
slug: integrate-android-sdk-7
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-7
privacy:
  view: публичный
position: 2
---

## Инициализация Android SDK

Рекомендуется инициализировать SDK в [глобальном классе/подклассе приложений](https://developer.android.com/reference/android/app/Application). Это гарантирует, что SDK может быть запущен в любом сценарии, в том числе в глубокой связи.

**Шаг 1: Импортируйте AppsFlyerLib**  
В глобальном классе приложения, импортируйте [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib):

```java Java
импортировать com.appsflyer.AppsFlyerLib;
```

```kotlin Kotlin
импортировать com.appsflyer.AppsFlyerLib
```

**Шаг 2: Инициализация SDK**  
В глобальном приложении `onCreate`, вызовите [`init`](doc:android-sdk-reference-appsflyerlib#init) со следующими аргументами:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, это)
```

1. Первым аргументом является ваш AppsFlyer dev ключ.
2. Второй аргумент является nullable [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener). Если вам не нужны данные для преобразования передайте `null`. Дополнительную информацию см. в разделе [Данные конверсии](doc:conversion-data-android).
3. Третьим аргументом является контекст приложения.

---

## Настройка SDK с помощью af_init_config.json

<span class="annotation-optional">Optional</span>

SDK V7 представляет помощник по инициализации на основе файлов. Если вы поместите файл `af_init_config. son` в папке `src/main/assets/`, SDK читает его во время `init()` и применяет поддерживаемые ключи как если бы вызывались соответствующие установки. Это рекомендуемый подход для любого значения конфигурации, которое является постоянным и известным во время сборки.

| JSON ключ                         | Тип                                | Эквивалентные настройки            | Пример значения                          |
| --------------------------------- | ---------------------------------- | ---------------------------------- | ---------------------------------------- |
| `debug_mode`                      | boolean                            | Журнал отладки                     | `true`                                   |
| `disable_advertising_identifiers` | boolean                            | `setDisableAdvertisingIdentifiers` | `true`                                   |
| `currency_code`                   | строка                             | `setCurrencyCode`                  | `"USD"`                                  |
| `host`                            | объект                             | `setHost`                          | `{ "prefix": "", "host": "af-sdk.net" }` |
| `min_time_between_sessions`       | число (int)     | `setMinTimeBetweenSessions`        | `1`                                      |
| `ddlTimeout`                      | число (int, ms) | `setDeepLinkTimeout`               | `3000`                                   |

**Example: `src/main/assets/af_init_config.json`**

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

> 📘 Заметка
>
> Если файл отсутствует, инициализация продолжается нормально. Неизвестные ключи игнорируются. Несовпадения типов пойманы и регистрируются.

---

## Запуск Android SDK

Вы контролируете, когда SDK запускает свою первую сессию. Используйте `registerSessionReadyListener`, чтобы получать уведомления, когда SDK готов, а затем вызывайте `start()` при выполнении условий вашего приложения.

### Без предварительных условий

Если вашему приложению не нужно ждать согласия, CUID или любого другого условия перед отправкой первой сессии, вызов `start()` непосредственно внутри прослушивающего обратного вызова:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().start();
});
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().start()
}
```

### С предварительными условиями

Если ваше приложение должно удовлетворять условиям, перед отправкой первого сеанса - например, сбор согласия пользователя или получение CUID от вашего бэкэнда, используйте класс координатора для синхронизации готовности SDK к собственным условиям вашего приложения. Создайте координатора, который отслеживает сигналы и вызовы «start()» только при выполнении обоих условий:

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

AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
AppsFlyerLib.getInstance(). egisterSessionReadyListener(() -> {
    startupManager.onAfSdkReadyToStart();
});

// Когда процесс вашего согласия завершается:
// startupManager.onConsentReady();
```

```kotlin Kotlin
val startupManager = AfSdkStartupManager()

AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
AppsFlyerLib.getInstance(). egisterSessionReadyListener {
    startupManager.onAfSdkReadyToStart()
}

// По завершении вашего согласия:
// startupManager.onConsentReady()
```

> ⚠️ Вызов `registerSessionReadyListener` вызывается в фоновом потоке. Если ваши условия также решаются в фоновом потоке, убедитесь, что флаги координатора являются потоками безопасными — отметьте их в Java или `@Volatile` в Kotlin.

### Полный пример

Следующий пример показывает, как инициализировать и запустить SDK из класса приложений без предварительных условий.

```java Java
импортируйте android.app.Application;
импортируйте com.appsflyer. ppsFlyerLib;

public class AFApplication extends Application {
    @Override
    public void onCreate() {
        super. nCreate();
        AppsFlyerLib. etInstance().init(<YOUR_DEV_KEY>, null, this);
        AppsFlyerLib.getInstance(). egisterSessionReadyListener(() -> {
            AppsFlyerLib. etInstance().start();
        });
    }
}
```

```kotlin Kotlin
импортируйте android.app.Application
импортируйте com.appsflyer. ppsFlyerLib

класс AFApplication : Application() {
    переопределить fun onCreate() {
        super. nCreate()
        AppsFlyerLib. etInstance().init(<YOUR_DEV_KEY>, null, this)
        AppsFlyerLib.getInstance(). egisterSessionReadyListener {
            AppsFlyerLib. etInstance().start()
        }
    }
}
```

---

Смотрите [Установка ID пользователя](doc:customer-user-id-android-7) чтобы связать CUID с этой интеграцией.

---

## Обеспечение активности лаунчера

SDK необходимо получить запуск запуска, чтобы определить, какая сущность запустила приложение. Чтобы включить его, вызовите `collectDataFromLauncherActivity(this)` в методе `onCreate` вашего лаунчера активности перед запуском `start()` для этого холодного запуска.

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

> ⚠️ Данные реферера доступны только на действие, которое получило первоначальное намерение запуска, которое обычно является вашей основной или заставку активности. Вызовите этот метод один раз, пока не начнется любая другая деятельность.

---

## Включение режима отладки

<span class="annotation-optional">Optional</span>

Вы можете включить отладочные журналы, вызвав [`setDebugLog`](doc:android-sdk-reference-appsflyerlib#setdebuglog):

```java Java
AppsFlyerLib.getInstance().setDebugLog(true);
```

```kotlin Kotlin
AppsFlyerLib.getInstance().setDebugLog(true)
```

> 📘 Заметка
>
> Чтобы увидеть полные журналы отладок, перед вызовом других методов SDK убедитесь вызвать `setDebugLog`.

> 🚧 Предупреждение
>
> Чтобы избежать утечки конфиденциальной информации, убедитесь, что логи отладки отключены перед распространением приложения.

> 📘 Заметка
>
> В качестве альтернативы, вы можете включить режим отладки во время сборки, установив `"debug_mode": true` в файле `af_init_config.json`. См. [Настройка SDK с af_init_config.json](#configuring-the-sdk-with-af_init_configjson) выше.

---

## Проверить интеграцию

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Простой тест с помощью мастера SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk-7');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Примечание**
>
> Если вы не хотите использовать рекомендованный мастер вы можете найти подробные инструкции по тестированию [here](doc:manual-testing-android).

Для полного устранения неполадок смотрите контрольный список [Troubleshooting](doc:troubleshooting-android-7).

### Создание приложения для отладки Android

<span class="annotation-optional">Optional</span>  
You can utilize Android Studio's build variants to configure an easy-to-use debug app for testing purposes.

Все тесты могут быть выполнены как для производственных, так и для отладочных приложений.

**Шаг 1: Настройте Gradle `debug` сборки**  
На вашем уровне `build. файл `debug`[build type](https://developer.android.com/studio/build/build-variants#build-types) и установите`applicationIdSuffix`на имя тестового приложения (в данном случае`.debug\`).

```groovy
android {
    // ...
    buildTypes {
        // Предотвращает ошибку подписи при построении production app
        release {
            signingConfig signingConfigs. ebug
        } 
        debug {
            applicationIdSuffix ". ebug"
        }
    }
}
```

**Шаг 2: Добавьте новое приложение к AppsFlyer**  
Используйте полученное имя пакета в качестве ID приложения при [добавлении приложения на панели AppsFler](https://support.appsflyer.com/hc/en-us/articles/207377436), или попросите члена команды с доступом к панели управления добавить ее.

Например, если у вас есть приложение с именем пакета `com.your. Вы используете вышеуказанную конфигурацию Gradle, имя тестового приложения будет `com.your.app.debug\`. Передайте это имя как ID приложения при добавлении приложения в AppsFlyer.
