---
title: Данные преобразования
slug: conversion-data-ios-7
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-ios-7
privacy:
  view: публичный
position: 3
---

В этом руководстве вы узнаете, как получить [данные преобразования](doc:conversion-data) с помощью iOS SDK, а также [примеры использования](https://dev.appsflyer.com/hc/docs/conversion-data-android#accessing-attribution-data).

## Прежде чем начать

Для получения данных о конвертации требуется сначала [интегрировать SDK](doc:integrate-ios-sdk).

## Получение данных о преобразовании в iOS SDK

```objectivec
#import "AppDelegate.h"
#import <AppsFlyerLib/AppsFlyerLib.h>

@interface AppDelegate ()
@end
@implementation AppDelegate
    // ...
    -(void)onConversionDataSuccess:(NSDictionary*) installData {
    // Вызывается, когда разрешение преобразования данных достигает
}
-(void)onConversionDataFail:(NSError *) error {
    // Вызывается при сбое разрешения данных конвертации
    NSLog(@"%@", rror);
}
// . .
@end
```

```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class Delegate: UIResponder, UIApplicationDelegate {
    // ..
}

extension AppDelegate: AppsFlyerLibDelegate {

    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        // Invoked when conversion data resolution succeeds
    }

    func onConversionDataFail(_ error: Error! {
        // Вызывается при сбое разрешения преобразования данных
    }
}
```

#### onConversionDataУспешно

[`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) реализовано в [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate).  
Способ [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) вызывается когда:

- Пользователь открывает приложение
- Пользователь перемещает приложение на передний план

При вызове [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) возвращает `NSDictionary` (называемый `installData`), который содержит данные атрибутов для этой установки. `installData` кэшируется первый раз [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) и будет идентичен при последовательных звонках.

#### onConversionDataОшибка

[`onConversionDataFail`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatafail) реализовано в [`AppsFlyerLibDelegate`](doc:ios-sdk-reference-appsflyerlibdelegate).  
Если по какой причине SDK не может получить данные о конвертации, вызывается [`onConversionDataFail`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatafail).

## Доступ к данным атрибутов

Тип преобразования можно получить, просмотрев значение `af_status` в полезной загрузке `onConversionDataSuccess`. Это может быть одно из следующих значений:

- «Органический»
- `Non-organic`

#### Пример

Ниже приведен пример реализации:

```objectivec
#импорт "AppDelegate. "
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()
@end
@implementation AppDelegate
    // ...
-(void)onConversionDataSuccess:(NSDictionary*) installData {
    // Вызывается бизнес-логика для сценария неорганической установки
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id кампания = [installData objectForKey:@"campaign"];
        NSLog(@"Это неорганическая установка. Источник СМИ: %@  Кампания: %@",sourceID,campaign);
    }

    else if([status isEqualToString:@"Organic"]) {
        // Вызывается бизнес-логика для сценария органической установки
        NSLog(@"Это органическая установка. );
    }

}
-(void)onConversionDataFail:(NSError *) error {
    NSLog(@"%@",error);
}
// . .
@end
```

```swift
import UIKit
import AppsFlyerLib
@UIApplicationMain
class Delegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {
    // ...
}

extension AppDelegate: AppsFlyerLibDelegate {

    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        if let status = installData["af_status"] как? String {
            if (status == "Non-organic") {
                // Сценарий Business logic для неорганической установки вызывается
                if let sourceID = installData["media_source"],
                let campaign = installData["campaign"] {
                    print("Это неорганическая установка. Источник мультимедиа: \(sourceID)  Кампания: \(campaign)")
                }
            }
            else {
                // Вызывается бизнес-логика для сценария органической установки
            }
        }
    }

    func onConversionDataFail(_ error: Error! {
        // Логика при сбое разрешения данных преобразования
        if let err = error{
            print(err)
        }
    }
}
```

[Github link](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L168-L212)

## Отложенная глубокая связь (устаревший метод)

Когда приложение открыто через отсроченные глубокие ссылки, [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess) загрузка возвращает глубокие данные, а также данные об атрибутах.

- Рекомендуется использовать глубокие связи [Unified Deep Linking (UDL)](https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking)
- Для существующих клиентов и ссылок, вот наш [путеводитель по глубоким связям в iOS](https://dev.appsflyer.com/hc/docs/dl_ios_gcd_legacy), используя [`onConversionDataSuccess`](doc:ios-sdk-reference-appsflyerlibdelegate#onconversiondatasuccess).
