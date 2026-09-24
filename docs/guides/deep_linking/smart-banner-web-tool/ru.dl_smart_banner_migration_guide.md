---
title: Гид миграции умных баннеров с 1 до 2
slug: dl_smart_banner_migration_guide
category:
  uri: Глубокая связь и OneLink
parent:
  uri: Smart-banner-web-инструмент
privacy:
  view: публичный
---

> ⚠️ **Важная запись**
>
> Начиная с 8 ноября 2023 года, AppsFlyer Smart Banner web SDK v1 является устаревшим. С этой даты веб-сайты с помощью Smart Banner web SDK v1 больше не могут показывать смарт-баннеры.
> Пожалуйста, обновитесь до Smart Banner v2, следуя инструкциям в этой статье.

## Общий обзор

Обновление SDK до новой версии может быть простым процессом, но важно понимать внесенные изменения. В этом руководстве мы рассмотрим шаги по обновлению вашего текущего SDK до новой версии, и как настроить ваш код для учета изменений.

## Предпосылки

1. Убедитесь, что загрузите последнюю версию SDK.
   Если у вас уже есть отдельный PBA Web SDK, удалите его и замените на Web SDK для Smart Banners и People's Attribution; не просто добавлять отдельную Web SDK для Smart Banners.

Вы можете найти и SDK сниппеты здесь (пожалуйста, выберите тот, который вам подходит):
1. [Использование Web SDK только для умных баннеров](dl_smart_banner_v2).
2. [Использование Web SDK как для умных баннеров, так и для персональных атрибутов](https://support.appsflyer.com/hc/en-us/articles/4410472474001#appsflyer-web-sdk-for-smart-banners-and-peoplebased-attribution).

## Установка

Замените старый сниппет SDK на ваш сайт [новый](dl_smart_banner_v2#code-example).
Просто замените старый кодовый сниппет в тэге \`<head>на каждой странице отображающей ваши мобильные баннеры с новым сниппетом SDK.

## Методы SDK

1. Как только новый SDK будет создан, вам нужно будет настроить ваш код, чтобы отразить изменения.
   В этом случае старый SDK включал устаревшие функции, такие как:
   `disableBanners()`
   `disableTracking()`
   `getAdditionalParams()`
   `setAdditionalParams()` `setAdditionalParams()`

Эти функции были удалены в новом SDK, поэтому вам нужно будет удалить любые ссылки на них в вашем коде.

### показать баннер

В старом SDK функция showBanner была названа следующим образом:

```js
showBanner({ bannerContainerQuery: "#container-id",
              bannerZIndex: 1000,
              additionalParams: { deep_link_value: "flights", deep_link_sub1: "london"}});
```

В новом SDK функция [`showBanner`](dl_smart_banner_v2#showbanner) называется так:

```js
AF('banners', 'showBanner', { bannerContainerQuery: "#container-id",
              bannerZIndex: 1000,
              additionalParams: { deep_link_value: "flights", deep_link_sub1: "london"}});
```

### hideBanner

Функция `hideBanner` также изменена, от:

```js
hideBanner()
```

к [новой версии](dl_smart_banner_v2#hidebanner)

```js
AF('banners', 'hideBanner')
```

### обновить параметры

[new SDK](dl_smart_banner_v2#updateparams) позволяет программно добавить до 10 параметров к OneLink, назначенному кнопке вызова к действию (CTA), после показа баннера. Это полезно для отслеживания или других целей, где вам нужно передавать динамические данные в OneLink.

Например:

```js
AF ("banners", "updateParams", {af_ad: "my_new_ad", deep_link_sub8: "promo_summer"})
```

**Важно отметить, что этот метод не работает с устаревшей смарт-баннер веб-SDK.**
