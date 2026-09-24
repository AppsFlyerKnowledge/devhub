---
title: Атрибут приглашения пользователя
slug: dl_user_invite
category:
  uri: Глубокая связь и OneLink
privacy:
  view: публичный
---

## Общий обзор

Атрибут пользователя приглашает маркетологов получить представление о том, сколько трафика получит от существующих пользователей, приглашая новых пользователей.

В целом она состоит из следующего:

1. Определение потока приглашений пользователей и реализация OneLink соответственно.
2. Регистрация приглашения в качестве события в приложении. Это результат:
   - Событие `af_invite`, которое отображается в панели инструментов AppsFlyer и отчетах.
   - Параметр `pid` (media source) задается значением по умолчанию `af_app_invites`. Чтобы изменить значение, нужно добавить пользовательский параметр `pid` со значением, которое вы хотите.
     **Примечание**: для Android это работает только для AppsFlyer SDK V6.4.2+.

## Руководства по осуществлению

<div class="button-container"><a class="button android" href="https://dev.appsflyer.com/hc/docs/dl_android_user_invite">Android</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/dl_ios_user_invite">iOS</a>
</div>

<style>
  .button-container {
  	display: flex;
  }
  . utton {
    display: flex;
    justify-content: center;
    выравнивание элементов: центр;
    ширина: 150px;
	  радиус границы: 6px;
    разгрузка: 8px;
    маржинальное право: 4px;
	}
  
  . utton:before {
  	margin-right: 4px;
  }
  .button. ndroid {
    border: solid 2px #3DDC84;
  }
  . os {
  	border-radius: 6px;
    padding: 8px;
    границы: твердый 2px #7D7D7D;
  }
  . os:before {
        content: url("https://files.readme.io/19fdc72-apple-icon.svg");
  }

  . ndroid:before {
        content: url("https://files.readme.io/d7dc5a3-android-icon.svg");
  }
</style>
