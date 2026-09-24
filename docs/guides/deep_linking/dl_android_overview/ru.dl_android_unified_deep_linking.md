---
title: Унифицированная глубокая связь Android
slug: dl_android_unified_deep_link
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

**На взгляд:** Унифицированная глубокая связь (UDL) позволяет отправлять новых и существующих пользователей на конкретную работу приложения (например, отдельная страница в приложении), как только приложение будет открыто.

> 📘 **Защита конфиденциальности UDL**
>
> Для новых пользователей метод UDL возвращает только параметры, относящиеся к отложенной глубокой ссылке: `deep_link_value` и `deep_link_sub1-10`. Если вы пытаетесь получить другие параметры (`media_source`, `campaign`, `af_sub1-5`, etc.), они возвращают null.

## Поток

![Android UDL поток!](https://files.readme.io/7309a5f-6577_Unified_Deep_Link_Android.png "Android UDL поток")

Этот поток работает следующим образом:

1. Пользователь кликает на OneLink.
   - Если у пользователя установлено приложение, приложение Android App Links или схема URI открывает приложение.
   - Если у пользователя не установлено, то он перенаправляется в магазин приложений, и после загрузки пользователь открывает приложение.
2. Приложение открывает запускает AppsFlyer SDK.
3. В AppsFlyer SDK запускается UDL API.
4. UDL API извлекает данные OneLink с серверов AppsFlyer
5. UDL API возвращает метод [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking) в классе [`DeepLinkListener`](https://dev.appsflyer.com/hc/docs/deeplinklistener).
6. Метод [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking) получает объект [`DeepLinkResult`](https://dev.appsflyer.com/hc/docs/deeplinkresult).
7. Объект [\`\`DeepLinkResult\`](https://dev.appsflyer.com/hc/docs/deeplinkresult) включает в себя:
   - Статус (Округ/Не найдено/Ошибка)
   - Объект DeepLink, который перевозит:
     - **Для пользователей с приложением еще не установлено**: `deep_link_value` и `deep_link_sub1-10` параметры.
     - **Для пользователей с уже установленным приложением**: Параметры `deep_link_value` и `deep_link_sub1-10` и все параметры, содержащиеся в параметре `link` атрибутивной ссылки OneLink.

## Планирование

- UDL требует AppsFlyer Android SDK V6.1+.

При настройке OneLinks, маркер использует параметры для создания ссылок, и разработчик настраивает поведение приложения на основе полученных значений. Это обязанность разработчика убедиться, что параметры правильно обрабатываются в приложении, как для маршрутизации, так и для персонализации данных по ссылке.

**Чтобы планировать OneLink:**

1. Получите от маркетинга нужное поведение и личные впечатления пользователя, когда он нажимает на URL.
2. Основываясь на желаемом поведении, планируйте `deep_link_value` и другие параметры, необходимые для того, чтобы дать пользователю желаемый личный опыт.
   - `deep_link_value` устанавливается маркером в URL и используется разработчиком для перенаправления пользователя на определенное место внутри приложения. Например, если у вас есть фруктовый магазин и вы хотите направить пользователей к яблокам, значение `deep_link_value` может быть `apples`.
   - Также в URL можно добавить параметры `deep_link_sub1-10`, чтобы персонализировать пользовательский опыт. Например, чтобы дать 10% скидку, значение `deep_link_sub1` может быть `10`.

## Осуществление

[block:html]
{
"html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    border: 1px solid #d8d8d8;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 180px; margin: 0 0; margin-right: 20px\">\n  <div>\n    <h1 style=\"margin-top: 20px\">\n      Let's save you some time  >>\n    </h1>   \n      <h3>\n        Set Deep Linking with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=dl_android_unified_deep_linking');\\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

Реализовать UDL API логику на основе выбранных параметров и значений.

1. Используйте метод [`subscribeForDeepLink()`](https://dev.appsflyer.com/hc/docs/appsflyerlib#subscribefordeeplink) (из `AppsFlyerLib`) перед вызовом [start](doc:android-sdk-reference-appsflyerlib#start), чтобы зарегистрировать слушателя интерфейса [`DeepLinkListener`](https://dev.appsflyer.com/hc/docs/deeplinklistener).
2. Убедитесь, что вы переопределили функцию обратного вызова [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking).
   `onDeepLinking() ` принимает в качестве аргумента объект [`DeepLinkResult`](https://dev.appsflyer.com/hc/docs/deeplinkresult).
3. Используйте [`getStatus()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getstatus) для запроса о том, будет ли найден глубокий совпадение ссылок.
4. Когда статус ошибки, вызовите [`getError()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#geterror) и запустите ваш поток ошибок.
5. При обнаружении статуса используйте [`getDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getdeeplink) для получения объекта [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink).
   Объект `DeepLink содержит глубокую информацию о ссылках и вспомогательные функции, чтобы легко получить значения из известных ключей OneLink, например, [`getDeepLinkValue()\`](https://dev.appsflyer.com/hc/docs/deeplink#getdeeplinkvalue).
6. Используйте [`getDeepLinkValue()`](https://dev.appsflyer.com/hc/docs/deeplink#getdeeplinkvalue) для получения `deep_link_value`.
7. Используйте [`getStringValue("deep_link_sub1")`](https://dev.appsflyer.com/hc/docs/deeplink#getstringvalue) для получения `deep_link_sub1`. Сделайте то же самое для параметров `deep_link_sub2-10`, изменив требуемое строковое значение.
8. После извлечения `deep_link_value` и `deep_link_sub1-10` передайте их маршрутизатору внутри приложения и используйте его для персонализации пользовательского опыта.

> 📘 **Примечание**
>
> `onDeepLinking` не вызывается, когда приложение запущено в фоновом режиме, и не стандартный режим запуска.
> Чтобы исправить это, вызовите метод `setIntent(intent)`, чтобы установить значение intent внутри метода `onNewIntent`, если приложение использует нестандартный LaunchMode.
>
> ```java
>        import android.content.Intent;
>        ...
>        ...
>        ...
>        @Override
>        protected void onNewIntent(Intent intent) 
>        { 
>           super.onNewIntent(intent);     
>           setIntent(intent);
> }
> ```

### Поддержка устаревших OneLink ссылок

Устаревшие OneLink это ссылки, которые не содержат параметров, рекомендованных для UDL: `deep_link_value` и `deep_link_sub1-10`.
Обычно это уже существующие и используемые ссылки при переходе с традиционных методов на UDL.
Новые пользователи, использующие старые ссылки, обрабатываются `onConversionDataSuccess` в контексте [Расширенная углубленная ссылка](dl_android_ocds_ddl).
UDL управляет глубокой связью для существующих пользователей. В этом случае рекомендуется добавить поддержку в UDL callback `onDeepLinking` для старых параметров.
[Пример кода Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/bcf13e588561af3739bafbab510d6c3a7fb4e08a/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L81-L89)

### Пример кода

```java
appsflyer. ubscribeForDeepLink(new DeepLinkListener
    @Override
    public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult) {
        DeepLinkResult. tatus dlStatus = deepLinkResult.getStatus();
        if (dlStatus == DeepLinkResult. tatus.FOUND) {
            Log. (LOG_TAG, "Глубокая ссылка найдена");
        } else if (dlStatus == DeepLinkResult. tatus.NOT_FOUND) {
            Лог. (LOG_TAG, "Глубокая ссылка не найдена");
            возвращение;
        } else {
            // dlStatus == DeepLinkResult. tatus.ERROR
            DeepLinkResult.Error dlError = deepLinkResult. etError();
            Журнал. (LOG_TAG, "Возникла ошибка при получении данных Deep Link: " + dlError. oString());
            возвращение;
        }
        DeepLink deepLinkObj = deepLinkResult. etDeepLink();
        try {
            Log. (LOG_TAG, "The DeepLink данные: " + deepLinkObj. oString());
        } catch (Exception e) {
            Log. (LOG_TAG, "Данные DeepLink вернулись назад нуль");
            возвращение;
        }
        // Пример для использования is_deferred
        if (deepLinkObj. sDeferred()) {
            Log. (LOG_TAG, "Это отложенная глубокая ссылка");
        } else {
            Log. (LOG_TAG, "Это прямая глубокая ссылка");
        }
        
        // ** Далее утверждение является необязательным **
        // Наше приглашение в пример приложения имеет идентификатор referrerID в deep_link_sub2
        // Смотрите раздел user-invite в FruitActivity. ava
        if (dlData. as("deep_link_sub2")){
            referrerId = deepLinkObj. etStringValue("deep_link_sub2");
            Журнал. (LOG_TAG, "The referrerID является: " + referrerId);
        } else {
            Log. (LOG_TAG, "deep_link_sub2/Referrer ID не найдено");
        }
        // Пример использования общего getter
        String fruitName = "";
        try {
            fruitName = deepLinkObj. etDeepLinkValue();
            Лог. (LOG_TAG, "The DeepLink будет маршрутизироваться в: " + fruitName);
        } catch (Exception e) {
            Log. (LOG_TAG, "Пользовательский параметр fruit_name не найден в данных DeepLinка");
            return;
        }
        goToFruit(фрукты, deepLinkObj);
    }
});
```

```kotlin
AppsFlyerLib.getInstance().subscribeForDeepLink(object : DeepLinkListener{
    переопределить веселье onDeepLinking(deepLinkResult: DeepLinkResult) {
        when (deepLinkResult. tatus) {
            DeepLinkResult.Status. OUND -> {
                Log. (
                    LOG_TAG, Обнаружена глубокая ссылка"
                )
            }
            DeepLinkResult. tatus.NOT_FOUND -> {
                Лог. (
                    LOG_TAG, Глубокая ссылка не найдена"
                )
                return
            }
            else -> {
                // dlStatus == DeepLinkResult. tatus.ERROR
                val dlError = deepLinkResult. rror
                журнал. (
                    LOG_TAG, Ошибка получения данных Deep LinkObj: $dlError"
                )
                return
            }
        }
        var deepLinkObj: DeepLink = deepLinkResult. eepLink
        try {
            Log. (
                LOG_TAG, Данные DeepLink: $deepLinkObj"
            )
        } catch (e: Exception) {
            Log. (
                LOG_TAG, Данные DeepLink вернулись в null"
            )
            return
        }

        // Пример для использования is_deferred
        if (deepLinkObj. sDeferred == true) {
            Log. (LOG_TAG, "Это отложенная глубокая ссылка");
        } else {
            Log. (LOG_TAG, "Это прямая глубокая ссылка");
        }

        try {
            val fruitName = deepLinkObj. eepLinkValue
            журнал. (LOG_TAG, "DeepLink будет маршрутизирован: $fruitName")
        } catch (e:Exception) {
            Log. (LOG_TAG, "Произошла ошибка: $e");
            возвращения;
        }
    }
})
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/master/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L31-L70)

## Тестирование отложенных глубинных связей

### Предпосылки

- Complete UDL [integration](#implementation)
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996)
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) в приложении
- Убедитесь, что приложение не установлено на вашем устройстве
- Запросите у вашего маркетинга шаблон OneLink.
  - Будет выглядеть так: `https://onelink-basic-app.onelink.me/H5hv`.
  - В этом примере используется поддомен OneLink `onelink-basic-app.onelink.me` и шаблон ID OneLink `H5hv`

### Тестовая ссылка

Вы можете использовать существующую ссылку OneLink или попросить вашего маркетинга создать новую для тестирования. Можно использовать как короткие, так и длинные OneLink URL.

#### Добавление параметров ad-hoc к существующей ссылке

- Используйте только шаблон домена и OneLink, например: `https://onelink-basic-app.onelink.me/H5hv`.
- Добавьте параметры OneLink `deep_link_value` и `deep_link_sub1-10`, как ожидалось в вашем приложении. Параметры следует добавить в параметры запроса.
  - Пример: `https://onelink-basic-app.onelink.me/H5hv?pid=my_media_source&deep_link_value=apples&deep_link_sub1=23`

### Выполните тест

1. Нажмите ссылку на вашем устройстве.
2. OneLink перенаправляет вас в соответствии с настройками ссылки либо на Google Play, либо на веб-сайт.
3. Установите приложение.

> \*\* Важное \*\*
>
> - Если приложение все еще находится в разработке, и еще не загружено в магазин, вы видите это изображение:> <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style={{textAlign: "center"}} />
> - Установите приложение из _Android Studio_ или любого другого IDE, который вы используете.

4. UDL обнаруживает отсроченные глубокие ссылки, соответствует установке на клик и получает параметры OneLink в обратный вызов `onDeepLinking`.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны **только** когда включен режим отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).

- Инициализация SDK:
  ```
  D/AppsFlyer_6.9.0: Инициализация AppsFlyer SDK: (v6.9.0.126)
  ```
- В нижеследующем журнале говорится о глубоких связях, которые могут игнорироваться в отсроченном сценарии увязки:
  ```
  D/AppsFlyer_6.9.0: Глубокая ссылка не обнаружена
  ```
- UDL API starts:
  ```
  D/AppsFlyer_6.9.0: [DDL] запуск
  ```
- UDL отправляет запрос в AppsFlyer для запроса соответствия с этой установкой:
  ```
  D/AppsFlyer_6.9.0: [DDL] Подготовка запроса 1
  ...
  I/AppsFlyer_6.9.0: вызов = https://dlsdk.appsflyer.com/v1.0/android/com.appsflyer.onelink. ppsflyeronelinkbasicapp?af_sig=<>&sdk_version=6.9; size = 239 байт; body = {
        . .
        TRUNCATED
        ...
  }
  ```
- UDL получил ответ и вызовы `onDeepLinking` с данными ссылки `status=FOUND` и OneLink:
  ```
  D/AppsFlyer_6.9.0: [DDL] Calling onDeepLinking with:
    {"deepLink":"{\"campaign_id\":\"\",\"af_sub3\":\"\",\"match_type\":\"probabilistic\",\"af_sub1\":\"\",\"deep_link_value\":\"apples\",\"campaign\":\"\",\"af_sub4\":\"\",\"timestamp\":\"2022-12-06T11:47:40.037\",\"click_http_referrer\":\"\",\"af_sub5\":\"\",\"media_source\":\"\",\"af_sub2\":\"\",\"deep_link_sub1\":\"23\",\"is_deferred\":true}","status":"FOUND"}

  ```

## Тестирование глубоких связей (ссылки на приложения Android)

### Предпосылки

- Complete UDL [integration](#implementation)
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996)
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) в приложении
- Убедитесь, что приложение уже установлено на вашем устройстве
- Запросите у вашего маркетинга шаблон OneLink.
  - Будет выглядеть что-то вроде `https://onelink-basic-app.onelink.me/H5hv`.
  - В этом примере используется поддомен `onelink-basic-app.onelink.me` и шаблон ID OneLink `H5hv`.
- [Настройка ссылок на приложения Android](dl_android_init_setup#procedures-for-android-app-links).

### Создать тестовую ссылку

Используйте тот же метод, что и в [отложенной глубокой ссылке](#testing-deferred-deep-linking).

### Выполните тест

1. Нажмите ссылку на вашем устройстве.
2. UDL обнаруживает ссылку на приложение Android и получает параметры OneLink в `onDeepLinking`.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны **только** когда включен режим отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).

- Если ссылка является OneLink короткой ссылкой (например, https://onelink-basic-app.onelink.me/H5hv/apples)
  ```
  D/AppsFlyer_6.9.0: HTTP: [258990367] GET:https://onelink.appsflyer.com/shortlink-sdk/v2/H5hv?id=яблоки 
  ```
- UDL вызовы `onDeepLinking` с данными `status=FOUND` и OneLink
  ```
  D/AppsFlyer_6.9.0: [DDL] Вызов onDeepLinking с:
      {"deepLink":"{\"path\":\"\\\/H5hv\",\"scheme\":\"https\",\"link\":\"https:\\\/\\\/onelink-basic-app.onelink.me\\\/H5hv?deep_link_value=apples&deep_link_sub1=23\",\"host\":\"onelink-basic-app.onelink.me\",\"deep_link_sub1\":\"23\",\"deep_link_value\":\"apples\",\"is_deferred\":false}","status":"FOUND"}
  ```

> 📘 **Подсказка**
> Если при нажатии на приложение Android привязать ОС показывает диалоговое окно Disambiguation или перенаправляется на Google Play или веб-сайт, проверьте, правильно ли подпись SHA256.
>
> 1. Используйте `adb`, чтобы получить подпись приложения на устройстве:
>
> ```
> adb shell pm get-app-links <PACKAGE_NAME>
> ```
>
> -2. Убедитесь, что поддомен `verified`.
> ![adb проверен!](https://files.readme.io/f0086fb-Screen_Shot_2022-12-06_at_17.05.10.png "adb проверен")
>
> 3. Если поддомен не верифицирован, он показывает `1024`.
>    ![adb проверен!](https://files.readme.io/f98642e-Screen_Shot_2022-12-06_at_17.05.22.png "adb проверен")
