---
title: Проверить и зарегистрировать покупку
slug: валидация-и log-purchase-android
category:
  uri: SDK AppsFlyer
parent:
  uri: проверка покупки-android
content:
  excerpt: Узнайте, как проверять и регистрировать покупки.
privacy:
  view: публичный
position: 1
---

Метод `validateAndLogInAppPurchase` является частью [процедуры проверки квитанции](https://support.appsflyer.com/hc/en-us/articles/42136725767569--WIP-About-Receipt-validation#how-does-receipt-validation-work), что позволяет приложению проверять события покупки, сгенерированные Google Play.

> 📘Заметка
>
> Функция `validateAndLogInAppPurchase` может быть заменена полностью автоматической покупкой разъема SDK (премиум-сервис). Чтобы узнать, как интегрировать коннектор, см. на Github&nbsp;[Android purchase SDK connector](https://github.com/AppsFlyerSDK/appsflyer-android-purchase-connector).

В настоящее время этот метод реализован в двух версиях.

- [validateAndLogInAppPurchase](#implement-validateandloginapppurchase-beta) поддерживается из SDK v.6.17.5
- [validateAndLogInAppPurchase (LEGACY)](#validateandloginapppurchase-legacy)

### Реализация validateAndLogInAppPurchase

[validateAndLogInAppPurchase](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#validateandloginapppurchase) отправляет детали покупки AppsFlyer для проверки. После того, как AppsFlyer проверяет покупку с помощью Google Play метод возвращает ответ на функцию обратного вызова.

**Для реализации метода выполните следующие действия:**

1. Query the Play Store for the [Purchase](https://developer.android.com/reference/com/android/billingclient/api/Purchase) object of the in-app purchase event.
2. Инициализируйте экземпляр [AFPurchaseDetails](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#afpurchasedetails) и установите его с типом покупки, токеном и идентификатором продукта, полученными от объекта покупки.
3. Если вы хотите добавить дополнительные детали для покупки в приложении, заполните хэш-карту парой ключевого значения.
4. Вызовите `validateAndLogInAppPurchase` следующим образом:
   - Объект `AFPurchaseDetails`, созданный в шаге 2.
   - Хэш-карта с дополнительными деталями, созданными в шаге 3.
   - An instance of the [AppsFlyerInAppPurchaseValidationCallback](https://dev.appsflyer.com/hc/docs/appsflyerinapppurchasevalidationcallback) to handle validation success and failure.
5. Добавьте логику для обработки сбоя, успеха или ответов на ошибки возвращается функции обратного вызова. Смотрите здесь несколько примеров ответов.

Если проверка прошла успешно, событие&nbsp;`af_purchase`&nbsp;регистрируется с значениями, представленными&nbsp;`validateAndLogInAppPurchase`.

> 📘Заметка
>
> `validateAndLogInAppPurchase`&nbsp;генерирует&nbsp;`af_purchase`&nbsp;в приложении после успешной проверки. Отправка этого события сама по себе приведет к дублированию отчёта о событиях.

## Пример кода

```java
AFPurchaseDetails = новые данные AFPurchaseDetails(
    AFPurchaseType. UBSCRIPTION, //Тип покупки
    "PurchaseToken", // Токен покупки
    "myProductId") // Product ID

Map<String, String> purchaseAdditionalDetails = new HashMap<>();

// Добавление пары ключевого значения на карте
purchaseAdditionalDetails. ut("firstDetail", "someth");
purchaseAdditionalDetail.put("secondDetail", "nice");
AppsFlyerLib. etInstance(). alidateAndLogInAppPurchase(
    purchaseDetails,
    purchaseAdditionalDetails, //необязательный
    new AppsFlyerInAppPurchaseValidationCallback() {
        @Override
        public void onInAppPurchaseValidationFinished(@NonNull Map<String, ?> validationFinishedResult) {
            Log. (LOG_TAG, "Получен ответ на проверку покупки");
            Boolean validationResult = (Boolean) validationFinishedResult. et("результат");

            if (validationResult == true) {
                Log. (LOG_TAG, "Покупка успешно проверена");
                // Добавляем здесь код после успешной проверки покупки
            } else {
                @NonNull Map<String, ?> error_data = (Map<String, ?>) validationFinishedResult. et("error_data");
                Журнал. (LOG_TAG, "Покупка не была проверена из-за " + error_data. et("сообщение"));
                // Добавьте здесь код, когда проверка не была успешной
            }
        }

        @Override
        public void onInAppPurchaseValidationError(@NonNull Map<String, ?> validationErrorResult) {
            Log. (LOG_TAG, "Покупка возвращенная ошибка: " + валидация Ошибки. et("error_message"));
        }
    }
);
```

### Примеры ответа

Функция обратного вызова [AppsFlyerInAppPurchaseValidationCallback](https://dev.appsflyer.com/hc/docs/appsflyerinapppurchasevalidationcallback) получает ответы на проверку от AppsFlyer в формате JSON. Вот два примера:

**Одноразовая покупка успешно проверена**

```json
{
  "result": true,
	"purchase_type": "one_time_purchase",
  "product_purchase": {
    "purchasetimemillis": "1699667717458",
    "purchasestate": "0",
    "Состояние потребления": "1",
    "количество": "0",
    "regioncode": "US",
    "acknowledgementstate": "1",
    "productid": "",
    "orderid": "GPA. 345-6347-1243-65405",
    "purchasetoken": "",
    "kind": "androidpublisher#productPurchase",
    "developerpayload": "", 0,
    "obfuscatedexternalprofileid": "",
    "purchasetype": "null",
    "obfuscatedexternalaccountid": ""
  }
}
```

**Подписка успешно проверена**

```json
{
  "результат: true,
	"purchase_type": "Подписание",
  "subscription_purchase": {
    "externalaccountidentifiers": {
      "obfuscatedexternalaccountid": "LD32LMR23K4E2"
    },
    "lineitems": [
      {
        "offerdetails": {
          "baseplanid": "p1w",
          "offerid": "freetrial"
        },
        "autorenewingplan": {
          "autorenewenabled": true
        },
        "productid": "s2_sub_00_00_00",
        "expirytime": "2023-10-21T09:15:16. 27Z"
      }
    ],
    "Код региона": "AU",
    "acknowledgementstate": "ACKNOWLEDGEMENT_STATE_PENDING",
    "subscriptionstate": "SUBSCRIPTION_STATE_ACTIVE",
    "kind": "androidpublisher#subscriptionPurchaseV2",
    "latestorderid": "GPA. 335-6293-5584-30859",
    "starttime": "2023-10-18T09:15:45.814Z"
  }
}
```

## validateAndLogInAppPurchase (Legacy)

<span class="annotation-deprecated">Устарел с версии V6.17.5</span>

[`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase-legacy) доступен через [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib).

`validateAndLognInAppPurchase` принимает эти аргументы:

```java
validateAndLogInAppPurchase(Контекстный контекст,
                            java.lang.String publicKey,
                            java.lang.String signature,
                            java.lang.String purchaseData,
                            java.lang.String price, java.lang.String currency,
                            java.util.Map<java.lang.String,java.lang.String> additionalParameters)
```

- `context`: контекст приложения / действия
- `publicKey`: Лицензионный ключ, полученный из консоли Google Play
- `signature`: `data.INAPP_DATA_SIGNATURE` из `onActivityResult`
- `purchaseData`: `data.INAPP_PURCHASE_DATA` из `onActivityResult`
- `price`: Цена покупки должна быть взята из `skuDetails.getStringArrayList("DETAILS_LIST")`
- `currency`: Покупная валюта, должна быть взята из `skuDetails.getStringArrayList("DETAILS_LIST")`
- `additionalParameters` - Дополнительные параметры событий для журнала

Если проверка прошла успешно, событие [`af_purchase`](https://dev.appsflyer.com/hc/docs/in-app-events-android#af_purchase) регистрируется с указанными значениями [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase-legacy).

> 📘 Заметка
>
> [`validateAndLogInAppPurchase`](doc:android-sdk-reference-appsflyerlib#validateandloginapppurchase-legacy) генерирует [`af_purchase`](https://dev.appsflyer.com/hc/docs/in-app-events-android#af_purchase) в приложении после успешной проверки. Отправка этого события сама по себе приведет к дублированию отчёта о событиях.

### Пример: Проверка покупки внутри приложения

```java
// Объект покупки возвращается Google API в onPurchasesUpdated() callback
private void handlePurchase(Purchase purchase) {
    Log. (LOG_TAG, "Покупка успешно!");
    Map<String, String> eventValues = new HashMap<>();
    eventValues. ut("some_parameter", "some_value");
    AppsFlyerLib.getInstance(). alidateAndLogInAppPurchase(getApplicationContext(),
                                                           PUBLIC_KEY,
                                                           покупка. etSignature(),
                                                           Покупка. etOriginalJson(),
                                                           "10",
                                                           "USD",
                                                           eventValues);
}
```

```kotlin
// Объект покупки возвращается Google API в onPurchasesUpdated() callback
private fun handlePurchase(Purchase purchase) {
   Log. (LOG_TAG, "Покупка успешно!")
   val eventValues = HashMap<String, String>()
   eventValues. ut("some_parameter", "some_value")
   AppsFlyerLib.getInstance(). alidateAndLogInAppPurchase(это,
                                                          PUBLIC_KEY,
                                                          покупка. etSignature(),
                                                          Покупка. etOriginalJson(),
                                                          "10",
                                                          "USD",
                                                          eventValues)
}
```

### Покупка прошла успешно/сбой

Используйте [`AppsFlyerInAppPurchaseValidatorListener`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener) чтобы подписаться на проверку успехов/сбоев и [`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener-legacy) для регистрации в классе приложения.

[`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener-legacy) подвергается воздействию через [`AppsFlyerLib`](doc:android-sdk-reference-appsflyerlib). Использовать [\`\`AppsFlyerInAppPurchaseValidatorListener\`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener), импортировать его:

```java Java
импортировать com.appsflyer.AppsFlyerInAppPurchaseValidatorListener;
```

```kotlin Kotlin
импортировать com.appsflyer.AppsFlyerInAppPurchaseValidatorListener
```

[\`\`AppsFlyerInAppPurchaseValidatorListener\`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener) имеет два обратных вызова:

- [`onValidateInApp`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener#onvalidateinapp): Срабатывает при успешной проверке покупки
- [`onValidateInAppFailure`](doc:android-sdk-reference-appsflyerinapppurchasevalidatorlistener#onvalidateinappfailure): Срабатывает при неудачных проверках покупки

[`registerValidatorListener`](doc:android-sdk-reference-appsflyerlib#registervalidatorlistener-legacy) принимает 2 аргумента:

- `context`: Контекст приложения
- `validationListener`: объект `AppsFlyerInAppPurchaseValidatorListener`, который вы хотите зарегистрировать

```java
AppsFlyerLib.getInstance(). egisterValidatorListener(это ew
   AppsFlyerInAppPurchaseValidatorListener() {
     public void onValidateInApp() {
       Log. (TAG, "Покупка успешно проверена");
     }
     public void onValidateInAppFailure(String error) {
       Log. (TAG, "onValidateInAppFailure называется: " + ошибка);
     }
});
```

```kotlin
AppsFlyerLib.getInstance().registerValidatorListener(this, object : AppsFlyerInAppPurchaseValidatorListener {
    переопределить веселье onValidateInApp() {
       	Log. (LOG_TAG, "Покупка успешно проверена")
    }

    переопределить fun onValidateInAppFailure(error: String) {
        Log. (LOG_TAG, "onValidateInAppFailure называется: $error")
   }
})
```

Проверка покупки в приложении автоматически отправляет на AppsFlyer событие покупки в приложении. Смотрите следующие данные образца, которые передаются в параметре event_value:

```json JSON
{
   "some_parameter": "some_value", // от additional_event_values
   "af_currency": "USD", // от валюты
   "af_content_id" :"test_id", // от покупки
   "af_revenue": "10", // от дохода
   "af_quantity": "1", // от покупки
   "af_validated": true // флаг AF проверил покупку
}
```

