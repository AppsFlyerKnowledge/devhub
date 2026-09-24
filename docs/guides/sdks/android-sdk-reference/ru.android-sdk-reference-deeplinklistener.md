---
title: Глубокий слушатель
slug: android-sdk-референц-глубокий слушатель
category:
  uri: SDK AppsFlyer
parent:
  uri: android-sdk-reference
privacy:
  view: публичный
---

[block:api-header]
{
"title": "Overview"
}
[/block]
`DeepLinkListener` является публичным интерфейсом, который содержит метод обратного вызова для [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).

[block:api-header]
{
"title": "Public Methods"
}
[/block]

### onDeepLinking

Функция обратного вызова для onDeepLinking в [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl) API.
[block:code]
{
"коды": [
{
"code": "public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult)",
"Язык": "java"
}
]
}
[/block]

[block:api-header]
{
"title": "Параметры"
}
[/block]

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Замечания",
"0-0": "`DeepLinkResult`",
"0-1": "`deepLinkResult`",
"0-2": "Объект с результатом операции поиска OneLink и данными DeepLink."
},
"холод": 3,
"ряды": 1
}
[/block]
