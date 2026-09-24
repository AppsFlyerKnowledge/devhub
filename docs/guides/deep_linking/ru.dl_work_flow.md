---
title: Глубокая привязка рабочего процесса
slug: dl_work_flow
category:
  uri: Глубокая связь и OneLink
privacy:
  view: публичный
---

## Настройка

Для настройки OneLink требуется совместная работа двух разных лиц внутри организации, используя собственные ресурсы: Маркетеры и разработчики.

## Роль Маркетера

Маркетеры планируют маркетинговые кампании и настроят OneLink. OneLink URL-адреса настроены для переноса параметров (например, `deep_link_value`) и данные, которые используются для того, чтобы дать пользователям персонализированный опыт при глубоких связях и отсрочке глубокого соединения.

> 📘 **Tip**
>
> Маркетеру и разработчикам необходимо совместно решать вопрос о лучшей долгосрочной системе для `deep_link_value` (и любых других параметров/значений), чтобы свести к минимуму дополнительные обновления приложений.
>
> `deep_link_value` может быть основан на SKU, ID записи, пути или что-нибудь еще. Мы настоятельно рекомендуем согласиться с системой, которая позволяет вам вводить динамические значения на выбранный вами параметр, так что вы можете сгенерировать много разных глубоких ссылок, которые относятся к разному содержимому в приложении, без дальнейших изменений в коде приложения разработчиками.
>
> Смотрите следующие примеры URL. `deep_link_value` фруктового типа был выбран маркетингом и разработчиком вместе. А застройщики сделали ценности динамичными, чтобы маркетолог мог входить в плоды без необходимости дальнейшей работы команды dev.
>
> [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month\*\*&deep_link_value=apples\*\*..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=apples**..).  
> [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month\*\*&deep_link_value=bananas\*\*..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=bananas**..).  
> [https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month\*\*&deep_link_value=peaches\*\*..](https://onelink-sample-app.onelink.me/H5hv?pid=Email&c=fruit_of_the_month**&deep_link_value=peaches**..).

## Роль разработчика

Разработчики выполняют установку OneLink в приложении:

- Начальная настройка
- Реализация UDL API
- Осуществление расширенной глубокой связи отсроченных сроков

### Начальная настройка

Первоначальная настройка приложения для [Android](dl_android_init_setup) и [iOS](dl_ios_init_setup): Открывает приложение (используя ссылки на приложения Android, универсальные ссылки или схемы URI)

### Реализация Единой Глубокой Связи (UDL)

Внедрение API объединенных глубоких связей (UDL) для извлечения данных из клика и использования этих данных для перенаправления пользователей в персонализированный режим работы внутри приложения (глубокая связь или отложенная глубокая связь).  
Этот API быстрый, простой в использовании и поддерживает как собственные, так и платные источники.

Примечание: Для новых пользователей метод UDL возвращает только параметры, относящиеся к отсрочке глубокой ссылки: `deep_link_value` и `deep_link_sub1-10`. Если вы пытаетесь получить другие параметры (`media_source`, `campaign`, `af_sub1-5`, etc.), они возвращают `null`.

#### Реализация UDL

[block:html]
{
"html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/dl_android_unified_deep_linking\\">Android SDK</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/dl_ios_unified_deep_linking\\">iOS SDK</a>\n  <a class=\"button unity\" href=\"https://dev.appsflyer.com/hc/docs/unifieddeeplink\\">Плагин Unity</a>\n</div>\n\n<style>\n  . utton-container {\n  \tdisplay: flex;\n  }\n  . utton {\n    display: flex;\n    justify-content: center;\n    выравнивание элементов: центр;\n    ширина: 150px;\n\t  радиус границы: 6px;\n    штук: 8px;\n    маржинальное право: 4px;\n\t}\n  \n  . utton:before {\n  \tmargin-right: 4px;\n  }\n\n  . utton.android {\n    border: solid 2px #3DDC84;\n  }\n\n  . utton. os {\n  \tborder-radius: 6px;\n    padding: 8px;\n    границы: твердое 2px #7D7D7D;\n  }\n  \n   . utton. nity {\n    border: solid 2px #3DDC84;\n    border-color: var(--project-primary-color);\n  }\n\n\n  . os:before {\n        content: url(\"https://files. eadme.io/19fdc72-apple-icon.svg\");\n  }\n\n  .android:before {\n        content: url(\"https://files. eadme.io/d7dc5a3-android-icon.svg\");\n  }\n\n. nity:before {\n    content: url(\"https://files.readme.io/59acdf6-unity-icon.svg\\");\\n}\\n\\n.reactnative:before {\n   content: url(\"https://files.readme.io/3e1288d-reactnative-icon. vg\");\n}\n\n.flutter:before {\n    content: url(\"https://files.readme. o/1f70175-flutter-icon.svg\");\n}\n</style>"
}
[/block]

### [Recommended] Внедрение расширенной глубокой связи откладывается

В некоторых случаях UDL не активирован для отсрочки. Например, когда:* Пользователь нажимает ссылку из Self Reporting Network (SRN), как Meta ads или Twitter.
* Пользователь кликает на ссылку, которая не содержит таких параметров, как `deep_link_value` или `deep_link_sub1-10`.
* Период времени между кликом и установкой превышает окно поиска UDL 15 минут.  
  Для гарантирования отложенных работ в таких случаях рекомендуется использовать метод `onConversionDataSuccess` (OCDS), являющийся частью GCD API. OCDS обычно используется для получения [данных преобразования](https://dev.appsflyer.com/hc/docs/conversion-data) и до UDL, является эксклюзивным методом для обработки отложенных глубоких соединений.  
  **Важно**: При реализации UDL и OCDS, разработчик должен гарантировать, что **только один** методов обрабатывает отсроченные глубокие связи.  
  См. инструкции по реализации расширенной глубокой связи [Android](dl_android_ocds_ddl) и [iOS](dl_ios_ocds_ddl).

### Legacy: Используйте только GCD API для двойной ссылки

Разработчики, уже использующие OneLink, могут использовать устаревшие методы для глубокой связи и отсрочки глубокого соединения, а не UDL.  
Устаревшие методы используют только GCD API, который состоит из двух методов: `onConversionDataSuccess` для отсрочки глубокой связи и `onAppOpenAttribution` для глубокой связи. См. информацию о старых методах для [Android](dl_android_gcd_legacy) и [iOS](dl_ios_gcd_legacy).

**Рекомендуется**: Приложения только с GCD API должны реализовывать [UDL](#implement-unified-deep-linking-udl) и [расширенная глубокая ссылка](#optional-implement-extended-deferred-deep-linking).

### Приглашения пользователя

Разрешить пользователям передавать других в приложение, используя ссылки OneLink, [создавая приглашения пользователей](dl_user_invite)
