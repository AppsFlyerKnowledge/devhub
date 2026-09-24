---
title: Тестирование интеграции
slug: интеграционное тестирование
category:
  uri: SDK AppsFlyer
parent:
  uri: получение запущено
privacy:
  view: публичный
position: 4
---

## Общий обзор

После завершения [SDK интеграции](doc:sdk-integration), рекомендуется протестировать его. Тестирование обеспечивает точный и всеобъемлющий сбор и доставку данных.

## Проверка интеграции

Тестирование проверяет SDK:

- Запускает и успешно устанавливает соединение с AppsFlyer, без проблем с сетью/аутентификацией.
- Пересылает данные атрибутов правильно.

Выполнено:

1. создание ссылки атрибута AppsFlyer и использование ее для симуляции пользователя, нажав на объявление.
2. Установка приложения на [зарегистрированное тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).
3. Проверка данных о конверсии.
   [block:html]
   {
   "html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/testing-android#test-android-sdk-integration\\">Test Android SDK integration</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/testing-ios#test-ios-sdk-integration\\">Test iOS SDK integration</a>\n</div>\n\n<style>\n  . utton-container {\n  \tdisplay: flex;\n  }\n\n  . utton {\n  \tmargin: 4px;\n  }\n  \n  . utton:before {\n  \tmargin-right: 4px;\n  }\n  . os:before {\n        content: url(\"https://files.readme.io/19fdc72-apple-icon.svg\\");\\n  }\n\n  . ndroid:before {\n        content: url(\"https://files.readme.io/d7dc5a3-android-icon. vg\");\n  }\n</style>"
   }
   [/block]

## Отладка приложений

Чтобы избежать смешивания производственных данных с тестовыми конверсиями и событиями в приложении, вы можете протестировать интеграцию SDK с помощью отладочного приложения.

Отладочные приложения отличаются от обычных приложений:

1. Есть другой ID приложения.
2. Приобрести свой собственный экземпляр в панели управления AppsFler.
3. Не опубликованы в магазинах приложений.

Создание отладочных приложений включает в себя настройку конфигурации сборки приложения и добавление нового приложения в приборную панель для использования в целях тестирования.

[block:html]
{
"html": "<div class=\"button-container\">\n  <a class=\"button android\" href=\"https://dev.appsflyer.com/hc/docs/testing-android#creating-an-android-debug-app\\">Android отладочное приложение</a>\n  <a class=\"button ios\" href=\"https://dev.appsflyer.com/hc/docs/testing-ios#creating-an-ios-debug-app\\">Приложение для iOS</a>\n</div>\n"
}
[/block]
