---
title: Приглашение пользователя iOS
slug: dl_ios_user_invite
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

## Общий обзор

Реализация и атрибут пользователя приглашают ссылки, когда существующие пользователи ссылаются на других в вашем приложении.  
Для введения смотрите [приглашение пользователей](https://dev.appsflyer.com/hc/docs/dl_user_invite).

Хотите увидеть полный пример? проверить рецепт:

[block:tutorial-tile]
{
"backgroundColor": "#01f44a",
"emoji": "✍️",
"id": "61b66080b17b13005ba40a18",
"link": "https://dev.appsflyer. om/v0.1/recipes/onelink-user-invite-in-ios-1",
"slug": "onelink-user-invite-in-ios-1",
"title": "OneLink user invite in iOS"
}
[/block]

## Реализовать пользователя

**Прежде чем начать**: Синхронизируйте с маркером, чтобы выяснить желаемые варианты использования ссылок и получить список [parameters](https://support.appsflyer.com/hc/en-us/articles/115004480866#parameters), которые хотят быть реализованы.

Чтобы реализовать атрибут приглашения пользователя, выполните следующие шаги:

1. [Настройте создание пригласительной ссылки](#set-up-invite-link-generation) для генерации пригласительных ссылок.
2. <span class="annotation-optional">Optional</span> [Log the invite link creation](#log-invite-link-creation-events).
3. Настройте [Единую глубинку](doc:dl_ios_unified_deep_linking) (UDL)
4. <span class="annotation-optional">Опционально</span> [Получение данных о реферере от пригласительных ссылок](#set-up-udl-for-user-invite-attribution).
5. <span class="annotation-optional">Опциональная</span> Настройте [награды реферала](#reward-referrers).

Следующий код основан на [примере маркера](https://support.appsflyer.com/hc/en-us/articles/115004480866#example).

### Настроить создание пригласительной ссылки

Для того, чтобы пользователи могли пригласить их друзей в ваше приложение, вам нужен способ создания пригласительных ссылок. Это делается с помощью `AppsFlyerLinkGenerator`.  
**Для настройки генерации пригласительной ссылки:**

1. Убедитесь, что импортируете `AppsFlyerLib`:
   ```swift
   импортировать com.appsflyer.AppsFlyerLib;
   ```

2. В `AppDelegate` установите шаблон OneLink, используя [`appInviteOneLinkID`](ios-sdk-reference-appsflyerlib#appinviteonelinkid) (ID шаблона [предоставлен маркером](hhttps://support.appsflyer.com/hc/en-us/articles/115004480866#procedures)):

   ```swift
   AppsFlyerLib.shared().appInviteOneLinkID = "H5hv" // Задайте ID шаблона OneLink для ссылок приглашения пользователя
   ```

   > 📘 Заметка
   >
   > - Не забудьте установить `appInviteOneLinkID` **ранее** вызов `start`
   > - Шаблон OneLink должен быть связан с приложением.

   1. Позвоните [`AppsFlyerShareInviteHelper.generateInviteUrl`](doc:ios-sdk-reference-appsflyershareinvitehelper#generateinviteurl) и передайте его [`AppsFlyerLinkGenerator`](doc:ios-sdk-reference-appsflyerlinkgenerator) и `completionHandler`:

      ```swift
      AppsFlyerShareInviteHelper. enerateInviteUrl(
          linkGenerator: {
              (_ генератор: AppsFlyerLinkGenerator) -> AppsFlyerLinkGenerator в
                  генератор. ddParameterValue(<TARGET_VIEW>, forKey: "deep_link_value")
                  генератора. ddParameterValue(<PROMO_CODE>, forKey: "deep_link_sub1")
                  генератора. ddParameterValue(<REFERRER_ID>, forKey: "deep_link_sub2")
                  // Необязательно; предоставляет идентификатор реферера в генераторе raw-data report
                  . ddParameterValue(<REFERRER_ID>, forKey: "af_sub1")
                  генератор. etCampaign("Летая_продажа")
                  генератора. etChannel("mobile_share")
            		// Необязательно; установите фирменное имя домена:
            		generator.brandDomain = "brand.domain. om"
                  return generator
          },
          completionHandler: {
              (_ url: URL? -> Аннулировать в
                  если url ! nil {
                      NSLog("[AFSDK] AppsFlyer share-invite link: \(url!. bsoluteString)")
                  }        
                  else {
                      print("url is nil")
                  }
              }
      )
      ```

      В зависимости от потока пользователя вы и маркетолог хотят достичь, настройте `generator` следующим образом:

      - Установка параметров атрибуции, используя [setters](ios-sdk-reference-appsflyerlinkgenerator#methods).
      - Установить глубокие параметры соединения, используя [`AppsFlyerLinkGenerator.addParameterValue`](doc:ios-sdk-reference-appsflyerlinkgenerator#addparametervalue):

        - `deep_link_value`: Приложение испытывает указанного пользователя глубокой связью.
        - `deep_link_sub1`: Параметр настраиваемый. В этом примере передается промо-код, полученный приглашением.
        - `deep_link_sub2`: идентификатор реферера. Может быть использовано для награды реферера.

        <br />

      > 📘 Заметка
      >
      > Вы также можете включить другие стандартные параметры AppsFlyer, такие как параметры перенаправления, такие как `af_web_dp`, при создании OneLinks через SDK. Подробнее о доступных параметрах смотрите [О структуре ссылок и параметрах](https://support.appsflyer.com/hc/en-us/articles/207447163-About-link-structure-and-parameters).

3. В `completionHandler` проверьте, был ли URL-адрес успешно создан (`url` не `nil`), и восстановите сгенерированную ссылку-приглашение пользователя.

4. Разрешить пользователям делиться сгенерированными ссылками. Например, скопируйте его в буфер обмена.

### Задать ID шортссылки

<span class="annotation-optional">Optional</span>  
The shortlink ID can be determined by the developer, by adding the parameter `af_custom_shortlink` to the `LinkGenerator` instance.

```swift
generator.addParameterValue(<value>, forKey:"af_custom_shortlink")
```

### Записывать события по созданию ссылки приглашения

<span class="annotation-optional">Опциональное</span>  
**Чтобы зарегистрировать событие создания пригласительной ссылки**:  
Отправить событие, указывающее, что пользователь создал ссылку-приглашение, используя [`logInvite`](doc:ios-sdk-reference-appsflyershareinvitehelper#loginvite):

```swift
AppsFlyerShareInviteHelper.logInvite(<CHANNEL>, параметры: [
    "кампания" : "summer_sale",
    "referrerId" : <REFERRER_ID>,
]);
```

`logInvite` приводит к событию в `af_invite`.

> 📘 Заметка
>
> Если вы не хотите использовать канал, используйте `logEvent`.

### Настройка UDL для атрибута приглашения пользователя

<span class="annotation-optional">Optional</span>  
**To set up UDL for user invite attribution:**

1. Настройте [Unified Deep Linking](doc:dl_ios_unified_deep_linking) (UDL).

2. В `DeepLinkDelegate.didResolveDeepLink` извлекает глубокие параметры соединения, созданные во время генерации ссылок. В этом примере получаются следующие свойства:

   - `deep_link_value`, используя `DeepLink.deeplinkValue`
   - `deep_link_sub1`, используя `DeepLink.clickEvent["deep_link_sub1"]`
   - `deep_link_sub2`, используя `DeepLink.clickEvent["deep_link_sub2"]`

   See code: [Swift](https://github.com/AppsFlyerSDK/appsflyer-onelink-ios-sample-apps/blob/11178dd846fa105cff295312286274824c556339/swift/basic_app/basic_app/AppDelegate.swift#L134).

3. Получив идентификатор реферера, вы сами решаете, как он хранится и используется.

## Рефереры наград

<span class="annotation-optional">Optional</span>  
In the following scenarios, **User A** invites **User B** to your app.

### Рефералы вознаграждения при установке

**Сценарий:** Пользователь B установит ваше приложение по пригласительной ссылке пользователя А.  
ID referrer пользователя A доступен в UDL `didResolveDeepLink` (в этом примере, в разделе `DeepLink.clickEvent["deep_link_sub2"]`). После получения идентификатора добавьте его в список идентификаторов рефереров, чтобы получить вознаграждение. Это зависит от того, как хранить и получать список.

### Рефералы вознаграждений за события в приложении

**Сценарий:** Пользователь B совершает покупку. Вы хотите вознаградить пользователя А, который изначально направил пользователя B в ваше приложение, за действие.

**Чтобы вознаградить пользователя A за действия пользователя:**

1. Получить идентификатор referrer пользователя А и добавить его в один из параметров события в приложении (например, `af_param_1`):
   ```swift
   AppsFlyerLib.shared().logEventEvent(AFEventPurchase, 
     withValues: [
   		AFEventParamRevenue: 200,
   		AFEventParamCurrency:"USD",
           AFEventParam1: <REFERRER_ID>
   ]);
   ```
2. На вашем бэкенде [получить данные о событиях в приложении](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-Overview#view-inapp-event-data).
3. Добавьте найденные ID рефереров в список пользователей, которые будут вознаграждены.
4. Когда пользователь A запускает приложение, проверьте, есть ли их ID реферера в списке пользователей, которые будут вознаграждены и если это есть.

> 📘 Заметка
>
> - Шаги 2-3 не выполняются мобильным разработчиком. Шаг 4 зависит от реализации шагов 2-3.
> - Событие покупки является всего лишь примером. Это относится к любому событию в приложении.

----------------

<span class="annotation-optional">Optional</span>  
In the following scenarios, **User A** invites **User B** to your app.

### Рефералы вознаграждения при установке

**Сценарий:** Пользователь B установит ваше приложение по пригласительной ссылке пользователя А.  
ID referrer пользователя A доступен в UDL `didResolveDeepLink` (в этом примере, в разделе `DeepLink.clickEvent["deep_link_sub2"]`). После получения идентификатора добавьте его в список идентификаторов рефереров, чтобы получить вознаграждение. Это зависит от того, как хранить и получать список.

### Рефералы вознаграждений за события в приложении

**Сценарий:** Пользователь B совершает покупку. Вы хотите вознаградить пользователя А, который изначально направил пользователя B в ваше приложение, за действие.

**Чтобы вознаградить пользователя A за действия пользователя:**

1. Получить идентификатор referrer пользователя А и добавить его в один из параметров события в приложении (например, `af_param_1`):
   ```swift
   AppsFlyerLib.shared().logEventEvent(AFEventPurchase, 
     withValues: [
   		AFEventParamRevenue: 200,
   		AFEventParamCurrency:"USD",
           AFEventParam1: <REFERRER_ID>
   ]);
   ```
2. На вашем бэкенде [получить данные о событиях в приложении](https://support.appsflyer.com/hc/en-us/articles/115005544169-Rich-in-app-events-Overview#view-inapp-event-data).
3. Добавьте найденные ID рефереров в список пользователей, которые будут вознаграждены.
4. Когда пользователь A запускает приложение, проверьте, есть ли их ID реферера в списке пользователей, которые будут вознаграждены и если это есть.

> 📘 Заметка
>
> - Шаги 2-3 не выполняются мобильным разработчиком. Шаг 4 зависит от реализации шагов 2-3.
> - Событие покупки является всего лишь примером. Это относится к любому событию в приложении.
