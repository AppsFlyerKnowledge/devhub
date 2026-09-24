---
title: Доход от рекламы
slug: gs-ad-доход
category:
  uri: SDK AppsFlyer
parent:
  uri: получение запущено
privacy:
  view: публичный
position: 9
---

Рекламный доход от партнеров может быть сообщен AppsFlyer с гранулярностью на уровне впечатлений через SDK. Данные на уровне показа через SDK:

- Имеет лучшую свежесть данных и более раннюю доступность в AppsFlyer.
- Поддерживает SKAN.

AppsFlyer SDK посылает данные о доходах AppsFlyer. Данные о доходах собираются и обрабатываются в AppsFlyer, и доход присваивается первоначальному источнику UA.

> 📘 Заметка
>
> Если ваша реализация Ad Revenue предшествует SDK v6.15.0 и вы хотите обновить код вашего рекламного дохода, как указано в руководствах ниже. В противном случае функция Ad Revenue не работает корректно.

Инструкции по доходам от AppsFlyer для различных платформ:

[block:html]
{
"html": "<style>\n  .button-container {\n    display: flex;\n    max-width: 800px;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    min-width: 200px;\n    border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n    border: solid 2px #434446;\n  }\n  .button:before {\n    margin-right: 4px;\n  }\n  .ios:before {\n    content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\\");\\n  }\n  .android:before {\n    content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\\");\\n  }\n  .unity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\\");\\n  }\n  .flutter:before {\n    content: url(\"https://files.readme.io/1f70175-flutter-icon.svg\\");\\n  }\n  .cordova:before {\n    content: url(\"https://files.readme.io/5f757d6-apache_cordova-icon.svg\\");\\n  }\n  .capacitor:before {\n    content: url(\"https://files.readme.io/ad0d405-capacitor-icon.svg\\");\\n  }\n  .reactnative:before {\n    content: url(\"https://files.readme.io/3e1288d-reactnative-icon.svg\\");\\n  }\n  a[href\*=http]:not([href\*=\"dev.appsflyer.com\"]):not(.landing-page__social):after {\n    display: none !important;\n  }\n</style>\n<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/ad-revenue-1\\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/ad-revenue-2\\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/ad-revenue-unity\\">Unity SDK</a>\n  <a class=\"button reactnative\" href=\"https://dev.appsflyer.com/hc/docs/rn_api#logadrevenue\\">React Native SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a target=\"_blank\" class=\"button flutter\" href=\"https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/API.md#-void-logadrevenueadrevenuedata-adrevenuedata\\">Flutter</a>\n  <a target=\"_blank\" class=\"button cordova\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cordova-plugin/blob/master/docs/API.md#logAdRevenue\\">Cordova</a>\n  <a target=\"_blank\" class=\"button capacitor\" href=\"https://github.com/AppsFlyerSDK/appsflyer-capacitor-plugin/blob/main/docs/API.md#logadrevenue\\">Capacitor</a>\n  <a target=\"_blank\" class=\"button cocos2dx\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cocos2dx-plugin?tab=readme-ov-file#logAdrevenue\\">Cocos2dx</a>\n</div>"
}
[/block]