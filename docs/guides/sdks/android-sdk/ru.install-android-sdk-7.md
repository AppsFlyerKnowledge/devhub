---
title: Установить Android SDK 7
slug: install-android-sdk-7
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-7
privacy:
  view: публичный
position: 1
---

## Прежде чем начать

Перед установкой Android SDK V7, убедитесь, что ваш проект соответствует следующим требованиям:

- **Минимальный уровень Android API**: SDK V7 требует уровень API 21 или выше. Обновите `build.gradle` перед продолжением:

```groovy
minSdk 21
```

- **Версия Kotlin**: Если ваше приложение использует Kotlin 1.9, вы можете столкнуться с ошибками метаданных при построении на SDK V7 AAR. Обновите до Kotlin 2.0 или выше перед установкой.

## Установка Android SDK

Установите Android SDK используя предпочтительный метод: через Gradle (рекомендуется) или вручную.

### Установить с помощью Gradle

**Рекомендуется**

**Шаг 1: Объявить репозитории**  
В файле `build.gradle` проекта объявить репозиторий `mavenCentral`:

```groovy
//
репозитории {
   mavenCentral()
}
// ...
```

**Шаг 2: Добавить зависимости**  
В файле `build.gradle` добавьте [latest Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) пакет:

```groovy
dependencies {
    // Получить последнюю версию с https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk
    implementation 'com.appsflyer:af-android-sdk:<<HERE_LATEST_VERSION>>'
    // Например,
    // implementation 'com.appsflyer:af-android-sdk:7.0.0'
}
```

### Ручная установка

1. В **Android Studio** переключите структуру папок с **Android** на **Project**.
2. [Скачайте последнюю версию Android SDK](https://mvnrepository.com/artifact/com.appsflyer/af-android-sdk) и вставьте ее в ваш проект Android, под **приложением> libs**.
3. Щелкните правой кнопкой мыши `aar`, который вы вставили и выберите **Add As Library**. При появлении запроса нажмите **Рефакторинг**. Если запрос на коммит git, нажмите **OK**.

## Установка необходимых разрешений

Добавьте следующие права в `AndroidManifest.xml` в раздел `manifest`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package=YOUR_PACKAGE_NAME>

      <uses-permission android:name="android.permission.INTERNET" />
      <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

      ...

</manifest>
```

### Разрешение AD_ID

SDK автоматически добавляет разрешение AD_ID. Если ваше приложение участвует в программе Designed for Families, вы должны проверить разрешение AD_ID.

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID" />
```

#### Отозвать разрешение AD_ID

В соответствии с [политикой Google](https://support.google.com/googleplay/android-developer/answer/11043825?hl=en), приложения, целевые потомки которых не должны передавать рекламный ID.

При использовании SDK `V6.8. ` и выше, Дочерние приложения, ориентированные на Android 13 (API 33) и выше, должны запретить объединение в свое приложение, добавив объявление об отзыве в их манифесте:

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID"
tools:node="remove"/>
```

Дополнительную информацию можно найти в [документации Google Play Services](https://developers.google.com/android/reference/com/google/android/gms/ads/identifier/AdvertisingIdClient.Info#public-string-getid).

## Правила защиты

<span class="annotation-optional">Optional</span>

Если вы используете ProGuard и вы столкнулись с предупреждением о нашем классе `AFKeystoreWrapper`, добавьте следующий код в ваш файл `proguard-rules.pro`:

### Правила защиты от AppsFlyer SDK

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal.** { *; }
```

## Правила резервного копирования

`AndroidManifest.xml` включает правила, чтобы отказаться от резервного копирования данных Общих настроек. Это делается для того, чтобы не сохранять одинаковые счетчики и AppsFlyer ID во время переустановки, тем самым предотвращая точное обнаружение новых установок или переустановки.

Чтобы объединить правила резервного копирования SDK с правилами резервного копирования приложений и предотвратить конфликты, выполните следующие инструкции для каждого варианта использования.

### Исправлены конфликты с полным BackupContent="true"

Если вы добавите `android:fullBackupContent="true"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Слияние манифеста не удалось: Attribute application@fullBackupContent value=(true)
```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:fullBackupContent"` в теге `<application>` в файле `AndroidManifest.xml`.

### Исправлены конфликты с dataExtractionRule="true"

Если вы добавите `android:dataExtractionRules="true"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Ошибка слияния манифеста: Attribute application@dataExtractionRules value=(true)
```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:dataExtractionRules"` в теге `<application>в файле `AndroidManifest.xml\`.

### Исправлены конфликты с allowBackup="false"

Если вы добавите `android:allowBackup="false"` в `AndroidManifest.xml`, вы можете получить следующую ошибку:

```
Ошибка:
	Атрибут application@allowBackup value=(false) из AndroidManifest.xml:
	также присутствует на [com.appsflyer:af-android-sdk:7.x. ] AndroidManifest.xml: value=(true).
	Предложение: добавить 'tools:replace="android:allowBackup"' на элемент <application> на AndroidManifest.xml для переопределения.
```

Чтобы исправить эту ошибку, добавьте `tools:replace="android:allowBackup"` в теге `<application>` в файле `AndroidManifest.xml`.

### Объединить правила резервного копирования в Android 12 и выше

Если вы нанимаете **Android 12** и выше, и у вас есть свои собственные правила резервного копирования (`android:dataExtractionRules="@xml/my_rules"`), в дополнение к инструкциям выше, пожалуйста, объедините ваши правила резервного копирования с правилами AppsFlyer вручную, добавив следующее правило:

```xml
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

Если вы ориентируетесь на **Android 11** и ниже, и у вас есть свои собственные правила резервного копирования (`android:fullBackupContent="@xml/my_rules"`), в дополнение к инструкциям выше, пожалуйста, объедините ваши правила резервного копирования с правилами AppsFlyer вручную, добавив следующее правило:

```xml
<full-backup-content>
    ...//ваши пользовательские правила
    <exclude domain="sharedpref" path="appsflyer-data"/>
</full-backup-content>
```

## Добавление ссылающихся библиотек магазина

AppsFlyer SDK поддерживает несколько библиотек рефереров. Использование реферера магазина повышает точность атрибутов.

Вам нужно только добавить зависимость, SDK заботится об остальном.

### Установить реферер Google Play

> ⚠️ Требуется в SDK V7
>
> Начиная с V7, SDK объявляет эту зависимость как `compileOnly` внутренней, что означает, что она больше не собирается с SDK. Вы должны добавить его явно в `build.gradle` вашего приложения. Без этого будут собраны данные реферера Google Play.

Добавьте следующую зависимость к `build.gradle`:

```groovy
dependencies {
    // ...
    реализация "com.android.installreferrer:installreferrer:2.2"
}
```

**Google Play Install Referrer правила защиты**

```groovy
-keep public class com.android.installreferrer.** { *; }
```

### Мета-инсталлятор

Реферер установки Meta позволяет AppsFlyer получать метаданные рекламной кампании с локального хранилища устройства.

#### Базовый поток Meta Install Referrer

1. Когда SDK инициализируется, он использует Facebook ID приложения для запроса к Meta API поставщика контента, извлечение сохраненных метаданных из приложения Facebook.
2. AppsFlyer SDK отправляет событие установки вместе с данными атрибутов серверам AppsFlyer .

#### Предпосылки

Для поддержки мета-инсталлированного реферера необходимо следующее:

- **SDK**: Интеграция с Android SDK версии 6.12.6 или выше.
- **Версия приложения Facebook**: Пользователи должны иметь на своем устройстве версию 428.x.x или выше.
- **Версия приложения Instagram**: Пользователи должны иметь версию 296.x.x или выше на своем устройстве.

#### Поддержка Meta Install Referrer

Чтобы включить Meta поддержку реферера установки, сделайте Facebook App ID доступным в SDK, добавив его в `AndroidManifest.xml`. Это можно сделать либо при интеграции Facebook SDK с приложением, либо при интеграции AppsFlyer SDK с приложением.

**С Facebook SDK интегрирован**

Обратитесь к [официальному руководству Facebook](https://developers.facebook.com/docs/android/getting-started#client-token), чтобы узнать, как добавить Facebook App ID в `AndroidManifest.xml`. SDK прочитает Facebook App ID из тега `meta-data`.

**Без интеграции с Facebook SDK**

Включите следующий тег в `AndroidManifest.xml`:

```xml
<meta-data android:name="com.appsflyer.FacebookApplicationId" android:value="@string/facebook_application_id" />
```

Включите в свой файл `strings.xml`:

```xml
<string name="facebook_application_id" translatable="false"><YOUR_FACEBOOK_APP_ID></string>
```

### Альтернативные модули магазина

Поддержка Samsung, Xiaomi, и Huawei store referrer больше не входит в основной артефакт `af-android-sdk` в SDK 7. Если вы распространяете приложение через любой из этих магазинов и нуждаетесь в данных о реферере, добавьте соответствующую библиотеку в качестве отдельной зависимости от Gradle.

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
> - **Xiaomi / GetApps:** Если вы добавите `xiaomi-referrer`, вам обычно необходим GetApps Install Referrer клиент Xiaomi (`com.miui.referrer:homereferrer`) в качестве отдельной зависимости `implementation`. Эта библиотека не является частью AppsFlyer BOM.
> - **Huawei / AppGallery:** Если вы добавляете `huawei-referrer`, следуйте руководству по интеграции AppsFlyer + Huawei AppGallery для хранилищ Maven и проверке Huawei / HMS зависимостей. Это не является частью AppsFlyer BOM.
> - **Samsung:** Для большинства приложений достаточно добавить `samsung-referrer`; объединенные правила манифеста из библиотеки охватывают обычную интеграцию магазина.

---

## Сбор ID AppSet

<span class="annotation-optional">Optional</span>

Начиная с **v6.17.0** SDK может автоматически собирать [AppSet ID](https://developer.android.com/identity/app-set-id). Чтобы включить эту функцию, добавьте зависимость сервисов Google Play в файл `build.gradle` в вашем модуле:

```groovy
dependencies {
    реализация 'com.google.android.gms:play-services-appset:16.1.0'
}
```

После добавления SDK собирает AppSet ID, если он доступен на устройстве. Чтобы отключить коллекцию идентификаторов AppSet используйте `disableAppSetId()`.

---

## API целостности Google Play

SDK имеет встроенную интеграцию с Google Play Integrity API. Это обеспечивает проверку целостности устройства через Google Play. You can read more about it [here](https://support.google.com/googleplay/android-developer/answer/15299193).

Если ваше приложение распространяется вне Google Play Store, вы можете удалить эту зависимость, добавив в `build.gradle` ваше приложение следующие строки:

```groovy
реализация ("com.appsflyer:af-android-sdk:HERE_SDK_VERSION") {
    exclude group: 'com.google.android.play', module: 'integrity'
}

// Например:
// реализация ("ком. ppsflyer:af-android-sdk:7.0.0") {
// исключаем группу: 'com.google.android.play', module: 'integrity'
// }
```

## Известные проблемы

### Загрузка завершена

Если ваше приложение прослушивает файл `LOCKED_BOOT_COMPLETED`, убедитесь, что все взаимодействия с SDK запускаются из активности лаунчера. Эта мера предосторожности предотвращает взлом SDK при попытке доступа к `SharedPreferences` на устройстве, которое по-прежнему заблокировано.