---
title: Глубокая связь AppsFlyerLink
slug: ios-sdk-референц-appsflyerdeeplink
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
Public class that holds the deep link data.

Вернуться к [справочному индексу SDK](doc:ios-sdk-reference).
[block:api-header]
{
"title": "Properties"
}
[/block]

### deeplinkValue

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`NSString`",
"0-1": "`deeplinkValue`",
"0-2": "Значение глубины ссылки из OneLink URL."
},
"холод": 3,
"ряды": 1
}
[/block]

### щелкнуть по HTTPReferrer

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`NSString`",
"0-1": "`clickHTTPReferrer`",
"0-2": "HTTP-реферер из OneLink идентифицирует адрес веб-страницы, которая ссылается на AppsFlyer нажмите URL-адрес. Проверяя реферера, вы можете увидеть, где был создан запрос."
},
"холод": 3,
"ряды": 1
}
[/block]

### mediaSource

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-1": "`mediaSource`",
"0-0": "`NSString`",
"0-2": "\*\*В ближайшем будущем это вернет null, из-за защиты конфиденциальности UDL. \*\nИсточник медиа из OneLink."
},
"холод": 3,
"ряды": 1
}
[/block]

### кампания

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-1": ""кампания"",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nКампания из OneLink URL. ,
"0-0": "`NSString`"
},
"холод": 3,
"ряды": 1
}
[/block]

### кампания Id

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-1": ""campaignId`",
    "0-2": "**В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. *\nID кампании из OneLink URL. ,
    "0-0": "`NSString\`"
},
"холод": 3,
"ряды": 1
}
[/block]

### afSub1

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"0-1": "`afSub1`",
"0-0": "`NSString`"
},
"холод": 3,
"ряды": 1
}
[/block]

### afSub2

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"0-0": "`NSString`",
"0-1": "`afSub2`"
},
"холод": 3,
"ряды": 1
}
[/block]

### afSub3

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"0-1": "`afSub3`",
"0-0": "`NSString`"
},
"холод": 3,
"ряды": 1
}
[/block]

### afSub4

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"0-1": "`afSub4`",
"0-0": "`NSString`"
},
"холод": 3,
"ряды": 1
}
[/block]

### afSub5

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-2": "\*\*В ближайшем будущем, это вернет null, из-за защиты конфиденциальности UDL. \*\nПредопределенный параметр, используемый в OneLink. ,
"0-1": "`afSub4`",
"0-0": "`NSString`"
},
"холод": 3,
"ряды": 1
}
[/block]

### событие клика

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`NSDictionary<NSString*, id>`",
"0-1": "`clickEvent`",
"0-2": "Возвращает словарь, который содержит все данные OneLink."
},
"cols": 3,
"rows": 1
}
[/block]
If the OneLink URL contains any of the following keys, they will appear in `clickEvent`:

- `deep_link_sub1`
- `deep_link_sub2`
- `deep_link_sub3`
- `deep_link_sub4`
- `deep_link_sub5`
- `deep_link_sub6`
- `deep_link_sub7`
- `deep_link_sub8`
- `deep_link_sub9`
- `deep_link_sub10`

### тип совпадений

[block:parameters]
{
"data": {
"0-0": "`NSString`",
"0-1": "`matchType`",
"0-2": "Метод атрибуции, используемый для этого щелчка. \n\nВозможные значения:\n<ul><li>реферер (строка реферера Google Play)</li><li>id_matching</li><li>вероятностная</li><li>srn (сеть самоотчетности)</li></ul>\nВозвращается только в отсроченные глубинные сценарии. ,
"h-2": "Описание",
"h-1": "Имя",
"h-0": "Тип"
},
"холод": 3,
"рядов": 1
}
[/block]

### отложено

[block:parameters]
{
"data": {
"h-0": "Тип",
"h-1": "Имя",
"h-2": "Описание",
"0-0": "`bool`",
"0-1": "`isDeferred`",
"0-2": "Определяет, находился ли UDL вызов для первого запуска приложения в отсрочке глубокого потока ссылок."
},
"холод": 3,
"ряды": 1
}
[/block]
