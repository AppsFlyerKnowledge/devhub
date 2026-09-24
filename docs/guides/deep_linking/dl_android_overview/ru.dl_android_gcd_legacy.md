---
title: Наследие API Android
slug: dl_android_gcd_legacy
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Прямая глубокая связь

### Общий обзор

Прямое глубокое связывание мобильных пользователей направляет их в определенную активность или контент в приложение, когда приложение уже установлено.

Это маршрутизация конкретной активности в приложении возможна из-за параметров, переданных приложению, когда ОС открывает приложение и называется метод `onAppOpenAttribution`. AppsFlyer's OneLink гарантирует, что правильное значение передается вместе с нажатием кнопки пользователя, таким образом, персонализируя работу приложения пользователя.

\*\*Для глубокой привязки требуется только `deep_link_value`. Однако другие параметры и значения (такие как пользовательские параметры атрибуции) также могут быть добавлены к ссылке и возвращены SDK в качестве глубоких ссылок. \*\*

\*\*Прямое глубокое связывание работает следующим образом: \*\*:

![Прямой поток глубоких ссылок](https://files.readme.io/b9f3bff-d649913-5472_Android_DL_1.png "Прямая глубокая связь")

1. Пользователь кликает на OneLink короткий URL.
2. Android запускает приложение на основе соответствующей деятельности в AndroidManifest.xml.
3. AppsFlyer SDK запускается в приложении.
4. AppsFlyer SDK извлекает данные OneLink.
   - Короткий URL, данные извлекаются из короткого URL resolver API на серверах AppsFlyer.
   - В длинный URL-адрес данные извлекаются непосредственно из длинного URL-адреса.
5. AppsFlyer SDK триггеры `onAppOpenAttribution()` с полученными параметрами и параметрами атрибута кэша (например, `install_time`).
6. Асинхронно, вызывается `onConversionDataSuccess()` с полными данными атрибута. (Вы можете выйти из этой функции, проверьте, является ли `is_first_launch` `true`.)
7. `onAppOpenAttribution()` использует карту атрибутов для отправки других активностей в приложении и передачи соответствующих данных.
   - Это создает персонализированный опыт для пользователя, который является главной целью OneLink.

### Процедуры

Для реализации метода `onAppOpenAttribution` и настройки поведения параметра, необходимо выполнить следующий контрольный список действий.

#### Список процедур

1. [Решение о поведении приложения и `deep_link_value`](#deciding-app-behavior) (и другие имена и значения параметров) - с маркером
2. [Метод планирования, т.е. `deep_link_value`](#planning-method-input) (и другие названия и значения параметров) - с маркером
3. [Реализация логики `onAppOpenAttribution()`](#implementing-onappopenattribution-logic)
4. [Реализация логики `onAttributionFailure()`](#implementing-onattributionfailure-logic)

#### Решение поведения приложения

**Чтобы решить, что такое приложение при нажатии на ссылку**:

Получить с маркера: Ожидаемое поведение ссылки при нажатии.

#### Ввод метода планирования

После нажатия OneLink и установки приложения на его устройстве, метод `onAppOpenAttribution` вызывается AppsFlyer SDK. Это называется повторным привлечением к ответственности.

Метод `onAppOpenAttribution` получает переменные в виде ввода: `Map <String, String>`.
Структура входных данных описана [here](https://dev.appsflyer.com/hc/docs/android-sample-payloads).

#### Реализация логики onAppOpenAttribution()

Глубокая ссылка открывает метод `onAppOpenAttribution` в основной активности. Параметры OneLink в вводе метода используются для реализации специфического опыта пользователя при открытии приложения.

#### Пример кода:

```java
@Override
  public void onAppOpenAttribution(Map<String, String> attributionData) {
  if (!attributionData. ontainsKey("is_first_launch"))
    Log.d(LOG_TAG, "onAppOpenAttribution: This is NOT deferred deep linking");
  for (String attrName : attributionData. eySet()) {
    String deepLinkAttrStr = attrName + " = " + attributionData.get(attrName);
    Log. (LOG_TAG, "Глубокий атрибут: " + deepLinkAttrStr);
  }
  Журнал. (LOG_TAG, "onAppOpenAttribution: Deep link into " + attributionData.get("deep_link_value"));
  goToFruit(attributionData. et("deep_link_value"), attributionData);
}

@Override
  public void onAttributionFailure(String errorMessage) {
  Log. (LOG_TAG, "error onAttributionFailure : " + errorMessage);
}

private void goToFruit(String fruitName, Map<String, String> dlData) {
    String fruitClassName = fruitName. oncat("Activity");
    try {
        Class fruitClass = Класс. orName(this.getPackageName().concat(".").concat(fruitClassName));
        Log. (LOG_TAG, "Поиск класса " + фруктовый класс);
        Цель = новый ориентир (getApplicationContext(), фруктовый класс);
        if (dlData ! null) {
            // Карта передана HashMap, так как проще передать сериализуемые данные для цели
            HashMap<String, String> copy = new HashMap<String, String>(dlData);
            intent. utExtra(DL_ATTRS, копия);
        }
        startActivity(intent);
    } catch (ClassNotFoundException e) {
        Log. (LOG_TAG, "Глубокая связь не ищет " + fruitName);
        e. rintStackTrace();
    }
}
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L64-L73)

> i **Примечание**
> `onAppOpenAttribution` не вызывается, когда приложение запущено в фоновом режиме, а `LaunchMode` не является стандартным.
> Чтобы исправить это, вызовите метод `setIntent(intent)`, чтобы установить значение intent внутри метода `onNewIntent`, если приложение использует нестандартный `LaunchMode`.
>
> ```java
> import android.content.Intent;
>  ...
>  ...
>  ...
>  @Override
>  protected void onNewIntent(Intent intent) 
>  { 
>    super.onNewIntent(intent);     
>    setIntent(intent);
> }
> ```

#### Реализация логики onAttributionFailure()

Метод `onAttributionFailure` вызывается всякий раз, когда вызывается вызов в `onAppOpenAttribution`. Функция должна сообщить об ошибке и создать ожидаемый опыт для пользователя.

```java
@Override
public void onAttributionFailure(String errorMessage) {
    Log.d(LOG_TAG, "error onAttributionFailure : " + errorMessage);
}
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L75-L78)

## Отложенная глубокая связь

### Общий обзор

Откладывается глубокое связывание новых пользователей сначала в нужный магазин приложений для установки, а затем, после открытия для определенного приложения (например, для конкретной страницы в приложении).

Когда пользователь запустит приложение, функция обратного вызова `onConversionDataSuccess` получает как данные преобразования нового пользователя, так и данные OneLink. Данные OneLink делают возможным маршрутизацию внутри приложения из-за `deep_link_value` или других параметров, которые передаются приложению при открытии операционной системы.

Только `deep_link_value` требуется для глубокой привязки. Однако другие параметры и значения (такие как пользовательские параметры атрибуции) также могут быть добавлены к ссылке и возвращены SDK в качестве глубоких ссылок. AppsFlyer OneLink гарантирует, что правильные параметры передаются вместе с кликом пользователя, таким образом персонализируя работу приложения пользователя.

Маркетер и разработчик должны координировать желаемое поведение приложения и `deep_link_value`. Маркетер использует параметры для создания глубоких ссылок, и разработчик настраивает поведение приложения на основе полученной стоимости.

Ответственность за правильность обработки параметров в приложении лежит на разработчике, для маршрутизации внутри приложения и персонализации данных по ссылке.

\*\*Отложенный глубоководный поток работает следующим образом:
![Откладывание глубоких связей потока!](https://files.readme.io/78a2623-5472_Android_DDL.png "Отложенный глубокий поток")

1. Пользователь кликает на OneLink на устройстве, на котором приложение не установлено.
2. AppsFlyer регистрирует клик и перенаправляет пользователя на правильную страницу магазина приложений или целевой страницы.
3. Пользователь устанавливает приложение и запускает его.
4. AppsFlyer SDK инициализирован и установка присваивается серверам AppsFler.
5. SDK запускает метод `onConversionDataSuccess`. Функция получает входные данные, которые включают в себя и `deep_link_value`, и атрибуционные данные/параметры, определенные в данных OneLink.
6. Параметр `is_first_launch` имеет значение `true`, что сигнализирует отложенный глубокий поток ссылок.
   Разработчик использует данные, полученные в функции «onConversionDataSuccess», для создания персонализированного опыта пользователя для первого запуска приложения.

### Процедуры

Чтобы реализовать метод `onConversionDataSuccess` и настроить поведение параметров, необходимо выполнить следующий контрольный список действий.

1. [Решение о поведении приложения при первом запуске и `deep_link_value`](#deciding-app-behavior-on-first-launch) (и другие названия и значения параметров) - с маркером
2. [Метод планирования, т.е. `deep_link_value`](#planning-method-input-1) (и другие названия и значения параметров) - с маркером
3. [Реализация логики `onConversionDataSuccess()`](#implementing-onconversiondatasuccess-logic)
4. [Реализация логики `onConversionDataFail()`](#implementing-onconversiondatafailure-logic)

#### Решение поведения приложения при первом запуске

**Чтобы решить поведение приложения при первом запуске**:

Получить с маркера: Ожидаемое поведение ссылки, когда она будет нажата, и приложение откроется в первый раз.

#### Ввод метода планирования

Для отсрочки глубокого привязки, необходимо спланировать ввод метода `onConversionDataSuccess`, и ввод решений в предыдущем разделе (для глубокой ссылки) будет иметь значение при первом запуске приложения.

Метод `onConversionDataSuccess` получает `deep_link_value` и другие переменные в качестве входных данных: Map <String, Object>.

Карта содержит два вида данных:

- [Данные атрибутов](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
- Data defined by the marketer in the link (`deep_link_value` and other parameters and values)
  Other parameters can be either:
  - Официальные параметры AppsFlyer
  - Пользовательские параметры и значения, выбранные маркером и разработчиком.
  - Структура входных данных описана [here](https://dev.appsflyer.com/hc/docs/android-legacy-apis#input-parameters).

Маркетеру и разработчикам необходимо планировать «deep_link_value» (и другие возможные параметры и значения) на основе желаемого поведения приложения при нажатии на ссылку.

**Планировать `deep_link_value` и другие имена параметров и значения, основанные на ожидаемом поведении ссылки**:

1. Сообщите маркеру какие параметры и значения необходимы для реализации желаемого поведения приложения.
2. Определите конвенции о именах для `deep_link_value` и других параметров и значений.
   **Примечание**:
   - Пользовательские параметры не будут отображаться в сырых данных, собранных в AppsFlyer.
   - Данные преобразования не будут возвращать пользовательский параметр с именем "name, " с строчным регистром "n".

#### Реализация логики onConversionDataSuccess()

Когда приложение открыто в первый раз, метод `onConversionDataSuccess` запускается в основной активности. `deep_link_value` и другие параметры ввода метода используются для реализации специфических пользовательских возможностей при первом запуске приложения.

**Для реализации логики**:

1. Реализовать логику на основе выбранных параметров и значений. Смотрите следующий пример кода.
2. После завершения отправьте маркетингу подтверждение того, что приложение ведет себя соответствующим образом.

#### Пример кода

```java
@Override
 public void onConversionDataSuccess(Map<String, Object> conversionData) {
     for (String attrName : conversionData. eySet())
         Лог. (LOG_TAG, "Атрибут конверсии: " + attrName + " = " + conversionData.get(attrName));
     Статус строки = Объекты. equireNonNull(conversionData.get("af_status")).toString();
     if(status quals("Non-organic"){
         if( Objects.requireNonNull(conversionData. et("is_first_launch")).toString().equals("true"){
             Log. (LOG_TAG,"Conversion: First Launch");
             if (conversionData. ontainsKey("deep_link_value"){
                 Log.d(LOG_TAG,"Conversion: This is deferred deep linking. );
                 // TODO SDK в будущих версиях - соответствует входным типам
                 Map<String,String> newMap = new HashMap<>();
                 для (Map. ntry<String, Object> запись : conversionData. ntrySet()) {
                         newMap. ut(entry.getKey(), String.valueOf(entry. etValue());
                 }
                 onAppOpenAttribution(newMap);
             }
         } else {
             Log. (LOG_TAG,"Конверсия: Не первый запуск");
         }
     } else {
         Log. (LOG_TAG,"Конверсия: Это органическая установка.");
     }
}
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L33-L56)

#### Реализация логики onConversionDataFailure()

Способ `onConversionDataFailure` вызывается всякий раз, когда сбой вызова `onConversionDataSuccess`. Функция должна сообщить об ошибке и создать ожидаемый опыт для пользователя.

**Для реализации метода `onConversionDataFailure`**:

```java
@Override
public void onConversionDataFail(String errorMessage) {
    Log.d(LOG_TAG, "Ошибка получения данных преобразования: " + errorMessage);
}
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/5b202b983b33d62bd5d80102ab27f17e2b1cb25f/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/MainActivity.java#L75-L78)

## Пример полезных нагрузок Android

Смотрите следующие примеры полезных нагрузок для App Links, URI схем и отсроченных проверок. Образцы содержат полную полезную нагрузку, связанную с тем, когда все параметры на странице настройки пользовательских ссылок Onelink содержат данные.

**Примечание**: Payloads возвращаются как карта. Однако для ясности следуют примерные нагрузки отображаются в форме JSON.

### Ссылки на Android

Ввести в `onAppOpenAttribution(Map<String, String> attributionData)`

```short_link
{
    "af_dp": "afbasicapp://mainactivity",
    "af_ios_url": "https://isitchristmas. om/",
    "fruit_name": "яблоки",
    "c": "fruit_of_the_month",
    "media_source": "Email",
    "link": "https://onelink-basic-app. nelink. e/H5hv/6d66214a",
    "pid": "Email",
    "af_cost_currency": "USD",
    "af_sub1": "my_sub1",
    "af_click_lookback": "20d",
    "af_adset": "my_adset",
    "af_android_url": "https://isitchristmas. om/",
    "af_sub2": "my_sub2",
    "fruit_amount": 26,
    "af_cost_value": 6,
    "кампания": "fruit_of_the_month",
    "af_channel": "my_channel",
    "af_ad": "my_adname",
    "is_retargeting": "true"
}
```

```long_link
{
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "fruit_name": "Apples",
    "af_ios_url": "https://my_ios_lp. om",
    "media_source": "Email",
    "scheme": "https",
    "link": "https://onelink-basic-app.onelink. e/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp. om&af_android_url=https%3A%2F%2Fmy_android_lp. om",
    "af_cost_currency": "USD",
    "af_sub1": "my_sub1",
    "af_click_lookback": "20d",
    "path": "/H5hv",
    "af_adset": "my_adset",
    "af_android_url": "https://my_android_lp. om",
    "af_sub2": "my_sub2",
    "fruit_amount": 16,
    "af_cost_value": 6,
    "host": "onelink-basic-app. nelink.me",
    "кампания": "fruit_of_the_month",
    "af_channel": "my_channel",
    "af_ad": "my_adname"
}
```

### URI schemes

Ввести в `onAppOpenAttribution(Map<String, String> attributionData)`

```short_link
{
    "scheme": "afbasicapp",
    "link": "afbasicapp://mainactivity?af_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp. om&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp. om&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092",
    "af_cost_currency": "NZD",
    "af_click_lookback": "25d",
    "af_deeplink": true,
    "path": "",
    "af_android_url": "https://my_android_lp. om",
    "af_force_deeplink": true,
    "fruit_amount": 15,
    "host": "mainactivity",
    "af_channel": "my_channel",
    "shortlink": "9270d092",
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "af_ios_url": "https://my_ios_lp. om",
    "fruit_name": "apples",
    "af_web_id": "367f81fb-59a4-446a-ac6c-a68d2ee9447c-p",
    "media_source": "Email",
    "af_status": "Non-organic",
    "af_sub1": "my_sub1",
    "af_adset": "my_adset",
    "af_sub2": "my_sub2",
    "af_cost_value": 5,
    "кампания": "my_campaign",
    "af_ad": "my_adname",
    "is_retargeting": true
}
```

```long_link
{
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-06 06:56:02",
    "af_ios_url": "https://my_ios_lp. om",
    "fruit_name": "apples",
    "af_web_id": "367f81fb-59a4-446a-ac6c-a68d2ee9447c-p",
    "scheme": "afbasicapp",
    "media_source": "Email",
    "link": "afbasicapp://mainactivity? f_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp. om&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp. om&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=367f81fb-59a4-446a-ac6c-a68d2ee9447c-p&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email",
    "af_cost_currency": "NZD",
    "af_status": "Неорганический",
    "af_click_lookback": "25d",
    "af_sub1": "my_sub1",
    "af_deeplink": true,
    "path": "",
    "af_android_url": "https://my_android_lp. om",
    "af_adset": "my_adset",
    "fruit_amount": 15,
    "af_sub2": "my_sub2",
    "host": "mainactivity",
    "af_cost_value": 5,
    "кампания": "my_campaign",
    "af_channel": "my_channel",
    "af_ad": "my_adname",
    "is_retargeting": true
}
```

### Отложенная глубокая связь

Ввод в `onConversionDataSuccess(Map<String, Object> conversionData)`

```short_link
{
    "redirect_response_data": null,
    "adgroup_id": null,
    "engmnt_source": null,
    "retargeting_conversion_type": "none",
    "orig_cost": 6. ,
    "af_cost_currency": "USD",
    "is_first_launch": true,
    "af_click_lookback": "20d",
    "af_cpi": null,
    "iscache": true,
    "click_time": "2020-08-12 16:04:50. 05",
    "af_android_url": "https://isitchristmas. om/",
    "fruit_amount": 26,
    "is_branded_link": null,
    "match_type": "probabilistic",
    "adset": null,
    "af_channel": "my_channel",
    "campaign_id": null,
    "shortlink": "6d66214a",
    "af_dp": "afbasicapp://mainactivity",
    "install_time": "2020-08-12 16:05:33. 50",
    "af_ios_url": "https://isitchristmas. om/",
    "fruit_name": "apples",
    "media_source": "Email",
    "Агент": null,
    "af_siteid": null,
    "af_status": "Неорганический",
    "af_sub1": "my_sub1",
    "cost_cents_USD": 600,
    "af_sub5": null,
    "af_adset": "my_adset",
    "af_sub4": null,
    "af_sub3": null,
    "af_sub2": "my_sub2",
    "adset_id": null,
    "esp_name": null,
    "af_cost_value": 6,
    "campaign": "fruit_of_the_month",
    "http_referrer": "android-app://com. lack/",
    "af_ad": "my_adname",
    "is_universal_link": null,
    "is_retargeting": true,
    "adgroup": null
}
```
