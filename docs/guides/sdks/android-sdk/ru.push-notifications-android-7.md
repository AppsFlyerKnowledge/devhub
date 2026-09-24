---
title: Push-уведомления
slug: push-уведомления-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: особенностей-Андроид-7
privacy:
  view: публичный
position: 1
---

## Общий обзор

Следующее руководство описывает конфигурацию Android SDK для обработки входящих уведомлений и отправки извлеченных атрибутов AppsFlyer.

Существует 2 метода осуществления интеграции:

- Используя OneLink в push полезной нагрузке (рекомендуемый метод).
- Используя простой JSON в push полезной нагрузке (старый метод).

Выберите правильный метод [основанный на том, как маркетинг структурирует push-уведомление](https://support.appsflyer.com/hc/en-us/articles/207364076#1-creating-the-push-notification).

### Предпосылки

Прежде чем продолжить, убедитесь, что у вас есть:

1. Приложение для Android с [AppsFlyer SDK](doc:integrate-android-sdk#initializing-the-android-sdk).
2. При реализации [рекомендованного решения на основе OneLink](https://support.appsflyer.com/hc/en-us/articles/207364076#using-onelink-recommended), вам нужно имя ключа внутри приложения уведомления push, который содержит OneLink (предоставляемый маркером приложения).

## Интеграция AppsFlyer с уведомлениями Android с помощью OneLink

<span class="annotation-recommended">Рекомендуемый метод</span>  
это рекомендуемый для применения измерения push-уведомлений в Android SDK.

**Чтобы интегрировать AppsFlyer с Android push-уведомлениями:**  
В вашем `Application`, позвоните `addPushNotificationDeepLinkPath` **до** вызова `start`:

```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link");
```

В этом примере SDK настроен на поиск ключа `af_push_link` на первом уровне полезной нагрузки push-уведомления.  
При вызове `addPushNotificationDeepLinkPath` SDK проверяет, что:

- Необходимый ключ существует в полезной нагрузке.
- Ключ содержит действительный OneLink URL.

> 📘 Заметка
>
> `addPushNotificationDeepLinkPath` принимает массив строк, чтобы извлечь соответствующий ключ из вложенных структур JSON. Дополнительную информацию см. в [`addPushNotificationDeepLinkPath`](doc:android-sdk-reference-appsflyerlib#addpushnotificationdeeplinkpath).

## Интеграция AppsFlyer с уведомлениями Android с помощью JSON (старый)

Это [устаревший метод](https://support.appsflyer.com/hc/en-us/articles/207364076#using-json-legacy) для применения измерения push-уведомлений в Android SDK.

**Чтобы интегрировать AppsFlyer с Android push-уведомлениями, используя старое решение:**  
В вашем глубоко связанном активном `onCreate`, вызовите `sendPushNotificationData`:

```java
public class MainActivity extends AppCompatActivity {
    // ...
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super. nCreate(savedInstanceState);
        // . .
        если (getIntent(). etExtras() ! null) {            
            AppsFlyerLib. etInstance(). endPushNotificationData(this);
        }
        // . .
    }
}
```

SDK ожидает получить ключ `af` в комплекте `Intent`'s `extras`. Если ключ `af` найден, SDK отправляет значение AppsFlyer.

## Опционально: обновите содержимое маршрута вручную

Некоторые Push провайдеры не автоматически создают `Intent`, который содержит пользовательские данные, требуемые AppsFlyer SDK. В этих случаях ваше приложение может извлечь необходимые значения непосредственно из push-приложения и добавить их в `Intent`, прежде чем оно будет передано в SDK.

```java
class PushNotificationService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
            ...

        val afOneLinkFromPayload: String? = null
        // Handle the data payload
        if (remoteMessage.data.isNotEmpty()) {
            afOneLinkFromPayload = remoteMessage.data["af_push_link"]
         // afCustomDataPayload = remoteMessage.data["af"] // For JSON Campaign data

        }
        ....

        val intent = Intent(this, <Activity>)

        intent.putExtra("af_push_link", afOneLinkFromPayload); // For deeplinking

    //  intent.putExtra("af", afCustomDataPayload); // For JSON campaign data

        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE
        );
        ...

        val builder = NotificationCompat.Builder(this, "")
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle("") 
            .setContentText("")
            .setAutoCancel(true)
            .setContentIntent(pendingIntent);
        
        ...

        notificationManager.notify(0, builder.build());
        
    }

}
```
