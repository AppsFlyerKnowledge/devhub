---
title: Общий обзор
slug: обзор приложения
category:
  uri: Интеграция с Apple App Clips
privacy:
  view: публичный
---

**На взгляду**: App Clips позволяют пользователям с iOS 14 или более поздней версией быстро получить доступ к вашему приложению. Интеграция AppsFlyer SDK дает вам ценную информацию об атрибутах App Clip. И конфигурация OneLink позволяет автоматически перенаправлять пользователей, которые не могут использовать App Clips на места, указанные в настройках OneLink. [Подробнее](https://www.appsflyer.com/resources/guides/ios-14-app-clips/)
[block:image]
{
"images": [
{
"image": [
"https://files.readme.io/5bc87f6-app_clip_flow_2.png",
"app clip flow 2. ng",
751,
422,
"#efeff0"
]
}
]
}
[/block]
Интеграция AppsFlyer SDK с App Clips, вам необходимо:

- [Добавить SDK в App Clip](https://dev.appsflyer.com/docs/app-clip-sdk-integration).
- [Optional] [Настроены события внутри приложения (в полном объеме и/или App Clip](https://dev.appsflyer.com/docs/in-app-events).
- [Настройте и клип приложения, и полнофункциональное приложение для измерения полной загрузки приложений.](https://dev.appsflyer.com/docs/app-clip-to-full-app-install)

[block:api-header]
{
"title": "Considerations"
}
[/block]
App Clips:

- Приложение может быть размером до 10 МБ. SDK AppsFlyer ~ 1.5 MB.
- Нет доступных рекламных идентификаторов.
- App Clips удаляются ОС автоматически после 30-дневного периода неактивности.
- Функция SKAdNetwork недоступна.
