---
title: Установка ID пользователя клиента
slug: клиент-пользователь-id-android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-7
privacy:
  view: публичный
position: 4
---

<span class="annotation-optional">Optional</span>

ID пользователя (CUID) — это уникальный идентификатор пользователя, созданный владельцем приложения за пределами SDK. CUID позволяет владельцам приложений следить за поездками пользователей на разных устройствах.

### Установка ID пользователя клиента

Как только CUID доступен, установите его вызовом [`setCustomerUserId`](doc:android-sdk-reference-appsflyerlib#setcustomeruserid):

```java Java
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

CUID может быть связан только с событиями в приложении после его установки. Если `start` был вызван перед `setCustomerUserId`, событие установки не будет связано с CUID. Чтобы связать событие установки с CUID, смотрите ниже.

> 📘 Заметка
>
> В SDK V7 между сессиями не сохраняются установленные значения. Повторно применять `setCustomerUserId` при каждом холодном запуске.

### Связать CUID с событием установки

Если вам нужен CUID для связи с событием установки, установите его перед вызовом `start()`.

В SDK V7 это просто: так как вы контролируете, когда вызывается `start()`, установите CUID внутри вашего сеанса готового процесса callback перед вызовом `start()`:

```java Java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this);

AppsFlyerLib.getInstance().registerSessionReadyListener(() -> {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
    AppsFlyerLib.getInstance().start();
});
```

```kotlin Kotlin
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, null, this)

AppsFlyerLib.getInstance().registerSessionReadyListener {
    AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>)
    AppsFlyerLib.getInstance().start()
}
```

> 📘 Заметка
>
> API `waitForCustomerUserId` и `setCustomerIdAndLogSession` были удалены в SDK V7. Новая модель сеанса делает их ненужными: поскольку вы контролируете при вызове «start()», нет необходимости в механизме ожидания.
