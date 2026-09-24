---
title: Ручная проверка
slug: Ручное тестирование-андроид
category:
  uri: SDK AppsFlyer
parent:
  uri: Андроид-сдк
privacy:
  view: любой_с ссылкой
position: 11
---

> 📘 **Примечание**
>
> Мы рекомендуем использовать наш [инструмент интеграции с SDK](https://dev.appsflyer.com/hc/docs/manual-testing-android) для тестирования

Для успешного завершения тестов в этом документе необходимо:

- [Интегрировать SDK](doc:integrate-android-sdk)
- [Зарегистрируйте тестовое устройство](https://support.appsflyer.com/hc/en-us/articles/207031996).

## Тестирование интеграции Android SDK

----------------------------

Испытание состоит из:

1. Симуляция клика рекламы и конверсии.
2. [Проверка данных о конверсии](#inspect-conversion-data) установки.

### Имитация преобразования

Имитация пользователя, нажатие на рекламу и установка приложения.

**Шаг 1: Имитация рекламы**  
Имитация рекламы с помощью ссылки атрибута. Структура присваиваемой ссылки выглядит следующим образом:

```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&advertising_id=<registered_device_gaid>
```

где:

- `app_id` это ваш AppsFlyer ID приложения.
- `pid` — это [media source](https://support.appsflyer.com/hc/en-us/articles/212188826), в который следует атрибутировать установку.
- `advertising_id` - это GAID, зарегистрированный на устройстве.

Параметр `advertising_id` требуется для атрибута через [ID matching](https://support.appsflyer.com/hc/en-us/articles/207447053#device-id-matching). При отсутствии атрибуция будет возникать [probabilistically](https://support.appsflyer.com/hc/en-us/articles/207447053#probabilistic-modeling).

Например, если ваш идентификатор приложения `com.my.app`, ссылка на атрибуты может выглядеть следующим образом:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1
```

или, с помощью GAID:

```HTTP
https://app.appsflyer.com/com.my.app?pid=devtest&c=test1&advertising_id=******-**-**-**-****-**-**-********************** **
```

> 👍 Tip
>
> Часто тесты с использованием ссылок атрибутов выполняются более одного раза. Поэтому рекомендуется использовать один из параметров атрибуции в "версию" ваши тесты – это облегчает понимание того, какая из них вызвала.
>
> В приведенном выше примере значение «c» равно «test1». При последовательных тестах, увеличите значение `c` до `test2`, `test3` и так далее.

**Шаг 2: Установите приложение**  
[Включить режим отладки](doc:integrate-android-sdk#enabling-debug-mode) и установите приложение на [зарегистрированном тестовом устройстве](https://support.appsflyer.com/hc/en-us/articles/207031996-Registering-test-devices-).

**Step 3: Execute test**  
Proceed to [inspect conversion data](#inspect-conversion-data).

### Проверять данные о конвертации

После моделирования преобразования выполните эти шаги для проверки данных о конвертации установки.

**Шаг 1. Получить UID**  
После установки приложения найдите в логах отладки `conversions.appsflyer`

![](https://files.readme.io/bd951f1-android-uid_en-us.png "android-uid_ru.png")

**Шаг 2: Анализ данных**  
Перейдите к [API теста на преобразование](https://dev.appsflyer.com/hc/reference/gcd-get-data) и заполните необходимые поля:

1. `app-id`: Ваш ID приложения
2. `device_id`: вставьте значение `uid` из шага 1.
3. `devkey` - devkey приложения. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key) how to get it.

Затем нажмите **Попробуйте!** для выполнения теста.

**Ожидался результат**  
200 ответа, содержащего данные о преобразовании программы установки (усечен для читаемости):

```json Log
{
  ...
  "campaign": "test1",
  ...
  "media_source": "devtest",
  ...
  "af_status": "Non-organic"
  ...
}
```

> 📘 Заметка
>
> Это может занять до 30 минут, чтобы установить на панели инструментов.
