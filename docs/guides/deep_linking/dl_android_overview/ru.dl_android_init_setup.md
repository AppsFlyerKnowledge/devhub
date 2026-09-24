---
title: Android initial setup
slug: dl_android_init_setup
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

**На взгляд**: первоначальная настройка приложения позволяет маркетологу создать ссылки, которые отправляют существующие пользователи приложения непосредственно в приложение. Первоначальная настройка также является обязательным условием глубокой связи и отсрочки глубокой связи.

## Методы открытия приложения

Есть два метода открытия приложения, которые могут быть реализованы для покрытия всей вашей пользовательской базы. Используемый метод зависит от версии мобильной платформы.

Эти два метода и инструкции по их применению подробно описаны в следующих разделах.

| Метод                            | Описание                                                                                | Версии Android     | Процедура                                                                                                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------- | ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Ссылки на приложение Android** | Открывает мобильное приложение по умолчанию.                            | Android V6+        | <ol><li>[Сгенерировать отпечатки пальца SHA256](#generating-a-sha256-fingerprint)</li><li> [Добавить intent-фильтр в основную деятельность.](#adding-app-link-intent-filter-to-main-activity)</li></ol>                                 |
| **URI Scheme**                   | Открывает приложение на основе пути активности, указанного в схеме URI. | Андроид все версии | <ol><li>[Решить схему URI с маркером.](#deciding-on-a-uri-scheme) </li><li> [Добавить intent-filter к основной активности. (#adding-uri-scheme-intent-filter-to-the-main-activity) </li><li> [Testing](#testing-uri-schemes) </li></ol> |

## Процедуры для Ссылки приложения Android

Ссылки Android App работают с Android V6 и выше. [Подробнее](https://support.appsflyer.com/hc/en-us/articles/115005314223).

### Генерация отпечатка SHA256 во время разработки

1. Найдите [магазин ключей приложения](https://developer.android.com/training/articles/keystore).
   Если приложение всё ещё находится в разработке, найдите `debug.keystore`
   - Для пользователя Windows: `C:\Users\USERNAME\.android\debug.keystore`
   - Для пользователей Linux или Mac OS: `~/.android/debug.keystore`
2. Откройте командную строку и перейдите в ту папку, в которой находится файл keystore .
3. Выполнить команду:

```shell
// keytool -list -v -keystore <<KEY_STORE_FILE>>
// Например, файл keystore 
keytool -list -v -keystore ~/.android/debug.keystore
```

> 🚧
>
> Пароль для debug.keystore обычно \"android\".

Вывод должен выглядеть следующим образом:

```text
Alias name: test
Creation date: Sep 27, 2017
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=myname
Issuer: CN=myname
Serial number: 365ead6d
Valid from: Wed Sep 27 17:53:32 IDT 2017 until: Sun Sep 21 17:53:32 IDT 2042
Certificate fingerprints:
MD5: DB:71:C3:FC:1A:42:ED:06:AC:45:2B:6D:23:F9:F1:24
SHA1: AE:4F:5F:24:AC:F9:49:07:8D:56:54:F0:33:56:48:F7:FE:3C:E1:60
SHA256: A9:EA:2F:A7:F1:12:AC:02:31:C3:7A:90:7C:CA:4B:CF:C3:21:6E:A7:F0:0D:60:64:4F:4B:5B:2A:D3:E1:86:C9
Signature algorithm name: SHA256withRSA
Version: 3
Extensions:
#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
  KeyIdentifier [
   0000: 34 58 91 8C 02 7F 1A 0F  0D 3B 9F 65 66 D8 E8 65 
   0010: 74 42 2D 44                    
 ]
]
```

4. Отправьте SHA256 обратно к маркетологу.

### Создание SHA256 отпечатка пальца во время производства

\*\*Отпечаток SHA256 сгенерирован в \*\*

1. В _Google Play console_ Найдите публичный отпечаток SHA256 в **Setup -> App signing** (см. изображение ниже)

![Сертификат Google Play SHA256!](https://files.readme.io/8574437-Screenshot_2023-11-27_at_11.30.43.png "Сертификат Google Play SHA256")

2. Отправьте SHA256 обратно к маркетологу.

### Добавление целевого фильтра App Link к основной активности

1. Получить автоматически сгенерированный intent-filter код из [marketer](https://support.appsflyer.com/hc/en-us/articles/207032246#add-redirection-logic-for-existing-app-users). Код intent-filter используется в AndroidManifest.XML.
2. Откройте файл `AndroidManifest.xml` в приложении.
3. Добавить intent-filter в **основную деятельность**.

#### Пример

```xml XML
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />

    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    
    <!-- Заменить "onelink-basic-app" своим доменом OneLink -->
    <data
        android:host="onelink-basic-app.onelink.me"
        android:scheme="https" />
</intent-filter>
```

> i
>
> Когда `android:autoVerify="true"` присутствует на любом из ваших настроенных фильтров, установка вашего приложения на устройства с Android 6 и выше приводит к тому, что система пытается проверить все хосты, связанные с URL-адресами, с любыми фильтрами намерений вашего приложения.
> Для каждого уникального имени хоста, найденного в приведенных выше intent фильтрах, Android запрашивает соответствующие веб-сайты для файла Links Digital Asset на `https://hostname/.well-known/assetlinks.json`. После того, как логика [перенаправляет существующих пользователей приложения](https://support.appsflyer.com/hc/en-us/articles/207032246-OneLink-templates#add-redirection-logic-for-existing-app-users) на конфигурацию шаблона OneLink, AppsFlyer создаёт и размещает этот путь для вас.  
> [Подробнее](https://developer.android.com/training/app-links/verify-site-associations#request-verify)

Github ссылка: [XML](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/AndroidManifest.xml#L39-L49)

4. Сообщите маркету о том, что конфигурация App Link завершена.
   Когда маркер проверяет ссылку, он должен направить пользователя на главную страницу приложения.

> 📘 **Уточните, какие шаблоны открывают ваше приложение**
>
> Вы можете указать, какие шаблоны открывают ваше приложение, добавив их в элемент `pathPrefix`, как показано в примере ниже:
>
> ```xml XML
> <intent-filter android:autoVerify="true">
>   	...		
>    <!-- Заменить "onelink-basic-app" своим OneLink доменом -->
>    <data 
>        android:scheme="https"
>        android:host="onelink-basic-app.onelink.me" 
>        android:pathPrefix="/H5hv" />
>    <data 
>        android:scheme="https"
>        android:host="onelink-basic-app.onelink.me" 
>        android:pathPrefix="/H2jv" />
> </intent-filter>
> ```

## Процедуры для схемы URI

Схема URI - это URL, который ведет пользователей непосредственно к мобильному приложению.

Когда пользователь приложения вводит схему URI в адресную строку браузера, или кликает по ссылке, основанной на схеме URI, запускается приложение, и пользователь глубоко связан.

Всякий раз, когда App Link не удается открыть приложение, схема URI может быть использована как резервная копия для открытия приложения.

### Решение по схеме URI

**Определить схему URI:**

1. Связаться с продавцом.
2. Выберите схему URI. Например: `yourappname://`

> i
>
> - Используйте схему URI, которая является как можно более уникальной для вашего приложения и бренда, чтобы избежать случайного дублирования с другими приложениями в экосистеме. Перекрытие с другими приложениями является неотъемлемой проблемой в характере протокола схемы URI.
> - Схема URI не должна начинаться с _http_ или _https_.
> - Схема URI должна быть аналогичным образом определена на Android и iOS.

3. Отправить схему URI продавцу. Например: `afshopapp://mainactivity`

### Добавление схемы URI intent-filter к основной активности

**Чтобы добавить intent-фильтр в основную деятельность:**

1. Откройте файл `AndroidManifest.xml` в приложении.
2. Добавить следующий фильтр в **основную деятельность**.
   В разделе «data» замените «host» и «scheme» на выбранный URI схему. В коде intent-filter ниже `host="mainactivity"` и `scheme="afshopapp"`, соответствующие схеме URI `afshopapp://mainactivity`.
   Если в основной активности уже есть intent-фильтр для схемы URI, перезапишите его.

```xml XML
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />

    <data
        android:host="mainactivity"
        android:scheme="afshopapp" />
</intent-filter>
```

⇲ Github link: [XML][uri_intent_filter]

3. Дать маркетингу схему URI.

[uri_intent_filter]: https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/src/main/AndroidManifest.xml#L29-L38

### Тестирование схем URI

**Требования**:

Устройство Android с установленным приложением. Убедитесь, что это исходный код приложения и версия, где вы внесли изменения и реализовали App Links и/или схему URI.

**Для тестирования схемы URI**:

1. Свяжитесь с маркетом и получите пользовательскую ссылку, которую они создали.
2. Отправьте короткий или длинный URL-адрес, который Маркетер предоставляет вам на ваш телефон. Вы можете:
   - Сканируйте QR-код с помощью камеры телефона или приложения QR-сканера.
   - Отправьте по электронной почте или WhatsApp самостоятельно ссылку и откройте ее на своем телефоне.
3. Нажмите ссылку на вашем мобильном устройстве.
   Приложение должно быть открыто на домашнем экране.

[1]: https://support.appsflyer.com/hc/en-us/articles/207033836?__hstc=215508872.986091deeadbd815ef04121e1d880589.1586684365062.1591196345127.15912728952.29&__hssc=215508872.2.15912728952&__hsfp=3667076369 "Заголовок"
