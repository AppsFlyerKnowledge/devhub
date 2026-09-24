---
title: OAID
slug: oaid-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: особенностей-Андроид-7
privacy:
  view: публичный
position: 4
---

## Общий обзор

Соберите Android Open Anonymous Device Identifier (OAID), чтобы установить его из сторонних магазинов приложений Android.

OAID является идентификатором пользователя для Android-устройств. Он был введен Союзом мобильной безопасности (МСА), Китайским институтом информационных и коммуникационных исследований, и изготовителям устройств в качестве альтернативы идентификаторам невозвращаемых устройств, например IMEI.

## Интеграция

Требуется AppsFlyer SDK V5.4.0+

Интеграция с OAID состоит из 3 этапов:

- Интеграция AppsFlyer SDK в файл `build.gradle` вашего проекта
- Интеграция модуля OAID AppsFlyer в файл `build.gradle` вашего проекта

```groovy
dependencies {
  implementation 'com.appsflyer:af-android-sdk:6.9.4'
  implementation 'com.appsflyer:oaid:6.9.0'
}
```

- Интеграция SDK для генерации и предоставления OAID (например, [MSA SDK](#msa-sdk-integration) или [Huawei HMS SDK](#huawei-hms-sdk-integration))
- Добавить правила ProGuard для защиты необходимых классов и интерфейсов от MSA и различных производителей устройств.

**Примечание**:

- Для приложений, предназначенных для использования в Китае, необходимо использовать MSA SDK.
- Для приложений, предназначенных для глобального использования на устройствах Huawei, должна использоваться библиотека Huawei HMS .

### Интеграция MSA SDK

**Чтобы интегрировать MSA SDK**:

1. Получить с маркера: MSA SDK (aar) файл и сертификат, который должен быть интегрирован в приложение.
   1. Скопируйте MSA SDK (аar) в папку libs.
   2. Скопируйте и вставьте `supplierconfig. son` в соответствии с папкой активов проекта и внесение необходимых изменений, например, обновление приложения в каждом из магазинов.
   3. Скопируйте и вставьте файл сертификата (имя комплекта name.cert.pem) в папку активов проекта.
   4. Смотрите [полные инструкции на сайте MSA](http://www.msa-alliance.cn/col.jsp?id=120)
2. Обновите файл `build.gradle` вашего проекта следующим образом:

```groovy
реализация 'com.appsflyer:af-android-sdk:6.9.4'
реализация 'com.appsflyer:oaid:6.9.0'
файлов реализации ('libs/oaid_sdk_2.0.0.aar')
```

### Huawei HMS SDK интеграция

**Чтобы интегрировать Huawei HMS SDK**:

1. Добавить дебютный репозиторий Huawei следующего содержания:

```groovy
repositories {
  maven {
      url "https://developer.huawei.com/repo/"
  }
}
```

2. Обновите файл `build.gradle` вашего приложения следующим образом:

```groovy
dependencies {
  implementation 'com.appsflyer:af-android-sdk:6.9.4'
  implementation 'com.appsflyer:oaid:6.9.0'
  implementation 'com.huawei.hms:ads-identifier:3.4.56.300'
}
```

### Обновление правил ProGuard (при использовании ProGuard)

Защитить необходимые классы и интерфейсы от MSA и различных производителей устройств.

\*\*Добавьте следующий код в файл `proguard-rules.pro`: \*\*

```groovy
# sdk
-keep class com.bun.miitmdid.** { *; }
-keep interface com.bun.supplier.** { *; }
# asus
-keep class com.asus.msa. upplementaryDID.** { *; }
-keep class com.asus.msa.sdid.** { *; }
# freeme
-keep class com.android.creator.** { *; }
-keep class com. ndroid.msasdk** { *; }
# huawei
-keep class com.huawei.hms.ads.** { *; }
-keep interface com.huawei.hms.ads. * {*; }
# lenovo
-keep class com.zui.deviceidservice.** { *; }
-keep class com. ui.opendeviceidlibrary.** { *; }
# meizu
-keep class com. eizu.flyme.openidsdk.** { *; }
# nubia
-keep class com.bun.miitmdid.provider.nubia. ubiaIdentityImpl
{ *; }
# oppo
-keep class com.heytap.openid.** { *; }
# samsung
-keep class com.samsung.android.deviceidservice. * { *; }
# vivo
-keep class com.vivo.identifier.** { *; }
# xiaomi
-keep class com.bun.miitmdid.provider.xiaomi. dentifierManager
{ *; }
# zte
-keep class com.bun.lib.** { *; }
# coolpad
-keep class com.coolpad.deviceidsupport.** { *; }
```

## Дополнительная информация

### Отключение коллекции OAID

**Чтобы отказаться от коллекции OAID, используйте один из следующих API**:

- [setCollectOAID](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcollectoaid) следующим образом:

```java
AppsFlyerlib.setCollectOaid(false);
```

- [setDisableAdvertisingIdentifiers](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setdisableadvertisingidentifiers) следующим образом:

```java
AppsFlyerlib.setDisableAdvertisingIdentifiers(true);
```

### Настройка OAID вручную

**Чтобы вручную установить OAID в AppsFlyer SDK**:

- Используйте [setOaidData API](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setoaiddata) следующим образом:

```java
AppsFlyerlib.setOaidData(oaid);
```
