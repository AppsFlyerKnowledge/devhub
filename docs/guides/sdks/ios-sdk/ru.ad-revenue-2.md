---
title: Доход от рекламы
slug: ad-revenue-2
category:
  uri: SDK AppsFlyer
parent:
  uri: in-app-events-ios-6
privacy:
  view: публичный
position: 3
---

## Рекомендовано

[block:html]
{
"html": "<style>\n  . ontainerBox {\n    справа: 0;\n    дисплей: flex;\n    justify-content: flex-start;\n    border-radius: 10px;\n    Отступ: 20px 10px;\n    Отступ: 50px;\n    пинг-топ: 10px;\n  }\n . jButton {\n    padding: 8px 16px;\n    border-radius: 4px;\n    декорация текста: нет;\n    цвета: белый;\n    вес шрифта: 600;\n   \tкурсора: указатель;\n    границы: нет;\n    фоновый цвет: rgb(3, 109, 235) ! mportant;\n  }\n  \n  . jButton:hover {\n  \tbackground-color: #0360ce !important;\n    переход: 0. s;\n  }\n</style>\n\n<div class=\"containerBox\">\n  <img src=\"https://dj.dev.appsflyer.com/images/DJ_illustratration.svg\\" style=\"width: 120px; margin: 0 0; margin-right: 20px\">\n  <div>\n  \n      <h3>\n        Мы рекомендуем использовать наш мастер интеграции SDK\n    </h3>\n      <button onclick=\"window.open('https://dj.dev.appsflyer.com/?sourceos=ios&utm_source=devhub&utm_medium=adrevenue-ios-sdk');gtag('event', 'click', {'event_category': 'DJ_Banner', 'event_label': 'DJ_ios_adrevenue', 'value': '1'});\" target=\"_blank\" class=\"djButton\">\n      Давайте пойдем\n      </button>\n  </div>\n</div>\n"
}
[/block]

Приложение посылает данные о доходах приложению AppsFlyer SDK. После этого SDK отправляет его в AppsFlyer. Эти данные впечатлений собираются и обрабатываются в AppsFlyer, и доход присваивается первоначальному источнику UA. To learn more about ad revenue see [here](https://support.appsflyer.com/hc/en-us/articles/217490046#connect-to-ad-revenue-integrated-partners).

Есть два способа для SDK генерировать рекламный доход в зависимости от вашей SDK версии. Используйте правильный метод для вашей версии SDK:

- [SDK 6.15.0 и выше](#log-ad-revenue-for-sdk-6150-and-above). Использует рекламный доход SDK API.
- [SDK 6.14.2 и ниже](#log-ad-revenue-for-sdk-6146-and-below). Использует рекламный разъем SDK.

## Доход от журнала объявлений (для SDK 6.15.0 и выше)

Когда появляется впечатление о доходах при вызове метода [`logAdRevenue`](doc:ios-sdk-reference-appsflyerlib#logadrevenue) с подробными данными о доходах.

> 📘 Заметка
>
> Если вы используете коннектор AdRevenue, пожалуйста, удалите его перед тем, как переключиться на новый метод `logAdRevenue`. Если это не сделано, это может привести к неожиданному поведению.

**Для реализации метода:**

1. Создайте экземпляр [`AFAdRevenueData`](doc:ios-sdk-reference-appsflyerlib#afadrevenuedata) с подробной информацией о доходах для регистрации.
2. Если вы хотите добавить дополнительные детали к событию выручки, то заполните словарь парой ключевого значения.
3. Вызовите метод `logAdRevenue` со следующими аргументами:
   - Объект `AFAdRevenueData`, который вы создали в шаге 1.
   - Словарь с дополнительными деталями, созданными в шаге 2.

### Пример кода

```swift
импортируйте AppsFlyerLib


пусть my_adRevenueData = AFAdRevenueData(monetizationNetwork: "ironsource",
                        mediationNetwork: MediationNetworkType. oogleAdMob,
                        currencyIso4217Code: "USD",
                        доход от событий: 0. 015)
        
var my_additionalParameters: [String: Any] = [:]
my_additionalParameters[kAppsFlyerAdRevenueCountry] = "US"
my_additionalParameters[kAppsFlyerAdRevenueAdType] = "Баннер"
my_additionalParameters[kAppsFlyerAdRevenueAdUnit] = "89b8c0159a50ebd1"
my_additionalParameters[kAppsFlyerAdRevenuePlacement] = "place"

AppsFlyerLib. hared().logAdRevenue(my_adRevenueData, дополнительные параметры: my_additionalParameters)
```

## [LEGACY] Доход от журнала объявлений (для SDK 6.14.6 и ниже)

Чтобы интегрировать разъем рекламы iOS, необходимо импортировать, инициализировать и запустить SDK.

### Импорт дохода от iOS объявлений SDK

1. В вашем подфайле, укажите следующее:
   [block:code]
   {
   "codes": [
   {
   "code": "pod 'AppsFlyer-AdRevenue'",
   "язык": "текст",
   "name": "Подфайл"
   }
   ]
   }
   [/block]
   **Важно**: Если у вас есть `AppsFlyerFramework` под в вашем подфайле, удалите его, чтобы избежать столкновения.

2. Запустить обновление под

### Инициализировать доход от рекламы iOS

- В «AppDelegate» методе «didFinishLaunchingWithOptions», вызвать метод AdRevenue [`start`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#start), используя следующий код:
  [block:code]
  {
  "коды": [
  {
  "код": "import AppsFlyerLib\nimport AppsFlyerAdRevenue\n\n@UIApplicationMain\nclass AppDelegate: UIResponder, UIApplicationDelegate {\n  \n\n    func application(_ приложение: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication. aunchOptionsKey: любой]?) -> Bool {\n       AppsFlyerAdRevenue. tart()\n    }\n\n     @objc func applicationDidBecomeActive() {\n        AppsFlyerLib. hared(). tart()        \n    }\n\n}",
  "Язык": "swift"
  }
  ]
  }
  [/block]

### Запустить вызов logAdRevenue API

- Запустите [`logAdRevenue`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue-1#logadrevenue) API, вызывающий все допустимые впечатления, включая обязательные и опциональные аргументы.

```swift
let adRevenueParams:[AnyHashable: Any] = [
                    kAppsFlyerAdRevenueCountry : "US",
                    kAppsFlyerAdRevenueAdUnit : "02134568",
                    kAppsFlyerAdRevenueAdType : "Баннер",
                    kAppsFlyerAdRevenuePlacement : "place",
                    "foo" : "testcustom",
                    "bar" : "testcustom2"
                ]
                
AppsFlyerAdRevenue. hared().logAdRevenue(
    monetizationNetwork: "facebook",
    mediationNetwork: MediationNetworkType. oogleAdMob,
    eventRevenue: 0.026,
    revenueВалюта: "USD",
    дополнительных параметров: adRevenueParams)
```
