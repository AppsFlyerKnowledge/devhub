---
title: Проверка покупки и подписки
slug: проверка покупки и подписки
category:
  uri: SDK AppsFlyer
parent:
  uri: получение запущено
privacy:
  view: публичный
position: 10
---

Проверка покупки обеспечивает измерение только реальных покупок внутри приложения и подписок на AppsFlyer. Это повышает точность доходов, помогает предотвратить ошибки в сообщениях и способствует принятию более эффективных решений в рамках кампаний.

AppsFlyer предлагает два продукта для поддержки проверки покупки:

- **Проверка получения** – бесплатное легкое решение для проверки покупки в приложении.
- **ROI360 Store доходов** – это комплексное решение для точности получения дохода, включая покрытие жизненного цикла подписки и отчетность о чистом доходе.

Дополнительную информацию см. в разделе [Проверка покупки и подписки](https://support.appsflyer.com/hc/en-us/articles/42120228484241--WIP-Purchase-and-subscription-validation-Overview).

## Методы интеграции SDK

AppsFlyer поддерживает два метода интеграции SDK для отправки данных покупки в AppsFlyer для проверки:

### 1. Метод Ручной Интеграции – проверка и запись

Вызов «Подтвердить» и «Зарегистрировать» (`validateAndLogInAppPurchase`) каждый раз, когда транзакция происходит в приложении (например, покупка в приложении, начало подписки или пробный запуск). Метод отправляет транзакцию в AppsFlyer, которая проверяет ее с помощью магазина и генерирует соответствующее событие в приложении.

- Требует явного вызова приложения для каждой транзакции
- Подходит для приложений, которым необходимо фиксировать события, не включенные в стандартное покрытие коннекторов покупки. С помощью метода Validate и log разработчики могут явно нацеливаться и отправлять эти дополнительные события.

Чтобы начать видеть:

[block:html]
{
"html": "<style>\n  .button-container {\n    display: flex;\n    max-width: 800px;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    min-width: 200px;\n    border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n    border: solid 2px #434446;\n  }\n  .button:before {\n    margin-right: 4px;\n  }\n  .ios:before {\n    content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\\");\\n  }\n  .android:before {\n    content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\\");\\n  }\n  .unity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\\");\\n  }\n  .flutter:before {\n    content: url(\"https://files.readme.io/1f70175-flutter-icon.svg\\");\\n  }\n  .cordova:before {\n    content: url(\"https://files.readme.io/5f757d6-apache_cordova-icon.svg\\");\\n  }\n  .capacitor:before {\n    content: url(\"https://files.readme.io/ad0d405-capacitor-icon.svg\\");\\n  }\n  .reactnative:before {\n    content: url(\"https://files.readme.io/3e1288d-reactnative-icon.svg\\");\\n  }\n  a[href\*=http]:not([href\*=\"dev.appsflyer.com\"]):not(.landing-page__social):after {\n    display: none !important;\n  }\n</style>\n<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-android\\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-purchase-ios\\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/validate-and-log-unity\\">Unity SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a target=\"_blank\" class=\"button flutter\" href=\"https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/API.md#validatePurchaseV2\\">Flutter</a>\n  <a class=\"button reactnative\" href=\"https://dev.appsflyer.com/hc/docs/rn_api#validateAndLogInAppPurchaseV2\\">React Native SDK</a>\n  <a class=\"button cordova\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cordova-plugin/blob/master/docs/API.md#-validateandloginapppurchasev2purchasedetails-additionalparameters-successc-failurec-void\\">Cordova SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a class=\"button cocos2dx\" href=\"https://github.com/AppsFlyerSDK/appsflyer-cocos2dx-plugin?tab=readme-ov-file#-validate-and-log-20-api\\">Cocos2dx SDK</a>\n  <a class=\"button unreal\" href=\"https://github.com/AppsFlyerSDK/appsflyer-unreal-plugin/blob/master/docs/API.md#validate-and-log-in-app-purchase\\">Unreal Engine</a>\n</div>"
}
[/block]

### 2. Метод автоматической интеграции – покупка коннектора

Purchase Connector автоматически определяет покупки и подписки, сделанные на устройстве. После инициализации он отправляет необходимые данные в AppsFlyer без дополнительного регистрационного кода.

- Поддерживается только на ROI360 продуктах и рекомендуется для большинства приложений
- Проверка триггера автоматически и возвращает результат клиенту в реальном времени
- Следующие возможности не могут быть поддержаны путем простой настройки метода Validate и Log и поэтому требуют подключения к покупке:
  - Выручка от регистрации подписки от пользователей, подписавшихся до добавления интеграции.
  - Логирование изменений цены подписки, гарантируя, что доход отражает актуальные цены.

Чтобы начать видеть:

[block:html]
{
"html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-android\\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-ios\\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/purchase-connector-unity\\">Unity SDK</a>\n</div>\n<br>\n<div class=\"button-container\">\n  <a target=\"_blank\" class=\"button flutter\" href=\"https://github.com/AppsFlyerSDK/appsflyer-flutter-plugin/blob/master/doc/PurchaseConnector.md\\">Flutter</a>\n  <a class=\"button reactnative\" href=\"https://dev.appsflyer.com/hc/docs/rn_purchaseconnector\\">React Native SDK</a>\n</div>"
}
[/block]

---

> ⚠️ Важное
>
> Чтобы избежать дублирования журнала событий и непоследовательных результатов проверки, рекомендуется использовать только один метод интеграции для каждого приложения.