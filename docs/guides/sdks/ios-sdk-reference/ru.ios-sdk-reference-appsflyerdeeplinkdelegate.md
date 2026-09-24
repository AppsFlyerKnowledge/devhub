---
title: AppsFlyerDeepLinkDelegate
slug: ios-sdk-референц-appsflyerdeeplinkdelegate
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
Протокол расширения AppDelegate. Задерживает метод обратного вызова для [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl).

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).

**Протокольная декларация**
[block:code]
{
"коды": [
{
"code": "extension AppDelegate: DeepLinkDelegate {\n     \n    func didResolveDeepLink(_ result: DeepLinkResult) {\n    ….\n    }    \n}\n",
"Язык": "swift"
}
]
}
[/block]

[block:api-header]
{
"title": "Public methods"
}
[/block]

### didResolveDeepLink

**Method signature**
[block:code]
{
"codes": [
{
"code": "- (void)didResolveDeepLink:(AppsFlyerDeepLinkResult \*_Nonnull)result; ,
"язык": "swift"
}
]
}
[/block]
**Описание**
`didResolveDeepLink(_ результат:)` является функцией обратного вызова onDeepLinking в [Unified Deep Linking](https://dev.appsflyer.com/hc/docs/unified-deep-linking-udl) API.

**Параметры Callback**
[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`didResolveDeepLink`",
"0-1": "`result`",
"0-2": "Объект, который держит результат операции извлечения OneLink, и данные DeepLink (или ошибка, если она произошлась".
},
"холод": 3,
"ряды": 1
}
[/block]
