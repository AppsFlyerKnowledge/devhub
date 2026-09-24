---
title: Установка ID пользователя клиента
slug: пользователь-id-ios
category:
  uri: SDK AppsFlyer
parent:
  uri: интеграция-sdk-ios-6
privacy:
  view: публичный
position: 4
---

<span class="annotation-optional">Опциональное</span>  
ID пользователя (CUID) является уникальным идентификатором пользователя, созданным вне SDK владельцем приложения. Если он будет доступен в SDK, он может быть связан с установкой и другими внутри-приложенными событиями. Эти CUID события могут быть перекрестно ссылаться на данные пользователей с других устройств и приложений.

### Установить CUID

Чтобы установить CUID:

```objectivec
[AppsFlyerLib shared].customerUserID = @"мой идентификатор пользователя";
```

```swift
AppsFlyerLib.shared().customerUserID = "мой идентификатор пользователя"
```

> 📘 Заметка
>
> ID пользователя клиента должен быть установлен с каждым запуском приложения.

### Связать CUID с событием установки

Если важно связать событие установки с CUID, необходимо установить [`customerUserId`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#customeruserid) перед вызовом метода [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start). Это происходит потому, что [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start) отправляет событие установки на AppsFlyer. Если CUID установлен после вызова [`start`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#start), он не будет связан с событием установки.

```objectivec
- (void)applicationDidBecomeActive:(UIApplication *)application {
  	// Ваша пользовательская логика извлечения CUID
    NSString *customUserId = [[NSUserDefaults standardUserDefaults] stringForKey:@"customerUserId"];  
    если (customUserId ! не && ! customUserId isEqual: @""]) {
        // Установка CUID в AppsFlyer SDK для этой сессии
        [AppsFlyerLib shared]. ustomerUserID = customUserId; 
        // Запуск
        [[AppsFlyerLib совместно старт]; 
    }
}
```

```swift
func applicationDidBecomeActive(_ приложение: UIApplication) {
  // ваша логика для получения CUID
  let customUserId = UserDefaults.standard. tring(forKey: "customUserId") 
  
  if(customUserId != nil && customUserId ! ""){
     // Установка CUID в AppsFlyer SDK для этой сессии
    AppsFlyerLib. hared().customerUserID = customUserId    
    AppsFlyerLib.shared().start() // Начало
  }
}
```
