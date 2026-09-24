---
title: Установка ID пользователя клиента
slug: пользователь-id-android
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-android-6
privacy:
  view: публичный
position: 4
---

<span class="annotation-optional">Optional</span>

ID пользователя (CUID) — это уникальный идентификатор пользователя, созданный владельцем приложения за пределами SDK. Он может быть связан с событиями в приложении, если предоставлен в SDK. Как только эти события связаны с CUID, они могут быть перекрёстными ссылками с пользовательскими данными с других устройств и приложений.

### Установка ID пользователя

Как только CUID доступен, вы можете его установить, позвонив [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid).

```java

...
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, conversionListener, this);  
AppsFlyerLib.getInstance().start(this , <YOUR_DEV_KEY> );
. .
// магия, чтобы получить customerUserID...
...
AppsFlyerLib.getInstance().setCustomerUserId(<MY_CUID>);
```

CUID может быть связан только с событиями в приложении после его установки. Поскольку `start` был вызван перед `setCustomerUserID`, событие установки не будет связано с CUID. Если вам нужно связать событие установки с CUID, см. раздел ниже.

### Связать CUID с событием установки

Если вам важно связать событие установки с CUID, вы должны установить его перед вызовом `start`.

Вы можете установить CUID перед `start` двумя способами, в зависимости от того, запускаете ли вы SDK в классе `Application` или `Activity`.

**При запуске от класса приложения**

Если вы запустили SDK из класса `Application` (см. [`Starting the Android SDK`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk)) и вы хотите, чтобы CUID был связан с событием установки, поместите SDK в режим ожидания, чтобы предотвратить отправку данных об установке в AppsFlyer до предоставления CUID.

Чтобы активировать режим ожидания, установите [`waitForCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#waitforcustomeruserid) на `true` после [`init`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) и до [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).

> ⚠️ **Важно**
> Важно помнить, что включение SDK в режим ожидания может заблокировать SDK от отправки события установки и, следовательно, предотвратить атрибут. Это может произойти, например, когда пользователь запускает приложение в первый раз, а затем выходит до того, как SDK может установить CUID.

```java
AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
AppsFlyerLib.getInstance().start(this);
```

После вызова [`start`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start), вы можете добавить свой пользовательский код, благодаря которому CUID доступен.

Как только CUID доступен, он включает в себя установку CUID, освобождение SDK из режима ожидания, и отправка данных атрибутов с ID клиента на AppsFlyer. Этот шаг выполняется с помощью вызова в [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession).

```java
AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, это);
```

Кроме [`setCustomerIdAndLogSession`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeridandlogsession), не используйте [`setCustomerUserId`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcustomeruserid) или любые другие функциональные возможности AppsFlyer SDK, так как ожидание SDK игнорирует это.

### Примечание

Если вы хотите удалить режим ожидания из потока инициализации SDK, недостаточно удалить вызов в `waitForCustomerUserId(true)`. Также необходимо заменить его на `waitForCustomerUserID(false)`. Просто удаления вызова недостаточно, потому что флаг 'waitForCustomerUserId' хранится в общих настройках Android.

**Пример кода**

```java
public class AFApplication extends Application {
  @Override
  public void onCreate() {
    super. nCreate();
    AppsFlyerConversionListener conversionDataListener = 
    new AppsFlyerConversionListener() {
      . .
    };
    AppsFlyerLib.getInstance().init(<YOUR_DEV_KEY>, getConversionListener(), getApplicationContext());
    AppsFlyerLib. etInstance().waitForCustomerUserId(true);
    AppsFlyerLib.getInstance(). tart(this);
    // Сделайте вашу магию, чтобы получить customerUserID
    // код AppsFlyer SDK, на который ссылается здесь, будет сброшен
    // . .
    // По мере доступности customerUserID вызова setCustomerIdAndLogSession(). 
    // setCustomerIdAndLogSession() устанавливает CUID, выпускает режим ожидания,
    // и посылает данные атрибутов с ID клиента на AppsFlyer.
    AppsFlyerLib.getInstance().setCustomerIdAndLogSession(<CUSTOMER_ID>, это);
  }
}
```

**При начале занятия**

Если вы запустили SDK из класса `Activity` (см. [\`\`Deferring SDK start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#deferring-sdk-start)) и вы хотите, чтобы CUID был связан с событием установки, установите CUID до[`start\`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#start).
