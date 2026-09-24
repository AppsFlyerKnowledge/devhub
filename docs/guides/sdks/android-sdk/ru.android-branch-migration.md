---
title: Навигатор миграции ветки на Android
slug: ветви-миграция и андроид
category:
  uri: SDK AppsFlyer
parent:
  uri: Андроид-сдк
content:
  excerpt: >-
    Активируйте Перемещение ветки для упрощения миграции трафика из ветки в AppsFlyer
privacy:
  view: любой_с ссылкой
position: 9
---

# Что такое Перемещение Ветки?

The Branch Migration Navigator is a tool designed to support the gradual and informed migration from Branch to AppsFlyer. Позволяет AppsFlyer собирать сигналы трафика из ветви через встроенный в приложение небольшой модуль.

Это руководство объясняет, как активировать ветвь миграции на Android с помощью модуля AppsFlyerMigrationHelper, разрешает наплавку данных о трафике ветви трафика и, по желанию, поддерживает непрерывность атрибутов в период миграции. `Помощник миграции` - это новый модуль в пакете AppsFlyer SDK, который облегчает передачу данных в AppsFlyer.

Обеспечение гладкой расстановки навигатора, ваше приложение должно собирать данные атрибутов из ветви и передавать их в AppsFlyerMigrationHelper в течение первой сессии. Кроме того, в случае глубоких прямых связей (Android App Links или URI схему) приложению следует собрать глубокие связанные данные и передать их.

# Концепция потока кода

Перед реализацией потока важно понимать рациональный подход. Любая другая реализация принимается, пока вы следуете этому рациональному.

| **Сценарий**                             | **Рекомендуемая индикация**                                                  | **Действие**                                                                                          | **Метод Ветки (Щелкните Retrieval)**                                                            | **AppsFlyer Метод**                             |
| ---------------------------------------- | ---------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| \*\*Органическое приложение открыто \*\* | `branchUniversalObject` это `null`                                           | Нет данных ветки для извлечения; перейдите к запуску AppsFlyer SDK                                    | Н/Д                                                                                                                | Н/Д                                             |
| **Ветка отсроченных Глубоких Ссылки**    | `branchUniversalObject` не является `null` и `+is_first_session` это `true`  | Введите 3-секундную задержку, а затем получите и передайте программные данные для установки AppsFlyer | `Branch.getInstance().getLastAttributedTouchData()`                                                                | `AppsFlyerMigrationHelper.setAttributionData()` |
| **Филиал Direct Deep Link**              | `branchUniversalObject` не является `null` и `+is_first_session` это `false` | Получить и передать прямую глубокую ссылку на AppsFlyer                                               | `Branch.getInstance().getLatestReferringParams()` или `branchUniversalObject.getContentMetadata().convertToJson()` | `AppsFlyerMigrationHelper.setDeepLinkingData()` |

# Инициализация модуля SDK и миграции

- **Инициализировать оба SDK глобально**:
  - В контексте `application` инициализируйте ветвь и AppsFlyer SDK во всем мире.

> ⚠️ Важное
>
> Не запускайте AppsFlyer SDK `start` сразу после `init`.
> Читайте ниже, когда запускаете AppsFlyer SDK

- **Управляйте стартом AppsFlyer SDK**:
  - Вызовите метод `start` AppsFlyer SDK **только после** передавая данные глубокой ссылки из ветки в AppsFlyer. Этот подход позволяет приложению управлять инициализацией SDK, гарантируя, что все необходимые данные из ветви будут доступны заранее.
  - Во всех сценариях, в том числе когда возникает `BranchError` или когда `branchUniversalObject` является `null` (указание на открытие органического приложения) — необходимо вызвать `AppsFlyerLib. etInstance().start()`, чтобы инициировать AppsFlyer SDK, убедитесь что он работает правильно во всех сценариях запуска приложения.

# Поток модуля миграции

Все потоки модулей миграции реализованы в ветке `onInitFinished`.  
ветка рекомендует внедрить `onInitFinished` в `onStart` вашего `MainActivity`. `MainActivity` относится к приложениям, которые вы выбрали для работы с глубокой связью.
Следующий код описывает код миграции в `onInitFinished`. Полную информацию можно найти на сайте [here](#full-code-example).

## Ошибка проверки

Первоначально проверьте, вернул ли `onInitFinished` непустой `BranchError`. В этом случае пропустите поток миграции и немедленно позвоните AppsFlyer SDK `start`.

## Органический поток

Органический поток означает установку или запуск приложения, не инициированного нажатием на ссылку ветки.
В этом случае `BranchUniversalObject` возвращается пусто.
В этом случае пропустите поток миграции и немедленно позвоните AppsFlyer SDK `start`.

## Глубокая связь

Процесс миграции становится актуальным при запуске приложения при нажатии на ветку. Существует два основных типа глубоких соединений:

- Отложенная Глубокая Связь: Это происходит, когда пользователь нажимает на ссылку ветки и если приложение еще не установлено, направляется для его установки. После установки пользователь передается непосредственно на нужный контент в приложении в соответствии со ссылкой на данные
- Direct Deep Linking: Это происходит, когда приложение уже установлено, и пользователь нажимает на ссылку ветки (напр. через ссылки на Android приложения), которые открывают приложение непосредственно к указанному контенту, в соответствии с данными по ссылке

Когда обратная связь onInitFinished\` вызывается непустой «BranchUniversalObject», это указывает на то, что произошли глубокие связи. После завершения процесса миграции стандартные глубоко укоренившиеся процедуры увязки с сектором должны продолжаться как обычно.

## Отложенная глубокая связь

В отсрочке глубокой связи параметр `+is_first_session` входящего `BranchUniversalObject` является `true`.
В данном случае:

1. После обязательного 3 секунды зарегистрируйте обратный вызов `getLastAttributedTouchData`
2. В вызове `getLastAttributedTouchData`:
   - AppsFlyer `AppsFlyerMigrationHelper.setAttributionData` с входящими глубокими ссылками из `getLastAttributedTouchData`.
   - Вызов AppsFlyer `start`

## Прямая глубокая связь

В сценарии глубокой связи параметр `+is_first_session` входящего `BranchUniversalObject` является `false`.
В данном случае:

1. Вызовите AppsFlyer `AppsFlyerMigrationHelper.setDeepLinkingData` с выходом из `getLatestReferringParams`.
2. Вызов AppsFlyer `start`

# Пример полного кода

## `MainActivity`

```java

public class MainActivity extends AppCompatActivity {

    // ...
    // onNewIntent() and onCreate() not affected
    // ...
    
    @Override
    protected void onStart() {
        super.onStart();
        Branch.sessionBuilder(this).withCallback(new Branch.BranchUniversalReferralInitListener() {
            @Override
            public void onInitFinished(BranchUniversalObject branchUniversalObject, LinkProperties linkProperties, BranchError error) {

                if (error != null) {
                    // Branch init failed. Start AppsFlyer immediately
                    Log.e("BranchSDK_Tester", "branch init failed. Caused by -" + error.getMessage());
                    AppsFlyerLib.getInstance().start(MainActivity.this);
                } else {
                    Log.i("BranchSDK_Tester", "branch init complete!");
                    boolean isBranchDeeplink = branchUniversalObject != null;
                    if (isBranchDeeplink) {
                        // Deep link flow
                        JSONObject sessionParams = branchUniversalObject.getContentMetadata().convertToJson();
                        try {
                            boolean isFirstSession = Boolean.parseBoolean(sessionParams.getString("+is_first_session"));
                            if(isFirstSession) {
                                // Deferred deep link
                                new Handler(Looper.getMainLooper()).postDelayed(() -> {
                                    Branch.getInstance().getLastAttributedTouchData((jsonObject, latd_error) -> {
                                        // Read the data from the LATD jsonObject
                                        AppsFlyerMigrationHelper.setAttributionData(jsonObject);
                                        // On LATD collected
                                        AppsFlyerLib.getInstance().start(MainActivity.this);
                                    }, 7);
                                }, 3000);
                            } else {
                                // Direct deep link
                                AppsFlyerMigrationHelper.setDeepLinkingData(Branch.getInstance().getLatestReferringParams());
                                AppsFlyerLib.getInstance().start(MainActivity.this);
                            }
                            goToFruit(sessionParams.getString("fruit_name"));
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }

                    } else {
                        // Organic install or launch
                        Log.i("BranchSDK_Tester", "@@@@ branchUniversalObject came back null");
                        AppsFlyerLib.getInstance().start(MainActivity.this);
                    }

                    if (linkProperties != null) {
                        Log.i("BranchSDK_Tester", "control params " + linkProperties.getControlParams());
                    } else {
                        Log.i("BranchSDK_Tester", "@@@@ linkProperties came back null");
                    }
                }
            }
        }).withData(this.getIntent().getData()).init();
        // init the LATD call from inside the session initialization callback
    }
}
```
