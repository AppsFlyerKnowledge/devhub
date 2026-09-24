---
title: Интеграция SDK
slug: интегрировать-Андроид-sdk
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-6
content:
  excerpt: Узнайте, как инициализировать и запустить Android SDK.
privacy:
  view: публичный
position: 2
---

## Рекомендовано

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Начните с мастера интеграции SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_int', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

- Вы должны [установить Android SDK](doc:install-android-sdk).
- Убедитесь, что в вашем приложении `build.gradle` значение `applicationId` (в блоке `defaultConfig`) соответствует ID приложения в AppsFlyer.
- Получить [AppSFlyer dev ключ](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key). Необходимо успешно инициализировать SDK.

## Инициализация Android SDK

Рекомендуется инициализировать SDK в \[глобальном классе/подклассе приложений]. Это должно обеспечить запуск SDK в любом сценарии (например, глубокая связь).

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

```java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);
```

```kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, это)
```

1. Первым аргументом является ваш AppsFlyer dev ключ.
2. Второй аргумент — это Nullable [`AppsFlyerConversionListener`](doc:android-sdk-reference-appsflyerconversionlistener). Если в качестве второго аргумента вам не нужны данные конвертации, мы рекомендуем передать `null`. Дополнительную информацию см. в разделе [Данные конверсии](doc:conversion-data-android).
3. Третьим аргументом является контекст приложения.

## Запуск Android SDK

В методе `onCreate` приложения, после вызова [`init`](doc:android-sdk-reference-appsflyerlib#init), вызовите [`start`](doc:android-sdk-reference-appsflyerlib#start) и передайте контекст приложения в качестве первого аргумента:

```java
AppsFlyerLib.getInstance().start(this);
```

```kotlin
AppsFlyerLib.getInstance().start(this)
```

### Отсрочка запуска SDK

<span class="annotation-optional">Опционально</span>  
Вы можете отложить инициализацию SDK, вызвав [`start`](doc:android-sdk-reference-appsflyerlib#start) от класса действия, вместо того, чтобы вызвать его в классе Приложения. [`init`](doc:android-sdk-reference-appsflyerlib#init) все еще следует вызвать в классе приложения.

Типичное использование отложенного SDK - когда приложение хочет получить согласие пользователя на сбор данных в основной активности, и позвоните [`start`](doc:android-sdk-reference-appsflyerlib#start) после получения согласия пользователя.

> ⚠️ **Важная запись**
>
> Если приложение вызывает `start` из активности, оно должно передавать **контекст действия** в SDK.  
> Неудача передать контекст активности не вызовет SDK, тем самым теряя атрибуционные данные и внутриприложенные события.

### Начиная с слушателя ответа

Чтобы получить подтверждение того, что SDK был успешно запущен, создайте объект `AppsFlyerRequestListener` и передайте его в качестве третьего аргумента `start`:

```java
AppsFlyerLib.getInstance().start(getApplicationContext(), <YOUR_DEV_KEY>, new AppsFlyerRequestListener() {
  @Override
  public void onSuccess() {
    Log. (LOG_TAG, "Запуск успешно отправлен, получено 200 кода ответа от сервера");
  }
  
  @Override
  публичная избегайте onError(int i, @NonNull String s) {
    Log. (LOG_TAG, "Запуск не был отправлен:\n" +
          "Код ошибки: " + i + "\n"
          + "Описание ошибки: " + s);
  }
});
```

```kotlin
AppsFlyerLib.getInstance().start(this, <YOUR_DEV_KEY>, object : AppsFlyerRequestListener {
  override fun onSuccess() {
    Log. (LOG_TAG, "Запуск успешно отправлен")
    }
  
  переопределить веселье onError(errorCode: Int, errorDesc: String) {
    Log. (LOG_TAG, "Запуск не был отправлен:\n" +
          "Код ошибки: " + errorCode + "\n"
          + "Описание ошибки: " + errorDesc)
    }
})
```

- Метод обратного вызова `onSuccess()` вызывается для каждого ответа `200` на запрос атрибуции, сделанный SDK.
- Метод обратного вызова `onError(String error)` вызывается для любого другого ответа и возвращает ответ как строку ошибки.

## Полный пример

Следующий пример показывает, как инициализировать и запустить SDK из класса приложения.

```java
импорт android.app.Application;
import com.appsflyer.AppsFlyerLib;
// ...
public class AFApplication extends Application {
    // ...
    @Override
    public void onCreate() {
        super. nCreate();
        // ...
        AppsFlyerLib. etInstance().init(<YOUR_DEV_KEY>, null, this);
        AppsFlyerLib. etInstance().start(this);
        // ...
    }
    // ...
}
```

```kotlin
импортировать android.app.Application
импортировать com.appsflyer.AppsFlyerLib
// ...
класс AFApplication : Application() {
    переопределить fun onCreate() {
        super. nCreate()
        // . .
        AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)
        AppsFlyerLib. etInstance().start(this)
        // ...
    }
    // ...
}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/80763ef8c93c49b1f0226455ae35d089f7968ede/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L144-L145)

Смотрите [Установка ID пользователя](doc:customer-user-id-android) чтобы связать CUID с этой интеграцией.

## Записывать сессии

SDK отправляет сообщение `af_app_opened` всякий раз, когда приложение открыто или доставлено на передний план.  Перед отправкой сообщения SDK проверяет, что время, прошедшее с момента отправки последнего сообщения, не меньше, чем предопределенный интервал.

### Установка интервала времени между запусками приложения

Вызовите [`setMinTimeBetweenSessions`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setmintimebetweensessions), чтобы установить минимальный временной интервал между двумя сообщениями `af_app_opened`. По умолчанию интервал 5 секунд.

### Сессии ведения журнала вручную

Сессии можно записывать вручную при помощи вызова [`logSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#logsession).

## Включение режима отладки

<span class="annotation-optional">Опционально</span>  
Вы можете включить отладочные журналы, вызвав [`setDebugLog`](doc:android-sdk-reference-appsflyerlib#setdebuglog):

```java
AppsFlyerLib.getInstance().setDebugLog(true);
```

```kotlin
AppsFlyerLib.getInstance().setDebugLog(true)
```

> 📘 Заметка
>
> Чтобы увидеть полные журналы отладок, перед вызовом других методов SDK убедитесь вызвать `setDebugLog`.
>
> See [example](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/d3d0d9dcf1c1dcb2f873f5b50708fc4fa24a7868/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L28).

> 🚧 Предупреждение
>
> Чтобы избежать утечки конфиденциальной информации, убедитесь, что логи отладки отключены перед распространением приложения.

## Проверить интеграцию

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Простой тест с помощью мастера SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=integrate-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_test', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

> **Примечание**
>
> Если вы не хотите использовать рекомендованный мастер вы можете найти подробные инструкции по тестированию [here](doc:manual-testing-android).

Для полного устранения неполадок смотрите контрольный список [Troubleshooting](doc:troubleshooting-android).

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

[global Application class/subclass]: https://developer.android.com/reference/android/app/Application
