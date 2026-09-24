---
title: Расширенные настройки iOS
slug: dl_ios_ddl
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

## Общий обзор

Расширенная глубокая связь с отсрочкой позволяет глубину связи для новых пользователей в определенных сценариях:

- Когда UDL возвращает `NOT_FOUND`, даже несмотря на соответствующую установку.
  Главный пример такого сценария:
  - Время между щелчками и установкой превышает окно поиска UDL (15 минут).
- Когда UDL возвращает `FOUND`, но глубокие связующие данные отсутствуют параметры, которые не являются `deep_link_value` и `deep_link_sub1-10`.  
  Основные примеры таких сценариев:
  - Нажав на ссылку, которая не содержит `deep_link_value` или `deep_link_sub1-10` для глубокой ссылки, например, старые ссылки, созданные до того, как существует `deep_link_value`, которые все еще используются.
  - Время между щелчками и установкой превышает окно поиска UDL (15 минут).

Чтобы отложить глубокое соединение, UDL возвращает `NOT_FOUND`, обратная связь `onConversionDataSuccess` должна проверять, должен ли он обрабатывать отложенную глубину соединения.  
`onConversionDataSuccess` является частью API Get Conversion Data(GCD). Его основная цель - [собрать данные о преобразовании внутри устройства](../sdks/getting-started/conversion-data).  
В описанном здесь варианте использования `onConversionDataSuccess` использует тот факт, что все отложенные глубокие параметры связи передаются на обратный вызов, поверх данных о конверсии.

## Предпосылки

- Внедрение [Unified Deep Linking](dl_ios_unified_deep_linking) для обработки отсроченных глубоких ссылок и прямой глубокой привязки.
- Реализация `onConversionDataSuccess` для обработки [отложенных углубленных ссылок с помощью GCD API](dl_ios_gcd_legacy).

## Осуществление

1. `onConversionDataSuccess` обнаруживает случаи, когда отложенные глубокие связи должны происходить, что UDL не обрабатывает.
   > Подробнее [рассечение кода](#code-dissect)
2. `onConversionDataSuccess` должен маршрутизировать пользователя до отложенного места назначения на основе глубинных параметров соединения, передаваемых обратной связи.

## Пример кода

### Code dissect

1. Реализовать приложение Get Conversion Data delegate `AppsFlyerLibDelegate`.
   > Реализовать только `onConversionDataSuccess` и `onConversionDataFail`.  
   > Методы `onAppOpenAttribution` и `onAttributionFailure` взаимоисключают с UDL и не будут называться.
2. Обнаружение отложенных сценариев глубоких связей путем фильтрации данных преобразования с помощью:
   - `af_status == Неорганический`
   - `is_first_launch == true`
3. При обнаружении отсрочки глубокого соединения, отфильтровать случаи, которые уже обрабатывались UDL.  
   В следующем примере все ссылки содержат `deep_link_value`.  
   UDL рекомендуется сигналировать флагом, что отсроченные глубокие связи уже обработаны, а `onConversionDataSuccess` должен пропустить.
4. `onConversionDataSuccess` проверяет, что данные о преобразовании содержат параметры, используемые для маршрутизации пользователей внутри приложения. Например, `fruit_name` в следующем примере.
5. Перенесите пользователя к отложенным глубоким связующим адресам.

### Фрагмент кода

```swift
extension AppDelegate: AppsFlyerLibDelegate {
     
    // Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        ConversionData = data
        print("onConversionDataSuccess data:")
        for (key, value) in data {
            print(key, ":", value)
        }
        if let conversionData = data as NSDictionary? as! [String:Any]? {
        
            if let status = conversionData["af_status"] as? String {
                if (status == "Non-organic") {
                    if let sourceID = conversionData["media_source"],
                        let campaign = conversionData["campaign"] {
                        NSLog("[AFSDK] This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                    }
                } else {
                    NSLog("[AFSDK] This is an organic install.")
                }
                
                if let is_first_launch = conversionData["is_first_launch"] as? Bool,
                    is_first_launch {
                    NSLog("[AFSDK] First Launch")
                    if !conversionData.keys.contains("deep_link_value") && conversionData.keys.contains("fruit_name"){
                        switch conversionData["fruit_name"] {
                            case let fruitNameStr as String:
                            NSLog("This is a deferred deep link opened using conversion data")
                            walkToSceneWithParams(fruitName: fruitNameStr, deepLinkData: conversionData)
                            default:
                                NSLog("Could not extract deep_link_value or fruit_name from deep link object using conversion data")
                                return
                        }
                    }
                } else {
                    NSLog("[AFSDK] Not First Launch")
                }
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        NSLog("[AFSDK] \(error)")
    }
}
```

<unk> Github ссылки: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L168-L212)

## Тестирование

> 📘 **Важно**
>
> Следующий сценарий тестирования демонстрирует обработку отложенных глубоких ссылок из ссылок, содержащих пользовательские параметры, но не `deep_link_value` и `deep_link_sub1-10` параметров.  
> Этот сценарий также важен для всех расширенных отложенных глубоких связей, описанных [earlier](#overview).

### Прежде чем начать

- Завершите описанную ранее реализацию.
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode) в приложении.
- Убедитесь, что приложение не установлено на вашем устройстве.

### Тестовая ссылка

Вы можете использовать существующую ссылку OneLink или попросить вашего маркетинга создать новую для тестирования. Можно использовать как короткие, так и длинные OneLink URL.

#### Добавление параметров ad-hoc к ссылке

- Используйте только шаблон домена и OneLink, например: `https://onelink-basic-app.onelink.me/H5hv`.
- Добавьте дополнительные параметры, отличные от `deep_link_value` и `deep_link_sub1-10`, как ожидалось в вашем приложении.
- Параметры должны быть добавлены как _query parameters_.
  - Пример: `https://onelink-basic-app.onelink.me/H5hv?my_inapp_dest=apples&my_inapp_value=23`

### Выполните тест

- Нажмите ссылку на вашем устройстве.
- OneLink перенаправляет вас по ссылке для исправления App Store или веб-сайта.
- Установите приложение.
  > **Важно**
  >
  > - Если приложение всё ещё находится в разработке и еще не загружено в магазин, то следующая картинка:  
  >   <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style={{textAlign: "center"}} />
  > - Установите приложение из Xcode или любой другой IDE, который вы используете.
- UDL обнаруживает отсроченные глубокие соединения, соответствует установке по щелчку и получает параметры OneLink к вызову `didResolveDeepLink`. **UDL не содержит параметров маршрута и выхода**.
- Обратный вызов `onConversionDataSuccess` вызывается с данными конверсии, которые содержат как пользовательские параметры, так и данные атрибутов.
- `onConversionDataSuccess` устанавливает пользовательские параметры для маршрутизации пользователя внутри приложения.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны только когда включен режим [отладки].(<https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode>)

- Инициализация SDK:
  ```
  [AppsFlyerSDK] [com.apple.main-thread] AppsFlyer SDK версии 6.6.0 начал сборку 
  ```

- UDL API starts:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] Start DDL
  ```

- UDL отправляет запрос в службу AppsFlyer для запроса соответствия с этой установкой:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] URL: https://dlsdk.appsflyer.com/v1.0/ios/id1512793879?sdk_version=6.6&af_sig=c9a1d5b34d68e584d0db2a20f4049fb7cd2e785c3383bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  ```

- UDL получил ответ и вызовы `didResolveDeepLink` с данными ссылки `status=FOUND` и OneLink:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] Вызов didResolveDeepLink с: {"af_sub4":"","click_http_referrer":"","af_sub1":"","click_event":{"af_sub4":"","click_http_referrer":"","af_sub1":"","af_sub3":"","deep_link_value":"","campaign":"","match_type":"probabilistic","af_sub5":"","campaign_id":"","media_source":"","af_sub2":""},"af_sub3":"","deep_link_value":"","campaign":"","campaign""","match_type"
  ```

- GCD извлекает данные преобразования:

```
[AppsFlyerSDK] [com.appsflyer.serial] [GCD-B01] GCD 4.0 URL: https://gcdsdk.appsflyer.com/install_data/v4.0/id1512793879?devkey=s*****4&device_id=1672050642148-9221195
```

- `onConversionDataSuccess` называется с преобразованием данных в входные данные:

```
[AppsFlyerSDK] [com.appsflyer.serial] [GCD-A02] -[basic_app.AppDelegate onConversionDataSuccess:]:
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
