---
title: Купить коннектор
slug: покупка-коннектор-андроид
category:
  uri: SDK AppsFlyer
parent:
  uri: проверка покупки-android
privacy:
  view: публичный
position: 2
---

## Общий обзор

Коннектор покупки AppsFlyer ROI360 используется для проверки и сообщения о событиях покупки внутри приложения и дохода от подписки. Компания ROI360 является частью решения для измерения доходов от покупки и оплаты подписки.

- Для приобретения коннектора требуется подписка на ROI360.
- Если вы используете это решение для измерения доходов от покупки в приложении, вы не должны отправлять [события покупки в приложении](https://dev.appsflyer.com/hc/docs/in-app-events-android) с доходом или выполнять [`validateAndLogInAppPurchase`](https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-android), так как это приводит к дублирующему доходу.
- Перед внедрением коннектора покупки, покупка в приложении ROI360 и измерение доходов от подписки должны быть интегрированы с Google Play и App Store. [См. инструкции (шаги 1 и 2)](https://support.appsflyer.com/hc/en-us/articles/7459048170769)

## Предпосылки

- Android AppsFlyer SDK **6.15.0** и выше

## ⚠️ Важное примечание ⚠️

Для некоторых версий приобретенного коннектора требуется специальная версия AppsFlyer SDK.
В следующей таблице описывается совместимость версий Purchase Connector с версиями SDK.

| Купить версию коннектора               | Поддерживаемые версии AppsFlyer SDK                                               | Поддерживаемые версии биллинговой библиотеки                                    |
| -------------------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| v2.0.0 | v6.12.2 - v6.14.3 | v5.x.x                                          |
| v2.0.1 | v6.12.2 - v6.14.3 | v5.x.x - v7.x.x |
| v2.1.0 | v6.15.0 (и выше)               | v5.x.x - v7.x.x |
| v2.1.1 | v6.15.0 (и выше)               | v5.x.x - v7.x.x |
| v2.1.2 | v6.15.0 (и выше)               | v5.x.x - v7.x.x |
| v2.2.0 | v6.15.0 (и выше)               | v8.x.x                                          |

## Добавление коннектора в ваш проект

1. Добавьте в свой файл build.gradle, где `play_billing_version` 5.x.x, 6.x.x, 7.x.x, 8.x.x.x:

```groovy
implementation 'com.appsflyer:purchase-connector:2.2.0'
implementation 'com.android.billingclient:billing:$play_billing_version'
```

2. Если вы используете ProGuard, добавьте следующие правила в файл `proguard-rules.pro`:

```groovy
-keep class com.appsflyer.** { *; }
-keep class kotlin.jvm.internal. ntrinsics{ *; }
-keep class kotlin.collections.**{ *; }
-keep class kotlin.Result$Companion { *; }
```

## Базовая интеграция

### Создать экземпляр PurchaseClient

Создайте экземпляр этого коннектора для наблюдения и проверки транзакций в вашем приложении.
**Обязательно сохраните ссылку на созданный объект. Если объект не сохранен, он может привести к неожиданному поведению и утечкам памяти.**

```java
// init
PurchaseClient.Builder = new PurchaseClient.Builder(context, Store.GOOGLE);
// Не забудьте сохранить этот экземпляр
PurchaseClient = builder.build();
```

```kotlin
// init
val builder = PurchaseClient.Builder(this, Store.GOOGLE)
// Убедитесь, что этот экземпляр
val afPurchaseClient = builder.build()
```

### Начать наблюдать транзакции

Запустите экземпляр SDK для наблюдения за транзакциями. </br>

> **⚠️ Примечание**
> После вызова метода Android SDK [`start`](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#starting-the-android-sdk).
> Вызов `startObservingTransactions` активирует слушателя, который автоматически следит за новыми платежными транзакциями. Это включает в себя новые и существующие подписки и новые покупки в приложении.
> Лучше всего активировать слушателя как можно раньше, предпочтительно в классе "Приложение".

```java
// запускаем
afPurchaseClient.startObservingTransactions();
```

```kotlin
// запускаем
afPurchaseClient.startObservingTransactions()
```

### Остановить наблюдение

Предотвратить наблюдение за транзакциями экземпляра SDK. </br>
**⚠️ Примечание**

> Это следует вызвать, если вы хотите остановить коннектор от прослушивания биллинговых транзакций. Это удаляет слушателя и останавливает наблюдение новых транзакций.
> Используйте этот API, когда, например, вы хотите, чтобы приложение прекратило отправку данных в AppsFlyer из-за изменений в согласии пользователя (отключилось от обмена данными). В противном случае нет оснований для вызова этого метода.
> Если вы решили использовать этот API, то перед вызовом Android SDK [`stop`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#stop) API.

```java
// запускаем
afPurchaseClient.stopObservingTransactions();
```

```kotlin
// запускаем
afPurchaseClient.stopObservingTransactions()
```

### Журнал подписок

Включает автоматический учет событий подписки. </br>
Set `true` to enable, `false` to disable.</br>
Если этот API не используется, то по умолчанию коннектор не записывает подписок.</br>

```java
builder.logSubscription(true);
```

```kotlin
builder.logSubscription(true)
```

### Войти в покупки

Включает автоматический вход в систему событий покупки</br>
Set `true` для включения, `false` для отключения.</br>
Если этот API не используется, то по умолчанию коннектор не записывает покупки в приложении.</br>

```java
конструктор.autoLogInApps(true);
```

```kotlin
конструктор.autoLogInApps(true)
```

## Зарегистрировать источник данных о покупке

Перед отправкой данных на серверы AppsFlyer вызывается обработчик данных о событии покупки, чтобы разработчик добавил дополнительные параметры к полезной нагрузке.

### Источник данных события покупки подписки

```java
builder.setSubscriptionPurchaseEventDataSource(new PurchaseClient. ubscriptionPurchaseEventDataSource() {
    @NonNull
    @Override
    public Map<String, Object> onNewPurchases(@NonNull List<? extends SubscriptionPurchaseEvent> purchaseEvents) {
        Map<String, Object> map = new HashMap<String, Object>(); Карта
        ut("некоторый ключ", "value");
        return map;
    }
});

// или используйте lambda 
builder. etSubscriptionPurchaseEventDataSource(purchaseEvents -> {
    Map<String, Object> map = new HashMap<String, Object>();
    map. ut("некоторый ключ", "value");
    return map;
});
```

```kotlin
builder.setSubscriptionPurchaseEventDataSource(объект : PurchaseClient. ubscriptionPurchaseEventDataSource{
    переопределить fun onNewPurchases(purchaseEvents: List<SubscriptionPurchaseEvent>): Map<String, Any> {
        return mapOf("some key" to "some value")
    }
})

// or use lambda
builder. etSubscriptionPurchaseEventDataSource {
    mapOf(
        "some key" to "some value",
        "другой ключ" к нему. размер
    )
}
```

### Источник данных о событии в приложениях

```java
builder.setInAppPurchaseEventDataSource(new PurchaseClient. nAppPurchaseEventDataSource() {
    @NonNull
    @Override
    public Map<String, Object> onNewPurchases(@NonNull List<? extends InAppPurchaseEvent> purchaseEvents) {
        Map<String, Object> map = new HashMap<String, Object>(); Карта
        ut("некоторый ключ", "value");
        return map;
    }
});

// или используйте lambda 
builder. etInAppPurchaseEventDataSource(purchaseEvents -> {
    Map<String, Object> map = new HashMap<String, Object>();
    map. ut("некоторый ключ", "value");
    return map;
});
```

```kotlin
builder.setInAppPurchaseEventDataSource(object :
    PurchaseClient.InAppPurchaseEventDataSource {
    override fun onNewPurchases(purchaseEvents: List<InAppPurchaseEvent>): Map<String, Any> {
        return mapOf(
            "some key" to "some value",
            "another key" to purchaseEvents.size
        )
    }
})

// or use lambda
builder.setInAppPurchaseEventDataSource { 
    mapOf(
        "some key" to "some value",
        "another key" to it.size
    )
}
```

## Регистрация слушателей результатов проверки

Вы можете зарегистрировать слушателей для получения результатов проверки после получения ответа от серверов AppsFler, чтобы узнать, была ли покупка подтверждена.

| Метод слушателя                                    | Описание                                                                                                                                                        |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `onResponse(результат: результат?)`                | Вызывается, когда у нас было 200 OK ответа от сервера (покупка INVALID считается успешным ответом и будет возвращена на этот обратный вызов) |
| `onFailure(результат: строка, ошибка: Throwable?)` | Вызывается, когда у нас есть какое-то исключение из сети или не 200/OK ответ от сервера.                                                        |

### Слушатель результатов проверки подписки

```java
builder.setSubscriptionValidationResultListener(new PurchaseClient.SubscriptionPurchaseValidationResultListener() {
    @Override
    public void onResponse(@Nullable Map<String, ? extends SubscriptionValidationResult> result) {
        if (result == null) {
            return;
        }
        result.forEach((k, v) -> {
            if (v.getSuccess()) {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " was validated successfully");
                SubscriptionPurchase subscriptionPurchase = v.getSubscriptionPurchase();
                Log.d(TAG, subscriptionPurchase.toString());
            } else {
                Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " wasn't validated successfully");
                ValidationFailureData failureData = v.getFailureData();
                Log.d(TAG, failureData.toString());
            }
        });
    }

    @Override
    public void onFailure(@NonNull String result, @Nullable Throwable error) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
        if (error != null) {
            error.printStackTrace();
        }
    }
});
```

```kotlin
конструктор.setSubscriptionValidationResultListener(объект :
    PurchaseClient. ubscriptionPurchaseValidationResultListener {
    переопределить удовольствие onResponse(result: Map<String, SubscriptionValidationResult>?) {
        результат?. orEach { (k: String, v: SubscriptionValidationResult?) ->
            if (v. uccess) {
                Log. (TAG, "[PurchaseConnector]: Успешно подтверждена подписка с ID $k ")
                val subscriptionPurchase = v. ubscriptionPurchase
                Log.d(TAG, подписка покупки). oString())
            } else {
                Log. (TAG, "[PurchaseConnector]: Подписка с ID $k не была успешно проверена")
                val failureData = v. ailureData
                Log.d(TAG, failureData. oString())
            }
        }
    }

    переопределяет весело onFailure(результат: строка, ошибка: достойно? {
        Лог. (TAG, "[PurchaseConnector]: Проверка не удалась: $result")
        ошибка?. rintStackTrace()
    }
})
```

### Слушатель результатов проверки покупки приложения

```java
builder.setInAppValidationResultListener(new PurchaseClient.InAppPurchaseValidationResultListener() {
    @Override
    public void onResponse(@Nullable Map<String, ? extends InAppPurchaseValidationResult> result) {
        if (result == null) {
            return;
        }
        result.forEach((k, v) -> {
            if (v.getSuccess()) {
                Log.d(TAG, "[PurchaseConnector]: Product with Purchase Token " + k + " was validated successfully");
                ProductPurchase productPurchase = v.getProductPurchase();
                Log.d(TAG, productPurchase.toString());
            } else {
                Log.d(TAG, "[PurchaseConnector]: Subscription with Purchase Token " + k + " wasn't validated successfully");
                ValidationFailureData failureData = v.getFailureData();
                Log.d(TAG, failureData.toString());
            }
        });
    }

    @Override
    public void onFailure(@NonNull String result, @Nullable Throwable error) {
        Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
        if (error != null) {
            error.printStackTrace();
        }
    }
});
```

```kotlin
конструктор.setInAppValidationResultListener(объект :
    PurchaseClient. nAppPurchaseValidationResultListener {
    переопределить удовольствие onResponse(result: Map<String, InAppPurchaseValidationResult>?) {
        результат?. orEach { (k: String, v: InAppPurchaseValidationResult?) ->
            if (v. uccess) {
                Log. (TAG, "[PurchaseConnector]: Товар с покупкой токена$k успешно проверен")
                val productPurchase = v. roductPurchase
                Log.d(TAG, productPurchase. oString())
            } else {
                Log. (TAG, "[PurchaseConnector]: Продукт с покупкой токена $k не был успешно проверен")
                val failureData = v. ailureData
                Log.d(TAG, failureData. oString())
            }
        }
    }

    переопределяет весело onFailure(результат: строка, ошибка: достойно? {
        Лог. (TAG, "[PurchaseConnector]: Проверка не удалась: $result")
        ошибка?. rintStackTrace()
    }
})
```

## Проверить интеграцию

Вы можете выбрать, какая среда будет использоваться для проверки, либо **производство** или **песочница** (производство по умолчанию). Окружение "песочница" должно использоваться во время тестирования [интеграции Биллинговой библиотеки Google Play](https://developer.android.com/google/play/billing/test).
Чтобы установить среду в песочницу, вызовите в качестве значения следующий метод конструктора с параметром «true». Перед загрузкой приложения в магазин либо вызовом этому методу, используя `false` в качестве значения, либо полностью удаляя этот вызов.

```java
// окружение песочницы
builder.setSandbox(true);
// среда производства
builder.setSandbox(false);

```

```kotlin
// окружение песочницы
builder.setSandbox(true)
// среда производства
builder.setSandbox(false)

```

## Пример полного кода

```java
@Override
public void onCreate() {
    super.onCreate();
    AppsFlyerLib.getInstance().init("YOUR_DEV_KEY", listener, getApplicationContext());
    AppsFlyerLib.getInstance().start(getApplicationContext());
    // init - Make sure to save a reference to the built object. If the object is not saved,
    // it could lead to unexpected behavior and memory leaks.
    PurchaseClient afPurchaseClient = new PurchaseClient.Builder(getApplicationContext(), Store.GOOGLE)
            // Enable Subscriptions auto logging
            .logSubscriptions(true)
            // Enable In Apps auto logging
            .autoLogInApps(true)
            // set production environment
            .setSandbox(false)
            // Subscription Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
            // to let customer add extra parameters to the payload
            .setSubscriptionPurchaseEventDataSource(purchaseEvents -> {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("somekey", "value");
                map.put("type", "Subscription");
                return map;
            })
            // In Apps Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
            // to let customer add extra parameters to the payload
            .setInAppPurchaseEventDataSource(purchaseEvents -> {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("somekey", "value");
                map.put("type", "InApps");
                return map;
            })
            // Subscriptions Purchase Validation listener. Invoked after getting response from AppsFlyer servers
            // to let customer know if purchase was validated successfully
            .setSubscriptionValidationResultListener(new PurchaseClient.SubscriptionPurchaseValidationResultListener() {
                @Override
                public void onResponse(@Nullable Map<String, ? extends SubscriptionValidationResult> result) {
                    if (result == null) {
                        return;
                    }
                    result.forEach((k, v) -> {
                        if (v.getSuccess()) {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " was validated successfully");
                            SubscriptionPurchase subscriptionPurchase = v.getSubscriptionPurchase();
                            Log.d(TAG, subscriptionPurchase.toString());
                        } else {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with ID " + k + " wasn't validated successfully");
                            ValidationFailureData failureData = v.getFailureData();
                            Log.d(TAG, failureData.toString());
                        }
                    });
                }

                @Override
                public void onFailure(@NonNull String result, @Nullable Throwable error) {
                    Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
                    if (error != null) {
                        error.printStackTrace();
                    }
                }
            })
            // In Apps Purchase Validation listener. Invoked after getting response from AppsFlyer servers
            // to let customer know if purchase was validated successfully
            .setInAppValidationResultListener(new PurchaseClient.InAppPurchaseValidationResultListener() {
                @Override
                public void onResponse(@Nullable Map<String, ? extends InAppPurchaseValidationResult> result) {
                    if (result == null) {
                        return;
                    }
                    result.forEach((k, v) -> {
                        if (v.getSuccess()) {
                            Log.d(TAG, "[PurchaseConnector]: Product with Purchase Token " + k + " was validated successfully");
                            ProductPurchase productPurchase = v.getProductPurchase();
                            Log.d(TAG, productPurchase.toString());
                        } else {
                            Log.d(TAG, "[PurchaseConnector]: Subscription with Purchase Token " + k + " wasn't validated successfully");
                            ValidationFailureData failureData = v.getFailureData();
                            Log.d(TAG, failureData.toString());
                        }
                    });
                }

                @Override
                public void onFailure(@NonNull String result, @Nullable Throwable error) {
                    Log.d(TAG, "[PurchaseConnector]: Validation fail: " + result);
                    if (error != null) {
                        error.printStackTrace();
                    }
                }
            })
            // Build the client
            .build();

    // Start the SDK instance to observe transactions.
    afPurchaseClient.startObservingTransactions();
}
 
```

```kotlin
override fun onCreate() {
    super.onCreate()
    // init and start the native AppsFlyer Core SDK
    AppsFlyerLib.getInstance().apply {
        init("YOUR_DEV_KEY", listener, applicationContext)
        start(applicationContext)
    }
    // init - Make sure to save a reference to the built object. If the object is not saved, 
    // it could lead to unexpected behavior and memory leaks.
    val afPurchaseClient = PurchaseClient.Builder(applicationContext, Store.GOOGLE)
        // Enable Subscriptions auto logging
        .logSubscriptions(true)
        // Enable In Apps auto logging
        .autoLogInApps(true)
        // set production environment
        .setSandbox(false)
        // Subscription Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
        // to let customer add extra parameters to the payload
        .setSubscriptionPurchaseEventDataSource {
            mapOf(
                "some key" to "some value",
                "another key" to it.size
            )
        }
        // In Apps Purchase Event Data source listener. Invoked before sending data to AppsFlyer servers
        // to let customer add extra parameters to the payload
        .setInAppPurchaseEventDataSource {
            mapOf(
                "some key" to "some value",
                "another key" to it.size
            )
        }
        // Subscriptions Purchase Validation listener. Invoked after getting response from AppsFlyer servers
        // to let customer know if purchase was validated successfully
        .setSubscriptionValidationResultListener(object :
            PurchaseClient.SubscriptionPurchaseValidationResultListener {
            override fun onResponse(result: Map<String, SubscriptionValidationResult>?) {
                result?.forEach { (k: String, v: SubscriptionValidationResult?) ->
                    if (v.success) {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]: Subscription with ID $k was validated successfully"
                        )
                        val subscriptionPurchase = v.subscriptionPurchase
                        Log.d(TAG, subscriptionPurchase.toString())
                    } else {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]: Subscription with ID $k wasn't validated successfully"
                        )
                        val failureData = v.failureData
                        Log.d(TAG, failureData.toString())
                    }
                }
            }

            override fun onFailure(result: String, error: Throwable?) {
                Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
                error?.printStackTrace()
            }
        })
        // In Apps Purchase Validation listener. Invoked after getting response from AppsFlyer servers
        // to let customer know if purchase was validated successfully
        .setInAppValidationResultListener(object :
            PurchaseClient.InAppPurchaseValidationResultListener {
            override fun onResponse(result: Map<String, InAppPurchaseValidationResult>?) {
                result?.forEach { (k: String, v: InAppPurchaseValidationResult?) ->
                    if (v.success) {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]:  Product with Purchase Token$k was validated successfully"
                        )
                        val productPurchase = v.productPurchase
                        Log.d(TAG, productPurchase.toString())
                    } else {
                        Log.d(
                            TAG,
                            "[PurchaseConnector]:  Product with Purchase Token $k wasn't validated successfully"
                        )
                        val failureData = v.failureData
                        Log.d(TAG, failureData.toString())
                    }
                }
            }

            override fun onFailure(result: String, error: Throwable?) {
                Log.d(TAG, "[PurchaseConnector]: Validation fail: $result")
                error?.printStackTrace()
            }
        })
        // Build the client
        .build()

    // Start the SDK instance to observe transactions.
    afPurchaseClient.startObservingTransactions()
}
```
