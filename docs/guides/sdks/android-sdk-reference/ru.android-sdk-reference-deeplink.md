---
title: Глубокая ссылка
slug: android-sdk-референц-глубокий
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
Public class that holds the deep link data.

Вернуться к [справочному индексу SDK](doc:android-sdk-reference).
[block:api-header]
{
"title": "Методы"
}
[/block]

### getDeepLinkValue

[block:code]
{
"коды": [
{
"code": "public String getDeepLinkValue()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "Значение глубины ссылки из OneLink URL."
},
"холод": 2,
"ряды": 1
}
[/block]

### getClickHttpReferrer

[block:code]
{
"коды": [
{
"code": "public String getClickHttpReferrer()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "HTTP-реферер из OneLink идентифицирует адрес веб-страницы, которая ссылается на AppsFlyer нажмите URL. Проверяя реферера, вы можете увидеть, где был создан запрос."
},
"холод": 2,
"ряды": 1
}
[/block]

### getMediaSource

[block:code]
{
"коды": [
{
"code": "public String getMediaSource()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nИсточник медиа из OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getКампания

[block:code]
{
"коды": [
{
"code": "public String getCampaign()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем это вернет null, из-за защиты конфиденциальности UDL. \*\nКампания из OneLink. ,
"h-0": "Тип",
"h-1": "Описание"
},
"холод": 2,
"ряды": 1
}
[/block]

### getCampaignId

[block:code]
{
"коды": [
{
"code": "public String getCampaignId()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем это вернет null, из-за защиты конфиденциальности UDL. \*\nID кампании из OneLink URL. ,
"h-0": "Тип",
"h-1": "Описание"
},
"холод": 2,
"ряды": 1
}
[/block]

### getAfSub1

[block:code]
{
"коды": [
{
"code": "public String getAFSub1()",
"language": "java"
}
]
}
[/block]

#### Возврат

[block:parameters]
{
"data": {
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"h-0": "Тип",
"h-1": "Описание"
},
"холод": 2,
"ряды": 1
}
[/block]

### getAfSub2

[block:code]
{
"коды": [
{
"code": "public String getAFSub2()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getAfSub3

[block:code]
{
"коды": [
{
"code": "public String getAFSub3()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getAfSub4

[block:code]
{
"коды": [
{
"code": "public String getAFSub4()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getAfSub5

[block:code]
{
"коды": [
{
"code": "public String getAFSub5()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getClickEvent

[block:code]
{
"коды": [
{
"code": "public JSONObject getClickEvent()",
"language": "java"
}
]
}
[/block]
**Примечание:** Значения в `clickEvent` можно получить непосредственно с помощью [`getStringValue()`](https://dev.appsflyer.com/hc/docs/deeplink#getstringvalue).

\####Возвращает
[block:parameters]
{
"data": {
"h-0": "Type",
"h-1": "Описание",
"0-0": "объект JSON",
"0-1": "JSON, который держит все данные OneLink."
},
"холод": 2,
"ряды": 1
}
[/block]

### getMatchType

[block:code]
{
"коды": [
{
"code": "public String getMatchType()",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "Метод атрибуции, используемый для этого щелчка. \n\nВозможные значения:\n<ul><li>реферер (строка реферера Google Play)</li><li>id_matching</li><li>вероятностная</li><li>srn (сеть самоотчетности)</li></ul>\nВозвращено только в отсроченные глубинные сценарии соединения."
},
"холод": 2,
"ряды": 1
}
[/block]

### getStringValue

[block:code]
{
"коды": [
{
"code": "public String getStringValue(String keyName)",
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
"h-1": "Описание",
"0-0": "`String`",
"0-1": "Значение ключа в JSON."
},
"холод": 2,
"ряды": 1
}
[/block]

### отложено

[block:code]
{
"коды": [
{
"code": "public Boolean isDeferred()",
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
"h-1": "Описание",
"0-0": ""Boolean"",
"0-1": "Определяет, находился ли UDL вызов для первого запуска приложения в отсрочке глубокого потока ссылок."
},
"холод": 2,
"ряды": 1
}
[/block]
