---
title: Сохранять конфиденциальность пользователя
slug: preserve-user-privacy-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-7
content:
  excerpt: Узнайте, как сохранить конфиденциальность пользователей в Android SDK.
privacy:
  view: публичный
position: 4
---

# Сохранять конфиденциальность пользователя

Общая информация о методах сохранения приватности в AppsFlyer SDK см. в разделе [Сохранение конфиденциальности пользователя](https://dev.appsflyer.com/hc/docs/preserve-user-privacy-1) (на начальном этапе).

## Используйте начало чтобы поделиться только событием установки

Если вы хотите отправить только событие установки и никакой дополнительной информации, вы можете вызвать `start` с запросом обратного вызова. После получения сообщения об успешном завершении события установки необходимо вызвать `stop` или `anonymizeUser` из функции обратного вызова.

- [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#anonymizeuser) отправляет данные на AppsFlyer, однако, по прибытии на сервер AppsFlyer все идентификаторы (включая IP-адрес) удаляются или хэшируются.
- Метод `stop` возвращает вызов `start`, что означает, что SDK перестает отправлять любые данные в AppsFlyer.

```java
appsflyer. tart(getApplicationContext(), null, new AppsFlyerRequestListener() {
    @Override
    public void onSuccess() {
        Log. (LOG_TAG, "Запуск успешно отправлен, получил 200 кода ответа от сервера");
        appsflyer. top(true, getApplicationContext());
    }

    @Override
    публичная отмена onError(int i, @NonNull String s) {
        Log. (LOG_TAG, "Запуск не был отправлен:\n" +
                "Код ошибки: " + i + "\n"
                + "Описание ошибки: " + s);
    }
});
```

## Запретить передачу данных третьим лицам

Если вы хотите не обмениваться информацией об установке и внутриприложениях с третьими сторонами, такими как SRN и рекламные сети, используйте метод `setSharingFilterForPartners` перед вызовом `start`. Партнеры, исключенные с помощью этого метода, не будут получать данные через postback, API, необработанные отчеты или любые другие средства.

**Примечание:** Вы можете вызвать [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setsharingfilterforpartners), если пользователь изменит настройки совместного использования приложения (добавление или удаление партнеров) позднее в сессии.  
Пример кода см. [`setSharingFilterForPartners`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setsharingfilterforpartners).

## Анонимизировать информацию о пользователе

Вы можете настроить SDK на инструкцию AppsFlyer удалить всю идентифицирующую пользователя информацию, используя метод [`anonymizeUser`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#anonymizeuser). В этом случае SDK отправляет события установки и внутри-приложения на AppsFlyer, где затем удаляется или хэшируется вся идентифицирующая информация:

- **Удалено:** личные идентификаторы (GAID, IDFA, IDFV и CUID)
- **Хэшел:** ID приложения и IP-адрес.

Чтобы узнать, как реализовать этот метод без анонимизации событий установки, см. [Поделиться только мероприятием по установке](#use-start-to-share-only-the-install-event).

## Отключить ID

SDK способен посылать несколько конкретных идентификаторов в AppsFlyer. Вы можете исключить их в соответствии с Вашими потребностями.

**Примечание:** Отключение идентификатора рекламодателя до начала вызова предотвратит атрибуцию SRN.

| Отключить идентификатор                                                                                                                                              | Описание                                                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`setDisableAdvertisingIdentifiers`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setdisableadvertisingidentifiers)(true) | Отключает подборку различных рекламных идентификаторов SDK. Это включает в себя Google Advertising ID (GAID), OAID, и Amazon Advertising ID (AAID). |
| [`setCollectOaid`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcollectoaid)(false)                                    | Отключает коллекцию OAID от SDK.                                                                                                                                                                          |

## Отправлять данные только после выбора пользователем

В тех случаях, когда вы хотите не отправлять какие-либо данные в AppsFlyer до тех пор, пока пользователь не даст свое согласие, откладывать вызов [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start) до момента получения согласия.
