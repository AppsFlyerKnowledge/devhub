---
title: Параметры ввода
slug: прямое глубокое соединение-1
category:
  uri: SDK AppsFlyer
privacy:
  view: любой_с ссылкой
---

В следующей таблице перечислены возможные параметры OneLink можно передать как ввод.

Входная карта содержит два типа данных:

- [Данные атрибутов](https://support.appsflyer.com/hc/en-us/articles/207447163#attribution-link-parameters)
- Данные, определенные маркером в ссылке (параметры и значения)
  Параметры могут быть либо:
  - Официальные параметры AppsFlyer
  - Пользовательские параметры и значения, выбранные маркером и разработчиком.
    [block:callout]
    {
    "type": "info",
    "title": "Note",
    "body": "\* The following table is relevant for AppsFlyer **SDK 5.4.1 and above**.\n   \* Parameters may not be present or renamed in earlier SDK versions\n\* The parameters \*\*not marked as deprecated \*\* are relevant for all OneLink types:\n   \* Short URL\n   \* Long URL\n   \* All OS's links:\n      \* Android App Link\n      \* Universal Links\n      \* URL schemes (both iOS and Android)"
    }
    [/block]

[block:parameters]
{
"data": {
"h-0": "Имя параметра",
"h-1": "Тип",
"h-2": "Описание",
"h-3": "Замечания",
"0-0": "af_dp",
"0-1": "Строка",
"0-2": "URI схема URL. ,
"0-3": "Резервное копирование ссылки приложения. \nНапример: afbasicapp://mainactivity",
"1-0": "link",
"1-1": "Строка",
"1-2": "Полная ссылка, которая была использована для выполнения глубокой ссылки. ,
"1-3": "Пример: https://onelink-basic-app.onelink. /H5hv? id=Email&c=fruit_of_the_month",
"3-0": "pid (медиа источник)",
"3-1": "Строка",
"3-2": "OneLink's media source, напр. email, SMS, социальные сети. ,
"4-0": "install_time",
"4-1": "Строка",
"4-2": "Время первого запуска приложения. ,
"4-3": "**Устарел**\nПример: 2020-05-06 13:51:19",
"5-0": "схема",
"5-1": "Строка",
"5-2": "Первое слово в URL, Определяет протокол, используемый для доступа к ресурсу в Интернете. Например: **mygreatapp**://mainactivity или **https**://killerapp.onelink. e/coolactivity/H7JK",
"5-3": "**Устарел**\nНикогда не используйте `http` или `https` для схем URI",
"6-0": "хост",
"6-1": "Строка",
"6-2": "Определяет узел, который содержит ресурс. Например: mygreatapp://**mainactivity** или \nhttps://**killerapp.onelink. e**/coolactivity/H7JK",
"7-0": "path",
"7-1": "String", "String",
"7-2": "Специфичный ресурс на хосте, к которому хочет получить доступ веб-клиент. Например: https://killerapp.onelink. e/coolactivity/**H7JK**",
"7-3": "**Устаревший**\nне подходит для схем URI",
"9-0": "af_web_id",
"9-1": "Строка",
"9-2": "Токен для атрибутов на основе людей. ,
"10-0": "af_status",
"10-1": "Строка",
"10-2": "**Устарел**",
"10-3": "Только \*\*в сценарии URI",
"11-0": "af_deeplink",
"11-1": "Boolean", "Boolean",
"11-2": "**Устарело**",
"11-3": "Пройдено **только \*\* в сценарии URI",
"12-0": "c (кампания)",
"12-1": "Строка",
"12-2": "Название маркетинговой кампании. ,
"8-0": "shortlink",
"8-1": "Строка",
"8-2": "Сокращенный URL, с значительно меньшим количеством символов, чем исходная ссылка. For example: https://killerapp.onelink.me/coolactivity/H7JK/\*\*checkitout**",
"13-0": "is_retargeting",
"13-1": "Boolean",
"13-2": "Marks the link as part of a retargeting campaign.",
"14-0": "af_ios_url",
"14-1": "String",
"14-3": "Passed to Android devices as well, even when not relevant",
"14-2": "Fallback URL when deep linking fails on an iOS device.",
"15-0": "af_android_url",
"15-1": "String",
"15-2": "Fallback URL when deep-linking fails on an Android device.",
"16-0": "af_sub[1-5]",
"16-1": "String",
"16-2": "Optional custom parameter defined by the advertiser.",
"16-3": "Values set by the marketer in the AppsFlyer dashboard.\nRecommended for passing parameters relevant for in-app routing.",
"17-0": "af_adset",
"17-1": "String",
"17-2": "Adset is an intermediate level in the hierarchy between campaign and ad.",
"20-0": "af_cost_currency",
"21-0": "af_cost_value",
"22-0": "af_click_lookback",
"18-0": "af_channel",
"19-0": "af_adname",
"18-1": "String",
"19-1": "String",
"18-2": "The media source channel through which the ads are distributed. Например: UAC_Search, UAC_Display, Instagram, Facebook Audience Network и т.д.",
"19-2": "Ad name provided by the marketer/publisher. ,
"17-3": "Значение, установленное маркером в AppsFlyer's dashboard",
"23-0": "af_force_deeplink",
"23-1": "Boolean",
"23-2": "Принудительная глубокая связь с активностью, указанной в значении af_dp. ,
"23-3": "Только для iOS.\nЗначение передается Android, даже если не актуально. ,
"20-1": "Строка",
"21-1": "Строка",
"22-1": "Строка", "Строка",
"20-2": "3-буквенный код валюты, соответствующий [ISO-4217](https://support.appsflyer.com/hc/en-us/articles/207040526-Ad-cost-measurement-guide#cost-aggregation-methods). Например, USD, ZAR, EUR\n[Default]: USD",
"21-2": "Стоимость использования валюты расходов. ,
"22-2": "Настраиваемое количество дней для периода поиска клика атрибута. ,
"18-3": "Значение, установленное маркером в панели управления AppsFlyer",
"19-3": "Значение, установленное маркером в панели управления AppsFlyer",
"20-3": "Значение, установленное маркером в панели управления AppsFlyer",
"21-3": "Значение, установленное маркером в панели управления AppsFlyer",
"22-3": "Значение, установленное маркером в панели управления AppsFlyer",
"13-3": "Значение, установленное продавцом. ,
"12-3": "Значение, установленное маркером в панели управления AppsFler". ,
"6-3": "**Устарел**",
"2-0": "deep_link_value",
"2-1": "строка",
"2-2": "Имя значения для конкретного контента в приложении, к которому будут направлены пользователи."
},
"холод": 4,
"ряды": 24
}
[/block]
