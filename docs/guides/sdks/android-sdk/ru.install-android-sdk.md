---
title: Установить SDK
slug: install-android-sdk
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-6
content:
  excerpt: Узнайте, как загрузить и установить Android SDK.
privacy:
  view: публичный
position: 1
---

## Рекомендовано

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Начните с мастера интеграции SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=install-android-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_install', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

## Установка Android SDK

Установите Android SDK используя предпочтительный метод: Via [Gradle](#install-using-gradle), или [manually](#manual-install).

### Установить с помощью Gradle

[block:html]
{
"html": "<span class=\"annotation-recommended\">Рекомендовано</span>"
}
[/block]

**Шаг 1: Объявить репозитории**  
В файле `build.gradle` проекта объявить репозиторий `mavenCentral`:

```groovy
//
репозитории {
   mavenCentral()
}
/// ...
```

**Шаг 2: Добавить зависимости**  
В файле `build.gradle` добавьте [latest Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) пакет:

```groovy
dependencies {
    // Получить последнюю версию с https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk
    implementation 'com.appsflyer:af-android-sdk:<<HERE_LATEST_VERSION>>'
    // Например,
    // implementation 'com.appsflyer:af-android-sdk:6.12.1'
}
```

### Ручная установка

[block:html]
{
"html": "<details><summary></summary>\n<div class=\"af__accordion\">\n  <ol>\n    <li>В <strong>Android Studio</strong>, переведите структуру папок с <strong>Android</strong> на <strong>Project</strong>:\n      <img src=\"https://files.readme.io/4954a02-android-to-project.gif\\"/></li>\n    <li><a href=\"https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk\\">Загрузите последнюю версию Android SDK</a> и вставьте ее в ваш проект Android, под приложением <strong> &gt; libs</strong>.</li>\n    <li>Щелкните правой кнопкой мыши по <code class=\"rdmd-code lang-\">aar</code> вы вставили и выберите <strong>Добавить как библиотеку</strong>. When prompted, click <strong>Refactor</strong>. <p>При появлении запроса на коммит git, нажмите <strong>ОК</strong></p></li></ol></div>\n</details>"
}
[/block]

## Установка необходимых разрешений

Добавьте следующие права в `AndroidManifest.xml` в раздел `manifest`:

```xml AndroidManfiest.xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package=YOUR_PACKAGE_NAME>

      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

      ...

</manifest>
```

### Разрешение AD_ID

В начале 2022 года Google объявил о внесении изменений в поведение служб Google Play и получение идентификатора рекламы. В соответствии с [announcement](https://support.google.com/googleplay/android-developer/answer/6048248?hl=en), приложения, ориентированные на Android 13 (API 33) и выше должны объявить обычные службы Google Play в своем \`AndroidManifest. ml-файл для получения доступа к Рекламному Идентификатору устройства.

Запуск `V6.8.0`, SDK автоматически добавляет разрешение AD_ID.

> 📘 Заметка
>
> - Если ваше приложение участвует в программе [Designed for Families](https://support.google.com/googleplay/android-developer/topic/9877766?hl=en&ref_topic=9858052):
>   - Если используется SDK `V6.8.0` и выше, вам следует [аннулировать разрешение AD_ID](#revoking-the-ad_id-permission).
>   - Если используется SDK старше `V6.8.0`, не добавьте это разрешение в ваше приложение.
> - Для приложений с целевым уровнем API 32 (Android 12L) или более старым, это разрешение не требуется.

Приложения, использующие SDK версии **старше** чем `V6.8. ` и целевой Android 13 (API 33) и выше должны вручную включать разрешение в их `AndroidManifest.xml`, чтобы иметь доступ к Рекламному ID:

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID" />
```

#### Отозвать разрешение AD_ID

В соответствии с [политикой Google](https://support.google.com/googleplay/android-developer/answer/11043825?hl=en) приложения, предназначенные для детей, не должны передавать Рекламный ID.

При использовании SDK `V6.8. ` и выше, Дочерние приложения, ориентированные на Android 13 (API 33) и выше, должны запретить объединение в свое приложение, добавив объявление об отзыве в их манифесте:

```xml AndroidManifest.xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"
 tools:node="remove"/>
```

Дополнительную информацию можно найти в [документации Google Play Services](https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info#public-string-getid).

## Правила защиты

<span class="annotation-optional">Optional</span>  
If you are using ProGuard and you encounter a warning regarding our `AFKeystoreWrapper` class, then add the following code to your `proguard-rules.pro` file:

#### Правила защиты от AppsFlyer SDK

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.** { *; }
```

## Правила резервного копирования

AndroidManifest.xml SDK включает правила, чтобы не создавать резервные копии данных общих настроек. Это делается для того, чтобы не сохранять одинаковые счетчики и AppsFlyer ID во время переустановки, тем самым предотвращая точное обнаружение новых установок или переустановки.

Чтобы объединить правила резервного копирования SDK с правилами резервного копирования приложений и предотвратить конфликты, выполните следующие инструкции для каждого варианта использования.

### Исправлены конфликты с полным BackupContent=«true»

Если вы добавите `android:fullBackupContent="true"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Слияние манифеста не удалось: Attribute application@fullBackupContent value=(true)
```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:fullBackupContent"` в теге `<application>` в файле `AndroidManifest.xml`.

### Исправлены конфликты с dataExtractionRule=”true”

Если вы добавите `android:dataExtractionRules="true"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Слияние манифеста не удалось: Attribute application@dataExtractionRules value=(true)

```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:dataExtractionRules"` в теге `<application>в файле `AndroidManifest.xml\`.

### Исправить конфликты с allowBackup=”false”

Если вы добавите `android:allowBackup="false"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Ошибка:
	Атрибут application@allowBackup value=(false) из AndroidManifest.xml:
	также присутствует на [com.appsflyer:af-android-sdk:6.14. ] AndroidManifest.xml: value=(true).
	Предложение: добавить 'tools:replace="android:allowBackup"' в <application> элемент на AndroidManifest.xml для переопределения.

```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:allowBackup"` в теге `<application>` в файле `AndroidManifest.xml`.

### Объединить правила резервного копирования в Android 12 и выше

Если вы нанимаете **Android 12** и выше, и у вас есть свои собственные правила резервного копирования (`android:dataExtractionRules="@xml/my_rules"`), в дополнение к инструкциям выше, пожалуйста, объедините ваши правила резервного копирования с правилами AppsFlyer вручную, добавив следующее правило:

```xml AndroidManfiest.xml
<data-extraction-rules>
    <cloud-backup>
        <exclude domain="sharedpref" path="appsflyer-data"/>
    </cloud-backup>
    <device-transfer>
        <exclude domain="sharedpref" path="appsflyer-data"/>
    </device-transfer>
</data-extraction-rules>

```

### Объединить правила резервного копирования в Android 11 и ниже

Если вы также нанимаете **Android 11** и ниже, и у вас есть свои собственные правила для резервного копирования (`android:fullBackupContent="@xml/my_rules"`), в дополнение к инструкциям выше, пожалуйста, объедините ваши правила резервного копирования с правилами AppsFlyer вручную, добавив следующее правило:

```xml AndroidManfiest.xml
<full-backup-content>
    ...//ваши пользовательские правила
    <exclude domain="sharedpref" path="appsflyer-data"/>
</full-backup-content>

```

## Добавление ссылающихся библиотек магазина

AppsFlyer SDK поддерживает несколько библиотек рефереров. Использование реферера магазина повышает точность атрибутов.

Вам нужно только добавить зависимость, SDK заботится об остальном.

### Установить реферер Google Play

Добавьте следующую зависимость к `build.gradle`:

```groovy Groovy 
dependencies {
    // ...
    реализация "com.android.installreferrer:installreferrer:2.2"
}
```

**Google Play Install Referrer правила защиты**

```groovy Groovy
-keep public class com.android.installreferrer.** { *; }
```

### Мета-инсталлятор

Реферер установки Meta позволяет AppsFlyer получать метаданные рекламной кампании с локального хранилища устройства.

#### Базовый поток Meta Install Referrer

Основным потоком механизма установки Meta является следующий:

1. Когда SDK инициализируется, он использует Facebook ID приложения для запроса к Meta API поставщика контента, извлечение сохраненных метаданных из приложения Facebook.
2. AppsFlyer SDK отправляет событие установки вместе с данными атрибутов серверам AppsFlyer .

#### **Требования**

Для поддержки мета-инсталлированного реферера необходимо следующее:

- **SDK**: Интеграция с Android SDK версии 6.12.6 или выше.
- **Версия приложения Facebook**: Пользователи должны иметь на своем устройстве версию 428.x.x или выше.
- **Версия приложения Instagram**: Пользователи должны иметь версию 296.x.x или выше на своем устройстве.

#### Настроить поддержку Meta Install Referrer

Чтобы включить Meta install referrer можно сделать Facebook App ID доступным в SDK, добавив его в `AndroidManifest.xml`.  Это можно сделать либо при интеграции Facebook SDK с приложением, либо при интеграции AppsFlyer SDK с приложением.

##### С Facebook SDK интегрирован

Обратитесь к [официальному руководству Facebook](https://developers.facebook.com/docs/android/getting-started#client-token), чтобы узнать, как добавить Facebook App ID в `AndroidManifest.xml`. SDK прочитает Facebook App ID из тега `meta-data`.

##### Без интеграции с Facebook SDK

Включите следующий тег в `AndroidManifest.xml`

```xml
<meta-data android:name="com.appsflyer.FacebookApplicationId" android:value="@string/facebook_application_id" />
```

Включите в свой файл `strings.xml`:

```xml
<string name="facebook_application_id" translatable="false"><YOUR_FACEBOOK_APP_ID></string>
```

### Установочный реферер Huawei

Поддержка реферера Huawei поддерживается в SDK v6.14.0 и выше.
Из-за изменений в магазине приложений Huawei AppGallery предыдущие версии AppsFlyer SDK не могут получить реферера из магазина.

Добавьте следующий репозиторий в `build.gradle` вашего проекта:

```groovy Groovy 
repositories {
    //...
    maven { url 'https://developer.huawei.com/repo/' }
}
```

Добавьте следующие зависимости в `build.gradle` приложения:

```groovy Groovy 
dependencies {
    // ...
    реализация 'com.huawei.hms:componentverifysdk:13.3.1.301'
}

```

Если вы используете ProGuard, добавьте следующие правила в ваш файл `proguard-rules.pro`:

```groovy
-keep class com.huawei.hms.**{*;}
```

### Реферер магазина Xiaomi GetApps

<span class="annotation-added">V6.9.0</span>
Добавьте следующую зависимость в `build.gradle`:

```groovy Groovy
dependencies {
  // ...
  реализация "com.miui.referrer:homereferrer:1.0.0.6"
}
```

\*\*Правила защиты рефереров Xiaomi GetApps

```groovy Groovy
-keep public class com.miui.referrer.** {*;}
```

[block:callout]
{
"type": "info",
"title": "Note",
"body": "Samsung store referrer supported out-of-the-box starting SDK `V6. .1` и не требует дополнительной интеграции."
}
[/block]

## Сбор ID AppSet

Начиная с **v6.17.0** SDK может автоматически собирать [AppSet ID](https://developer.android.com/identity/app-set-id).  
Чтобы включить эту функцию, добавьте зависимость сервисов Google Play в файл `build.gradle` в вашем модуле:

```groovy
dependencies {
    реализация 'com.google.android.gms:play-services-appset:16.1.0'
}
```

После добавления SDK собирает AppSet ID, если он доступен на устройстве.  
Чтобы отключить подборку ID AppSet используйте [`disableAppSetId()`](doc:android-sdk-reference-appsflyerlib#disableappsetid).

## API целостности Google Play

Начиная с **v6.17.1**, SDK имеет встроенную интеграцию с Google Play Integrity API.
Это обеспечивает проверку целостности устройства через Google Play.
You can read more about it [here](https://support.google.com/googleplay/android-developer/answer/15299193)

Если ваше приложение распространяется вне Google Play Store, вы можете удалить эту зависимость, добавив в `build.gradle` ваше приложение следующие строки:

```groovy
реализация ("com.appsflyer:af-android-sdk:HERE_SDK_VERSION") {
    exclude group: 'com.google.android.play', module: 'integrity'
}

// Например:
// реализация ("ком. ppsflyer:af-android-sdk:6.17.1") {
// исключаем группу: 'com.google.android.play', module: 'integrity'
// }
```

## Известные проблемы

### Отсутствуют файлы ресурсов

Убедитесь, что в APK файле, в дополнение к `classes. например и файлы ресурсов, у вас также есть папка **assets > com > appsflyer > internal**, содержащая четыре файла с расширением `a-`, `b-`, `c-`, и `d-\`.

Убедитесь, что у вас есть необходимые файлы, открыв APK в Android Studio:

```
assets/
└── com/
    └── appsflyer/
        └── internal/
            ├── <hash>a-
            ├── <hash>b-
            ├── <hash>c-
            └── <hash>d-
```

Если эти файлы отсутствуют, SDK не может отправлять сетевые запросы на наш сервер, и вам необходимо связаться с вашим CSM или поддержкой.

### Загрузка завершена

Если ваше приложение прослушивает файл `LOCKED_BOOT_COMPLETED`, убедитесь, что все взаимодействия с SDK запускаются из активности лаунчера. Эта мера предосторожности предотвращает взлом SDK при попытке доступа к `SharedPreferences` на устройстве, которое по-прежнему заблокировано.
