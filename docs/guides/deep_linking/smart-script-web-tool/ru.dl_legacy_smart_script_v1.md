---
title: '[Legacy] умный скрипт OneLink V1'
slug: dl_legacy_smart_script_v1
category:
  uri: Глубокая связь и OneLink
parent:
  uri: smart-script-web-tool
privacy:
  view: публичный
---

**На взгляд**: Настройте OneLinks, которые автоматически создаются и вставляются за кнопкой или баннером на сайте вашего бренда. **Примечание**: Несмотря на то, что переход на [OneLink Smart Script V2](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator).
[block:image]
{
"images": [
{
"image": [
"https://files.readme.io/2b7e970-7901_Smart_Script_flow_1920x1080_2_1. ng",
"7901 Smart Script flow 1920x1080 2 (1). ng",
1920,
1080,
"#ecf2f8"
]
}
]
}
[/block]

[block:embed]
{
"html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Ffast.wistia.net%2Fembed%2Fiframe%2Fpeqytyburo&display_name=Wistia%2C+Inc.&url=https%3A%2F%2Fappsflyer.wistia.com%2Fmedias%2Fpeqytyburo&image=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2F446f0c0ae9fe8b40f83c9151d39cdd7f.jpg%3Fimage_crop_resized%3D960x540&key=f2aa6fc3595946d0afc3d76cbbd25dc3&type=text%2Fhtml&schema=wistia\" width=\"960\" height=\"540\" scrolling=\"no\" title=\"Wistia, Inc. embed\" frameborder=\"0\" allow=\"autoplay; fullscreen\" allowfullscreen=\"true\"></iframe>",
"url": "https://appsflyer.wistia. om/medias/peqytyburo",
"title": "OneLink_Smart_Script_Tech deep dive [Q4 2020]",
"favicon": "https://appsflyer. istia.com/favicon.ico",
"image": "https://embed-ssl.wistia.com/deliveries/446f0c0ae9fe8b40f83c9151d39cdd7f.jpg?image_crop_resized=960x540"
}
[/block]

[block:api-header]
{
"title": "About OneLink Smart Script"
}
[/block]
Users arrive at your mobile website before reaching your app store page, either organically, or via advertising campaigns. Однако поскольку есть два клика (первый, который направляет на веб-страницу и второй, который направляется с веб-страницы в магазин приложений), метрика конвертации кликов и глубокая связь проблематичны.

OneLink Smart Script решает эти проблемы. Скрипт:

- Использует входящие URL, ведущие на веб-страницу, для автоматической генерации уникальных исходящих OneLink, ведущих в магазин приложений.
- Обеспечивает точную сбор метрик веб-приложения для всех источников мультимедиа.
- Может использоваться для глубокой привязки.
- Работает легко на любой веб-странице или целевой странице.
  [block:api-header]
  {
  "title": "Процедуры"
  }
  [/block]
  Для настройки Smart Script, следующий список действий по проверке процедур должен быть завершен.
  [block:parameters]
  {
  "data": {
  "h-0": "checklist",
  "0-0": "1. Импортируйте скрипт на ваш сайт.",
  "1-0": "2. Инициализация объекта Smart Script [OneLinkUrlGenerator](doc:onelinkurlgenerator) с параметрами и значениями.",
  "2-0": "3. [Optional] Выполнить наборы с дополнительными параметрами и значениями.",
  "3-0": "4. Генерировать URLs."
  },
  "холод": 1,
  "ряды": 4
  }
  [/block]

### Импортировать скрипт

**Для импорта скрипта на ваш сайт**:

1. [Скачать скрипт](https://github.com/AppsFlyerSDK/appsflyer-onelink-smart-script/blob/main/v1/scripts/onelink-smart-script.js).
2. Импортируйте его в мобильный сайт/страницы, на которых вы хотите запускать.

### Инициализация скрипта

**Для инициализации скрипта**:

1. Получить от маркера: параметры/значения, которые должен содержать исходящий OneLink URL (на основе того, что содержится в входящем URL). Подробности в таблице ниже.
2. Инициализация объекта Smart Script [`OneLinkUrlGenerator`](doc:onelinkurlgenerator), используя аргументы (параметры).
   [block:parameters]
   {
   "data": {
   "h-0": "Параметры",
   "h-1": "Тип",
   "h-2": "Функциональность",
   "h-3": "Пример",
   "0-0": "oneLinkURL [required]",
   "1-0": "Список ключей",
   "2-0": "Список pidOverrideist",
   "3-0": "pidStaticValue",
   "4-0": "Список кампаний",
   "5-0": "campaignStaticValue",
   "6-0": "gclIdParam",
   "0-1": "строка",
   "1-1": "Список строк",
   "2-1": "словарь {string: строка,\n…}",
   "3-1": "string",
   "4-1": "Список строк",
   "5-1": "строка",
   "6-1": "строка", "строка",
   "0-2": "- Серверы в качестве базы для всех ссылок, сгенерированных скриптом.\n- это домен шаблона OneLink + ID шаблона.",
   "0-3": "yourbrand.onelink.me/A1b2\nПример домена бренда: клик. ourbrand. ом/А1b2",
   "1-2": "- Список параметров источника медиа в входящем URL, который будет помещен в качестве параметра pid в исходящем URL.\n- Если в входящей ссылке есть несколько параметров источника мультимедиа (например, af_pid и utm_source), pidKeysList сканирует параметры от первого к последнему и использует первую игру. ,
   "2-2": "Список значений источника мультимедиа во входящем URL, наряду с тем, что вы хотите, чтобы они были заменены. ,
   "1-3": "['af_pid', 'utm_source']",
   "4-3": "['af_campaign', 'utm_campaign']",
   "3-3": "- 'веб-сайт'\n- 'landing_page'",
   "2-3": "{\n                      'twitter': 'twitter_int',\n                      'snapchat': 'snapchat_int',\n                      'some_social_net': 'some_social_net_int'\n                     }",
   "3-2": "Если ключ pid не найден в списке pidKeysList, значение pidStaticValue используется в качестве значения pid. ,
   "4-2": "Список параметров кампании в входящем URL-адресе, который будет помещен в качестве параметра c в исходящем URL. ,
   "5-2": "Если ключ кампании не найден в campaignKeysList, в качестве значения c используется кампанияStaticValue . ,
   "5-3": "- 'веб-сайт'\n- 'landing_page'",
   "6-2": "- Определяет параметр исходящего URL несет GCLID. \n- можно выбрать любой параметр. **Примечание!** Для отображения в отчётах AppsFlyer параметр должен быть одним из af_sub[1-5]. ,
   "6-3": "'af_sub5'",
   "7-0": "skipList",
   "7-1": "string",
   "7-2": "Если в HTTP-реферере появляется строки, то Smart Script возвращает `null`. ,
   "7-3": "- "[‘facebook’, ‘twitter’]'\n- Facebook по умолчанию находится в списке."
   },
   "холод": 4,
   "ряды": 8
   }
   [/block]

### Запустить сеттеры

**Для запуска установщиков**:

1. Получить от маркера: Любые другие параметры и значения, которые должен содержать исходящий OneLink URL (на основе того, что содержится в входящем URL).
2. Запустите установщики, используя следующий шаблон:
   [block:code]
   {
   "codes": [
   {
   "code": "onelinkGenerator. et[parameter](\"value\", \"Необязательное статическое значение\"); ,
   "язык": "javascript"
   }
   ]
   }
   [/block]
   Например:
   [block:code]
   {
   "коды": [
   {
   "код": "onelinkGenerator. etAfSub1(\"original_url_sub1\", \"ram_afsub1\"); ,
   "язык": "javascript"
   }
   ]
   }
   [/block]

### Генерировать URL

**Для генерации исходящих OneLink адресов**:

- Запустите метод generateUrl на странице HTML, вызывающей скрипт.
  Возможные возвращаемые значения:
  - Исходящий URL Onelink
  - Null. Если скрипт возвращает null, существующий URL веб-страницы не изменяется.
    [block:api-header]
    {
    "title": "Examples"
    }
    [/block]

### Базовый атрибут

**Входящий URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/basic_url.html?af_c=gogo&af_pid=email

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa. nelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source'],\n         список кампаний: ['incoming_campaign']\n      });\n      const url = onelinkGenerator. enerateUrl();",
"Язык": "javascript",
"name": null
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=email&c=gogo&af_js_web=true

### Параметры UTM

**Входящий URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/utm_params.html?utm_source=email&utm_campaign=summer_sale

**Script**:
[block:code]
{
"codes": [
{
"code": "onst onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source', 'utm_source'],\n         список кампаний: ['incoming_campaign', 'utm_campaign']\n      });\n      const url = onelinkGenerator. enerateUrl();",
"Язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=email&c=summer_sale&af_js_web=true

### PID и статические значения кампании

**Входящий URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/static_val.html?af_not_c=gogo&af_not_pid=email

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source'],\n         pidStaticValue: 'my_static_pid',\n         список кампаний: ['incoming_campaign'],\n         StaticValue: 'my_static_cmpn',\n      });\n      const url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=my_static_pid&c=my_static_cmpn&af_js_web=true

### Переопределить PID

**Incoming URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/override_pid.html?af_pid=twitter&af_c=big_social

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source'],\n         campaignKeysList: ['incoming_campaign'],\n         pidOverrideList: { twitter: 'twitter_out',\n                            снимк: 'snapchat_out'\n                          }\n      });\n      const url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=twitter_out&c=big_social&af_js_web=true

### Проход Google Click ID в af_sub

**Incoming URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/gclid.html?af_pid=sms&af_c=candles&gclid=1a2b3c

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source'],\n         список кампаний: ['incoming_campaign'],\n         gclIdParam: 'af_sub4'\n      });\n      const url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=google_lp&c=candles&af_js_web=true&af_sub4=1a2b3c

### Задать параметры OneLink

Чтобы создать длинную ссылку, которая будет использоваться для глубокой связи, вы можете передать как пользовательские параметры, так и предопределенные параметры. Смотрите функции передачи параметров в приведенном ниже примерном скрипте.

**Для передачи пользовательского параметра:**

- Вызовите функцию `setCustomParameter`.
  `setCustomParameter` принимает три аргумента:
  1. [Mandatory] Ключ входящего URL, с которого скрипт принимает значение для исходящего URL.
  2. [Mandatory] Ключ, который будет указан в исходящей ссылке.
  3. [Optional] Статическое резервное значение, если ключ в первом аргументе не найден в URL.

Если ключ в первом аргументе не найден, и статический резерв не определен, параметр пропущен.

**Для передачи предопределенного параметра**

- Вызывает следующую функцию(я) образца скрипта (за исключением `setCustomParameter`).
  Каждая функция принимает два аргумента:
  1. [Mandatory] Ключ входящего URL, с которого скрипт принимает значение для исходящего URL.
  2. [Optional] Статическое резервное значение, если ключ в первом аргументе не найден в URL.

Если ключ в первом аргументе не найден, и статический резерв не определен, параметр пропущен.

**Входящий URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/setters.html?af_c=gogo&af_pid=email

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n        {oneLinkURL: "https://engmntqa. nelink. e/LtRd/",\n         pidKeysList: ['incoming_media_source'],\n         список кампаний: ['incoming_campaign']\n      });\n      onelinkGenerator. etDeepLinkValue("original_url_deeplinkvalue", "yesss");\n      onelinkGenerator.setChannel("original_url_channel", "new_channel");\n      onelinkGenerator. etAdset("no_adset", "adset");\n      onelinkGenerator.setAd("original_url_ad", "new_ad");\n      onelinkGenerator. etAfSub1("original_url_sub1", "ram_afsub1");\n      onelinkGenerator. etAfSub2("original_url_sub2");\n      onelinkGenerator.setAfSub3("no_sub3", "new_afsub3");\n      onelinkGenerator. etAfSub4("original_url_sub4");\n      onelinkGenerator. etAfSub5 ("neverfind_sub5", "new_afsub5");\n      onelinkGenerator.setCustomParameter("original_url_fruit_name", "onelink_my_custom_param", "apples");\n      const url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa.onelink.me/LtRd/?pid=email&c=gogo&af_js_web=true&deep_link_value=yesss&af_channel=new_channel&af_adset=adset&af_ad=new_ad&af_sub1=ram_afsub3&afsub5=new_afsub3&afsub5=new_afsub5&onelink_my_custom_param=apples

### Установка дополнительных параметров атрибутов

Вы можете создать длинную ссылку с дополнительными параметрами. Смотрите функции передачи параметров в приведенном ниже примерном скрипте.

**Чтобы добавить параметр атрибута:**

- Вызовите функцию `setCustomParameter`.
  `setCustomParameter` принимает три аргумента:
  1. [Mandatory] Ключ параметра атрибуции в входящем URL, с которого скрипт принимает значение, установленное в исходящем URL.
  2. [Mandatory] Ключ параметра атрибуции, который будет указан в исходящем URL.
  3. [Optional] Статическое резервное значение, если ключ в первом аргументе не найден в URL.

Если ключ в первом аргументе не найден, и статический резерв не определен, параметр пропущен.

**Incoming URL**:
https://appsflyersdk.github.io/appsflyer-onelink-smart-script/v1/examples/set_af_params.html?af_c=gogo&af_pid=email&partner_name=bigagency

**Скрипт**:
[block:code]
{
"codes": [
{
"code": "onelinkGenerator. etCustomParameter(\"incoming_site_id\", \"af_siteid\", \"defaultSiteID\"); ,
"язык": "javascript"
}
]
}
[/block]
**Исходящий URL**:
https://engmntqa. nelink.me/LtRd/?pid=email&c=gogo&af_js_web=true&af_siteid=defaultSiteID

### Пропустить клики из Twitter или Facebook

Вы можете отключить Smart Script для определенного клика (например, из Twitter или Facebook), создав пропущенный список. Если одна из строк в пропущенном списке появится в HTTP-реферере клика, Smart Script возвращает `null`.

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n      {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n        pidKeysList: ['original_pid'],\n        кампания KeysList: ['original_campaign'],\n        Список: ['twitter', 'facebook']\n    });\nconst url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]

### Не пропускать клики

Вы можете убедиться, что OneLink Smart Script работает для всех щелчков и никогда не пропускает ни один из них, передавая пустой список пропусков.

**Script**:
[block:code]
{
"codes": [
{
"code": "const onelinkGenerator = новое окно. F.OneLinkUrlGenerator(\n      {oneLinkURL: "https://engmntqa.onelink. e/LtRd/",\n        pidKeysList: ['original_pid'],\n        список кампаний: ['original_campaign'],\n        Список: []\n    });\nconst url = onelinkGenerator. enerateUrl();",
"язык": "javascript"
}
]
}
[/block]
