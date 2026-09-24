---
title: Плагин безопасности Android
slug: android-legacy-plugin
category:
  uri: SDK AppsFlyer
parent:
  uri: Андроид-сдк
privacy:
  view: любой_с ссылкой
position: 8
---

[![Maven Central](https://img.shields.io/nexus/r/com.appsflyer/af-security-plugin?server=https%3A%2F%2Foss.sonatype.org)](https://repo1.maven.org/maven2/com/appsflyer/af-security-plugin/)

## Общий обзор

Плагин Gradle для Android приложений, который автоматизирует процесс создания, загрузки, и интеграции AppsFlyer Security SDK для каждой сборки и будет держать вас в курсе последних обновлений безопасности.

Важно заметить, что этот плагин работает только в модуле приложения, где применяется `com.android.application`.

## Минимальные версии

Убедитесь, что ваш проект соответствует следующим минимальным версиям для совместимости с плагином AppsFlyer Security:

- [AppsFlyer Android SDK](https://dev.appsflyer.com/hc/docs/android-sdk): Версия 6.12.5
- [Плагин Android Gradle (AGP)](https://developer.android.com/build): Версия 7.0.0
- [Gradle](https://gradle.org/): Версия 7.0

## Перед началом ⚠️

Пожалуйста, присылайте нам все хэши сертификатов (SHA-256) всех сертификатов, с которыми Вы подписываете приложение. This include the debug and release certificate hashes.</br>
We use them to pre-build the version of the security module that your app will use.</br>
This is a mandatory stage that is essential for the success of the app build when using this plugin.</br>
Позже вы будете использовать эти хэши в конфигурации плагинов как подробные [below](#configuration-options). </br>
Инструкция по получению сертификатов может быть найдена [here](#sha256-fingerprint). </br>

## Установка

**Используя [plugins DSL](https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block):**

### Шаг 1

Плагин размещен на Maven Central.
Сначала вам нужно добавить Maven Central в репозиторий в файл `settings.gradle` или `settings.gradle.kts`:

```groovy
pluginManagement {
    repositories {
        mavenCentral()
        // other repositories...
    }
}
```

```kotlin
pluginManagement {
    repositories {
      mavenCentral()
        // other repositories...
    }
}
```

### Шаг2

Объясните плагин в блоке `plugins` вашего root-уровня (`project-level`) Gradle.
Обычно `<project>/build.gradle` или `<project>/<app-module>/build.gradle.kts` файл.

```groovy
plugins {
    id 'com.android.application' версия "$AGP_VERSION" применяется false
    id 'com. Версия ppsflyer.security' "$APPSFLYER_SECURITY_PLUGIN_VERSION" применяет ложные
    // другие плагины ...
}
```

```kotlin
plugins {
    id("com.android.application") версия "$AGP_VERSION" применяется false
    id("com.appsflyer.security") версия "$APPSFLYER_SECURITY_PLUGIN_VERSION" применяется false
    // другие плагины ...
}
```

### Шаг3

Применить плагин в вашем файле Gradle.
Обычно `<project>/<app-module>/build.gradle` или `<project>/<app-module>/build.gradle.kts` файл

```groovy
plugins {
    id 'com.android.application'
    id 'com.appsflyer.security'
    // other plugins...
}
```

```kotlin
plugins {
    id("com.android.application")
    id("com.appsflyer.security")
    // другие плагины...
}
```

### Устаревшая установка

**Используя [старое приложение плагина](https://docs.gradle.org/current/userguide/plugins.html#sec:old_plugin_application):**

```groovy
buildscript {
  repositories {
    maventCentral()
  }
  dependencies {
    classpath "com.appsflyer:af-security-plugin:$APPSFLYER_SECURITY_PLUGIN_VERSION"
  }
}

применяют плагин: "com.appsflyer.security"
```

```kotlin
buildscript {
  repositories {
    maventCentral()
  }
  dependencies {
    classpath("com.appsflyer:af-security-plugin:$APPSFLYER_SECURITY_PLUGIN_VERSION")
  }
}

Apy(plugin = "com.appsflyer.security")
```

**Примечания:**

1. Замените `$AGP_VERSION` фактической версией плагина Android Gradle.
2. Замените `$APPSFLYER_SECURITY_PLUGIN_VERSION` фактической версией AppsFlyer Security Plugin.

## Базовая конфигурация

Настройте плагин безопасности AppsFlyer в файле Gradle. Обычно `<project>/<app-module>/build.gradle` или `<project>/<app-module>/build.gradle.kts` файл. </br>Убедитесь, что конфиденциальная информация, такая как `authToken` и `certificateHashes` хранится в защищенном месте, и не включайте её прямо в конфигурационный блок.

```groovy
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
}
```

```kotlin
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = listOf("defaultHash1", "defaultHash2")
        authToken = "defaultAuthToken"
    }
}
```

## Параметры конфигурации

Каждый блок конфигурации (`defaultConfig` или конкретный `flavorConfig`) может включать:

| Вариант             | Тип              | Описание                                                                                                                                                                                                                                                                                                                                                                                                                          | Требуется | Важная заметка                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `certificateHashes` | `Список<String>` | Это поле определяет список ключей подписи приложения, которые будут использоваться для проверки целостности приложения. Это является обязательным и требует предоставить хэш сертификата для вашего ключа подписи вручную, поскольку AppsFlyer не может автоматически определить ключ подписи, используемый для подписания вашего приложения. Поддерживаются только хэши SHA-256. | Да        | **1.** При использовании подписи приложения через [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), Google управляет и защищает подпись вашего приложения и подписывает ваш APK от вашего имени. В этом случае необходимо предоставить хэш сертификата для ключа подписи **используемого Google**, используя эту опцию. Это **всегда** случай, когда вы распространяете наборы приложений для Android. </br>**2.** If `certificateHashes` is not specified or if the provided value doesn't match the build, the validation will fail and the traffic will be marked as fraud. |
| `authToken`         | `Строка`         | Это API V2 токен, необходимый для аутентификации плагина. Вы можете получить токен в AppsFlyer [dashboard](https://support.appsflyer.com/hc/en-us/articles/360004562377).                                                                                                                                                                                                                         | Да        | Если `authToken` не указан или неверен, плагин не может подключиться к серверу AppsFler.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

В случае отсутствия необходимых значений (`certificateHashes` и `authToken`), плагин будет работать не так, как ожидалось. Отсутствие `certificateHashes` приведет к ошибке проверки и потенциальному обнаружению трафика как мошенничества, в то время как отсутствие корректного `authToken` не позволит плагину работать правильно.

## Игнорировать флаги

By default, the plugin will register tasks and embed the AppsFlyer Security SDK for every flavor.</br>
If you wish to exclude flavors, you should provide the relevant flavors to exclude in the `ignoreFlavors` set under the `appsFlyerSecurityPlugin` section.</br>

Плагин исключает флажки в следующем порядке приоритета:

1. **Полный вариант сборки:** Полный вариант сборки представляет собой комбинацию всех размеров и типа сборки. Например, учитывая параметры "tier" (с значениями "free", "paid") и "server" (с значениями "dev", "prod"), полным вариантом сборки может быть "freeDevDebug" или "paidProdRelease".

2. **Комбинированный флажок товара:** Конфигурационные блоки продуктов названы по размеру комбинированных вкусов. Например, если вы создаете вариант с комбинированным вариантом 'paid' и 'prod', то плагин будет искать блок конфигурации под названием 'paidProd'.

3. **Тип сборки (Отладка/Релиз):** Это исключает все вкусы, собранные таким типом сборки.

```groovy
appsFlyerSecurityPlugin {
  ignoreFlavors = ["freeDev"]
  defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
}
```

```kotlin
appsFlyerSecurityPlugin {
    ignoreFlavors = setOf("freeDev", "debug")
    defaultConfig {
        certificateHashes = listOf("defaultHash1", "defaultHash2")
        authToken = "defaultAuthToken"
    }
}
```

## Расширенная конфигурация

### Обработка конфигурации вкусов и приоритетов

Плагин позволяет вам определить конкретные конфигурации для определенных вариантов или строить типы вашего приложения. Плагин разрешает настройки в следующем порядке:

1. **Полный вариант сборки:** Этот конфигурационный блок связан с полным вариантом сборки. Полный вариант сборки - это комбинация всех размеров вкуса и типа сборки. Например, учитывая параметры "tier" (с значениями "free", "paid") и "server" (с значениями "dev", "prod"), полным вариантом сборки может быть "freeDevDebug" или "paidProdRelease".

2. **Смешанный флажок товара:** Если не указано конфигурации для полного варианта сборки, плагин попытается найти конфигурацию, соответствующую комбинированному варианту товара. Конфигурационные блоки для вкусов названы в честь комбинированных размеров. Например, если вы создаете вариант с комбинированным вариантом 'paid' и 'prod', то плагин будет искать блок конфигурации под названием 'paidProd'.

3. **Тип сборки (Отладка/Релиз):** Если нет конфигураций для полного варианта сборки или комбинированных вариантов продукта, плагин будет искать блок конфигурации, названный после типа сборки. Это будет применено ко всем вкусам, собранным с этим типом.

4. **По умолчанию:** Если ничего из вышеперечисленного не найдено, плагин по умолчанию использует `defaultConfig`, применяя его ко всем вариантам.

### Расширенная конфигурация Flavor

```groovy
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
    flavorConfigs {
        paidProdRelease {
            certificateHashes = ['paidProdReleaseHash1', 'paidProdReleaseHash2']
            authToken = 'paidProdReleaseAuthToken'
            channel = 'paidProdReleaseChannel'
        }
        paidDev {
            certificateHashes = ['paidDevHash1', 'paidDevHash2']
            authToken = 'paidDevAuthToken'
            канал = 'paidDevChannel'
        }
    }
}
```

```kotlin
appsFlyerSecurityPlugin {
    defaultConfig {
      certificateHashes = listOf("defaultHash1", "defaultHash2")
      authToken = "defaultAuthToken"
    }
    flavorConfigs {
      create("paidProdRelease") {
        certificateHashes = listOf("paidProdReleaseHash1", "paidProdReleaseHash2")
        authToken = "paidProdReleaseAuthToken"
        channel = "paidProdReleaseChannel"
      }
      create("paidDev") {
        certificateHashes = listOf("paidDevHash1", "paidDevHash2")
        authToken = "paidDevAuthToken"
        канал = "paidDevChannel"
      }
    }
}
```

<a name="advanced-configuration-options"></a>

### Расширенные настройки

| Вариант         | Тип      | Описание                                                                                                                                                                                                                                                                                                                                                                                                                            | Требуется | Важная заметка                                                                                                                                                                        |
| --------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `канал`         | `Строка` | Этот канал определяет магазин вашего Android-приложения при добавлении его через опцию Android Out-of Store. Это сочетание имени пакета Android и канала уникально идентифицирует каждую панель управления AppsFler. Эта опция актуальна только при использовании панели управления магазином. Если не указано, значение по умолчанию является пустой строкой `""`. | Нет       | Если значение канала пустое или является одним из "googleplay", "playstore", или "googleplaystore", игнорируется, и возвращаемое значение будет пустой строкой, `""`. |
| "applicationId" | `Строка` | Уникальный идентификатор приложения, связанного с конфигурацией флавора. Он может быть использован для переопределения поведения по умолчанию для получения AppsFlyer App ID из имени пакета варианта и `channel`. Если не указано, будет соблюдаться поведение по умолчанию.                                                                                                       | Нет       | Если не указано, AppsFlyer App ID будет создан из имени пакета варианта и канала `channel`.                                                                           |

## Создание отпечатка SHA256

### Debug

**Чтобы сгенерировать отпечаток SHA256:**

1. Найдите [магазин ключей приложения](https://developer.android.com/training/articles/keystore).
   При разработке вашего приложения используется хранилище ключей по умолчанию, если не указано иное в вашей конфигурации Gradle.
   По умолчанию `debug.keystore`:

- Для пользователя Windows: `C:\Users\USERNAME\.android\debug.keystore`
- Для пользователей Linux или Mac OS: `~/.android/debug.keystore`

2. Откройте командную строку и перейдите в ту папку, в которой находится файл keystore .
3. Выполнить команду:

```shell
// keytool -list -v -keystore KEY_STORE_FILE
// Например, файл keystore 
keytool -list -v -keystore ~/.android/debug.keystore
```

> 🚧 Пароль для debug.keystore обычно \"android\".

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

4. Отправить SHA256 в AppsFlyer.

### Релиз

> 🚧 Если ваша сборка не подписана [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), следуйте инструкциям [debug](#debug-sha256-fingerprint) с вашим ключом.

При подписании приложения [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), Google управляет и защищает подпись вашего приложения и подписывает ваш APK от вашего имени. В этом случае необходимо предоставить хэш сертификата для ключа подписи **используемого Google**, используя эту опцию. Это **всегда** случай, когда вы распространяете наборы приложений для Android.</br>

1. В консоли Google Play найдите публичный отпечаток пальца SHA256 в **Настройке** -> **Регистрация приложения** (см. изображение ниже)
   ![](https://files.readme.io/8574437-Screenshot_2023-11-27_at_11.30.43.png)
2. Отправить SHA256 в AppsFlyer.
