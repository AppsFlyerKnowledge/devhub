---
title: iOS отсрочка глубокой связи с iOS Private Relay
slug: дл_ios_приватный_реле
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

С запуском 1OS 15, Apple предоставляет пользователям iCloud+ возможность приватного передатчика, , которая предоставляет возможность зашифровать трафик веб-страниц и скрыть их точное местоположение, IP-адрес и содержимое их трафика. Если пользователи выбирают Private Relay, это может помешать атрибутированию и откладывать глубокое соединение. Как только новый пользователь без приложения переходит в App Store, и устанавливает и запускает приложение, Частный передатчик может помешать его отправке на определенную страницу в приложении.

Чтобы удостовериться, что отсроченные глубокие связи (DDL) продолжают работать, вам нужно реализовать одно из следующих решений AppsFler:

- **[Recommended] Приложение на клипе**: Создайте App Clip, который даёт данные об атрибутах пользователя, и направляет пользователей на индивидуальный интерфейс App Clip, похожий на то, что вы хотите, чтобы DDL получился. Приложение также может включать поток прямых пользователей из вашего App Clip в полное приложение.
- **Решение на основе буфера обмена**: Создайте целевую страницу с отложенными глубокими ссылками из URL-адреса и корректно перенаправляет пользователя в приложение. Примечание: Это решение не помогает с атрибуцией.
  [block:api-header]
  {
  "title": "Решение на основе клиентов"
  }
  [/block]
  **Требования**: AppsFlyer SDK V6.4.0+

**Для настройки DDL на клипе приложения**:

1. Следуйте [инструкциям Apple](https://developer.apple.com/documentation/app_clips) и разрабатывайте приложение для желаемого пользователя.
2. [Интегрируйте AppsFlyer SDK для App Clips](https://dev.appsflyer.com/hc/docs/app-clip-sdk-integration), в том числе [App Clip-to-full app attribution](https://dev.appsflyer.com/hc/docs/app-clip-to-full-app-install).
3. В App Clip `sceneDelegate`:
   - Замените `scene` `continue userActivity` следующей функцией:
     \[block:code]
     {
     "codes": \[
     {
     "code": "func scene(\_ scene: UIScene, continue userActivity: NSUserActivity) {\n  // Must for AppsFlyer attrib\n  AppsFlyerLib. hared(). ontinue(userActivity, restorationHandler: nil)\n\n  //Получить URL вызова с действия пользователя, чтобы добавить его к стандартному пользователю\n  охранять userActivity. ctivityType == NSUserActivityTypeBrowsingWeb,\n  пусть invocationURL = userActivity. ebpageURL else {\n    return\n  }\n  addDlUrlToSharedUserDefaults(invocationURL)        \n}",
     "Язык": "swift"
     }
     ]
     }
     \[/block] <unk> Github ссылки: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app_AppClip/SceneDelegate.swift#L17-L28

- Добавьте следующий метод:
  \[block:code]
  {
  "codes": \[
  {
  "code": "func addDlUrlToSharedUserDefaults(\_ url: URL){\n  guard let sharedUserDefaults = UserDefaults(suiteName: \"group.\<your\_app>.appClipToFullApp\") else {\n    return\n  }\n  //Добавить URL вызова в группу приложений\n  sharedUserDefaults. et(url, forKey: \"dl\_url\")\n  //Включить отправку событий\n  sharedUserDefaults. et(true, forKey: \"AppsFlyerReadyToSendEvents\")\n}",
  "язык": "swift"
  }
  ]
  }
  \[/block] <unk> Github ссылки: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app_AppClip/SceneDelegate.swift#L70-L78

4. В полном приложении:
   - В `appDelegate`, добавить следующий метод:
     [block:code]
     {
     "codes": [
     {
     "code": "func deepLinkFromAppClip() {\n  guard let sharedUserDefaults = UserDefaults(suiteName: \"group.<your_app>.appClipToFullApp\"),\n  let dlUrl = sharedUserDefaults. rl(forKey: \"dl_url\")\n  else {\n    NSLog(\"Не удалось найти группу приложений или глубокий URL из клипа\")\n    return\n  }\n  AppsFlyerLib. hared().performOnAppAttribution(with: dlUrl)\n  sharedUserDefaults. emoveObject(forKey: \"dl_url\")\n}",
     "Язык": "swift"
     }
     ]
     }
     [/block]

<unk> Github ссылки: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app/AppDelegate.swift#L123-L134

- В конце метода `application didFinishLaunchingWithOptions launchOptions`, вызов `deepLinkFromAppClip`:
  \[block:code]
  {
  "codes": \[
  {
  "code": "func application(\_ application: UIApplication, didFinishLaunchWithOptions launchOptions: \[UIApplication. aunchOptionsKey: любой]?) -> Bool {\n\n  // ...\n\n  deepLinkFromAppClip()\n\n  возвращает true\n}",
  "язык": "swift"
  }
  ]
  }
  \[/block] <unk> Github ссылки: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/0a11ff86ca01e0c279010eebc00baf35bf88da2e/swift/basic_app/basic_app/AppDelegate.swift#L54

[block:api-header]
{
"title": "Решение на основе буфера обмена"
}
[/block]
**Чтобы настроить решение на основе буфера обмена**:

1. Введите следующий код в `appDelegate`.
   [block:code]
   {
   "коды": [
   {
   "code": "NSString \*pasteboardUrl = [[UIPasteboard generalPasteboard] string];\nNSString \*checkParameter = @\"cp_url=true\";\n\nif ([pasteboardUrl containsString:checkParameter]) {\n  [[AppsFlyerLib shared] performOnAppAttributionWithURL:[NSURL URLWithString:pasteboardUrl]];\n}",
   "Язык": "цели"
   },
   {
   "код": "var pasteboardUrl = UIPasteboard. eneral.string ?? \"\"\nlet checkParameter = \"cp_url=true\"\n\nif pasteboardUrl.contains(checkParameter) {\n    AppsFlyerLib.shared(). erformOnAppAttribution(с: URL(строка: pasteboardUrl))\n}",
   "Язык": "swift"
   }
   ]
   }
   [/block]
2. Внедрить код, который вставляет отложенные глубокие данные ссылки в URL из буфера обмена. Это не является частью AppsFlyer SDK.
