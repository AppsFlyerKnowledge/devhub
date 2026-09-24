---
title: Приглашение в Android
slug: dl_android_user_invite
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Общий обзор

Реализация и атрибут пользователя приглашают ссылки, когда существующие пользователи ссылаются на других в вашем приложении.  
Для введения смотрите [приглашение пользователей](https://dev.appsflyer.com/hc/docs/dl_user_invite).

Хотите увидеть полный пример? проверить рецепт:

[block:tutorial-tile]
{
"backgroundColor": "#018FF4",
"emoji": "🦉",
"id": "61ad0cf7fe61e2002352c544",
"link": "https://dev.appsflyer. om/v0.1/recipes/onelink-user-invite-in-android-1",
"slug": "onelink-user-invite-in-android-1",
"title": "OneLink user invite in Android"
}
[/block]

## Реализовать приглашения пользователей

**Прежде чем начать**: Синхронизируйте с маркером, чтобы выяснить желаемые варианты использования ссылок и получить список [parameters](https://support.appsflyer.com/hc/en-us/articles/115004480866#parameters), которые хотят быть реализованы.

Чтобы реализовать атрибут приглашения пользователя, выполните следующие шаги:

1. [Настройте создание пригласительной ссылки](#set-up-invite-link-generation) для генерации пригласительных ссылок.
2. <span class="annotation-optional">Optional</span> [Log the invite link creation](#log-invite-link-creation-events).
3. [Настройка Единой Глубокой Связы](doc:unified-deep-linking-udl) (UDL)
4. <span class="annotation-optional">Опционально</span> [Получение данных о реферере от пригласительных ссылок](#set-up-udl-for-user-invite-attribution).
5. <span class="annotation-optional">Опциональная</span> Настройте [награды реферала](#reward-referrers).

Следующий код основан на [примере маркера](https://support.appsflyer.com/hc/en-us/articles/115004480866#example).

### Настроить создание пригласительной ссылки

Чтобы разрешить пользователям пригласить их друзей в ваше приложение, вам нужен способ создания пригласительных ссылок для пользователей. Это делается с помощью `LinkGenerator`.  
**Чтобы настроить создание ссылки для приглашения:**

1. Убедитесь, что импортированы следующие зависимости:
   ```java
   импортировать com.appsflyer.AppsFlyerLib;
   import com.appsflyer.CreateOneLinkHttpTask;
   import com.appsflyer.share.LinkGenerator;
   import com.appsflyer.share.ShareInviteHelper;
   ```

2. Установите шаблон OneLink, используя [`setAppInviteOneLink()`](doc:android-sdk-reference-appsflyerlib#setappinviteonelink) (ID шаблона [предоставлен маркером](https://support.appsflyer.com/hc/en-us/articles/115004480866#procedures)):
   ```java
   AppsFlyerLib.getInstance().setAppInviteOneLink("H5hv"); // задание ID шаблона OneLink, на основе приглашения пользователя
   ```
   > 📘 Заметка
   >
   > - Не забудьте позвонить `setAppInviteOneLink()` **раньше** при вызове `start`.
   > - Шаблон OneLink должен быть связан с приложением.

3. Создайте [`LinkGenerator`](doc:android-sdk-reference-linkgenerator) используя [`ShareInviteHelper.generateInviteUrl()`](doc:android-sdk-reference-shareinvitehelper#generateinviteurl).
   ```java
   Generator linkGenerator = ShareInviteHelper.generateInviteUrl(getApplicationContext());
   ```

4. В зависимости от трафика пользователя, добавьте следующие параметры, используя [`linkGenerator.addParameter()`](doc:android-sdk-reference-linkgenerator#addparameter):

   ```java
   linkGenerator.addParameter("deep_link_value", <TARGET_VIEW>);
   linkGenerator.addParameter("deep_link_sub1", <PROMO_CODE>);
   linkGenerator. ddParameter("deep_link_sub2", <REFERRER_ID>);
   // Необязательно; предоставляет идентификатор referrer в отчете об установке raw-data
   linkGenerator.addParameter("af_sub1", <REFERRER_ID>);
   ```

   - `deep_link_value`: Приложение испытывает указанного пользователя глубокой связью.
   - `deep_link_sub1`: полученный приглашением промо-код.
   - `deep_link_sub2`: идентификатор реферера. Может быть использовано для награды реферера.
   - **Примечание**: Если у вас есть SDK V6.5.2 или ниже, необходимо кодировать любые значения параметров специальными символами.

   > 📘 Заметка
   >
   > Вы также можете включить другие стандартные параметры AppsFlyer, такие как параметры перенаправления, такие как `af_web_dp`, при создании OneLinks через SDK. Подробнее о доступных параметрах смотрите [О структуре ссылок и параметрах](https://support.appsflyer.com/hc/en-us/articles/207447163-About-link-structure-and-parameters).

5. Установка [параметров атрибуции](doc:android-sdk-reference-linkgenerator#methods). (Они будут отображаться в панелях AppsFlyer и отчетах о необработанных данных).
   ```java
   linkGenerator.setCampaign("summer_sale");
   linkGenerator.setChannel("mobile_share");
   ```

6. <span class="annotation-optional">Опционально</span> Установить фирменный домен для сгенерированной ссылки:

   ```java Java
   linkGenerator.setBrandDomain("brand.domain.com");
   ```

7. Создайте `LinkGenerator.ResponseListener`, чтобы получить ссылку для приглашения пользователя, когда она доступна:

   ```java
   LinkGenerator.ResponseListener слушатель = новый генератор ссылок. esponseListener() {
               @Override
               public void onResponse(String s) {
                   Log. (LOG_TAG, "Поделиться ссылкой-приглашением: " + s);
                   // . .
               }

               @Override
               public void onResponseError(String s) {
                   Log. (LOG_TAG, "onResponseError вызвал");
               }
            
   };
   ```

> 📘 Заметка
> С SDK v6.9.0 `LinkGenerator.ResponseListener` заменена на `CreateOneLinkHttpTask.ResponseListener`

- `onResponse()` вызывается при успешном создании приглашения для пользователя.
- `onResponseError()` вызывается при сбое генерации ссылок.

8. Передайте `listener` на [`linkGenerator.generateLink()`](doc:android-sdk-reference-linkgenerator#generatelink-1):
   ```java
   linkGenerator.generateLink(getApplicationContext(), слушателя);
   ```

### Задать ID шортссылки

<span class="annotation-optional">Optional</span>  
The shortlink ID can be determined by the developer, by adding the parameter `af_custom_shortlink` to the `LinkGenerator` instance.

```java
linkGenerator.addParameter("af_custom_shortlink", <value>);
```

### Записывать события по созданию ссылки приглашения

<span class="annotation-optional">Optional</span>  
**To log the invite link creation event**:  
Log the invite using [`logInvite()`](doc:android-sdk-reference-shareinvitehelper#loginvite):

```java
HashMap<String,String> logInviteMap = new HashMap<String,String>();
logInviteMap.put("referrerId", <REFERRER_ID>);
logInviteMap.put("campaign", "summer_sale");

ShareInviteHelper.logInvite(getApplicationContext(), "mobile_share", logInviteMap);
```

`logInvite` приводит к событию в `af_invite`.

> 📘 Заметка
>
> Если вы не хотите использовать канал, используйте `logEvent`.

### Настройка UDL для атрибута приглашения пользователя

<span class="annotation-optional">Optional</span>  
**To set up UDL for user invite attribution:**  
Set up [Unified Deep Linking](doc:unified-deep-linking-udl) (UDL). В `DeepLinkListener.onDeepLinking()` извлекает глубокие параметры соединения, созданные во время генерации ссылок. В этом примере получаются следующие свойства:

- `deep_link_value`, используя `DeepLink.getDeepLinkValue()`
- `deep_link_sub1`, используя `DeepLink.getStringValue()`
- `deep_link_sub2`, используя `DeepLink.getStringValue()`

See code: [Java](https://github.com/AppsFlyerSDK/appsflyer-onelink-android-sample-apps/blob/ee2a671926520c0aa031885da078f5ecf370c5c4/java/basic_app/app/src/main/java/com/appsflyer/onelink/appsflyeronelinkbasicapp/AppsflyerBasicApp.java#L74).

## Рефереры наград

<span class="annotation-optional">Optional</span>  
In the following scenarios, **User A** invites **User B** to your app.

### Рефералы вознаграждения при установке

**Сценарий:** Пользователь B установит ваше приложение по пригласительной ссылке пользователя А.

ID пользователя A доступен в файле `DeepLinkListener.onDeepLinking()` и в этом примере он получен с помощью `DeepLink.getStringValue("deep_link_sub2")`. После получения идентификатора добавьте его в список идентификаторов рефереров, чтобы получить вознаграждение. Это зависит от того, как хранить и получать список.

### Рефереры вознаграждений за действия пользователей

**Сценарий:** Пользователь B совершает покупку. Вы хотите вознаградить пользователя А, который изначально направил пользователя B в ваше приложение, за действие.

**Чтобы вознаградить пользователя A за действия пользователя:**

1. Получить ID реферера пользователя А и добавить его в один из параметров события в приложении (например, `af_param_1`):
   ```java
    Map<String, Object> purchaseEventParameters = new HashMap<String, Object>();
    purchaseEventParameters.put(AFInAppEventParameterName.PARAM_1, <REFERRER_ID>);
    purchaseEventParameters.put(AFInAppEventParameterName.CURRENCY, "USD");
    purchaseEventParameters.put(AFInAppEventParameterName.REVENUE, 200);
    
    AppsFlyerLib.getInstance().logEvent(getApplicationContext(), purchaseEventParameters);
   ```

2. На вашем бэкенде [получить данные о событиях в приложении](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-Overview#view-inapp-event-data)

3. Добавьте найденные ID рефереров в список пользователей, которые будут вознаграждены.

4. Когда пользователь A запускает приложение, проверьте, есть ли их ID реферера в списке пользователей, которые будут вознаграждены и если это есть.

> 📘 Заметка
>
> - Шаги 2-3 не выполняются мобильным разработчиком. Шаг 4 зависит от реализации шагов 2-3.
> - Событие покупки является всего лишь примером. Это относится к любому событию в приложении.
