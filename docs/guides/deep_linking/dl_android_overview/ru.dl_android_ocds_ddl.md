---
title: Расширенная глубокая связь Android
slug: dl_android_ddl
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Общий обзор

Расширенная глубокая связь с отсрочкой позволяет глубину связи для новых пользователей в определенных сценариях:

- Когда UDL возвращает `NOT_FOUND`, даже несмотря на соответствующую установку.
  Главный пример такого сценария:
  - Время между щелчками и установкой превышает окно поиска UDL (15 минут).
- Когда UDL возвращает `FOUND`, но глубокие связующие данные отсутствуют параметры, которые не являются `deep_link_value` и `deep_link_sub1-10`.  
  Основным примером такого сценария является нажатие на ссылку, которая не содержит `deep_link_value` или `deep_link_sub1-10` для углубленной ссылки, Например, старые ссылки, созданные до `deep_link_value` существуют, которые все еще используются.

Чтобы отложить глубокое соединение, UDL возвращает `NOT_FOUND`, обратная связь `onConversionDataSuccess` должна проверять, должен ли он обрабатывать отложенную глубину соединения.  
`onConversionDataSuccess` является частью API Get Conversion Data(GCD). Его основная цель - [собрать данные о преобразовании внутри устройства](https://dev.appsflyer.com/hc/docs/conversion-data).  
В описанном здесь варианте использования `onConversionDataSuccess` использует тот факт, что все отложенные глубокие параметры связи передаются на обратный вызов, поверх данных о конверсии.

## Предпосылки

- Внедрение [Unified Deep Linking](dl_android_unified_deep_linking) для обработки отсроченных глубоких ссылок и прямой глубокой привязки.
- Реализация `onConversionDataSuccess` для обработки [отложенных углубленных ссылок с помощью GCD API](dl_android_gcd_legacy).

## Осуществление

1. `onConversionDataSuccess` обнаруживает случаи, когда отложенные глубокие связи должны происходить, что UDL не обрабатывает.
   > Подробнее [рассечение кода](#code-dissect)
2. `onConversionDataSuccess` должен маршрутизировать пользователя до отложенного места назначения на основе глубинных параметров соединения, передаваемых обратной связи.

## Пример кода

### Code dissect

1. Реализовать _Получить API данных Преобразования `AppsFlyerConversionListener`.
   > Все методы слушателя должны быть реализованы, хотя `onAppOpenAttribution` и `onAttributionFailure` являются взаимоисключающими с UDL и не будут вызваны.
2. Обнаружение отложенных сценариев глубоких связей путем фильтрации данных преобразования с помощью:
   - `af_status == Неорганический`
   - `is_first_launch == true`
3. При обнаружении отсрочки глубокого соединения, отфильтровать случаи, которые уже обрабатывались UDL.  
   В следующем примере все ссылки содержат `deep_link_value`.  
   UDL рекомендуется сигналировать флагом, что отсроченные глубокие связи уже обработаны, а `onConversionDataSuccess` должен пропустить.
4. `onConversionDataSuccess` проверяет, что данные о преобразовании содержат параметры, используемые для маршрутизации пользователей внутри приложения. Например, `fruit_name` в следующем примере.
5. Перенесите пользователя к отложенным глубоким связующим адресам.

### Фрагмент кода

```java
    AppsFlyerConversionListener conversionListener = new AppsFlyerConversionListener() {
        @Override
        public void onConversionDataSuccess(Map<String, Object> conversionDataMap) {
            String status = Objects. equireNonNull(conversionDataMap.get("af_status")).toString();
            if(status quals("Non-organic"){
                if( Objects.requireNonNull(conversionDataMap. et("is_first_launch")).toString().equals("true"){
                    Log. (LOG_TAG,"Conversion: First Launch");
                    //Отложена глубокая ссылка в случае устаревшей ссылки
                    if(conversionDataMap. ontainsKey("fruit_name"){
                        if (conversionDataMap. ontainsKey("deep_link_value")) { //Не старая ссылка
                            Журнал. (LOG_TAG,"onConversionDataSuccess: Link contains deep_link_value, deep link with UDL");
                        }
                        else{ //Legacy link
                            conversionDataMap. ut("deep_link_value", conversionDataMap. et("fruit_name"));
                            String fruitNameStr = (String) conversionDataMap. et("fruit_name");
                            DeepLink deepLinkData = mapToDeepLinkObject(conversionDataMap);
                            goToFruit(fruitNameStr, deepLinkData);
                        }
                    }
                } else {
                    Log. (LOG_TAG,"Конверсия: Не первый запуск");
                }
            } else {
                Log. (LOG_TAG, "Конверсия: Это органическая установка. );
            }
        }

        @Override
        public void onConversionDataFail(String errorMessage) {
            Log. (LOG_TAG, "Ошибка получения данных о конверсии: " + errorMessage);
        }

        @Override
        public void onAppOpenAttribution(Map<String, String> attributionData) {
            Log. (LOG_TAG, "onAppOpenAttribution: Это поддельный вызов. );
        }

        @Override
        public void onAttributionFailure(String errorMessage) {
            Log. (LOG_TAG, "error onAttributionFailure : " + errorMessage);
        }
};
```

<unk> Github ссылки: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/bcf13e588561af3739bafbab510d6c3a7fb4e08a/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L99-L143)

## Тестирование

> 📘 **Важно**
>
> Следующий сценарий тестирования демонстрирует обработку отложенных глубоких ссылок из ссылок, содержащих пользовательские параметры, но не `deep_link_value` и `deep_link_sub1-10` параметров.  
> Этот сценарий также важен для всех расширенных отложенных глубоких связей, описанных [earlier](#overview).

### Прежде чем начать

- Завершите описанную ранее реализацию.
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode) в приложении.
- Убедитесь, что приложение не установлено на вашем устройстве.

### Тестовая ссылка

Вы можете использовать существующую ссылку OneLink или попросить вашего маркетинга создать новую для тестирования. Можно использовать как короткие, так и длинные OneLink URL.

#### Добавление параметров ad-hoc к ссылке

- Используйте только шаблон домена и OneLink, например: `https://onelink-basic-app.onelink.me/H5hv`.
- Добавьте дополнительные параметры, отличные от `deep_link_value` и `deep_link_sub1-10`, как ожидалось в вашем приложении.
- Параметры должны быть добавлены как _query parameters_.
  - Пример: `https://onelink-basic-app.onelink.me/H5hv?my_inapp_dest=apples&my_inapp_value=23`

### Выполните тест

1. Нажмите ссылку на вашем устройстве.
2. OneLink перенаправляет вас по ссылке на Google Play или веб-сайт.
3. Установите приложение.
   > \*\* Важное \*\*
   >
   > - Если приложение всё ещё находится в разработке и еще не загружено в магазин, то следующая картинка:  
   >   <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style={{textAlign: "center"}} />
   > - Установите приложение из Android Studio или любой другой IDE, который вы используете.
4. UDL обнаруживает отсроченные глубокие ссылки, соответствует установке клика, и получает параметры OneLink в обратный вызов `onDeepLinking`. **UDL не содержит параметров маршрута и выхода**.
5. Обратный вызов `onConversionDataSuccess` вызывается с данными конверсии, которые содержат как пользовательские параметры, так и данные атрибутов.
6. `onConversionDataSuccess` устанавливает пользовательские параметры для маршрутизации пользователя внутри приложения.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны только когда включен режим [отладки](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).

- Инициализация SDK:
  ```
  D/AppsFlyer_6.9.0: Инициализация AppsFlyer SDK: (v6.9.0.126)
  ```

- В нижеследующем журнале говорится о глубоких связях, которые могут игнорироваться в отсроченном сценарии увязки:
  ```
  D/AppsFlyer_6.9.0: Глубокая ссылка не обнаружена
  ```

- UDL API starts:
  ```
  D/AppsFlyer_6.9.0: [DDL] запуск
  ```

- UDL отправляет запрос в AppsFlyer для запроса соответствия с этой установкой:
  ```
  D/AppsFlyer_6.9.0: [DDL] Подготовка запроса 1
  ...
  I/AppsFlyer_6.9.0: вызов = https://dlsdk.appsflyer.com/v1.0/android/com.appsflyer.onelink. ppsflyeronelinkbasicapp?af_sig=<>&sdk_version=6.9; size = 239 байт; body = {
        . .
        TRUNCATED
        ...
  }
  ```

- UDL получил ответ и вызовы `onDeepLinking` с данными ссылки `status=FOUND` и OneLink:
  ```
  D/AppsFlyer_6.9.0: [DDL] Вызов onDeepLinking с:
    {"deepLink":"{\"campaign_id\":\"\",\"af_sub3\":\"\",\"match_type\":\"probabilistic\",\"af_sub1\":\"\",\"deep_link_value\":\"\",\"campaign\":\"\",\"af_sub4\":\"\",\"timestamp\":\"2022-12-07T09:32:52.256\",\"click_http_referrer\":\"\"af_sub5\":\",\"media_source\":\"\",\"af_sub2\":\"
  ```

- GCD извлекает данные преобразования:

```
GET:https://gcdsdk.appsflyer.com/install_data/v4.0/com.appsflyer.onelink.appsflyeronelinkbasicapp?devkey=XXXXXXXXX&device_id=1670405582645-822555416155480367
```

- `onConversionDataSuccess` называется с преобразованием данных в входные данные:

```
 D/AppsFlyer_6.9.0: [GCD-A02] Вызов onConversionDataУспех с:
    {
        ...
        is_first_launch=true, 
        ...
        fruit_amount=56,
        fruit_name=apples, 
        ...
        af_status=Non-organic,
        ...
}
```
