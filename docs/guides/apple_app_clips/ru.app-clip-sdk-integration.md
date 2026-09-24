---
title: Интеграция с App Clip SDK
slug: app-clip-sdk-интеграция
category:
  uri: Интеграция с Apple App Clips
privacy:
  view: публичный
---

Разработчик направляет пользователя к правильной активности, используя URL-адрес вызова (QR-код, NFC-тег и т.д., вызывающий App Clip).

**Прежде чем начать**: Убедитесь, что вы и маркетер уже создали шаблон OneLink с [Universal Links](https://dev.appsflyer.com/hc/docs/dl_ios_init_setup#app-opening-methods), и настраиваемая ссылка OneLink, чтобы направлять ваших пользователей приложений. С шаблоном и пользовательской ссылкой уже настроены, узлы AppsFlyer и редактирует файл AASA, чтобы поддерживать App Clips автоматически. **Примечание**: Обновление файла AASA может занять несколько часов.

\*\*Чтобы добавить SDK в клик приложения и направить пользователя \*\*:

1. [Добавьте SDK в ваш App Clip](https://dev.appsflyer.com/hc/docs/install-ios-sdk)
2. [Интегрировать SDK](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk)
3. [Optional] [Add support for scene delegate](https://dev.appsflyer.com/hc/docs/integrate-ios-sdk#add-scenedelegate-support)
4. В **Список объектов информации** (`info. list-file) для клипа приложения, добавьте следующую строку ключом и значением, как подробно описано в следующей таблице. [block:parameters]
   {
     "data": {
       "h-0": "Ключ",
       "h-1": "Тип",
       "h-2": "Значение",
       "0-0": "`AppsFlyerAppClip`",
       "0-1": "Boolean`",
   "0-2": "`1`"
   },
   "холод": 3,
   "ряды": 1
   }
   [/block]
5. Добавьте следующий код в `sceneDelegate`:
   \[block:code]
   {
   "codes": \[
   {
   "code": "func scene(\_ scene: UIScene, continue userActivity: NSUserActivity) {\n        \n    // Must for AppsFlyer attrib\n    AppsFlyerLib. hared().continue(userActivity, restorationHandler: nil)\n}\n    \nfunc scene(\_ сцены: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene. onnectionOptions) {\n        \n    guard let \_ = (сцена как? UIWindowScene) еще { return }\n        \n    если позволить userActivity = connectionOptions. serActivities.first {\n       себя. cene(scene, continue: userActivity)\n    }\n    return\n}",
   "язык": "swift"
   }
   ]
   }
   \[/block] <unk> Github ссылки: [Swift][scene_swift]

[scene_swift]: https://github.com/AppsFlyerSDK/appsflyer-apple-app-clips-sample-app/blob/01f91d8052f89baf27ad9b750e718e20b1b9d155/Fruit%20AppClip/SceneDelegate.swift#L18-L32

6. [Optional] Настройте [атрибут приложения для полного приложения](https://dev.appsflyer.com/hc/docs/app-clip-to-full-app-install).

7. Пусть маркетолог знает, что интеграция SDK завершена, и расскажите им, чтобы реализовать опыт App Clip в пользовательской ссылке OneLink и App Store Connect. [Подробнее](https://support.appsflyer.com/hc/en-us/articles/360014262358-Apple-App-Clips-integration-guide#app-clip-implementation)
   [block:callout]
   {
   "type": "info",
   "title": "Пример",
   "Тело": "[Посмотреть наш App Clip](https://github.com/AppsFlyerSDK/appsflyer-apple-app-clips-sample-app), демонстрирующий интеграцию приложений AppsFly."
   }
   [/block]
