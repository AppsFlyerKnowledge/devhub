---
title: OneLink Smart Script V2
slug: dl_smart_script_v2
category:
  uri: Глубокая связь и OneLink
parent:
  uri: smart-script-web-tool
privacy:
  view: публичный
---

**На взгляд**: Настройте OneLinks, которые автоматически создаются и вставляются за кнопкой или баннером на сайте вашего бренда.

[block:tutorial-tile]
{
"backgroundColor": "#018FF4",
"emoji": "🦉",
"id": "62bd963f6f466b00926ab69f",
"link": "https://dev.appsflyer.com/v0. /recipes/smart-script-quick-start-single-key",
"slug": "smart-script-quick-start-single-key",
"title": "Smart Script Quick Start - Single Key"
}
[/block]

[block:embed]
{
"html": "<iframe class=\"embedly-embed\" src=\"//cdn.embedly.com/widgets/media.html?src=https%3A%2F%2Ffast.wistia.net%2Fembed%2Fiframe%2F9sx58ic0e3&display_name=Wistia%2C+Inc.&url=https%3A%2F%2Fappsflyer.wistia.com%2Fmedias%2F9sx58ic0e3&image=https%3A%2F%2Fembed-ssl.wistia.com%2Fdeliveries%2F36d0dbecf1b69f6898d748446b91153fb897c467.jpg%3Fimage_crop_resized%3D640x360&key=f2aa6fc3595946d0afc3d76cbbd25dc3&type=text%2Fhtml&schema=wistia\" width=\"640\" height=\"360\" scrolling=\"no\" title=\"Wistia, Inc. embed\" frameborder=\"0\" allow=\"autoplay; fullscreen\" allowfullscreen=\"true\"></iframe>",
"url": "https://appsflyer.wistia. om/medias/9sx58ic0e3",
"title": "smart_script_v2",
"favicon": "https://appsflyer.wistia.com/favicon.ico",
"image": "https://embed-ssl. istia.com/deliveries/36d0dbecf1b69f6898d748446b91153fb897c467.jpg?image_crop_resized=640x360",
"provider": "appsflyer.wistia.com",
"href": "https://appsflyer.wistia.com/medias/9sx58ic0e3"
}
[/block]

## О OneLink Smart Script

OneLink Smart Script использует входящие URL, ведущие к веб-странице для автоматической генерации уникальных исходящих адресов OneLink, ведущих в магазин приложений.

Исходящие URL-адреса создаются с помощью [arguments](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#arguments), которые вы получаете от маркетинга и ввод в скрипт. **Примечание**: У аргумента `afParameters` есть структура, состоящая из нескольких аргументов (параметров), каждый из которых содержит [файл конфигурации](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#configuration-object), который имеет клавиши, значения переопределения и значение по умолчанию.

## Этапы осуществления

Чтобы настроить умный скрипт, вы можете:

### Встроить скрипт на свой сайт

Инициализация Smart Script и телефонный код могут быть получены от генератора Smart Script на панели AppsFlyer (**рекомендуется**), или импортирован и вызван вручную разработчиком.

> 📘 Сохранить входящие параметры URL
>
> Чтобы убедиться, что входящие URL параметры будут сопоставлены со сгенерированным OneLink, рекомендуется импортировать Smart Script на каждой странице сайта, будь то OneLink генерируется на странице или нет.
>
> Доступно с версии 2.5.0.
>
> Подробнее и полный пример [here](https://dev.appsflyer.com/hc/docs/dl_smart_script_v2#preserve-incoming-url-parameters-across-pages).

#### Использовать код, созданный генератором Smart Script

1. Загрузите файл из маркера, включающего скрипт, код инициализации и аргументы.
2. Проверьте скрипт на [Smart Script test page](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/test_page.html). Убедитесь, что создается правильный исходящий адрес.
3. Следуйте [test and use Smart Script result instruction](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#check-and-use-smart-script-result).

[См. пример интеграции в Github](https://github.com/AppsFlyerSDK/appsflyer-onelink-smart-script/blob/main/examples/generator_integration.html)

#### Ручная настройка скрипта

1. Скачать [скрипт](https://onelinksmartscript.appsflyer.com/onelink-smart-script-latest.js) или [минимизированную версию](https://onelinksmartscript.appsflyer.com/onelink-smart-script-latest-minified.js).
2. Получить аргументы для вызова скрипта, который сопоставляет входящие параметры исходящим параметрам с маркера.
3. Инициализация Smart Script [arguments](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#arguments) и [Конфигурации](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#configuration-object).
4. Сгенерировать URL, вызвав скрипт на странице web/landing HTML, используя следующий метод:

```javascript
var result = window.AF_SMART_SCRIPT.generateOneLinkURL({
  oneLinkURL,
  afParameters,
  referrerSkipList, // optional
  urlSkipList // необязательный
})
```

5. Следуйте [test and use Smart Script result instruction](https://dev.appsflyer.com/hc/docs/onelink-smart-script-v2web-to-app-url-generator#check-and-use-smart-script-result).

#### Проверить и использовать Smart Script результат

1. Проверьте возвращаемое значение в `result`. Возможные возвращаемые значения:
   - Исходящий Onelink URL. При необходимости используйте значение результата. Например, поместить его как ссылку под CTA на ваш сайт.
   - `null`. Если скрипт возвращает `null`, реализует желаемый поток ошибок. Например: существующий URL-адрес веб-страницы не изменился.

```javascript
      var result_url = "Нет вывода из скрипта"
      if (result) {
            result_url = result. lickURL;            
            // Поместите генерируемый OneLink URL позади CTA кнопки
            документа. etElementById('andrd_link'). etAttribute('href', result_url);
            document.getElementById('ios_link'). etAttribute('href', result_url);
            // Необязательно - Создать QR-код из созданного окна OneLink URL
            . F_SMART_SCRIPT. isplayQrCode("my_qr_code_div_id");
            //Размер QR-кода определен в CSS файле #my_qr_code_div_id
            // #my_qr_code_div_id canvas { 
            // height: 200px;
            // ширина: 200px;
            //}
            // Необязательно - впечатление.
            // Поразительное впечатление приведёт к https://impressions.onelink. e//.... 
            setTimeout(() => {
              окно. F_SMART_SCRIPT.fireImpressionsLink();
              консоли. og("Импрессия запущена"); 
            }, 1000);
}
```

### Использовать Google Tag Manager

Чтобы настроить Smart Script в Google Tag Manager:

1. Confirm that the marketer followed their [instructions](https://support.appsflyer.com/hc/en-us/articles/4413588932241#set-up-onelink-smart-script) and placed the Smart Script code into GTM.
2. Проверьте возвращаемое значение в `AF_SMART_SCRIPT_RESULT`. Возможные возвращаемые значения:
   - Исходящий OneLink URL. При необходимости используйте значение результата. Например, поместить его как ссылку под CTA на ваш сайт.
   - `null`. Если скрипт возвращает `null`, реализует желаемый поток ошибок. Например: существующий URL-адрес веб-страницы не изменился.

```javascript
      var result_url = AF_SMART_SCRIPT_RESULT. lickURL;
      if (result_url) {
            document. etElementById('andrd_link').setAttribute('href', result_url);
            документ. etElementById('ios_link'). etAttribute('href', result_url);
            // Необязательно - создание QR-кода из созданного окна OneLink URL
            . F_SMART_SCRIPT. isplayQrCode("my_qr_code_div_id");
            //Размер QR-кода определен в CSS файле #my_qr_code_div_id
            // #my_qr_code_div_id canvas { 
            // высота: 200px;
            // ширина: 200px;
            //}
            // Необязательно - впечатление.
            // Пожар будет подстрекаться к https://impressions.onelink. e//.... 
            setTimeout(() => {
              окно. F_SMART_SCRIPT.fireImpressionsLink();
              консоли. og("Огонь впечатления"); 
            }, 1000);            
}
```

3. Проверьте скрипт на [Smart Script test page](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/test_page.html). Убедитесь, что создается правильный исходящий адрес.

### Создайте QR-код с результатом Smart Script

**Требование**: умный скрипт V2.6+

> 📘 передовые методы
>
> - Настройте QR-код в соответствии с вашим брендом приложения с логотипом центра и подходящим цветом кода
> - Показывать QR-код, когда пользователи находятся на рабочем столе и показывать кнопку со ссылкой, когда пользователи находятся на мобильном устройстве

**Чтобы создать QR-код**:

1. Создайте тег div с конкретным идентификатором в HTML странице вашего сайта, чтобы разместить QR-код.  
   Вы можете стилизовать тег div однако вы хотите.
2. После запуска Smart Script и генерации OneLink URL вызовите следующий метод `displayQrCode`

#### `displayQrCode`

***

**Метод подписи**

```javascript
const qrOptions = {
  logo,
  colorCode
}

window.AF_SMART_SCRIPT.displayQrCode(divId, qrOptions)
```

**Input arguments**

| Тип      | Mandatory | Наименование | Описание                                                                                     | Комментарий                                                            |
| :------- | :-------- | :----------- | :------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------- |
| `Строка` | Да        | `divID`      | Тег `div` с конкретным идентификатором в HTML странице вашего сайта, чтобы разместить QR-код |                                                                        |
| `Объект` | Нет       | `qrOptions`  | Объект конфигурации (см. подробности в таблице ниже)      | Если объект отсутствует, QR-код будет создан без логотипа по умолчанию |

**`qrOptions` объект**

| Тип      | Mandatory | Наименование | Описание                                             | Комментарий                                                                   |
| :------- | :-------- | :----------- | :--------------------------------------------------- | :---------------------------------------------------------------------------- |
| `Строка` | Нет       | `logo`       | Допустимый URL-адрес изображения или URI изображения | Если значение неверно, QR-код будет сгенерирован без логотипа                 |
| `Строка` | Нет       | `colorCode`  | Hex цвет QR-кода                                     | Если значение неверно, код цвета будет возвращен к черному цвету по умолчанию |

**Примеры использования:**

- _QR-код без логотипа и без пользовательского цвета_ [пример Github](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/qr_code.html?incmp=gogo&inmedia=email)
- _QR-код с логотипом и пользовательским цветом_ [пример Github ](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/qr_code_logo_color.html?incmp=gogo&inmedia=email)

### Пожарное впечатление

Вы можете создать впечатление, когда загружается страница, CTA или баннер и т.д. **Примечание**: Впечатления можно запускать только на мобильных устройствах, а не на рабочем столе.

**Требование**: Smart Script V2.2+

**Чтобы произвести впечатление**:

1. Следуйте инструкциям для запуска Smart Script и создания URL-адреса щелчка.
2. Убедитесь, что результат действителен (и не нулевый).
3. Выполнить функцию впечатления:

> 🚧 Должно сделать обход
>
> Пожалуйста, оберните вызов `fireImpressionsLink` с `setTimeout`, чтобы убедиться, что между вызовом `generateOneLinkURL` и `fireImpressionsLink` есть хотя бы одна секунда

```javascript
setTimeout(() => {
  window.AF_SMART_SCRIPT.fireImpressionsLink();
  console.log("Импрессия"); 
}, 1000);
```

Вы можете найти примеры показов [только для мобильного](#impressions---onelink-template-with-mobile-only-support) и [кроссплатформенной поддержки](#impressions---onelink-template-with-cross-platform-support)

## Аргументы

[block:html]
{
"html": "<table class=\"table--hover table--striped table--color-header unsortable\" style=\"height: 532px; width: 842px;\">\n  <thead>\n    <tr style=\"height: 40px;\">\n      <th style=\"width: 272.312px;\" colspan=\"2\">Argument</th>\n      <th style=\"width: 291.5px; height: 40px;\">Remarks</th>\n      <th style=\"width: 268.188px; height: 40px;\">Example</th>\n    </tr>\n  </thead>\n  <tbody>\n    <tr style=\"height: 19px;\">\n      <td style=\"width: 264.312px;\" colspan=\"2\">oneLinkURL (required)</td>\n      <td style=\"width: 283.5px; height: 19px;\">\n        <ul>\n          <li>\n            Provide the OneLink template domain + template ID.\n            <strong>Note: </strong>Not a OneLink custom link URL!\n          </li>\n        </ul>\n      </td>\n      <td style=\"width: 260.188px; height: 19px;\">\n        <ul>\n          <li>\n            <strong>yourbrand.onelink.me/A1b2</strong>\n          </li>\n          <li>\n            Branded domain example: <strong>click.yourbrand.com/A1b2</strong>\n          </li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 19px;\">\n      <td style=\"width: 119.953px;\" rowspan=\"9\">\n        <p>afParameters</p>\n        <p>(required)</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <p>&nbsp;</p>\n        <span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 133.359px; height: 19px;\">\n        <p>mediaSource</p>\n        <p>(required)</p>\n      </td>\n      <td style=\"width: 283.5px; height: 19px;\">\n        <p>Configuration object for media source</p>\n      </td>\n      <td style=\"width: 260.188px; height: 19px;\">\n        <ul>\n          <li>Keys: ['incoming_mediasource’' 'utm_source']</li>\n          <li>\n            Override values: {twitter: 'twitter_int', orig_src: 'new_src'}\n          </li>\n          <li>Default value: ['any_source']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 40px;\">\n      <td style=\"width: 133.359px; height: 40px;\">\n        <p>campaign</p>\n      </td>\n      <td style=\"width: 283.5px; height: 40px;\">\n        <p>Configuration object for campaign</p>\n      </td>\n      <td style=\"width: 260.188px; height: 40px;\">\n        <ul>\n          <li>Keys: ['incoming_campaign', 'utm_campaign']</li>\n          <li>Override values: {campaign_name: 'new_campaign_name'}</li>\n          <li>Default value: ['any_campaign_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 133.359px;\">\n        <p>channel</p>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <p>Configuration object for channel</p>\n      </td>\n      <td style=\"width: 260.188px;\">\n        <ul>\n          <li>Keys: ['incoming_channel', 'utm_channel']</li>\n          <li>Override values: {video: 'new_video'}</li>\n          <li>Default value: ['any_video']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <p>ad</p>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <p>Configuration object for ad</p>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>Keys: ['incoming_ad', 'utm_ad']</li>\n          <li>Override values: {ad_name: 'new_ad_name'}</li>\n          <li>Default value: ['any_ad_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 62px;\">\n      <td style=\"width: 133.359px; height: 62px;\">adSet</td>\n      <td style=\"width: 283.5px; height: 62px;\">\n        <p>Configuration object for adset</p>\n      </td>\n      <td style=\"width: 260.188px; height: 62px;\">\n        <ul>\n          <li>Keys: ['incoming_adset', 'utm_adset']</li>\n          <li>Override values: {'adset_name': 'new_adset_name'}</li>\n          <li>Default value: ['any_adset_name']</li>\n        </ul>\n      </td>\n    </tr>\n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">deepLinkValue</td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <p>\n          Configuration object for <code>deep_link_value</code>\n        </p>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>Keys: ['product_id', 'page_name']</li>\n          <li>Override values: {twenty_percent_off: 'thirty_percent_off'}</li>\n          <li>Default value: 'new_offers_page'</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"width: 133.359px;\">afSub1-5</td>\n      <td style=\"width: 283.5px;\">\n        <p>\n          Configuration object for <code>af_sub[1-5]</code>\n        </p>\n      </td>\n      <td>&nbsp;</td>\n    </tr>\n    <tr style=\"height: 40px;\">\n      <td style=\"width: 133.359px; height: 39px;\">googleClickIdKey</td>\n      <td style=\"width: 283.5px; height: 39px;\">\n        <p>\n         Smart Script automatically maps the incoming <a href=\"https://support.google.com/google-ads/answer/9744275?hl=en\\" target=\"_blank\" rel=\"noopener\">GCLID</a> parameter value to the outgoing GCLID parameter: <code>gclid={gclid}</code>.<br>\n          <strong>Заметка</strong>!\n          <span style=\"font-weight: 400;\">для отображения в отчётах AppsFlyer параметр должен быть одним из <strong>af_sub[1-5]</strong>.</span>\n        </p>\n      </td>\n      <td style=\"width: 260.188px; height: 39px;\">&nbsp;</td>\n    </tr>\n    <tr style=\"height: 83px;\">\n      <td style=\"width: 133.359px; height: 83px;\">\n        <span style=\"font-weight: 400;\">Other (custom) query parameters</span><span style=\"font-weight: 400;\"><br></span>\n      </td>\n      <td style=\"width: 283.5px; height: 83px;\">\n        <ul>\n          <li>\n            List of any other parameters you want to be included in the\n            outgoing OneLink URL for attribution or deep linking, along\n            with their configuration objects.\n          </li>\n          <li>\n            The name of the custom parameter is listed by the developer\n            as <code>paramKey</code> in the configuration object.\n          </li>\n        </ul>\n      </td>\n      <td style=\"width: 260.188px; height: 83px;\">\n        <ul>\n          <li>paramKey: 'deep_link_sub1'</li>\n          <li>Keys: ['page_id']</li>\n          <li>Override values: {page12: 'new_page12'}</li>\n          <li>Default value: 'page1'</li>\n        </ul>\n      </td>\n    </tr>\n    <tr>\n      <td colspan=\"2\">\n        <span style=\"font-weight: 400;\">&nbsp;</span><br>\n        <span style=\"font-weight: 400;\">referrerSkipList</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        List of the strings in the HTTP referrer for a particular click (for\n        example Twitter or Meta ads) that if found, cause the Smart Script\n        to return <code>null</code>. Это может быть полезно для SRN, таких как Twitter\n        и мета-рекламы, за клики по которым уже сообщается.\n      </td>\n      <td style=\"width: 260.188px;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">urlList</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span>Список строк в URL для определенного клика (например, <code>af_r</code>), что если найдено, вызывает возврат умного скрипта&nbsp;</span><code><span>null</span></code><span>. This can be useful if you use an AppsFlyer attribution link with af_r to redirect users to your mobile website, and don't want data from the original click to be lost.</span>\n      </td>\n      <td style=\"width: 260.188px;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">webReferrer</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span>Этот аргумент определяет ключ исходящего URL, , значение которого будет являться копией документа HTTP <code>. более поздние</code>. The referrer is saved in the first page the user lands in, and may be used in any consecutive page in this domain which runs Smart Script with this argument.</span>\n      </td>\n      <td style=\"width: 260.188px;\">&nbsp;</td>\n    </tr>\n    <tr>\n      <td style=\"width: 119.953px;\" colspan=\"2\">\n        <span style=\"font-weight: 400;\">SEO (опционально)</span>\n      </td>\n      <td style=\"width: 283.5px;\">\n        <span>При включении, и медиа-источник не разрешен из параметра URL, Умный скрипт проверяет, прибыл ли пользователь из поисковой системы на основе URL веб-реферера, и устанавливает источник медиа соответственно. (Доступно из версии 2.0. )</span>\n      </td>\n      <td style=\"width: 260.188px;\">\n        <ul>\n          <li>SEO: true</li>\n        </ul>\n      </td>\n    </tr>\n  </tbody>\n</table>"
}
[/block]

## Конфигурация объекта

Смарт-скрипт OneLink использует аргументы для генерации исходящего URL-адреса, основанного на параметрах входящего URL-адреса и аргументах, указанных в скрипте. Аргумент "Параметры" имеет структуру, состоящую из нескольких других аргументов (параметров), используемых для атрибуции и глубокой привязки, каждый из которых содержит конфигурационный объект, имеющий клавиши, значения переопределения и значение по умолчанию, как описано в следующей таблице.

[block:html]
{
"html": " <table class=\"table--hover table--striped table--color-header unsortable\" style=\"height: 301px;\">\n        <thead>\n          <tr style=\"height: 40px;\">\n            <th style=\"width: 147.969px; height: 40px;\">Аргумент</th>\n            <th style=\"width: 283.359px; height: 40px;\">Описание</th>\n            <th style=\"width: 200.172px; height: 40px;\">Пример</th>\n          </tr>\n        </thead>\n        <tbody>\n          <tr style=\"height: 223px;\">\n            <td style=\"width: 139.969px; height: 223px;\">клавиши</td>\n            <td style=\"width: 275.359px; height: 223px;\">\n              <ul>\n                <li>Список строк</li>\n                <li>\n                  <span>Список возможных параметров в входящем URL страницы, значение которого помещается в качестве значения исходящего URL-адреса.</span>\n                </li>\n                <li>\n                  Скрипт ищет слева направо и останавливает\n                  при первом матче.\n                </li>\n              </ul>\n            </td>\n            <td style=\"width: 192.172px; height: 223px;\">\n              <ul>\n                <li>Пример: ['in_channel', 'utm_channel']</li>\n                <li>\n                  Для параметра канала в скрипте, Скрипт\n                  ищет входящую ссылку для in_channel\n                  и использует значение в качестве значения для канала.\n                </li>\n              </ul>\n            </td>\n          </tr>\n          <tr style=\"height: 19px;\">\n            <td style=\"width: 139.969px; height: 19px;\">\n              <p>перезаписывает значения</p>\n            </td>\n            <td style=\"width: 275.359px; height: 19px;\">\n              <ul>\n                <li>словарь {string: string}</li>\n                <li>\n                  <span>Для значений в исходящей ссылке, список значений входящего URL-адреса, а также их замену.</span>\n                </li>\n                <li>\n                  The script replaces the param values of the incoming\n                  URL with the values you define.&nbsp;\n                </li>\n              </ul>\n            </td>\n            <td style=\"width: 192.172px; height: 19px;\">\n              <p>Example: {'video': 'video_new'}</p>\n              <p>\n                For the channel parameter in the script, anytime\n                the incoming value is video, the script changes it\n                to video_new on the outgoing link.\n              </p>\n            </td>\n          </tr>\n          <tr style=\"height: 19px;\">\n            <td style=\"width: 139.969px; height: 19px;\">defaultValue</td>\n            <td style=\"width: 275.359px; height: 19px;\">\n              <ul>\n                <li>String</li>\n                <li>\n                  <span>State what you want your \"fallback\" value to be.</span>\n                </li>\n                <li>\n                  <span>Если параметр не найден из вашего списка ключей, значение по умолчанию используется в исходящем URL-адресе.</span>\n                </li>\n                <li>\n                  <span>Вы можете принудительно задать значение по умолчанию, передав пустой список ключей.</span>\n                </li>\n              </ul>\n            </td>\n            <td style=\"width: 192.172px; height: 19px;\">\n              <p>Пример: ['web_video']</p>\n              <p>\n                Для параметра канала в скрипте, если у вас есть\n                параметр in_channel не найден, web_video в качестве значения канала используется\n                .\n              </p>\n            </td>\n          </tr>\n        </tbody>\n      </table>"
}
[/block]

## Примеры

### Базовый атрибут

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/single_key.html?incmp=gogo&inmedia=email) основного преобразования входящего URL в исходящий OneLink, с одним ключом для media_source и кампании

### Несколько клавиш

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/multiple_keys.html?incmp11=gogo11&inmedia22=email22) преобразование входящего URL в исходящий OneLink с несколькими ключами для media_source и кампании.

### Параметры UTM

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/utm_parameters.html?utm_campaign=mycmpn&utm_source=mysource) преобразование входящего URL-адреса в исходящий OneLink с параметрами UTM для media_source и кампании.

### Переопределить значения

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/override_mediasource.html?inmedia=old_value) преобразование входящего URL-адреса в исходящий OneLink, заменив входящее значение media_source.

### Значения по умолчанию

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/override_mediasource.html?inmedia_found=orig_media_value) преобразование входящего URL-адреса в исходящий OneLink, использование значения по умолчанию, когда входящее значение media_source не найдено.

### Принудительные значения по умолчанию

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/forced_default_values.html?inmedia_found=plain_media_source) преобразование входящего URL-адреса в исходящий OneLink, значение по умолчанию, даже если обнаружено входящее значение media_source.

### GBRAID и WBRAID

Смотрите[example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/google_gbraid.html?inmedia=email&gbraid=1a2b3c) преобразование входящего URL-адреса в исходящий OneLink, передавая параметр `gbraid` и [другой пример](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/google_wbraid.html?inmedia=email&wbraid=7hjy89) для передачи параметра `wbraid`.

### Пропуск идентификатора клика Google

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/google_clickid.html?inmedia=email&gclid=1a2b3c&keyword=sale%2Bboat) преобразование входящего URL-адреса в исходящий OneLink, который передает идентификатор клика Google в `af_sub4` и `gclid`.
Начиная с версии 2.8.1 Smart Script GCLID автоматически пересылается на исходящий URL при присутствии входящего URL.
**Примечание:** Когда обнаружен GCLID, скрипт ищет входящий параметр `keyword`, и добавляет его значение в исходящий URL в качестве значения параметра `af_keywords`.

### Пропуск идентификатора клика Facebook

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/facebook_clickid.html?inmedia=email&fbclid=7hjy89) преобразование входящего URL-адреса в исходящий OneLink, который передает идентификатор клика Facebook в `af_sub2` и `fbclid`.
Начиная с версии 2.8.1 Smart Script FBCLID автоматически пересылается на исходящий URL при наличии входящего URL.

### TikTok, X (прежний Twitter), Проход Snap клика ID

Начиная с версии 2.10.0 Smart Script, следующие параметры идентификатора клика при наличии автоматически пересылаются на исходящие URL, сгенерированные Smart Script:

- TikTok: `ttclid`
- X (ранее Twitter): `twclid`
- Снапс: `ScCid`

### Установить атрибуты и параметры OneLink

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/onelink_parameters.html?inmedia=email&dp_dest=apples&inchnl=this_channel&promo=buy99) преобразование входящего URL в исходящий OneLink с атрибутом AppsFlyer и параметрами OneLink.

### Установить дополнительные пользовательские параметры

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/onelink_custom_parameters.html?inmedia=email&dp_dest=apples&pageid=2g4f&productid=shirt12&partner=bigagency) преобразование входящего URL в исходящий OneLink с дополнительными пользовательскими параметрами.

### Список пропущенных рефереров

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/referrer_skip_list.html?incmp=gogo&inmedia=email) о том, как можно отключить Smart Script для того или иного клика (например, из Twitter или мета рекламы), создав пропущенный список. Если одна из строк в пропущенном списке появится в HTTP-реферере клика, Smart Script возвращает `null`.

### Список URL пропущенных

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/url_skip_list.html?incmp=gogo&inmedia=email&af_r=hotel.me) о том, как отключить Smart Script для определенной строки в URL (например, `af_r`), создав список пропусков. Если одна из строк в списке пропусков появится в URL клика, Smart Script возвращает `null`.

### Smart Script настроен с помощью Google Tag Manager

См. [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/google_tag_manager.html?my_source=email&app_dest=planes&typeid=b787&msg_id=f7h8) преобразование входящего URL в исходящий OneLink URL с помощью OneLink Smart Script настроен с помощью Google Tag Manager.

### Впечатления - OneLink шаблон с поддержкой только для мобильных устройств

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/impressions_mobile.html?incmp=gogo&inmedia=email) показов, запущенных с помощью шаблона OneLink, который имеет только мобильное устройство.

> 🚧 Должно сделать обход
>
> Пожалуйста, оберните вызов `fireImpressionsLink` с `setTimeout`, чтобы убедиться, что между вызовом `generateOneLinkURL` и `fireImpressionsLink` есть хотя бы одна секунда

### Впечатления - OneLink шаблон с межплатформенной поддержкой

Смотрите [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/impressions_cross_platform.html?incmp=gogo&inmedia=email) показов, запущенных с помощью шаблона OneLink, который поддерживает кросс-платформенную поддержку.  
Например, впечатление уволено с немобильной платформы (например рабочий стол или консоль).

> 📘 Создание впечатления от кросс-платформенной целевой страницы
>
> Вы можете найти здесь [пример кода](https://github.com/AppsFlyerSDK/appsflyer-sample-app-smartscript-demo-page/blob/8c0b6e7385b3b0cedd1208a530f002438a336e76/index.html#L241-L244) для создания впечатления с [демо-страницы](https://appsflyersdk.github.io/appsflyer-sample-app-smartscript-demo-page/)

> 🚧 Должно сделать обход
>
> Пожалуйста, оберните вызов `fireImpressionsLink` с `setTimeout`, чтобы убедиться, что между вызовом `generateOneLinkURL` и `fireImpressionsLink` есть хотя бы одна секунда

### Сохранять входящие параметры URL между страницами

> 📘
>
> Доступно с версии 2.5.0.

Входящие параметры (например, `utm_source`) с целевой страницы по умолчанию не передаются на другие страницы.  
Импорт Smart Script на каждой странице сайта сохраняет параметры входящего URL-адреса и позволяет Smart Script использовать их на других страницах.

Вы можете найти здесь [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/save_params_demo/save_params_demo_home.html?utm_source=my_source&utm_channel=my_channel) этого варианта использования.

### Скопировать HTTP реферер в исходящий URL

> 📘
>
> Доступно с версии 2.7.0.

Вы можете установить Smart Script для копирования HTTP `document.referrer` в пользовательский параметр исходящего URL-адреса или предопределенные параметры исходящего URL-адреса. Если вы хотите видеть значения веб-рефереров в панели управления или в необработанных отчетах, мы рекомендуем использовать один из следующих **предварительных** параметров исходящего URL:

- `af_channel` - параметр доступен в приборных панелях и необработанных данных
- `af_sub1-5` - Параметр доступен в сырых данных в колонках **af_sub1-5** и в **исходном URL**.

Если вы хотите задать пользовательский параметр, Smart Script должен скопировать `документ. Значение свойства eferrer` и установить его как значение параметра. В этом [example](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/webreferrer.html?utm_source=my_source&utm_channel=my_channel) Smart Script копирует значение `document.referrer` в пользовательский ключ параметра исходящего URL, определяемый `webReferrer`. Выбранный пользовательский ключ в примере `this_referrer`.

Дополнительную информацию см. [сопоставление веб-рефереров](https://support.appsflyer.com/hc/en-us/articles/4413588932241-OneLink-Smart-Script-V2-setup#web-referrer-mapping).

### Использование локального хранилища для установки параметров для глубокой связи

Вы можете выбрать сохранение любых данных с сайта на локальное хранение, и затем настроить Smart Script для получения этих данных и присвоить ему параметр исходящего URL-адреса. Например, вы можете использовать информацию о сайте для динамического заполнения параметра `deep_link_value`, что позволяет глубокие ссылки пользователей непосредственно на контент приложения.

В [этом примере](https://appsflyersdk.github.io/appsflyer-onelink-smart-script/examples/key_from_local_storage.html?incmp11=gogo11&inmedia22=email22) вы можете увидеть, как исходящий URL `deep_link_value` заполняется значением, скопированным из локального хранилища сайта. В данном примере скопированным значением является идентификатор продукта, получаемый с данных веб-сайта.
