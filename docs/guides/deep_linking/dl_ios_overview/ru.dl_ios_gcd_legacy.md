---
title: iOS устаревшие API
slug: dl_ios_gcd_legacy
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

## Прямая глубокая связь

### Общий обзор

Прямое глубокое связывание мобильных пользователей направляет их в определенную активность или контент в приложение, когда приложение уже установлено.

Это маршрутизация конкретной активности в приложении возможна из-за параметров, переданных приложению, когда ОС открывает приложение и называется метод `onAppOpenAttribution`. AppsFlyer's OneLink гарантирует, что правильное значение передается вместе с нажатием кнопки пользователя, таким образом, персонализируя работу приложения пользователя.

\*\*Для глубокой привязки требуется только `deep_link_value`. Однако другие параметры и значения (такие как пользовательские параметры атрибуции) также могут быть добавлены к ссылке и возвращены SDK в качестве глубоких ссылок. \*\*

\*\*Прямой глубокий поток связей работает следующим образом:  
![Прямая Глубокая Связь](https://files.readme.io/2407f56-Ios_DL.png "Прямая Глубокая Связь")

1. Пользователь кликает на OneLink короткий URL.

2. iOS читает названия связанных доменов в приложении.

3. iOS открывает приложение.

4. AppsFlyer SDK запускается внутри приложения.

5. AppsFlyer SDK извлекает данные OneLink.
   - Короткий URL, данные извлекаются из короткого URL resolver API на серверах AppsFlyer.
   - В длинный URL-адрес данные извлекаются непосредственно из длинного URL-адреса.

6. AppsFlyer SDK триггеры `onAppOpenAttribution()` с полученными параметрами и параметрами атрибута (например: `install_time`).

7. Асинхронно, вызывается `onConversionDataSuccess()` с полными данными атрибута. (Вы можете выйти из этой функции, проверьте, является ли `is_first_launch` `true`.)

8. `onAppOpenAttribution()` использует карту `attributionData` для отправки других активностей в приложении и передачи соответствующих данных.
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

Метод `onAppOpenAttribution` получает переменные в качестве входных записей: `AnyHashable: Any`.  
Структура входных данных описана [here](https://dev.appsflyer.com/hc/docs/gcd-input-parameters).

#### Реализация логики onAppOpenAttribution()

Глубокая ссылка открывает метод `onAppOpenAttribution` в основной активности. Параметры OneLink в вводе метода используются для реализации специфического опыта пользователя при открытии приложения.

#### Пример кода:

```swift
func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
    //Обработка данных Deep Link
    print("onAppOpenAttribution data:")
    for (key, значение) в attributionData {
        print(key, ":", alue)
    }
    walkToSceneWithParams(params: attributionData)
}

// User logic
fileprivate func walkToSceneWithParams(params: [AnyHashable:Any]) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bund: nil)
    UIApplication. ед. indows.first?.rootViewController?. ismiss(animated: true, completion: nil)

    var fruitNameStr = ""

    если пусть thisFruitName = params["deep_link_value"] как? String {
        fruitNameStr = thisFruitName
    } else if let linkParam = params["link"] как? String {
        guard let url = URLComponents(string: linkParam) else {
            print("Не могу извлечь параметры запроса из ссылки")
            return
        }
        if let thisFruitName = url. ueryItems?.first(где: { $0.name == "deep_link_value" })?. alue {
            fruitNameStr = thisFruitName
        }
    }

    пусть destVC = fruitNameStr + "_vc"
    if let newVC = storyBoard. nstantiateVC(withIdentifier: destVC) {

        print("AppsFlyer routing to section: \(destVC)")
        newVC. ttributionData = параметры

        UIApplication.shared.windows.first?.rootViewController?. повторно (newVC, анимирован: true, completion: nil)
    } else {
        print("AppsFlyer: не может найти раздел: \(destVC)")
    }
}
```

<unk> Github ссылки: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L151-L159)

#### Реализация логики onAttributionFailure()

Метод `onAttributionFailure` вызывается всякий раз, когда вызывается вызов в `onAppOpenAttribution`. Функция должна сообщить об ошибке и создать ожидаемый опыт для пользователя.

```swift
func onAppOpenAttributionFailure(_ ошибка: Ошибка) {
    print("\(error)")
}
```

<unk> Github ссылки: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L161-L163)

## Отложенная глубокая связь

> ❗ Важное
>
> Отложенные глубокие ссылки с использованием традиционного метода onConversionDataSuccess могут не работать для iOS 14. +, так как для этого требуются данные атрибутов, которые могут быть недоступны в связи с защитой конфиденциальности.  
> Рекомендуем использовать [Единое глубокое соединение (UDL)](https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking). UDL соответствует стандартам конфиденциальности iOS 14.5+ и возвращает только параметры, относящиеся к глубокой ссылке и отложенной глубокой ссылке: `deep_link_value` и `deep_link_sub1-10`. Параметры атрибутов (такие как `media_source`, `campaign`, `af_sub1-5`, etc.), return `null` и не могут быть использованы для глубоких целей соединения.  
> [Подробнее](https://content.appsflyer.com/ios-14-hub/deep-linking-deferred-deep-linking/)

### Общий обзор

Откладывается глубокое связывание новых пользователей сначала в нужный магазин приложений для установки, а затем, после открытия для определенного приложения (например, для конкретной страницы в приложении).

Когда пользователь запустит приложение, функция обратного вызова `onConversionDataSuccess` получает как данные преобразования нового пользователя, так и данные OneLink. Данные OneLink делают возможным маршрутизацию внутри приложения из-за `deep_link_value` или других параметров, которые передаются приложению при открытии операционной системы.

Только `deep_link_value` требуется для глубокой привязки. Однако другие параметры и значения (такие как пользовательские параметры атрибуции) также могут быть добавлены к ссылке и возвращены SDK в качестве глубоких ссылок. AppsFlyer OneLink гарантирует, что правильные параметры передаются вместе с кликом пользователя, таким образом персонализируя работу приложения пользователя.

Маркетер и разработчик должны координировать желаемое поведение приложения и `deep_link_value`. Маркетер использует параметры для создания глубоких ссылок, и разработчик настраивает поведение приложения на основе полученной стоимости.

Ответственность за правильность обработки параметров в приложении лежит на разработчике, для маршрутизации внутри приложения и персонализации данных по ссылке.

\*\*Отложенный глубоководный поток работает следующим образом:  
![Откладывание глубоких связей потока!](https://files.readme.io/4db3218-Ios_DDL.png "Отложенный глубокий поток")

1. Пользователь кликает на OneLink на устройстве, на котором приложение не установлено.
2. AppsFlyer регистрирует клик и перенаправляет пользователя на правильную страницу магазина приложений или целевой страницы.
3. Пользователь устанавливает приложение и запускает его.
4. AppsFlyer SDK инициализирован и установка присваивается серверам AppsFler.
5. SDK запускает метод `onConversionDataSuccess`. Функция получает входные данные, которые включают в себя и `deep_link_value`, и атрибуционные данные/параметры, определенные в данных OneLink.
6. Параметр `is_first_launch` имеет значение `true`, что сигнализирует отложенный глубокий поток ссылок.  
   Разработчик использует данные, полученные в функции «onConversionDataSuccess», для создания персонализированного опыта пользователя для первого запуска приложения.

### Процедуры

Чтобы реализовать метод `onConversionDataSuccess` и настроить поведение параметров, необходимо выполнить следующий контрольный список действий.

1. [Решение о поведении приложения при первом запуске и `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#deciding-app-behavior-on-first-launch) (и другие названия и значения параметров) - с маркером
2. [Метод планирования, т.е. `deep_link_value`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#planning-method-input-1) (и другие названия и значения параметров) - с маркером
3. [Реализация логики `onConversionDataSuccess()`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onconversiondatasuccess-logic)
4. [Реализация логики `onConversionDataFail()`](https://dev.appsflyer.com/hc/docs/ios-legacy-apis#implementing-onconversiondatafailure-logic)

#### Решение поведения приложения при первом запуске

**Чтобы решить поведение приложения при первом запуске**:

Получить с маркера: Ожидаемое поведение ссылки, когда она будет нажата, и приложение откроется в первый раз.

#### Ввод метода планирования

Для отсрочки глубокого привязки, необходимо спланировать ввод метода `onConversionDataSuccess`, и ввод решений в предыдущем разделе (для глубокой ссылки) будет иметь значение при первом запуске приложения.

Метод `onConversionDataSuccess` получает `deep_link_value` и другие переменные в качестве входных данных: `AnyHashable: Any`.

Карта содержит два вида данных:

- [Данные атрибутов](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
- Data defined by the marketer in the link (`deep_link_value` and other parameters and values)  
  Other parameters can be either:
  - Официальные параметры AppsFlyer
  - Пользовательские параметры и значения, выбранные маркером и разработчиком.
  - Структура входных данных описана [here](https://dev.appsflyer.com/hc/docs/ios-sample-payloads).

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

```swift
// Обработка Органической/Неорганической установки
func onConversionDataSuccess(_ данных: [AnyHashable: Any]) {

    print("onConversionDataSuccess data:")
    for (key, значение) в data {
        print(key, ":", значение)
    }

    если пусть статус = data["af_status"] как? String {
        if (status == "Non-organic") {
            if let sourceID = data["media_source"],
                let campaign = data["campaign"] {
                print("Это неорганическая установка. Источник медии: \(sourceID)  Кампания: \(campaign)")
            }
        } else {
            print("Это органическая установка. )
        }
        if let is_first_launch = data["is_first_launch"] как? Bool,
            is_first_launch {
            print("Первый запуск")
            if let fruit_name = data["deep_link_value"]
            {
                // Ключ 'deep_link_value' существует только в OneLink origins
                print("deferred deep-linking to \(fruit_name)")
                walkToSceneWithParams(params: data)
            }
            else {
                print("Install from a non-owned media")
            }
        } else {
            print("Not First Launch")
        }
    }
 } 
 } 
 }
```

<unk> Github ссылки: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L113-L145)

#### Реализация логики onConversionDataFailure()

Способ `onConversionDataFailure` вызывается всякий раз, когда сбой вызова `onConversionDataSuccess`. Функция должна сообщить об ошибке и создать ожидаемый опыт для пользователя.

**Для реализации метода `onConversionDataFailure`**:

```swift
func onConversionDataFail(_ ошибка: Ошибка) {
    print("\(error)")
}
```

<unk> Github ссылки: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/07f6d6d4b6897756942787774a8adb69c26838a5/swift/basic_app/basic_app/AppDelegate.swift#L147-L149)

## Пример полезных нагрузок iOS

Смотрите следующие примеры полезных нагрузок для Universal Links, URI схем и отсроченных проверок. Образцы содержат полную полезную нагрузку, связанную с тем, когда все параметры на странице настройки пользовательских ссылок Onelink содержат данные.

**Примечание**: Payloads возвращаются как карта. Однако для ясности следуют примерные нагрузки отображаются в форме JSON.

### Универсальные ссылки

Ввести в `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`

```short_link
{
   "af_ad": "my_adname",
   "af_adset": "my_adset",
   "af_android_url": "https://isitchristmas. om/",
   "af_channel": "my_channel",
   "af_click_lookback": "20d",
   "af_cost_currency": "USD",
   "af_cost_value": 6,
   "af_dp": "afbasicapp://mainactivity",
   "af_ios_url": "https://isitchristmas. om/",
   "af_sub1": "my_sub1",
   "af_sub2": "my_sub2",
   "c": "fruit_of_the_month",
   "кампания": "fruit_of_the_month",
   "fruit_amount": 26,
   "fruit_name": "apples",
   "is_retargeting": true,
   "link": "https://onelink-basic-app. nelink.me/H5hv/6d66214a",
   "media_source": "Email",
   "pid": "Email"
}
```

```long_link
{
   "path": "/H5hv",
   "af_android_url": "https://my_android_lp.com",
   "af_channel": "my_channel",
   "host": "onelink-basic-app.onelink.me",
   "af_adset": "my_adset",
   "pid": "Email",
   "scheme": "https",
   "af_dp": "afbasicapp://mainactivity",
   "af_sub1": "my_sub1",
   "fruit_name": "apples",
   "af_ad": "my_adname",
   "af_click_lookback": "20d",
   "fruit_amount": 16,
   "af_sub2": "my_sub2",
   "link": "https://onelink-basic-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month&af_channel=my_channel&af_adset=my_adset&af_ad=my_adname&af_sub1=my_sub1&af_sub2=my_sub2&fruit_name=apples&fruit_amount=16&af_cost_currency=USD&af_cost_value=6&af_click_lookback=20d&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_ios_url=https%3A%2F%2Fmy_ios_lp.com&af_android_url=https%3A%2F%2Fmy_android_lp.com",
   "af_cost_currency": "USD",
   "c": "fruit_of_the_month",
   "af_ios_url": "https://my_ios_lp.com",
   "af_cost_value": 6
}
```

### URI scheme

Ввести в `onAppOpenAttribution(_ attributionData: [AnyHashable: Any])`

```short_link
{
  "af_click_lookback ": "25d",
  "af_sub1 ": "my_sub1",
  "shortlink ": "9270d092",
  "af_deeplink ": true,
  "media_source ": "Email",
  "Кампания": "my_campaign",
  "af_cost_currency ": "NZD",
  "host ": "mainactivity",
  "af_ios_url ": "https://my_ios_lp. om",
  "схема ": "afbasicapp",
  "Путь ": "",
  "af_cost_value ": 5,
  "af_adset ": "my_adset",
  "af_ad ": "my_adname",
  "af_android_url ": "https://my_android_lp. om",
  "af_sub2 ": "my_sub2",
  "af_force_deeplink ": true,
  "fruit_amount ": 15,
  "af_dp ": "afbasicapp://mainactivity",
  "link ": "afbasicapp://mainactivity? f_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp. om&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp. om&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email&shortlink=9270d092",
  "af_channel ": "my_channel",
  "is_retargeting ": true,
  "af_web_id ": "56441f02-377b-47c6-9648-7a7f88268130-o",
  "fruit_name ": "Apple"
}
```

```long_link
{
  "af_ad ": "my_adname",
  "fruit_name ": "apples",
  "host ": "mainactivity",
  "af_channel ": "my_channel",
  "link ": "afbasicapp://mainactivity? f_ad=my_adname&af_adset=my_adset&af_android_url=https%3A%2F%2Fmy_android_lp. om&af_channel=my_channel&af_click_lookback=25d&af_cost_currency=NZD&af_cost_value=5&af_deeplink=true&af_dp=afbasicapp%3A%2F%2Fmainactivity&af_force_deeplink=true&af_ios_url=https%3A%2F%2Fmy_ios_lp. om&af_sub1=my_sub1&af_sub2=my_sub2&af_web_id=56441f02-377b-47c6-9648-7a7f88268130-o&campaign=my_campaign&fruit_amount=15&fruit_name=apples&is_retargeting=true&media_source=Email",
  "af_deeplink ": true,
  "кампания": "my_campaign",
  "af_sub1 ": "my_sub1",
  "af_click_lookback ": "25d",
  "af_web_id ": "56441f02-377b-47c6-9648-7a7f88268130-o",
  "Путь ": "",
  "af_sub2 ": "my_sub2",
  "af_ios_url ": "https://my_ios_lp. om",
  "af_cost_value ": 5,
  "fruit_amount ": 15,
  "is_retargeting ": true,
  "схема ": "afbasicapp",
  "af_force_deeplink ": true,
  "af_adset ": "my_adset",
  "media_source ": "Email",
  "af_cost_currency ": "NZD",
  "af_dp ": "afbasicapp://mainactivity",
  "af_android_url ": "https://my_android_lp. om"
}
```

### Отложенная глубокая связь

Ввод в `onConversionDataSuccess(_ данных: [AnyHashable: Any])`

```short_link
{
  "adgroup": null,
  "adgroup_id": null,
  "adset": null,
  "adset_id": null,
  "af_ad": "my_adname",
  "af_adset": "my_adset",
  "af_android_url": "https://isitchristmas. om/",
  "af_channel": "my_channel",
  "af_click_lookback": "20d",
  "af_cost_currency": "USD",
  "af_cost_value": 6,
  "af_cpi": null,
  "af_dp": "afbasicapp://mainactivity",
  "af_ios_url": "https://isitchristmas. om/",
  "af_siteid": null,
  "af_status": "Non-organic",
  "af_sub1": "my_sub1",
  "af_sub2": "my_sub2",
  "af_sub3": null,
  "af_sub4": null,
  "af_sub5": null,
  "агентство": null,
  "кампания": "fruit_of_the_month ",
  "campaign_id": null,
  "click_time": "2020-08-12 15:08:00. 70",
  "cost_cents_USD": 600,
  "engmnt_source": null,
  "esp_name": null,
  "fruit_amount": 26,
  "fruit_name": "apples",
  "http_referrer": null,
  "install_time": "2020-08-12 15:08:33. 35",
  "is_branded_link": null,
  "is_first_launch": 1,
  "is_retargeting": true,
  "is_universal_link": null,
  "iscache": 1,
  "match_type": "probabilistic",
  "media_source": "Email",
  "orig_cost": "6. ",
  "redirect_response_data": null,
  "retargeting_conversion_type": "none",
  "shortlink": "6d66214a"
}
```
