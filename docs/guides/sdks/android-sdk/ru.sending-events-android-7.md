---
title: Отправка событий
slug: отправка-события android-7
category:
  uri: SDK AppsFlyer
parent:
  uri: in-app-events-android-7
privacy:
  view: публичный
position: 1
---

## Общий обзор

Информацию о событиях в приложении для разработчиков см. [События в приложении](doc:in-app-events-sdk).

## Прежде чем начать

Вы должны [интегрировать SDK](doc:integrate-android-sdk).

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Интеграция событий внутри приложения с нашим мастером SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=android&utm_source=devhub&utm_medium=in-app-events-android');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_Anrd_events', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

## Вход в приложение

SDK позволяет регистрировать действия пользователей, происходящие в контексте вашего приложения. Эти события обычно называются **внутри-приложения**.

### Метод `logEvent`

Метод [`logEvent`](doc:android-sdk-reference-appsflyerlib#logevent) позволяет вам входить в приложение и отправлять его на обработку.

Для доступа к методу `logEvent`, импортируйте [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib):

```java Java
импортировать com.appsflyer.AppsFlyerLib;
```

```kotlin Kotlin
импортировать com.appsflyer.AppsFlyerLib
```

Для доступа к [предопределенным константам событий](#event-constants), импортируйте `AFInAppEventType` и `AFInAppEventParameterName`:

```java Java
импортировать com.appsflyer.AFInAppEventType; // Предопределенные имена событий
импортировать com.appsflyer.AFInAppEventParameterName; // Предопределенные имена параметров
```

```kotlin Kotlin
импорт com.appsflyer.AFInAppEventType // Предопределенные имена событий
импортировать com.appsflyer.AFInAppParameterName // Имена параметров
```

`logEvent` принимает 4 аргумента:

```java
void logEvent(Context context,
              java.lang.String eventName,
              java.util.Map<java.lang.String,java.lang.Object> eventValues,
              AppsFlyerRequestListener слушателю)
```

- Первым аргументом (`context`) является контекст приложения/действия
- Второй аргумент (`eventName`) - это название события в приложении
- Третий аргумент (`eventValues`) — это параметры события `Map`
- Четвертый аргумент (`listener`) является опциональным `AppsFlyerRequestListener` (полезен для [обработки события успеха/сбоя](#handling-event-submission-success-and-failure))

### Пример: Отправить событие «добавить в список пожеланий»

Например, чтобы войти в журнал, что пользователь добавил элемент в свой список пожеланий:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.PRICE, 1234.56);
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567");

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.ADD_TO_WISHLIST , eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.PRICE, 1234.56)
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567")

AppsFlyerLib.getInstance().logEvent(getApplicationContext() ,
                                    AFInAppEventType.ADD_TO_WISHLIST , eventValues)
```

В вызове выше `logEvent`:

- Название события: [`AFInAppEventType.ADD_TO_WISHLIST`](#af_add_to_wishlist)
- Значение события - это `Map`, содержащий следующие параметры событий:
  - [AFInAppEventParameterName.PRICE](#af_price): The price that's associated with the event
  - [AFInAppEventParameterName.CONTENT_ID](#af_content_id): Идентификатор добавленного элемента

### Внедрение определений структуры событий

На основании примера, приведенного в [Понимании структуры событий](https://dev.appsflyer.com/hc/docs/in-app-events-sdk#understanding-event-structure-definitions), событие должно быть реализовано следующим образом:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.PRICE, <ITEM_PRICE>);
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>);
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>);

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.CONTENT_VIEW, eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.PRICE, <ITEM_PRICE>)
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>)
eventValues.put(AFInAppEventEventParameterName.CONTENT_ID, <ITEM_SKU>)

AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    AFInAppEventType.CONTENT_VIEW, eventValues)
```

### Успешная обработка события

Вы можете предоставить [`logEvent`](doc:android-sdk-reference-appsflyerlib#logevent) объект [`AppsFlyerRequestListener`](doc:android-sdk-reference-appsflyerrequestlistener) при записи событий в приложении. Обработчик позволяет определить логику для двух сценариев:

- Событие в приложении записано успешно
- Произошла ошибка при записи события в приложении

```java
AppsFlyerLib.getInstance(). ogEvent(getApplicationContext(),
                                    AFInAppEventType. УЧАСТИЕ
                                    значений,
                                    new AppsFlyerRequestListener() {
                    @Override
                    public void onSuccess() {
                        Log. (LOG_TAG, "Событие успешно отправлено");
                    }
                    @Override
                    public void onError(int i, @NonNull String s) {
                        Log. (LOG_TAG, "Событие не было отправлено:\n" +
                                "Код ошибки: " + i + "\n"
                                + "Описание ошибки: " + s);
                    }
});
```

```kotlin
AppsFlyerLib.getInstance(). ogEvent(getApplicationContext(),
                                    AFInAppEventType. УЧАСТИЕ
                                    значений,
                                    object : AppsFlyerRequestListener {
            переопределить fun onSuccess() {
                Log. (LOG_TAG, "Событие успешно отправлено")
            }
            переопределить веселье onError(errorCode: Int, errorDesc: String) {
                Log. (LOG_TAG, "Событие не было отправлено:\n" +
                        "Код ошибки: " + errorCode + "\n"
                        + "Описание ошибки: " + errorDesc)
            }
})
```

В случае возникновения ошибки при записи события в приложении. код ошибки и описание строки, как указано в следующей таблице.

| Код ошибки | Описание (NSError)                                          |
| :--------- | :----------------------------------------------------------------------------- |
| `10`       | "Тайм-аут события. Проверьте параметр 'minTimeBetweenSessions' |
| `11`       | "Пропускать событие, потому что включена 'isStopTracking'                      |
| `40`       | Ошибка сети: Описание ошибки происходит от Android             |
| `41`       | "Нет dev ключ"                                                                 |
| `50`       | "Код состояния не удался" + код ответа от сервера                              |

### Запись событий в автономном режиме

SDK может записывать события, происходящие при отсутствии подключения к Интернету. Смотрите [События в автономном режиме](https://dev.appsflyer.com/hc/docs/in-app-events-sdk#offline-in-app-events) для подробностей.

### Журнал событий перед вызовом `start`

Если вы инициализировали SDK, но не вызывали `start`, SDK будет кешировать события до тех пор, пока не вызовет [`start`](doc:android-sdk-reference-appsflyerlib#start).

Если в кэше много событий, они отправляются на сервер один за другим (unbatched, один сетевой запрос на событие).

## Выручка от записи

> 📘 Заметка
>
> Для событий с **доходом**, включая покупки внутри приложений, подписки и рекламные события, клиенты AppsFlyer с подпиской на ROI360 должны избегать использования `AFInAppParameterName. Параметр EVENUE`(`af_revenue`) в своих событиях в приложении. Это может привести к дублированию доходов. Вместо этого они должны использовать [коннектор покупки](https://dev.appsflyer.com/hc/docs/purchase-connector-android) и [ad revenue SDK API](https://dev.appsflyer.com/hc/docs/ad-revenue-1).

Вы можете отправить доход с любого события в приложении. Используйте параметр [`AFInAppEventParameterName.REVENUE`](#af_revenue) для включения дохода в приложение события. Вы можете заполнить его любым числовым значением, положительным или отрицательным.

Значение дохода не должно содержать разделителей запятой, валютных знаков или текста. Доходное событие должно быть похоже на 1234.56.

### Пример: Закупка события с доходом

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>);
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>);
eventValues.put(AFInAppEventParameterName.REVENUE, 200);

AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.CONTENT_ID, <ITEM_SKU>)
eventValues.put(AFInAppEventParameterName.CONTENT_TYPE, <ITEM_TYPE>)
eventValues.put(AFInAppEventParameterName.REVENUE, 200)

AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues)
```

Покупка выше 200 долларов, что в качестве дохода на панели управления.

> 📘 Заметка
>
> Не добавляйте символы валюты в значение дохода.

### Настройка валюты дохода

Вы можете задать код валюты для дохода события, используя параметр `af_currency`:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.CURRENCY, "USD");
eventValues.put(AFInAppEventParameterName.REVENUE, <TRANSACTION_REVENUE>);
AppsFlyerLib.getInstance().logEvent(getApplicationContext(), 
                                    AFInAppEventType.PURCHASE, eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.REVENUE, <TRANSACTION_REVENUE>)
eventValues.put(AFInAppEventParameterName.CURRENCY,"USD")
AppsFlyerLib.getInstance().logEvent(getApplicationContext() , AFInAppEventType.PURCHASE , eventValues)
```

- Код валюты должен быть 3 символа ISO 4217
- Валюта по умолчанию - USD

Чтобы узнать о настройках, отображении и конвертации валют, смотрите наш путеводитель по [валюте дохода]().

### Логирование чистого дохода

Чтобы сообщать чистый доход наряду с валовым доходом, добавьте пользовательский параметр с ключом `af_net_revenue` к значениям события. Ценность показывает чистый доход в соответствии с собственной бизнес-логикой, например доход после сборов и/или налогов, валовой маржи или дохода после оплаты услуг.

Для этого параметра не существует предопределенной константы SDK, поэтому передайте строковый ключ напрямую. Следуйте тем же правилам форматирования, что и `af_revenue` и тем же правилам валют (валюта по умолчанию `af_currency`).

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName. EVENUE, 200); // валовой
eventValud. ut("af_net_revenue", 140); // сеть (пользовательский ключ)
eventValues. ut(AFInAppEventParameterName.CURRENCY, "USD");

AppsFlyerLib.getInstance(). ogEvent(getApplicationContext(),
                                    AFInAppEventType. URCHASE, eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>()
eventValues.put(AFInAppEventParameterName.REVENUE, 200) // валовой
eventValues. ut("af_net_revenue", 140) // сеть (пользовательский ключ)
eventValues. ut(AFInAppEventParameterName.CURRENCY, "USD")

AppsFlyerLib.getInstance(). ogEvent(getApplicationContext(),
                                    AFInAppEventType. URCHASE, значения событий)
```

> 📘 Заметка
>
> Для приложений с включенным доходом от магазина ROI360, `af_net_revenue` автоматически заполняется при покупке внутри приложения и подписке, записанных доходом магазина ROI360, так что не нужно отправлять его для этих событий.

### Логирование негативных доходов

Может возникнуть ситуация, когда вы хотите записать отрицательный доход. Например, пользователь получает возврат или аннулирует подписку.

Регистрировать отрицательный доход:

```java
Map<String, Object> eventValues = new HashMap<String, Object>();
eventValues.put(AFInAppEventParameterName.REVENUE, -1234.56);
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567");
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    "cancel_purchase",
                                    eventValues);
```

```kotlin
val eventValues = HashMap<String, Any>() 
eventValues.put(AFInAppEventParameterName.REVENUE, -1234.56)
eventValues.put(AFInAppEventParameterName.CONTENT_ID,"1234567")
AppsFlyerLib.getInstance().logEvent(getApplicationContext(),
                                    "cancel_purchase",
                                    eventValues)
```

> 📘 Заметка
>
> Обратите внимание на следующие в коде выше:
>
> - Значение дохода предшествует минусному знаку
> - Название события - это название пользовательского события под названием "cancel_purchase" - это поможет вам легко определить негативные события дохода на панели управления и отчеты о необработанных данных

## Проверка покупок

AppsFlyer предоставляет проверку сервера для покупок в приложении. Дополнительную информацию см. [Подтвердить и зарегистрировать покупку](doc:validate-and-log-purchase-android)

## Константы событий

### Предопределенные имена событий

Чтобы использовать следующие константы, импортируйте com.appsflyer.AFInAppEventType:

```java Java
импортировать com.appsflyer.AFInAppEventType;
```

```kotlin Kotlin
импортировать com.appsflyer.AFInAppEventType
```

Предопределенные константы имени события следуют за конвенцией именования `AFInAppEventType.EVENT_NAME`. Например, `AFInAppEventType.ADD_TO_CART`

| Название события                     | Имя константы Android                                                                             |   |
| :----------------------------------- | :------------------------------------------------------------------------------------------------ | - |
| `"af_level_achieved"`                | <div id="af_level_achieved">`AFInAppEventType.LEVEL_ACHIEVED`</div>                               |   |
| `"af_add_payment_info"`              | <div id="af_add_payment_info">`AFInAppEventType.ADD_PAYMENT_INFO`</div>                           |   |
| `"af_add_to_cart"`                   | <div id="af_add_to_cart">`AFInAppEventType.ADD_TO_CART`</div>                                     |   |
| `"af_add_to_wishlist"`               | <div id="af_add_to_wishlist">`AFInAppEventType.ADD_TO_WISHLIST`</div>                             |   |
| `"af_complete_registration"`         | <div id="af_complete_registration">`AFInAppEventType.COMPLETE_REGISTRATION`</div>                 |   |
| `"af_tutorial_completion"`           | <div id="af_tutorial_completion">`AFInAppEventType.TUTORIAL_COMPLETION`</div>                     |   |
| `"af_initiated_checkout"`            | <div id="af_initiated_checkout">`AFInAppEventType.INITIATED_CHECKOUT`</div>                       |   |
| `"af_purchase"`                      | <div id="af_purchase">`AFInAppEventType.PURCHASE`</div>                                           |   |
| `"af_rate"`                          | <div id="af_rate">`AFInAppEventType.RATE`</div>                                                   |   |
| `"af_search"`                        | <div id="af_search">`AFInAppEventType.SEARCH`</div>                                               |   |
| `"af_spent_credits"`                 | <div id="af_spent_credits">`AFInAppEventType.SPENT_CREDITS`</div>                                 |   |
| `"af_achievement_unlock"`            | <div id="af_achievement_unlocked">`AFInAppEventType.ACHIEVEMENT_UNLOCKED`</div>                   |   |
| `"af_content_view"`                  | <div id="af_content_view">`AFInAppEventType.CONTENT_VIEW`</div>                                   |   |
| `"af_list_view"`                     | <div id="af_list_view">`AFInAppEventType.LIST_VIEW`</div>                                         |   |
| `"af_travel_booking"`                | <div id="af_travel_booking">`AFInAppEventType.TRAVEL_BOOKING`</div>                               |   |
| `"af_share"`                         | <div id="af_share">`AFInAppEventType.SHARE`</div>                                                 |   |
| `"af_invite"`                        | <div id="af_invite">`AFInAppEventType.INVITE`</div>                                               |   |
| `"af_login"`                         | <div id="af_login">`AFInAppEventType.LOGIN`</div>                                                 |   |
| `"af_re_engage"`                     | <div id="af_re_engage">`AFInAppEventType.RE_ENGAGE`</div>                                         |   |
| `"af_update"`                        | <div id="af_update">`AFInAppEventType.UPDATE`</div>                                               |   |
| `"af_location_coordinates"`          | <div id="af_location_coordinates">`AFInAppEventType.LOCATION_COORDINATES`</div>                   |   |
| `"af_customer_segment"`              | <div id="af_customer_segment">`AFInAppEventType.CUSTOMER_SEGMENT`</div>                           |   |
| `"af_subscribe"`                     | <div id="af_subscribe">`AFInAppEventType.SUBSCRIBE`</div>                                         |   |
| `"af_start_trial"`                   | <div id="af_start_trial">`AFInAppEventType.START_TRIAL`</div>                                     |   |
| `"af_ad_click"`                      | <div id="af_ad_click">`AFInAppEventType.AD_CLICK`</div>                                           |   |
| `"af_ad_view"`                       | <div id="af_ad_view">`AFInAppEventType.AD_VIEW`</div>                                             |   |
| `"af_opened_from_push_notification"` | <div id="af_opened_from_push_notification">`AFInAppEventType.OPENED_FROM_PUSH_NOTIFICATION`</div> |   |

### Предопределенные параметры события

Чтобы использовать следующие константы, импортируйте `AFInAppEventParameterName`:

```java Java
импортировать com.appsflyer.AFInAppEventParameterName;
```

```kotlin Kotlin
импортировать com.appsflyer.AFInAppEventParameterName
```

Предопределенный параметр констант события следует за конвенцией именования `AFInAppEventParameterName.PARAMETER_NAME`. Например, `AFInAppEventParameterName.CURRENCY`

| Имя параметра события              | Имя константы Android                                                             | Тип                                                |
| :--------------------------------- | :-------------------------------------------------------------------------------- | :------------------------------------------------- |
| `"af_content"`                     | <div id="af_content">`CONTENT`</div>                                              | `Строка[]`                                         |
| `"af_achievement_id"`              | <div id="af_achievement_id">`ACHIEVEMENT_ID`</div>                                | `Строка`                                           |
| `"af_level"`                       | <div id="af_level">`LEVEL`</div>                                                  | `Строка`                                           |
| `"af_score"`                       | <div id="af_score">`SCORE`</div>                                                  | `Строка`                                           |
| `"af_success"`                     | <div id="af_success">`SUCCESS`</div>                                              | `Строка`                                           |
| `"af_price"`                       | <div id="af_price">`PRICE`</div>                                                  | `float`                                            |
| `"af_content_type"`                | <div id="af_content_type">`CONTENT_TYPE`</div>                                    | `Строка`                                           |
| `"af_content_id"`                  | <div id="af_content_id">`CONTENT_ID`</div>                                        | `Строка`                                           |
| `"af_content_list"`                | <div id="af_content_list">`CONTENT_LIST`</div>                                    | `Строка[]`                                         |
| `"af_currency"`                    | <div id="af_currency">`CURRENCY`</div>                                            | `Строка`                                           |
| `"af_quantity"`                    | <div id="af_quantity">`QUANTITY`</div>                                            | `int`                                              |
| `"af_registration_method"`         | <div id="af_registration_method">`REGISTRATION_METHOD`</div>                      | `Строка`                                           |
| `"af_payment_info_available"`      | <div id="af_payment_info_available">`PAYMENT_INFO_AVAILABLE`</div>                | `Строка`                                           |
| `"af_max_rating_value"`            | <div id="af_max_rating_value">`MAX_RATING_VALUE`</div>                            | `Строка`                                           |
| `"af_rating_value"`                | <div id="af_rating_value">`RATING_VALUE`</div>                                    | `Строка`                                           |
| `"af_search_string"`               | <div id="af_search_string">`SEARCH_STRING`</div>                                  | `Строка`                                           |
| `"af_date_a"`                      | <div id="af_date_a">`DATE_A`</div>                                                | `Строка`                                           |
| `"af_date_b"`                      | <div id="af_date_b">`DATE_B`</div>                                                | `Строка`                                           |
| `"af_destination_a"`               | <div id="af_destination_a">`DESTINATION_A`</div>                                  | `Строка`                                           |
| `"af_destination_b"`               | <div id="af_destination_b">`DESTINATION_B`</div>                                  | `Строка`                                           |
| `"af_description"`                 | <div id="af_description">`DESCRIPTION`</div>                                      | `Строка`                                           |
| `"af_class"`                       | <div id="af_class">`CLASS`</div>                                                  | `Строка`                                           |
| `"af_event_start"`                 | <div id="af_event_start">`EVENT_START`</div>                                      | `Строка`                                           |
| `"af_event_end"`                   | <div id="af_event_end">`EVENT_END`</div>                                          | `Строка`                                           |
| `"af_lat"`                         | <div id="af_lat">`LAT`</div>                                                      | `Строка`                                           |
| `"af_long"`                        | <div id="af_long">`LONG`</div>                                                    | `Строка`                                           |
| `"af_customer_user_id"`            | <div id="af_customer_user_id">`CUSTOMER_USER_ID`</div>                            | `Строка`                                           |
| `"af_validated"`                   | <div id="af_validated">`VALIDATED`</div>                                          | `boolean`                                          |
| `"af_revenue"`                     | <div id="af_revenue">`REVENUE`</div>                                              | `float`                                            |
| `"af_projected_revenue"`           | <div id="af_projected_revenue">`PROJECTED_REVENUE`</div>                          | `float`                                            |
| `"af_receipt_id"`                  | <div id="af_receipt_id">`RECEIPT_ID`</div>                                        | `Строка`                                           |
| `"af_tutorial_id"`                 | <div id="af_tutorial_id">`TUTORIAL_ID`</div>                                      | `Строка`                                           |
| `"af_virtual_currency_name"`       | <div id="af_virtual_currency_name">`VIRTUAL_CURRENCY_NAME`</div>                  | `Строка`                                           |
| `"af_deep_link"`                   | <div id="af_deep_link">`DEEP_LINK`</div>                                          | `Строка`                                           |
| `"af_old_version"`                 | <div id="af_old_version">`OLD_VERSION`</div>                                      | `Строка`                                           |
| `"af_new_version"`                 | <div id="af_new_version">`NEW_VERSION`</div>                                      | `Строка`                                           |
| `"af_review_text"`                 | <div id="af_review_text">`REVIEW_TEXT`</div>                                      | `Строка`                                           |
| `"af_coupon_code"`                 | <div id="af_coupon_code">`COUPON_CODE`</div>                                      | `Строка`                                           |
| `"af_order_id"`                    | <div id="af_order_id">`ORDER_ID`</div>                                            | `Строка`                                           |
| `"af_param_1"`                     | <div id="af_param_1">`PARAM_1`</div>                                              | `Строка`                                           |
| `"af_param_2"`                     | <div id="af_param_2">`PARAM_2`</div>                                              | `Строка`                                           |
| `"af_param_3"`                     | <div id="af_param_3">`PARAM_3`</div>                                              | `Строка`                                           |
| `"af_param_4"`                     | <div id="af_param_4">`PARAM_4`</div>                                              | `Строка`                                           |
| `"af_param_5"`                     | <div id="af_param_5">`PARAM_5`</div>                                              | `Строка`                                           |
| `"af_param_6"`                     | <div id="af_param_6">`PARAM_6`</div>                                              | `Строка`                                           |
| `"af_param_7"`                     | <div id="af_param_7">`PARAM_7`</div>                                              | `Строка`                                           |
| `"af_param_8"`                     | <div id="af_param_8">`PARAM_8`</div>                                              | `Строка`                                           |
| `"af_param_9"`                     | <div id="af_param_9">`PARAM_9`</div>                                              | `Строка`                                           |
| `"af_param_10"`                    | <div id="af_param_10">`PARAM_10`</div>                                            | `Строка`                                           |
| `"af_departing_departure_date"`    | <div id="af_departing_departure_date">`DEPARTING_DEPARTURE_DATE`</div>            | `Строка`                                           |
| `"af_returning_departure_date"`    | <div id="af_returning_departure_date">`RETURNING_DEPARTURE_DATE`</div>            | `Строка`                                           |
| `"af_destination_list"`            | <div id="af_destination_list">`DESTINATION_LIST`</div>                            | `Строка[]`                                         |
| `"af_city"`                        | <div id="af_city">`CITY`</div>                                                    | `Строка`                                           |
| `"af_region"`                      | <div id="af_region">`REGION`</div>                                                | `Строка`                                           |
| `"af_country"`                     | <div id="af_country">`COUNTRY`</div>                                              | `Строка`                                           |
| `"af_departing_arrival_date"`      | <div id="af_departing_arrival_date">`DEPARTING_ARRIVAL_DATE`</div>                | `Строка`                                           |
| `"af_returning_arrival_date"`      | <div id="af_returning_arrival_date">`RETURNING_ARRIVAL_DATE`</div>                | `Строка`                                           |
| `"af_suggested_destinations"`      | <div id="af_suggested_destinations">`SUGGESTED_DESTINATIONS`</div>                | `Строка[]`                                         |
| `"af_travel_start"`                | <div id="af_travel_start">`TRAVEL_START`</div>                                    | `Строка`                                           |
| `"af_travel_end"`                  | <div id="af_travel_end">`TRAVEL_END`</div>                                        | `Строка`                                           |
| `"af_num_adults"`                  | <div id="af_num_adults">`NUM_ADULTS`</div>                                        | `Строка`                                           |
| `"af_num_children"`                | <div id="af_num_children">`NUM_CHILDREN`</div>                                    | `Строка`                                           |
| `"af_num_infants"`                 | <div id="af_num_infants">`NUM_INFANTS`</div>                                      | `Строка`                                           |
| `"af_suggested_hotels"`            | <div id="af_suggested_hotels">`SUGGESTED_HOTELS`</div>                            | `Строка[]`                                         |
| `"af_user_score"`                  | <div id="af_user_score">`USER_SCORE`</div>                                        | `Строка`                                           |
| `"af_hotel_score"`                 | <div id="af_hotel_score">`HOTEL_SCORE`</div>                                      | `Строка`                                           |
| `"af_purchase_currency"`           | <div id="af_purchase_currency">`PURCHASE_CURRENCY`</div>                          | `Строка`                                           |
| `"af_preferred_neighborhoods"`     | <div id="af_preferred_neighborhoods">`PREFERRED_NEIGHBORHOODS`</div>              | `Строка[]`                                         |
| `"af_preferred_num_stops"`         | <div id="af_preferred_num_stops">`PREFERRED_NUM_STOPS`</div>                      | `Строка`                                           |
| `"af_adrev_ad_type"`               | <div id="af_adrev_ad_type">`AD_REVENUE_AD_TYPE`</div>                             | `Строка`                                           |
| `"af_adrev_network_name"`          | <div id="af_adrev_network_name">`AD_REVENUE_NETWORK_NAME`</div>                   | `Строка`                                           |
| `"af_adrev_placement_id"`          | <div id="af_adrev_placement_id">`AD_REVENUE_PLACEMENT_ID`</div>                   | `Строка`                                           |
| `"af_adrev_ad_size"`               | <div id="af_adrev_ad_size">`AD_REVENUE_AD_SIZE`</div>                             | `Строка`                                           |
| `"af_adrev_mediated_network_name"` | <div id="af_adrev_mediated_network_name">`AD_REVENUE_MEDIATED_NETWORK_NAME`</div> | `Строка`                                           |
| `"af_preferred_price_range"`       | <div id="af_preferred_price_range">`PREFERRED_PRICE_RANGE`</div>                  | `String`, int tuple отформатирован как `(min,max)` |
| `"af_preferred_star_ratings"`      | <div id="af_preferred_star_ratings">`PREFERRED_STAR_RATINGS`</div>                | `String`, int tuple отформатирован как `(min,max)` |
