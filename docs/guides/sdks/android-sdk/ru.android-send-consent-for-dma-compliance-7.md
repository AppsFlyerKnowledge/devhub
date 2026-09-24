---
title: Отправить согласие на соответствие DMA
slug: android-send-consent-for-dma-compliance-7
category:
  uri: SDK AppsFlyer
parent:
  uri: особенностей-Андроид-7
privacy:
  view: публичный
position: 3
---

Общее введение к данным о согласии DMA см. в разделе [here](https://dev.appsflyer.com/hc/docs/send-consent-for-dma-compliance).

SDK предлагает два альтернативных метода сбора данных о согласии:

- **Через согласованную платформу управления (CMP)**: Если приложение использует CMP, соответствующий [прозрачности и согласованности Framework (TCF) v2. /2.3 протокол](https://iabeurope.eu/tcf-supporting-resources/), SDK может автоматически получить информацию о согласии.

  **ИЛИ**

- **Через выделенный SDK API**: разработчики могут передавать требуемые данные Google напрямую в SDK с помощью определенного для этой цели API.

> 📘 Заметка
>
> AppsFlyer рекомендует использовать только один из вышеперечисленных методов для каждого конкретного события отправления. Если оба метода отправляются для одного и того же события, AppsFlyer будет приоритизировать данные ручного согласия, отправленные через выделенный SDK API.

## Использовать CMP для сбора данных согласия

CMP совместимый с TCF v2.2/2.3 собирает данные согласия DMA и хранит их в разделе SharedPreferences. Чтобы включить SDK для доступа к этим данным и их включения с каждым событием, выполните следующие действия:

1. [Инициализировать SDK](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) из класса `Application`.
2. Сразу после инициализации SDK вызовите `enableTCFDataCollection(true)` для указания SDK собирать данные TCF с устройства.
3. В классе `Activity`, используйте CMP для решения о необходимости диалога согласия в текущей сессии.
4. При необходимости показать диалог согласия с использованием CMP, чтобы принять решение о согласии пользователя. В противном случае, перейдите к шагу 6.
5. Получайте от CMP подтверждение того, что пользователь принял решение о согласии и данные доступны в разделе "Общие настройки".
6. Вызов `start()`.

**Класс приложения**

```java
public class AppsflyerBasicApp расширяет Application {
    @Override
    public void onCreate() {
      super. nCreate();
      String afDevKey = AppsFlyerConstants.afDevKey;
      AppsFlyerLib appsflyer = AppsFlyerLib. etInstance();  
      // В этом примере AppsFlyerConversionListener не инициализирован.
      // Это необязательный
      appsflyer. nit(afDevKey, null, this);
      appsflyer.enableTCFDataCollection(true);
    }
}}	
```

**Класс действия**

```java
public class MainActivity расширяет AppCompatActivity {

  private boolean consentRequired = true;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
      super. nCreate(savedInstanceState);
      setContentView(R.layout. ctivity_main);
      if (consentRequired)
          initConsentCollection();
      else
          AppsFlyerLib. etInstance(). tart(this);
  }
  
  private void initConsentCollection() {
    // Реализовать здесь процесс CMP
    // Когда поток завершен и получено согласие 
    // call onConsentCollectionFinished()
  }

  private void onConsentCollectionFinished() {
    AppsFlyerLib. etInstance().start(this);
}
```

## Вручную собирать данные согласия

Чтобы вручную собирать данные согласия, выполните следующие действия:

1. [Инициализация SDK](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#init) из класса приложения.
2. В классе `Activity` укажите, применяется ли GDPR к пользователю.
3. Определяет, сохранены ли данные согласия для этой сессии.
   - При отсутствии сохраненных данных согласия показывать диалог согласия для принятия решения о согласии пользователя.
   - При наличии согласия данные сохраняются на следующий шаг.
4. Для передачи согласия на SDK создайте объект [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerconsent) со следующими дополнительными параметрами:
   - `isUserSubjectToGDPR` - Указывает, применим ли GDPR к пользователю.
   - `hasConsentForDataUsage` - указывает, дал ли пользователь согласие на использование своих данных в рекламных целях.
   - `hasConsentForAdsPersonalization` - указывает, дал ли пользователь согласие на использование своих данных в персонализированных рекламных целях.
   - `hasConsentForAdStorage` - указывает, дал ли пользователь согласие на хранение или доступ к информации на устройстве.
5. Если GDPR не применим к пользователю `isUserSubjectToGDPR` является `false`, остальные параметры должны быть `null`. Пример ниже.
6. Вызовите [`setConsentData()`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setconsentdata) с помощью объекта [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerconsent).

> 📘 Заметка
>
> SDK регистрирует только параметры, которые явно передаются методу [`setConsentData()`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setconsentdata) с помощью объекта [`AppsFlyerConsent`](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerconsent).

6. Вызов `start()`.

```java
// Установите данные согласия на SDK:
// Сбор данных с согласия
// или извлечение их из хранилища
...
// Пример для пользователя, НЕ подлежащего GDPR
AppsFlyerConsent nonGdprUser = new AppsFlyerConsent(false, null, null, null);
AppsFlyerLib.getInstance(). etConsentData( nonGdprUser);

// Пример для пользователя под GDPR
AppsFlyerConsent gdprUser = new AppsFlyerConsent(true, true, true, true, false);
AppsFlyerLib. etInstance().setConsentData( gdprUser);

// Запуск AppsFlyer SDK
AppsFlyerLib.getInstance().start(this);
```

## Проверка данных согласия отправлена

Чтобы проверить, посылает ли SDK данные согласия DMA на каждое событие, выполните следующие действия:

1. [Включить режим отладки SDK](https://dev.appsflyer.com/hc/docs/integrate-android-sdk#enabling-debug-mode).
2. Поиск `consent_data` в журнале исходящего запроса.

### Пример логов сниппета для CMP потока

```
LAUNCH-10: Подготовка данных: { ... {"consent_data":{"tcf":{"policy_version":4,"cmp_sdk_id":300,"cmp_sdk_version":2,"gdpr_applies":1,"tcstring":"XXXXXXXX"}} ... }
```

### Пример логов для ручного потока

```
LAUNCH-10: Подготовка данных: { ... {"consent_data":{"manual":{"gdpr_applies":true,"ad_user_data_enabled":true,"ad_personalization_enabled":true}}} ... }
```
