---
title: Представитель AppsFlyerLibDelegate
slug: ios-sdk-референц-appsflyerlibdelegate
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

[block:api-header]
{
"title": "Overview"
}
[/block]
Протокол расширения AppDelegate. Задерживает метод обратного вызова для OneLink устаревших API и атрибута.

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

**Протокол**
[block:code]
{
"codes": [
{
"code": "extension AppDelegate: AppsFlyerLibDelegate {\n     \n    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {\n    . .\n    }\n    \n    func onConversionDataFail(_ error: Error) {\n    ...\n    }\n    \n    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {\n    . .\n    }\n    \n    func onAppOpenAttributionFailure(_ ошибка: Ошибка) {\n    . .\n    }\n}\n",
"язык": "swift"
}
]
}
[/block]

[block:api-header]
{
"title": "Public methods"
}
[/block]

### onAppOpenAttribution

**Описание**
Получайте данные для пользователей, когда приложение открывает через глубокие прямые ссылки (не через отсроченные глубокие ссылки).
Узнайте больше о `onAppOpenAttribution()` для [iOS](https://dev.appsflyer.com/docs/direct-deep-linking#implementing-onappopenattribution-logic).

**Method signature**
[block:code]
{
"codes": [
{
"code": "func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {\n\t\t//Обработка данных Deep Link\n}",
"Язык": "swift"
},
{
"code": "(void) onAppOpenAttribution:(NSDictionary\*) attributionData {\n\t\t//Обработать Глубокую связь\n\t}",
"Язык": "Цель"
}
]
}
[/block]

### onConversionDataУспешно

**Описание**

Получить данные о преобразовании после установки. Полезно для отложенных глубоких связей.
Узнайте больше о `onConversionDataSuccess()` для [iOS](https://dev.appsflyer.com/hc/docs/dl_ios_ocds_ddl#implementation).

**Method signature**
[block:code]
{
"codes": [
{
"code": "func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {\n\t  //Обработать данные о преобразованиях (отложенные Deep Link)\n}",
"Язык": "swift"
},
{
"код": "-(void)onConversionDataSuccess:(NSDictionary\*) installData {\n\t  //Обработка данных преобразования (отложенные глубины соединения)\n}",
"Язык": "Цель"
}
]
}
[/block]

### onAppOpenAttributionFailure

**Описание**

Обрабатывайте ошибки при сбое получения данных о преобразовании из установок.
Узнайте больше о `onAppOpenAttributionFailure()` для [iOS](https://dev.appsflyer.com/docs/direct-deep-linking#implementing-onappopenattributionfailure-logic).

**Method signature**
[block:code]
{
"codes": [
{
"code": "func onAppOpenAttributionFailure(_ error: Error? ",
"язык": "swift"
},
{
"code": "- (void)onAppOpenAttributionFailure:(NSError \*)error; ,
"Язык": "Цель"
}
]
}
[/block]

### onConversionDataОшибка

**Описание**

Обрабатывайте ошибки при сбое получения данных о преобразовании из установок.
Подробнее о `onConversionDataFail()` для [iOS](https://dev.appsflyer.com/docs/deferred-deep-linking#implementing-onconversiondatafailure-logic).

**Method signature**
[block:code]
{
"codes": [
{
"code": "func onConversionDataFail(_ error: Error?) {\n\t\t// print(\"\\(error)\")\n\t\t// обрабатываем сбои данных преобразования\n}",
"Язык": "swift"
},
{
"code": "-(void)onConversionDataFail:(NSError \*) {\n\t  NSLog(@\"%@\", rror);\n\t  // обработка сбоев с преобразованием данных\n}",
"Язык": "Цель"
}
]
}
[/block]

### выполнить OnAppAttribution

**Описание**

Позволяет разработчикам вручную перезапускать onAppOpenAttribution и разрешать разработчикам доступ к глубоким данным ссылок в любое время без подключения к процессу запуска приложения. Это может потребоваться, потому что регулярный обратный вызов onAppOpenAttribution вызывается только **если приложение было открыто глубокой ссылкой**.

**Method signature**
[block:code]
{
"codes": [
{
"code": "AppsFlyerLib. hared(). erformOnAppAttribution(с: url) ",
"язык": "swift"
},
{
"code": "[[AppsFlyerLib shared] performOnAppAttributionWithURL:(NSURL \* _Nullable)url]; ",
"Язык": "Цель"
}
]
}
[/block]
