---
title: AppsFlyerDeepLinkResult
slug: ios-sdk-референц-appsflyerdeeplinkresult
category:
  uri: SDK AppsFlyer
parent:
  uri: ios-sdk-ссылка
privacy:
  view: публичный
---

## Общий обзор

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).
[block:api-header]
{
"title": "Properties"
}
[/block]

### глубокая ссылка

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "[`DeepLink`](doc:deeplink-1)",
"0-1": "`DeepLink`",
"0-2": "Свойство с извлеченными данными OneLink из UDL API."
},
"холод": 3,
"ряды": 1
}
[/block]

### статус

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"0-0": "`DeepLinkResultStatus`",
"0-1": "`status`",
"h-2": "Описание"
},
"холод": 3,
"ряды": 1
}
[/block]

#### Константы

[block:parameters]
{
"data": {
"h-0": "Имя",
"h-1": "Описание",
"0-0": "`AFSDKDeepLinkResultStatusNotFound`",
"1-0": "`AFSDKDeepLinkResultStatusFound`",
"2-0": "`AFSDKDeepLinkResultStatusFailure"",
    "0-1": "UDL API не находит совпадение с этим глубоким связыванием или отсрочкой глубокого нажатия на ссылку.\nМетод [`didResolveDeepLink()\`](https://dev.appsflyer.com/hc/docs/deeplinkdelegate#didresolvedeeplink) должен выйти. ,
"1-1": "UDL API нашел совпадение с этим глубоким связыванием или отсрочкой глубокого нажатия на ссылку.\nДанные глубоких ссылок OneLink находятся в [объекте DeepLink](\[http://google.com](https://dev.appsflyer.com/hc/docs/deeplink-1)) в [deepLink property](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#deeplink). ,
"2-1": "UDL API столкнулся с ошибкой при попытке найти совпадение с этой глубокой ссылкой или отложенным нажатием на ссылку, или во время извлечения данных OneLink.\nПолучить ошибку от свойства [error](https://dev.appsflyer.com/hc/docs/deeplinkresult-1#error)."
},
"холод": 2,
"ряды": 3
}
[/block]

### Ошибка

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`NSError`",
"0-1": "`error`",
"0-2": "Обнаружена ошибка при выполнении UDL."
},
"холод": 3,
"ряды": 1
}
[/block]
