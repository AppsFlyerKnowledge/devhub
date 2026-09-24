---
title: Результат Глубокой Связи
slug: android-sdk-референц-глубокий результат
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
DeepLinkResult является публичным классом, который держит результат операции поиска OneLink. В случае успеха она содержит глубокие данные о ссылках.

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).
[block:api-header]
{
"title": "Методы"
}
[/block]

### getDeepLink

[block:code]
{
"коды": [
{
"code": "public DeepLink getDeepLink()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Замечания",
"0-0": "[DeepLink](doc:deeplink)",
"0-1": "Объект с глубокими ссылками OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getStatus

[block:code]
{
"коды": [
{
"code": "public DeepLinkResult.Status getStatus()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Замечания",
"0-0": "Статус",
"0-1": "Эним, описывающий возможные результаты работы по извлечению данных OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getОшибка

[block:code]
{
"коды": [
{
"code": "public DeepLinkResult.Error getError()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Замечания",
"0-0": "Ошибка",
"0-1": "Заявка, описывающая возможные ошибки, которые могут возникнуть во время операции извлечения данных OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

[block:api-header]
{
"title": "Переменные"
}
[/block]

### Статус

[block:code]
{
"коды": [
{
"code": "public static enum Status",
"language": "java"
}
]
}
[/block]

#### Константы

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Замечания",
"0-0": "байт",
"0-1": "FOUND",
"0-2": "Unified Deep Linking API обнаружил совпадение с этим глубоким связыванием или отсрочкой глубокого нажатия на ссылку.\n\nГлубокие данные OneLink находятся в объекте [`DeepLink`](https://dev.appsflyer.com/hc/docs/deeplink) получен пользователем [`getDeepLink()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#getdeeplink). ,
"1-0": "байт",
"1-1": "NOT_FOUND",
"1-2": "Unified Deep Linking API не обнаружил совпадения с этой глубокой ссылкой или отсрочкой глубокого нажатия на ссылку.\n\nМетод [`onDeepLinking()`](https://dev.appsflyer.com/hc/docs/deeplinklistener#ondeeplinking) должен выйти. ,
"2-0": "байт",
"2-1": "ОШИБКА",
"2-2": "Unified Deep Linking API столкнулся с ошибкой, пытаясь найти совпадение с этим глубоким или отложенным нажатием на ссылку, или во время извлечения данных OneLink. \n\n`Get Error` enum using [`getError()`](https://dev.appsflyer.com/hc/docs/deeplinkresult#geterror) to check what error occurred."
},
"холод": 3,
"ряды": 3
}
[/block]

### Ошибка

[block:code]
{
"коды": [
{
"code": "public static enum Error",
"language": "java"
}
]
}
[/block]

#### Константы

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Замечания",
"0-0": "байт",
"1-0": "байт",
"2-0": "байт",
"3-0": "байт",
"0-1": "TIMEOUT",
"1-1": "NETWORK",
"2-1": "HTTP_STATUS_CODE",
"3-1": "UNEXPECTED",
"0-2": "Unified Deep Linking API не обнаружил отсроченных глубоких ссылок в указанный промежуток времени. ,
"1-2": "Невозможно получить доступ к сети. Не относится к AppsFlyer SDK. ,
"2-2": "Unified Deep Linking API получил ответ от сервера AppsFler, отличный от 200 (успешно). ,
"3-2": "Unified Deep Linking API обнаружил ошибку, отличную от вышеуказанных ошибок."
},
"холод": 3,
"ряды": 4
}
[/block]
