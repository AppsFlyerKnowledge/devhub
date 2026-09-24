---
title: Смарт-скрипт для кросс-платформенной
slug: create-direct-click-url
category:
  uri: Глубокая связь и OneLink
parent:
  uri: smart-script-web-tool
privacy:
  view: публичный
---

Smart Script может создавать OneLinks, которые перенаправляют пользователей на немобильные магазины, где они могут загружать, устанавливать или покупать ПК, CTV или консольные приложения.

## Этапы осуществления

### Создать URL-адрес прямого клика

Чтобы создать прямой URL-адрес, выполните следующие действия:

1. [Скачать Smart Script](https://onelinksmartscript.appsflyer.com/onelink-smart-script-latest.js).
2. Получите аргументы для вызова скрипта, сопоставляя входящие параметры с параметрами маркера.
3. Инициализация Smart Script[arguments](#arguments) и [Конфигурации](https://dev.appsflyer.com/hc/hc/docs/onelink-smart-script-v2web-to-app-url-generator#configuration-object) как и в следующем примере:

   ```jsx
   var mediaSource = { keys: ["my_media_source"], defaultValue: "my_default_media_source" };

   var campaign = { keys: ["my_campaign"], defaultValue: "my_default_campaign" };
   ```
4. Сгенерируйте URL, вызвав скрипт на вашей веб-странице или целевой странице HTML, используя следующий метод:

   ```jsx
    var result = window.AF_SMART_SCRIPT.generateDirectClickURL({
      afParameters: afParameters,
      platform: platform.platformName,
      app_id: platform.appid,
      redirectURL: platform.redirectURL,
   })
   ```
5. Проверьте возвращаемое значение в `result`. Возможные возвращаемые значения:

   - Исходящий прямой URL (`https://engagements.appsflyer.com`). Примеры дополнительных прямых ссылок см. на демо-странице ниже. Например, используйте значение «результат», чтобы поместить его в качестве ссылки под вызов действия (CTA) на вашем сайте.
   - Значение «null». Если скрипт возвращает `null`, выполните вашу обработку ошибок. Например, когда существующий URL веб-страницы или целевой страницы не меняется.

   Например:

   ```javascript
    //В имитации Smart Script аргументы
    // Если источник медиа НЕ НАЙДЕНО на ссылке и значение NO по умолчанию, скрипт возвращает null string 
    var mediaSource = {keys: ["my_media_source"], defaultValue: "my_default_media_source"};
    var кампания = {keys: ["my_campaign"], defaultValue: "my_default_campaign"};

    //Вызов функции после ее встраивания код будет через глобальный параметр в окне окна. F_SMART_SCRIPT
    //Onelink URL генерируется

    var результат = window.AF_SMART_SCRIPT. enerateDirectClickURL({
      afParameters:{
        mediaSource: mediaSource,
        кампания: кампания
      }, Платформа
      : 'steam',
      app_id: '123456',
      redirectURL:'https://store. teampowered.com/app/123456/Team_Fortress_2/'
    })

    var result_url = "Нет вывода из скрипта"
    if (result) {
      result_url = result. lickURL;            
   }
   ```

   Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/direct_click.html?incmp=gogo&inmedia=new_source) преобразование входящего URL-адреса в исходящий щелчок URL для игры Steam.

> 📘 Заметка
>
> Чтобы убедиться, что входящие URL параметры будут сопоставлены с генерируемым исходящим URL, рекомендуется импортировать Smart Script на каждой странице сайта, будь то исходящий URL генерируется на странице или нет.
>
> Для получения дополнительной информации и полного примера смотрите[here](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#preserve-incoming-url-parameters-across-pages).

### Создайте QR-код с результатом Smart Script

Чтобы создать QR-код с результатом Smart Script, см. [here](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#create-a-qr-code-with-the-smart-script-result).

### Пожарное впечатление

To fire an impression, see [here](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#impressions----onelink-template-with-cross-platform-support)

## Аргументы

[block:html]
{
"html": "<table class=\"table--hover table--striped table--color-header unsortable\" style=\"height: 532px; width: 842px;\">\n  <thead>\n    <tr style=\"height: 40px;\">\n      <th style=\"width: 272.312px;\" colspan=\"2\">Argument</th>\n      <th style=\"width: 291.5px; height: 40px;\">Remarks</th>\n      <th style=\"width: 268.188px; height: 40px;\">Example</th>\n    </tr>\n  </thead>\n  <tbody>    \n    <tr style=\"height: 19px;\">\n      <td style=\"width: 119.953px;\" rowspan=\"6\">\n        <p>afParameters</p>\n        <p>(required)</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 133.359px; height: 19px;\">\n        <p>mediaSource</p>\n        <p>(required)</p>\n      </td>\n      <td style=\"width: 283.5px; height: 19px;\">\n        <p>Configuration object for media source</p>\n      </td>\n      <td style=\"width: 260.188px; height: 19px;\">\n        <ul>\n          <li>Keys: ['incoming_mediasource’' 'utm_source']</li>\n          <li>\n            Override values: {twitter: 'twitter_int', orig_src: 'new_src'}\n          </li>\n          <li>Default value: ['any_source']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 40px;\">\n      <td style=\"width: 133.359px; height: 40px;\">\n        <p>campaign</p>\n      </td>\n      <td style=\"width: 283.5px; height: 40px;\">\n        <p>Configuration object for campaign</p>\n      </td>\n      <td style=\"width: 260.188px; height: 40px;\">\n        <ul>\n          <li>Keys: ['incoming_campaign', 'utm_campaign']</li>\n          <li>Override values: {campaign_name: 'new_campaign_name'}</li>\n          <li>Default value: ['any_campaign_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 133.359px;\">\n        <p>channel</p>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <p>Configuration object for channel</p>\n      </td>\n      <td style=\"width: 260.188px;\">\n        <ul>\n          <li>Keys: ['incoming_channel', 'utm_channel']</li>\n          <li>Override values: {video: 'new_video'}</li>\n          <li>Default value: ['any_video']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <p>ad</p>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <p>Configuration object for ad</p>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>Keys: ['incoming_ad', 'utm_ad']</li>\n          <li>Override values: {ad_name: 'new_ad_name'}</li>\n          <li>Default value: ['any_ad_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 62px;\">\n      <td style=\"width: 133.359px; height: 62px;\">adSet</td>\n      <td style=\"width: 283.5px; height: 62px;\">\n        <p>Configuration object for adset</p>\n      </td>\n      <td style=\"width: 260.188px; height: 62px;\">\n        <ul>\n          <li>Keys: ['incoming_adset', 'utm_adset']</li>\n          <li>Override values: {'adset_name': 'new_adset_name'}</li>\n          <li>Default value: ['any_adset_name']</li>\n        </ul>\n      </td>\n    </tr>      \n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <span style=\"font-weight: 400;\">Other (custom) query parameters</span><span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <ul>\n          <li>\n            List of any other parameters you want to be included in the\n            outgoing OneLink URL for attribution or deep linking, along\n            with their configuration objects.\n          </li>\n          <li>\n            The name of the custom parameter is listed by the developer\n            as <code>paramKey</code> in the configuration object.\n          </li>\n        </ul>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>paramKey: 'deep_link_sub1'</li>\n          <li>Keys: ['page_id']</li>\n          <li>Override values: {page12: 'new_page12'}</li>\n          <li>Default value: 'page1'</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">platform</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        A string describes the platform. MUST be from this list:\n        <ul><li>smartcast</li>        \n        <li>tizen</li>\n        <li>roku</li>\n        <li>webos</li>\n        <li>vidaa</li>\n        <li>playstation</li>\n        <li>android</li>\n        <li>ios</li>\n        <li>steam</li>\n        <li>quest</li>\n        <li>battlenet</li>\n         <li>nativepc</li>\n         <li>epic</li>\n          <li>switch</li></ul>\n      </td>\n      <td style=\"width: 260.188px;\">\"steam\"</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">app_id</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span> Application ID</span>\n      </td>\n      <td style=\"width: 260.188px;\">\"123456\"</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">redirectURL</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span> The URL the user will be redirected</span>\n      </td>\n      <td style=\"width: 260.188px;\">\"https://store.steampowered.com/app/123456/Team_Fortress_2/\\"</td>\n    </tr>\n  </tbody>\n</table>"
}
[/block]

## Целевая страница игры демо

Вы можете найти здесь полнофункциональную [демо страницу](https://appsflyersdk.github.io/appsflyer-sample-app-smartscript-demo-page/), которая демонстрирует интеграцию `generateDirectClickURL` [Smart Script code](https://github.com/AppsFlyerSDK/appsflyer-sample-app-smartscript-demo-page/blob/master/index.html#L340-345).

