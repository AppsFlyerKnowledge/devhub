---
title: Смарт-баннер OneLink V2
slug: dl_smart_banner_v2
category:
  uri: Глубокая связь и OneLink
parent:
  uri: Smart-banner-web-инструмент
privacy:
  view: публичный
position: 1
---

## **Обзор**

AppsFlyer предоставляет Smart Banner SDK, который рекламодатели интегрируются в свои сайты. Цель SDK - извлечь все необходимые данные для динамического отображения смарт-баннеров. Smart Banners SDK также автоматически строит ссылки для атрибутов, так что вам не нужно создавать их вручную.

Поэтому **Smart Banner SDK должен быть доступен со всех страниц, отображающих ваши мобильные баннеры.**

Smart Banner SDK аутентифицируется, используя уникальный **Web ключ**, который вы можете получить с [места работы с сайтом](https://support.appsflyer.com/hc/en-us/articles/360000764837#1-website-setup).

Чтобы установить смарт-баннеры или смарт-баннеры и PBA на вашем сайте, выполните следующие действия:

1. Выберите фрагмент кода
2. Вставить фрагмент кода на сайт

## Выберите фрагмент кода

Выберите сниппет, который соответствует вашему регистру и требованиям безопасности.

- **Только для смарт-баннеров**: используйте это, если вы хотите отображать смарт-баннеры на вашем сайте без персональных атрибутов.
- **Смарт-баннеры с использованием персональных атрибутов (PBA)**: используйте это для отображения умных баннеров и измерения поездок пользователей на разных платформах.

### Только смарт-баннеры

Вы можете выбрать один из двух сниппетов умных баннеров:

- **Стандарт**: Стандартная интеграция.
- **Расширенная проверка SDK**: Расширенная интеграция, добавляющая защиту цепи поставок для Web SDK. Используйте это, чтобы добавить дополнительный уровень безопасности от компрометации CDN, угона DNS и атаки человека в середину.

> **Важно!**
> Если вы переходите от стандартной Web SDK к Advanced SDK верификации, замените существующий сниппет на новый. Не добавляйте новый сниппет поверх существующего.

#### **Standard code snippet**

```jsx
<script>
!function(t,e,n,s,a,c,i,o,p){t.AppsFlyerSdkObject=a,t.AF=t.AF|function(){
(t.AF.q=t.AF.q||[]).push([Date.now()].concat(Array.prototype.slice.call(arguments))},
t.AF.id=t.AF.id||i,t.AF.plugins={},o=e.createElement(n),p=e.getElementsByTagName(n)[0],o.async=1,
o.src="https://websdk.appsflyersdk.com?"+(c.length>0?").sort().join(",")+" ength>0?"af_id="+i:""),
p.parentNode. nsertBefore(o,p)}(window,document,"script",0,"AF","banners",{banners: {key: ">>>>>YOUR_WEB_KEY<<<"}});
// Умные баннеры по умолчанию устанавливаются в значение z-index, поэтому элементы сайта не будут скрыты. Это может быть изменено, если вы хотите, чтобы некоторые компоненты сайта были поверх баннера.
AF('баннеры', 'showBanner');
</script>
```

#### **Расширенная проверка SDK**

```jsx
<script>
  // Queue — buffers AF() calls until the SDK is ready
  window.AppsFlyerSdkObject = "AF";
  window.AF = window.AF || function() {
    (window.AF.q = window.AF.q || []).push([Date.now()].concat(Array.prototype.slice.call(arguments)));
  };
  window.AF.id = window.AF.id || { banners: { key: "YOUR_BANNER_KEY" } };
  window.AF.plugins = {};

  // Manifest loader config
  window.AF_LOADER_CONFIG = {
    baseUrl: "https://websdk.appsflyersdk.com",
    plugins: ["banners"]
  };

  // Inject manifest loader
  var loaderScript = document.createElement("script");
  loaderScript.src = "https://websdk.appsflyersdk.com/manifestLoader.v1.js";
  loaderScript.integrity = "sha384-Uncl2YwvjFpFz0PwEfl3bL/0JsOQcDFEpwXHzcN0MBavn9vvFEx5pZxADTq8h+CV";
  loaderScript.crossOrigin = "anonymous";
  loaderScript.async = true;
  document.head.appendChild(loaderScript);
  // Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner.
  AF('banners', 'showBanner');
</script>
```

#### Умные баннеры и персональные атрибуты (PBA)

Вы можете выбрать между двумя смарт-баннерами и сниппетами PBA

- **Стандарт**: Стандартная интеграция.
- **Расширенная проверка SDK**: Расширенная интеграция, добавляющая защиту цепи поставок для Web SDK. Используйте это, чтобы добавить дополнительный уровень безопасности от компрометации CDN, угона DNS и атаки человека в середину.

> **Важно!**
> Если вы переходите от стандартной Web SDK к Advanced SDK верификации, замените существующий сниппет на новый. Не добавляйте новый сниппет поверх существующего.

#### Стандартный фрагмент кода

```jsx
<script>
!function(t,e,n,s,a,c,i,o,p){t.AppsFlyerSdkObject=a,t.AF=t.AF||function(){
(t.AF.q=t.AF.q||[]).push([Date.now()].concat(Array.prototype.slice.call(arguments)))},
t.AF.id=t.AF.id||i,t.AF.plugins={},o=e.createElement(n),p=e.getElementsByTagName(n)[0],o.async=1,
o.src="https://websdk.appsflyersdk.com?"+(c.length>0?"st="+c.split(",").sort().join(",")+"&":"")+(i.length>0?"af_id="+i:""),
p.parentNode.insertBefore(o,p)}(window,document,"script",0,"AF", "pba,banners",{pba: {webAppId: "YOUR_PBA_KEY"}, banners: {key: "YOUR_WEB_KEY"}});
// Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner.
AF('banners', 'showBanner', { bannerZIndex: 1000, additionalParams: { p1: "v1", p2: "v2"}});
```

#### **Расширенная проверка SDK**

```jsx
<script>
  // Queue — buffers AF() calls until the SDK is ready
  window.AppsFlyerSdkObject = "AF";
  window.AF = window.AF || function() {
    (window.AF.q = window.AF.q || []).push([Date.now()].concat(Array.prototype.slice.call(arguments)));
  };
  window.AF.id = window.AF.id || { pba: { webAppId: "WEB_DEV_KEY" }, banners: { key: "YOUR_BANNER_KEY" } };
  window.AF.plugins = {};

  // Manifest loader config
  window.AF_LOADER_CONFIG = {
    baseUrl: "https://websdk.appsflyersdk.com",
    plugins: ["banners", "pba"]
  };

  // Inject manifest loader
  var loaderScript = document.createElement("script");
  loaderScript.src = "https://websdk.appsflyersdk.com/manifestLoader.v1.js";
  loaderScript.integrity = "sha384-Uncl2YwvjFpFz0PwEfl3bL/0JsOQcDFEpwXHzcN0MBavn9vvFEx5pZxADTq8h+CV";
  loaderScript.crossOrigin = "anonymous";
  loaderScript.async = true;
  document.head.appendChild(loaderScript);
  // Smart Banners are by default set to the max z-index value, so they won't be hidden by the website elements. This can be changed if you want some website components to be on top of the banner.
  AF('banners', 'showBanner', { bannerZIndex: 1000, additionalParams: { p1: "v1", p2: "v2"}});
</script>
```

## Вставить фрагмент кода на сайт

После выбора фрагмента кода выполните следующие действия:

1. Замените переменную _YOUR_WEB_KEY_ в скрипте на ваш **Web ключ**. Веб-ключ создается при создании нового рабочего места сайта.
2. Если вы выбрали умные баннеры и сниппет PBA, замените плейсхолдер _YOUR_PBA_KEY_ в скрипте на ваш **web dev ключ**. Веб-ключ dev создается при создании набора брендов.
3. Вставьте этот код в тег `head` на вашем сайте. Не забудьте вставить его в верхней части тега «head».

> 📘 Заметка
>
> - Метод `showBanner` в конце инсталляционного кода может занять больше параметров.[Подробнее](https://dev.appsflyer.com/hc/docs/dl_smart_banner_v2#showbanner).
> - Для преодоления ограничений хранения iOS 26/Safari, объявить флаг storage-mode глобальной переменной до инициализации SDK для управления сохранением данных для Smart Banners. Смотрите ниже «Установка режима хранения».

### Установить режим хранения (необязательно)

Умные баннеры используют хранилище браузера для обработки состояния и функциональности баннера. С выпуском iOS 26 Safari появились изменения, влияющие на поведение хранилища браузера. Чтобы помочь веб-сайтам поддерживать последовательное поведение смарт-баннера в этих средах, вы можете настроить метод хранения с помощью флага `storage-mode`.

- **локальный (по умолчанию):** использует браузер `localStorage` / `sessionStorage`. Это режим по умолчанию и не требует никаких изменений в вашем согласии на настройке конфиденциальности cookie.
- **cookie:** Использует файлы cookie первой группы (на вашем домене) для преодоления ограничений на хранение iOS 26/Safari.

> ⚠️ Важное
>
> При включении режима **cookie**, на ваш сайт может распространяться дополнительное разрешение на использование cookie и требования о раскрытии информации в соответствии с положениями о конфиденциальности (например, GDPR, ePrivacy). Владелец сайта несет ответственность за то, чтобы обеспечить их согласие на платформу управления (CMP) и соответствующим образом обновлять политику конфиденциальности.

```js
<script>
  // Необязательно: настройте режим хранения перед инициализацией SDK
  // Опции: "local" (по умолчанию) или "cookie"
  окно. F_SB_STORAGE_MODE = "cookie";
</script>

<script>
  // Инициализация умных баннеров Web SDK
  // Используйте сниппет, указанный в разделе установки выше
</script>

```

## Шрифт смарт-баннера

Использование того же шрифта в смарт-баннере, что и остальная часть сайта создает целостную визуальную идентичность для вашего бренда.

Чтобы изменить шрифт по умолчанию в умном баннере, вам нужно добавить следующее правило в ваш **CSS**

```css
[data-af-custom-fonts="af-creatives-text"] {
    font-family: PUT-YOUR-CUSTOM-FONT-HERE !important;
}
```

Например:

```css
[data-af-custom-fonts="af-creatives-text"] {
    font-family: museo-sans !important;
}
```

> 🚧
>
> - Требуется `!important`
> - Убедитесь, что шрифт уже загружен на сайт
> - Пользовательский шрифт будет применен к **всем** баннерам на сайте
> - Если шрифт не отображается корректно, повторно сохраните свой баннер в [творческом редакторе](https://support.appsflyer.com/hc/en-us/articles/360000764837#3-banner-setup)

## Функции SDK

### показать баннер

**Метод подписи**

```JavaScript
AF('banners', 'showBanner', { bannerContainerQuery: String,
              bannerZIndex: Integer,              
              additionalParams: <Key, Value Dictionary>);
```

**Описание**  
Начать отображение умного флага по ключам баннера, предоставленным в сниппете.

> i **Примечание**
>
> Не используйте эту функцию при реализации Smart Banners в оболочке/гибридном приложении для загрузки страницы баннеров из приложения (а не из браузера), как при использовании `showBanner` будет отображаться баннер в приложении. Если вы используете `showBanner` для гибридного приложения, используйте `hideBanner` для загрузки мобильных приложений.

**Input arguments**

| Тип                       | Наименование              | Описание                                                                                                                                                                                                                                           |
| :------------------------ | :------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Строка`                  | `bannerContainerQuery`    | Если пройдено, SDK пытается найти элемент на странице с этим запросом и рассматривает его как входную точку для размещения баннера. В противном случае используется `document.body`.                               |
| «Целое число              | `bannerZIndex`            | Умные баннеры по умолчанию устанавливаются в максимальном значении z-index, поэтому элементы сайта не будут скрыты. Это может быть изменено, если вы хотите, чтобы некоторые компоненты сайта были поверх баннера. |
| `<Key, Value Dictionary>` | "дополнительныеПараметры" | Если передано, эти ключи и значения (например, `deep_link_value: apples`) добавляются в качестве параметров запроса в OneLink URL.                                                                              |

**Примеры использования**

- Добавить параметры в OneLink URL

```js
AF('banners', 'showBanner', { additionalParams: { deep_link_value: "apples", deep_link_sub1: "22", af_adset: "my_adset"}});
```

- Установить Z-index этого баннера и идентификатор контейнера для его размещения

```js
AF('banners', 'showBanner', { bannerContainerQuery: "#my-container-id"
                              bannerZIndex: 999});
```

### обновить параметры

**Метод подписи**

```js
AF('banners', 'updateParams', { <Key, Value Dictionary> });
```

**Description**  
Programmatically add up to 10 parameters (for example, `deep_link_value`) to the OneLink URL assigned to the call-to-action (CTA) button, after the banner displays.

Введён объект с ключами и значениями параметров.

Ключ не может иметь пустое значение.  
Ключ не может быть назван: не определен, null, NaN, или arg  
Недопустимые символы:  
Key: `/, \, *, ! @, #, ? $, %, ^, &, ~, ``, =, +, ', ", ; :, >, <`  
Значение = `\, ;, $, >, <, ^, #, `` `

- Параметры добавляются в качестве параметров запроса в OneLink.
- При использовании updateParams для добавления параметров URL показа отличается от URL клика.
- Добавленные параметры не заменяют их на оригинальном OneLink. Если добавляемый параметр уже находится в OneLink, он не изменяется.
- Если updateParams вызывается более одного раза, только параметры от последнего вызова добавляются к URL.

**Input arguments**

| Тип                       | Наименование | Описание                                                                                                                                                     |
| :------------------------ | :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<Key, Value Dictionary>` | Н/Д          | Эти ключи и значения (например, `deep_link_value: apples`) добавляются в качестве параметров запроса в URL-адрес OneLink. |

**Примеры использования**

- Добавить параметры в OneLink URL

```js
AF('banners', 'updateParams', { deep_link_value: "new_param", deep_link_sub4: "gg_77", af_ad: "new_ad_param"});
```

### hideBanner

**Метод подписи**

```js
AF('banners', 'hideBanner');
```

**Описание**

Программно удалить любой отображаемый баннер со страницы (например, после ввода определенного пользователя).

**Input arguments**

нет

**Примеры использования**

- Скрыть баннер

```js
AF('banners', 'hideBanner');
```

## Черты и ограничения

| Симптом                                            | Замечания                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Одностраничное приложение (SPA) | Smart Banners are by default only displayed once, even if users navigate between pages.<br> Для отображения баннеров, когда пользователи переходят между страницами, вам необходимо вручную вызывать hideBanner и showBanner для каждой навигации, которая не перезагружает страницу и запускает логику по умолчанию смарт-баннеров.                    |
| Нажмите ID автопересылка                           | Следующие идентификаторы кликов автоматически пересылаются на исходящий URL, когда они присутствуют на входящем URL:<br> - Google: `gclid`, `gbraid`, `wbraid`<br> - Facebook: `fbclid`<br> - TikTok: `ttclid`<br> - X (ранее Twitter): `twclid`<br> - Snap: `ScCid` |
