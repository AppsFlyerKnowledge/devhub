---
title: Универсальная связь iOS
slug: dl_ios_unified_deep_link
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

**На взгляд:** Унифицированная глубокая связь (UDL) позволяет отправлять новых и существующих пользователей на конкретную работу приложения (например, отдельная страница в приложении), как только приложение будет открыто.

> 📘 **Защита конфиденциальности UDL**
>
> Для новых пользователей метод UDL возвращает только параметры, относящиеся к отложенной глубокой ссылке: `deep_link_value` и `deep_link_sub1-10`. Если вы пытаетесь получить другие параметры (`media_source`, `campaign`, `af_sub1-5`, etc.), они возвращают null.

## Поток

![поток iOS UDL!](https://files.readme.io/b1079fb-6577_Unified_Deep_Link_flow_iOS.png "поток iOS UDL")

Этот поток работает следующим образом:

1. Пользователь кликает на OneLink.
   - Если у пользователя установлено приложение, то программа Universal Links или URI открывает приложение.
   - Если у пользователя нет установленного приложения, он перенаправляется в магазин приложений, и после загрузки пользователь открывает приложение.
2. Приложение открывает запускает AppsFlyer SDK.
3. В AppsFlyer SDK запускается UDL API.
4. UDL API извлекает данные OneLink с серверов AppsFlyer
5. UDL API возвращает \[\`\`didResolveDeepLink()`] в [`DeepLinkDelegate\`].
6. Метод [`didResolveDeepLink()`] получает объект [`DeepLinkResult`].
7. Объект [`DeepLinkResult`] включает в себя:
   - Статус (округл/не найдено/провал).
   - Объект DeepLink, который перевозит:
     - **Для пользователей с приложением еще не установлено**: `deep_link_value` и `deep_link_sub1-10` параметры.
     - **Для пользователей с уже установленным приложением**:Параметры `deep_link_value` и `deep_link_sub1-10` и все параметры, содержащиеся в параметре `link` ссылки OneLink.

[`didResolveDeepLink()`]: https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink
[`DeepLinkDelegate`]: https://dev.appsflyer.com/hc/docs/appsflyerlib-1#deeplinkdelegate
[`DeepLinkResult`]: https://dev.appsflyer.com/hc/docs/deeplinkresult-1
[`DeepLink`]: https://dev.appsflyer.com/hc/docs/deeplink-1

## Планирование

- UDL требует AppsFlyer iOS SDK V6.1+.

При настройке OneLink, маркер использует параметры для создания ссылок, и разработчик настраивает поведение приложения на основе полученных значений. Ответственность за правильность обработки параметров в приложении лежит на разработчике, для маршрутизации внутри приложения и персонализации данных по ссылке.

**Чтобы планировать OneLink:**

1. Получите от маркетинга нужное поведение и личные впечатления пользователя, когда он нажимает на URL.
2. Основываясь на желаемом поведении, планируйте `deep_link_value` и другие параметры, необходимые для того, чтобы дать пользователю желаемый личный опыт.
   - `deep_link_value` устанавливается маркером в URL и используется разработчиком для перенаправления пользователя на определенное место внутри приложения. Например, если у вас есть фруктовый магазин и вы хотите направить пользователей к яблокам, значение `deep_link_value` может быть `apples`.
   - Также в URL можно добавить параметры `deep_link_sub1-10`, чтобы персонализировать пользовательский опыт. Например, чтобы дать 10% скидку, значение `deep_link_sub1` может быть `10`.

## Осуществление

[block:html]
{
"html": "<style>\n  .containerBox {\n    right: 0;\n    display: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    border: 1px solid #d8d8d8;\n    padding: 20px 10px;\n    padding-right: 50px;\n    padding-top: 10px;\n  }\n .djButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    text-decoration: none;\n    color: white;\n    font-weight: 600;\n   \tcursor: pointer;\n    border: none;\n    background-color: rgb(3, 109, 235) !important;\n  }\n  \n  .djButton:hover {\n  \tbackground-color: #0360ce !important;\n    transition: 0.3s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 180px; margin: 0 0; margin-right: 20px\">\n  <div>\n    <h1 style=\"margin-top: 20px\">\n      Let's save you some time  >>\n    </h1>   \n      <h3>\n        Set Deep Linking with our SDK integration wizard\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=dl_ios_unified_deep_linking');\\" target=\"_blank\" class=\"djButton\">\n      Let's go\n      </button>\n  </div>\n</div>\n"
}
[/block]

Реализовать UDL API логику на основе выбранных параметров и значений.

1. Назначить `AppDelegate`, используя `self` в [`AppsFlyerLib.shared().deepLinkDelegate`](https://dev.appsflyer.com/hc/docs/appsflyerlib-1#deeplinkdelegate).
2. Внедрить функцию приложения, чтобы позволить:
   - Поддержка универсальных ссылок через [\`\`continue\`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#continue).
   - Поддержка схемы URI с помощью [`handleOpen`](https://dev.appsflyer.com/hc/docs/ios-sdk-reference-appsflyerlib#handleopen).
3. Создать [\`\`DeepLinkDelegate`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate) в качестве расширения `AppDelegate\`.
4. Добавьте функции `application` для поддержки Universal Links и URI схем.
5. В `DeepLinkDelegate` убедитесь, что вы переопределили функцию обратного вызова, [`didResolveDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink).
   `didResolveDeepLink()` в качестве аргумента принимает объект [`DeepLinkResult`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1).
6. Используйте [\`\`DeepLinkResult.status\`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#status) для задания вопроса о том, найдена ли глубокая связь.
7. Когда статус ошибки, вызовите [\`\`DeepLinkResult.error\`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#error) и запустите ваш поток ошибок.
8. Если статус найден, используйте [\`\`DeepLinkResult.deepLink`](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#deeplink) для получения объекта [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink-1). 
   Объект `DeepLink` содержит глубокие ссылки в публичных переменных для получения значений из известных ключей OneLink, например, [`DeepLink. eeplinkValue`](https://dev.appsflyer.com/hc/docs/deeplink-1#deeplinkvalue) для `deep_link_value\`.
9. Используйте [`deepLinkObj.clickEvent["deep_link_sub1"]`](https://dev.appsflyer.com/hc/docs/deeplink-1#clickevent) для получения `deep_link_sub1`. Сделайте то же самое для параметров `deep_link_sub2-10`, изменив требуемое строковое значение.
10. После извлечения `deep_link_value` и `deep_link_sub1-10` передайте их маршрутизатору внутри приложения и используйте его для персонализации пользовательского опыта.

### Поддержка устаревших OneLink ссылок

Устаревшие ссылки OneLink - это ссылки, которые не содержат параметров, рекомендованных для Unified Deep Linking: `deep_link_value` и `deep_link_sub1-10`.
Обычно это ссылки, которые уже существуют в этой области при переезде с традиционных методов на UDL.
Новые пользователи, использующие старые ссылки, обрабатываются `onConversionDataSuccess` в контексте [расширенной глубокой ссылки](dl_ios_ocds_ddl).
UDL управляет глубокой связью для существующих пользователей. Рекомендуется добавить поддержку в UDL callback `didResolveDeepLink` для старых параметров.
[Пример кода](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/7c58363b01a184863d3b3fc07ba707a72d76bcda/swift/basic_app/basic_app/AppDelegate.swift#L152-L162)

### Пример кода

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  // Replace 'appleAppID' and 'appsFlyerDevKey' with your Apple App ID (eg 69999999, without id prefix) and DevKey
  // The App ID and the DevKey must be set prior to the calling of the deepLinkDelegate
  AppsFlyerLib.shared().appleAppID = appleAppID  
  AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerDevKey
  ...
  AppsFlyerLib.shared().deepLinkDelegate = self
  ...
}

// For Swift version < 4.2 replace function signature with the commented out code
// func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool { // this line for Swift < 4.2
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
  AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
  return true
}

// Open URI-scheme for iOS 9 and above
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
  AppsFlyerLib.shared().handleOpen(url, options: options)
  return true
}

extension AppDelegate: DeepLinkDelegate {
    func didResolveDeepLink(_ result: DeepLinkResult) {
        var fruitNameStr: String?
        switch result.status {
        case .notFound:
            NSLog("[AFSDK] Deep link not found")
            return
        case .failure:
            print("Error %@", result.error!)
            return
        case .found:
            NSLog("[AFSDK] Deep link found")
        }
        
        guard let deepLinkObj:DeepLink = result.deepLink else {
            NSLog("[AFSDK] Could not extract deep link object")
            return
        }
        
        if deepLinkObj.clickEvent.keys.contains("deep_link_sub2") {
            let ReferrerId:String = deepLinkObj.clickEvent["deep_link_sub2"] as! String
            NSLog("[AFSDK] AppsFlyer: Referrer ID: \(ReferrerId)")
        } else {
            NSLog("[AFSDK] Could not extract referrerId")
        }        
        
        let deepLinkStr:String = deepLinkObj.toString()
        NSLog("[AFSDK] DeepLink data is: \(deepLinkStr)")
            
        if( deepLinkObj.isDeferred == true) {
            NSLog("[AFSDK] This is a deferred deep link")
        }
        else {
            NSLog("[AFSDK] This is a direct deep link")
        }
        
        fruitNameStr = deepLinkObj.deeplinkValue
        walkToSceneWithParams(fruitName: fruitNameStr!, deepLinkData: deepLinkObj.clickEvent)
    }
}
// User logic
fileprivate func walkToSceneWithParams(deepLinkObj: DeepLink) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    guard let fruitNameStr = deepLinkObj.clickEvent["deep_link_value"] as? String else {
         print("Could not extract query params from link")
         return
    }
    let destVC = fruitNameStr + "_vc"
    if let newVC = storyBoard.instantiateVC(withIdentifier: destVC) {
       print("AppsFlyer routing to section: \(destVC)")
       newVC.deepLinkData = deepLinkObj
       UIApplication.shared.windows.first?.rootViewController?.present(newVC, animated: true, completion: nil)
    } else {
        print("AppsFlyer: could not find section: \(destVC)")
    }
}
```

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Set isDebug to true to see AppsFlyer debug logs
    [AppsFlyerLib shared].isDebug = YES;
    
    // Replace 'appsFlyerDevKey', `appleAppID` with your DevKey, Apple App ID
    [AppsFlyerLib shared].appsFlyerDevKey = appsFlyerDevKey;
    [AppsFlyerLib shared].appleAppID = appleAppID;
    
    [AppsFlyerLib shared].deepLinkDelegate = self;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    [[AppsFlyerLib shared] continueUserActivity:userActivity restorationHandler:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[AppsFlyerLib shared] handleOpenUrl:url options:options];
    return YES;
}

#pragma mark - DeepLinkDelegate

- (void)didResolveDeepLink:(AppsFlyerDeepLinkResult *)result {
    NSString *fruitNameStr;
   NSLog(@"[AFSDK] Deep link lowkehy");
    switch (result.status) {
        case AFSDKDeepLinkResultStatusNotFound:
            NSLog(@"[AFSDK] Deep link not found");
            return;
        case AFSDKDeepLinkResultStatusFailure:
            NSLog(@"Error %@", result.error);
            return;
        case AFSDKDeepLinkResultStatusFound:
            NSLog(@"[AFSDK] Deep link found");
            break;
    }
    
    AppsFlyerDeepLink *deepLinkObj = result.deepLink;
    
    if ([deepLinkObj.clickEvent.allKeys containsObject:@"deep_link_sub2"]) {
        NSString *referrerId = deepLinkObj.clickEvent[@"deep_link_sub2"];
        NSLog(@"[AFSDK] AppsFlyer: Referrer ID: %@", referrerId);
    } else {
        NSLog(@"[AFSDK] Could not extract referrerId");
    }
    
    NSString *deepLinkStr = [deepLinkObj toString];
    NSLog(@"[AFSDK] DeepLink data is: %@", deepLinkStr);
    
    if (deepLinkObj.isDeferred) {
        NSLog(@"[AFSDK] This is a deferred deep link");
        if (self.deferredDeepLinkProcessedFlag) {
            NSLog(@"Deferred deep link was already processed by GCD. This iteration can be skipped.");
            self.deferredDeepLinkProcessedFlag = NO;
            return;
        }
    } else {
        NSLog(@"[AFSDK] This is a direct deep link");
    }
    
    fruitNameStr = deepLinkObj.deeplinkValue;
    
    // If deep_link_value doesn't exist
    if (!fruitNameStr || [fruitNameStr isEqualToString:@""]) {
        // Check if fruit_name exists
        id fruitNameValue = deepLinkObj.clickEvent[@"fruit_name"];
        if ([fruitNameValue isKindOfClass:[NSString class]]) {
            fruitNameStr = (NSString *)fruitNameValue;
        } else {
            NSLog(@"[AFSDK] Could not extract deep_link_value or fruit_name from deep link object with unified deep linking");
            return;
        }
    }
    
    // This marks to GCD that UDL already processed this deep link.
    // It is marked to both DL and DDL, but GCD is relevant only for DDL
    self.deferredDeepLinkProcessedFlag = YES;
    
    [self walkToSceneWithParams:fruitNameStr deepLinkData:deepLinkObj.clickEvent];
}

- (void)walkToSceneWithParams:(NSString *)fruitName deepLinkData:(NSDictionary *)deepLinkData {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[UIApplication sharedApplication].windows.firstObject.rootViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSString *destVC = [fruitName stringByAppendingString:@"_vc"];
    DLViewController *newVC = [storyboard instantiateViewControllerWithIdentifier:destVC];
    
    NSLog(@"[AFSDK] AppsFlyer routing to section: %@", destVC);
    newVC.deepLinkData = deepLinkData;
    
    [[UIApplication sharedApplication].windows.firstObject.rootViewController presentViewController:newVC animated:YES completion:nil];
}

```

<unk> Ссылка на Github: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/a96399329a369b30263ea4f8cc4558029ea603b3/swift/basic_app/basic_app/AppDelegate.swift#L126) <unk> Ссылка на Github: [Objective-C](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/e8c2d63969a89989680032b8c3e00c361f26658e/obj-c/obj-c/AppDelegate.m#L102)

### Отложенная глубокая связь после согласия сети

In some cases the application might require consent from the user in order to connect to the network, in a dialog similar to this one:
[block:image]
{
"images": [
{
"image": [
"https://files.readme.io/c4ac931-network_consent_dialog.png",
"c4ac931-network_consent_dialog.png",
null
],
"align": "center",
"sizing": "250px"
}
]
}
[/block]

В целях поддержки отложенных глубоких ссылок после предоставления согласия сети мы рекомендуем:

- Реализация [eDDL](./dl_ios_ocds_ddl) для разрешения UDL обрабатывать отложенные глубокие ссылки

## Тестирование отложенных глубинных связей

### Предпосылки

- Complete UDL [integration](#implementation).
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode) в приложении.
- Убедитесь, что приложение не установлено на вашем устройстве.
- Запросите у вашего маркетинга шаблон OneLink.
  - Будет выглядеть что-то вроде `https://onelink-basic-app.onelink.me/H5hv`.
  - В этом примере используется поддомен `onelink-basic-app.onelink.me` и шаблон ID OneLink `H5hv`.

### Тестовая ссылка

Вы можете использовать существующую ссылку OneLink или попросить вашего маркетинга создать новую для тестирования. Можно использовать как короткие, так и длинные OneLink URL.

#### Добавление параметров ad-hoc к существующей ссылке

- Используйте только домен и шаблон OneLink. Например: `https://onelink-basic-app.onelink.me/H5hv`.
- Добавьте `deep_link_value` и `deep_link_sub1-10` параметры OneLink. Параметры следует добавить в параметры запроса.
  - Пример: `https://onelink-basic-app.onelink.me/H5hv?pid=my_media_source&deep_link_value=apples&deep_link_sub1=23`

### Выполните тест

1. Нажмите ссылку на вашем устройстве.
2. OneLink перенаправляет вас в соответствии с настройками ссылки на App Store или веб-сайт.
3. Установите приложение.

> \*\* Важное \*\*
>
> - Если приложение все еще находится в разработке и еще не загружено в магазин, вы видите это изображение:> <img src="https://files.readme.io/8d43627-Screenshot_20221205-191054_Chrome.jpg" alt="drawing" width="250" style={{textAlign: "center"}} />
> - Установите приложение из Xcode.

4. UDL обнаруживает отсроченные глубокие соединения, соответствует установке по щелчку и получает параметры OneLink к вызову `didResolveDeepLink`.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны только когда включен режим [отладки](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode).

- Инициализация SDK:
  ```
  [AppsFlyerSDK] [com.apple.main-thread] AppsFlyer SDK версии 6.6.0 начал сборку
  ```
  ```

  ```
- UDL API starts:
  ```
  D/AppsFlyer_6.9.0: [DDL] запуск
  ```
- UDL отправляет запрос в AppsFlyer для запроса соответствия с этой установкой:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] URL: https://dlsdk.appsflyer.com/v1.0/ios/id1512793879?sdk_version=6.6&af_sig=efcecc2bc95a0862ceaa7b62fa8e98ae1e3e022XXXXXXXXXXXXXXXX
  ```
- UDL получил ответ и вызовы `didResolveDeepLink` с данными ссылки `status=FOUND` и OneLink:
  ```
  [AppsFlyerSDK] [com.appsflyer.serial] [DDL] Вызов didResolveDeepLink с: {"af_sub4":"","click_http_referrer":"","af_sub1":"","click_event":{"af_sub4":"","click_http_referrer":"","af_sub1":"","af_sub3":"","deep_link_value":"peaches","campaign":"","match_type":"probabilistic","af_sub5":"","campaign_id":"","media_source":"","deep_link_sub1":"23","af_sub2":""},"af_sub3":"","deep_link_value":"peaches
  ```

## Тестирование глубоких связей (универсальные ссылки)

### Предпосылки

- Complete UDL [integration](#implementation).
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996).
- [Включить режим отладки](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode) в приложении.
- Убедитесь, что приложение уже установлено на вашем устройстве.
- Запросите у вашего маркетинга **шаблон OneLink**.
  - Будет выглядеть что-то вроде `https://onelink-basic-app.onelink.me/H5hv`.
  - В этом примере используется поддомен OneLink `onelink-basic-app.onelink.me` и шаблон ID OneLink `H5hv`
- [Настройка универсальных ссылок](dl_ios_init_setup#procedures-for-ios-universal-links).

### Создать тестовую ссылку

Используйте тот же метод, что и в [отложенной глубокой ссылке](#testing-deferred-deep-linking).

### Выполните тест

1. Нажмите ссылку на вашем устройстве.
2. UDL обнаруживает Универсальную ссылку и получает параметры OneLink в обратный вызов `didResolveDeepLink`.

### Ожидаемые результаты журналов

> 📘 Следующие журналы доступны только когда включен режим [отладки](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#enabling-debug-mode).

- Если ссылка является OneLink короткой ссылкой (например, https://onelink-basic-app.onelink.me/H5hv/apples):
  ```

  ```

[AppsFlyerSDK] [com.apple.main-thread] NSUserActivity `webpageURL`: https://onelink-basic-app.onelink.me/H5hv/apples
[AppsFlyerSDK] [com.appsflyer.serial] UniversalLink/Deeplink найден:
https://onelink-basic-app.onelink.me/H5hv/apples
[AppsFlyerSDK] [com.appsflyer.serial] Shortlink найден. Выполнение: https://onelink.appsflyer.com/shortlink-sdk/v2/H5hv?id=apples
...
[AppsFlyerSDK] [com.appsflyer.serial]  
[Shortlink] OneLink:{
c = test1;
кампания = test1;
"deep_link_sub1" = 23;
"deep_link_value" = peaches;
"is_retargeting" = true;
"media_source" = СМС;
pid = СМС;
}

  ```
  - UDL вызовы `didResolveDeepLink` с данными ссылки `status=FOUND` и OneLink:
  ```

[AppsFlyerSDK] [com.appsflyer.serial] [DDL] Вызов didResolveDeepLink с: {"af_sub4":null,"click_http_referrer":null,"af_sub1":null,"click_event":{"campaign":"test1","deep_link_sub1":"23","deep_link_value":"peaches","media_source":"SMS"},"af_sub3":null,"deep_link_value":"peaches","campaign":"test1","match_type":null,"af_sub5":null,"media_source":"SMS","campaign_id":null,"af_sub2":null}

  ```
  
  ```
