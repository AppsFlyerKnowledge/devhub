---
title: Удалить измерение
slug: uninstall-measurement-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: особенностей-Андроид-7
privacy:
  view: публичный
position: 2
---

## Общий обзор

Настройте измерение удаления в Android приложениях с помощью AppsFlyer SDK и Firebase Cloud Messaging.

## Интеграция измерения удаления для Android

Этот документ охватывает интеграцию измерений удаления для следующих сценариев:

- Приложения, которые уже используют FCM
- Приложения, которые не используют FCM.

Найдена последняя версия клиента FCM [here](https://firebase.google.com/docs/cloud-messaging/android/client).

### Приложения с использованием FCM

**Чтобы добавить измерение удаления для существующей интеграции с FCM:**
в переопределении `onNewToken()`, вызовите `updateServerUninstallToken`:

```java
@Override
public void onNewToken(String s) {
    super. nNewToken(s);
    // Отправка нового токена AppsFlyer
    AppsFlyerLib. etInstance(). pdateServerUninstallToken(getApplicationContext(), s);
    // остальная часть кода, использующего токен, идет также в этом методе, а также в
}
```

### Приложения не используют FCM

**Чтобы интегрировать измерения удаления:**

1. Скачайте `google-services.json` [с консоли Firebas](https://support.google.com/firebase/answer/7015592).
2. Добавьте `google-services.json` в каталог модуля приложения
3. Добавьте следующие зависимости в файл `build.gradle` с root-уровнем:
    ```java
    buildscript { 
        // ... 
        dependencies { 
          // 
          classpath 'com.google.gms:google-services:4.2.0' // google-services plugin 
        } 
    }
    ```
4. В `build.gradle` уровня добавьте следующие зависимости:
    ```groovy
    dependencies {
        // ...
        реализация 'com.google.firebase:firebase-messaging:23.0.3'
        реализация 'com.google.firebase:firebase-core:20.1.2'
        // ...
    }
    ```
   **Примечание:** Если вы получили ошибку "**Не удалось найти метод реализации()...**", убедитесь, что у вас есть последняя версия репозитория Google в Android SDK.
   [block:image]
   {
   "images": [
   {
   "image": [
   "https://files.readme.io/7d639a9-Screen_Shot_2022-04-17_at_12.01.34. ng",
   "Screen Shot 2022-04-17 at 12.01.34.png",
   1169,
   47,
   "#3d3030"
   ]
   }
   ]
   }
   [/block]
5. **Если вы используете FCM только для измерения удаления в AppsFlyer**, используйте службу `appsFlyer.FirebaseMessagingServiceListener`, встроенную в SDK. Это расширяет класс `FirebaseMessagingService`, используемый для получения токена устройства FCM и вызовов `updateServerUninstallToken`. Чтобы добавить службу `appsFlyer.FirebaseMessagingServiceListener` в приложение:
    ```xml
    <application
       <!-- ... -->
          <service
            android:name="com.appsflyer.FirebaseMessagingServiceListener">
            <intent-filter>
              <action android:name="com.google.firebase.MESSAGING_EVENT"/>
            </intent-filter>
          </service>
       <!-- ... -->
    </application>
    ```
   В противном случае, переопределите метод `FirebaseMessagingService.onNewToken()` и вызовите `updateServerUninstallToken`:
    ```java
    @Override
    public void onNewToken(String s) {
        super. nNewToken(s);
        // Отправка нового токена AppsFlyer
        AppsFlyerLib. etInstance(). pdateServerUninstallToken(getApplicationContext(), s);
        // остальная часть кода, использующего токен, идет также в этом методе, а также в
    }
    ```

[block:callout]
{
"type": "info",
"title": "Note",
"body": "Если вы используете Proguard, обязательно добавьте следующее правило:\n\`\`java\n-dontwarn com. ppsflyer.\*\*\n-keep public class com.google.firebase.messaging.FirebaseMessagingService {\n    public \*;\n}\n\`\`\`"
}
[/block]

## Тестирование измерения удаления Android

Описанная процедура тестирования действительна для приложений, доступных через Google Play Store, в ожидании, прямую загрузку и через альтернативные магазины приложений.

- Метрика **Деинсталляции** доступна в панели Обзора.
- Список пользователей, удаляющих приложение, доступен в процессе удаления [raw-data reports].(https://support.appsflyer.com/hc/en-us/articles/209680773-Raw-data-reporting-overview#user-journey-report-availability).

**Для тестирования измерения удаления Android:**

1. Установить приложение.
2. Удалить приложение. Вы можете удалить приложение сразу же после его установки.
3. Дождитесь появления деинсталляции на панели управления. Это может занять до 48 часов.

## Соображения

- Установленные регистры событий удаления в течение 24 часов, так как измерение удаления обрабатывается [daily](https://support.appsflyer.com/hc/en-us/articles/360000310629-Data-freshness-and-time-zone-support#data-freshness-types).
- Если приложение переустановлено в это время, **не записывается событие деинсталляции**.

## Переопределение `onMessageReceived` FCM\`

Переопределение метода `onMessageReceived` FX и реализация собственной логики
в нем может привести к удалению push-уведомлений, которые не будут тихими. Это может повлиять на качество работы пользователя. Чтобы предотвратить это, убедитесь, что сообщение содержит `af-uninstall-tracking`. См. следующий пример:

```java
@Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        
        if(remoteMessage. etData(). ontainsKey("af-uinstall-tracking"){ // "uinstall" не является опечаткой
            ;
        } else {
           // handleNotification(remoteMessage);
        }
}
```
