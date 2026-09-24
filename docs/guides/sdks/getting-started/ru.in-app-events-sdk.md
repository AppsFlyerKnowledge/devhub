---
title: События внутри приложения
slug: в приложении-событиях-sdk
category:
  uri: SDK AppsFlyer
content:
  excerpt: Узнайте о базовых концепциях и терминологии, связанных с событиями в приложении.
parent:
  uri: получение запущено
privacy:
  view: публичный
position: 5
---

События в приложении дают представление о том, как пользователи взаимодействуют с вашим приложением. AppsFlyer SDK позволяет легко регистрировать эти взаимодействия.

## Инструкции по SDK событиям внутри приложения

[block:html]
{
"html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/in-app-events-android\\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/in-app-events-ios\\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/inappevents\\">Unity SDK</a>\n\n</div>\n\n<style>\n  .button-container {\n  \tdisplay: flex;\n  }\n  .button {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    width: 150px;\n\t  border-radius: 6px;\n    padding: 8px;\n    margin-right: 4px;\n\t}\n  \n  .button:before {\n  \tmargin-right: 4px;\n  }\n  .button.android {\n    border: solid 2px #3DDC84;\n  }\n  .ios {\n  \tborder-radius: 6px;\n    padding: 8px;\n    border: solid 2px #7D7D7D;\n  }\n   .button.unity {\n    border: solid 2px #3DDC84;\n    border-color: var(--project-primary-color);\n  }\n  .ios:before {\n        content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\\");\\n  }\n\n  .android:before {\n        content: url(\"https://files.readme.io/d7dc5a3-android-icon.svg\\");\\n  }\n\n.unity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\\");\\n}\\n\\n.reactnative:before {\n   content: url(\"https://files.readme.io/3e1288d-reactnative-icon.svg\\");\\n}\\n\\n.flutter:before {\n    content: url(\"https://files.readme.io/1f70175-flutter-icon.svg\\");\\n}\\n\\n</style>"
}
[/block]

## Анатомия события

События внутри приложения состоят из 2 частей:

- **Имя события**: уникальный идентификатор события. Как маркетологи видят событие в панели управления.
- **Значения событий**: Объект состоит из пар ключевого значения под названием **event parameters**. Параметры события обеспечивают дополнительный контекст и информацию о происходящем событии.

Имена событий и параметры события могут быть **предопределены** или **пользователь**.

[block:callout]
{
"type": "success",
"title": "Tip",
"Тело": "Быстрое определение и генерация кода событий в приложении для всех основных платформ с помощью нашего [инструмента генератора событий в приложении](https://evgen.appsflyer.com?utm_medium=referral&utm_source=devhub)."
}
[/block]

## Константы событий

В SDK [предопределенные события и параметры](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-for-Android-and-iOS#introduction-predefined-and-custom-events) показываются как константы.

При отправке событий, рекомендуется использовать константы вместо строк:

- Это снижает вероятность введения несоответствий с именами.
- Изменения в нижележащих именах событий/параметров прозрачны для вас и требуют меньшего обслуживания.

Технически, предопределенные имена/параметры событий являются строками, начинающимися с `af_`.

## Пользовательские события и параметры событий

Пользовательские имена событий и параметры определены пользователем и обычно описывают сценарии, специфичные для бизнес-логики вашего приложения и взаимодействия ваших пользователей с приложением.
[block:callout]
{
"type": "предупреждение",
"body": "Чтобы избежать путаницы с [предопределёнными событиями](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-for-Android-and-iOS#introduction-predefined-and-custom-events), не префиксуйте имена пользовательских событий с `af_`. ,
"title": "Внимание"
}
[/block]

### Допустимые пользовательские имена событий

Пользовательские имена событий должны следовать этим правилам:

- Длина до 100 символов.
- Поддерживаются не-английские символы.

### Доступные пользовательские параметры события

Пользовательские параметры событий:

- Должно быть не более 1000 символов; если длиннее будет сокращено
- Цены и поступления: использовать только цифры и десятичные дроби, например 5 или 5.2.
- Значения цен и доходов могут иметь до 5 цифр после указанного периода, например, 5.12345

> 📘 Заметка
>
> Для событий с **выручкой**, включая покупки в приложениях, подписки и события поступления от рекламы, Клиенты AppsFlyer с подпиской ROI360 не должны использовать параметр `af_revenue` в своих внутри-приложениях событий. Это может привести к дублированию доходов. Вместо этого они должны использовать [коннектор покупки](https://dev.appsflyer.com/hc/docs/purchase-connector) и [ad revenue SDK API](https://dev.appsflyer.com/hc/docs/ad-revenue).

## Понимание определений структуры событий

В идеале, маркер должен предоставить четкие определения структуры событий, основанные на инструкциях в [Определение событий в приложении](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-guide#introduction-defining-an-inapp-event). For example, a definition of an `af_content_view` event for an eCommerce app would look something like this:
[block:parameters]
{
"data": {
"h-0": "Event name",
"h-1": "Event parameters",
"h-2": "Parameter values",
"0-0": "`af_content_view`",
"0-1": "`af_price`\n`af_content_type`\n`af_content_id`",
"0-2": "`af_price`: Item price\n`af_content_type`: Item category.\n`af_content_id`: Item SKU.",
"h-3": "Where/When (Optional)",
"0-3": "When a user navigates to an item view."
},
"холод": 4,
"ряды": 1
}
[/block]

- Первый столбец (Event name) — это значение, которое вы передаете в качестве второго аргумента `logEvent`.

  `af_content_view` — как маркетологи видят событие в панели инструментов. Рекомендуется использовать предопределенные константы событий вместо поставщиков сырых строковых значений.

- Во второй колонке (параметры исключения) перечислены параметры событий, связанных с событием. В этом случае вы должны передать следующие параметры события в `logEvent`:
  - `af_price`
  - `af_content_type`
  - `af_content_id`

- Третий столбец (значения параметров) содержит дополнительную информацию о конкретных значениях, присвоенных параметрам события. В приведенном выше примере маркер четко сообщает, что значение параметра события `af_content_id` должно быть SKU просмотренного элемента.

- Четвертый столбец - где маркер описывает, где и когда в приложении будет происходить событие

Смотрите, как приведенное выше определение реализовано на [Android](https://dev.appsflyer.com/hc/docs/in-app-events-android#implementing-event-structure-definitions) и [iOS](https://dev.appsflyer.com/hc/docs/in-app-events-ios#implementing-in-app-event-definitions).

## События в автономном режиме

SDK может кэшировать события, происходящие при отсутствии интернет-соединения:

- SDK отправляет события на серверы AppsFlyer и ждет ответа
- Если SDK не получает 200 ответов, события кэшируются
- После получения следующего 200 ответов, сохраненные события будут повторно отправлены на сервер
- Если в кэше много событий, они отправляются на сервер один за другим (unbatched, один сетевой запрос на событие).

SDK может кэшировать до 40 событий. Сохраняются только первые 40 оффлайн событий. Все, что происходит впоследствии (до следующего успешного ответа), отбрасывается.
