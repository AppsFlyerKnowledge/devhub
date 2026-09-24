---
title: Глубокая связь ESP 2.0
slug: dl_android_esp_2_setup
category:
  uri: Глубокая связь и OneLink
parent:
  uri: dl_android_обзор
privacy:
  view: публичный
---

## Общий обзор

Предоставленный код призван регулировать функциональность сворачиваемых ссылок в кампании по электронной почте, в частности для двух типов: веб-ссылки, предназначена для открытия веб-сайта и ссылок, предназначенных для открытия приложения через универсальную ссылку или ссылку на приложение.

## Описание потока

1. Поддерживайте ESP домены в постоянном списке. Ссылки на это приведены ниже

```java
   public static final String[] ESP_DOMAINS = {
            "click.example.com",
            "email.example.com"
};
```

2. Информировать SDK для разрешения ESP доменов

```java
AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
appsflyer.setResolveDeepLinkURLs(ESP_DOMAINS);
```

3. В обратном вызове `onDeepLinking` проверьте, появляется ли `original_link` в возвращаемом `clickEvent`

```java
@Override
public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult) {
    DeepLink deepLinkObj = deepLinkResult. etDeepLink();

    if (deepLinkObj.isDeferred()) {
        Log. (LOG_TAG, "Это отложенная глубокая ссылка");
    } else {
        Log. (LOG_TAG, "Это прямая глубокая ссылка");

        // Следующая `try` является входной точкой потока разрешения ESP
        // Проверка `try` в объекте DeepLink включает в себя поле `original_link`
        try {
                Uri espUri = Uri. arse(deepLinkObj.getClickEvent().getString("original_link"));
                Журнал. (LOG_TAG, "Это разрешенный ESP поток");

            // ... Больше кода здесь на следующих стадиях

        } catch (JSONException e) {
            Log. (LOG_TAG, "original_link НЕ найдена в глубоких данных. Это нормальный поток.");
        }
}
```

4. Проверьте, совпадает ли `host` доменов `original_link` с ESP, указанных вами в `ESP_DOMAINS` (см. шаг #1)

```java
    // Извлечение хоста
    String espHost = espUri.getHost();
    Log. (LOG_TAG, "ESP хост: " + esphost);

    // Метод `testDomainInEspDomains` проверяет, соответствует ли хост-часть `original_link`
    // ESP доменам, назначенным `setResolveDeepLinkURLs`.
    // Это означает, что это ESP ссылка завершает другую ссылку
    if (testDomainInEspDomains(espHost)) {
    Log. (LOG_TAG, "The ESP domain match");

    // ... Больше кода здесь на следующих стадиях 
        
    } else {
        Log. (LOG_TAG, "ESP домен не соответствует домену, который мы хотим решить");
    }}


// Внедрение этого метода в вашем классе
частных булев testDomainInEspDomains(String testDomain) {
    for (String element : ESP_DOMAINS) {
        if (testDomain. quals(element)) {
            return true; // Строка соответствует элементу в массиве
        }
    }
    return false; // Строка не соответствует ни одному элементу массива
}
```

5. Проверьте, является ли завернутая ссылкой OneLink. Если это так, то глубокий поток ссылок будет продолжаться как обычно.
   Если нет, `link` будет открыт в браузере по умолчанию.

```java
    Строка espLink = deepLinkObj.getClickEvent(). ptString("link");
    // Следующий `if` проверяет, должна ли завернутая ссылка продолжить углубленную ссылку или открыть ссылку в браузере.
    // Если завернутая ссылка заканчивается на ".onelink. e" он явно является OneLink и будет континентальным потоком Глубоких ссылок.
    // Первое условие — это маловероятный случай, когда AF разрешит соединения, не работают.
    if (espUri.toString().equals(espLink) ||
        Uri. arse(espLink).getHost().endsWith(".onelink.me")) {
        Log.d(LOG_TAG, "The ESP link is a OneLink. Глубокая ссылка продолжает нормально работать");
    } else {
        // Завернутая ссылка - это ссылка, предназначенная для открытия в веб-браузере по умолчанию
        Log. (LOG_TAG, "ESP ссылка не является OneLink. Он будет открыт в браузере);
        openUrlInBrowser(espLink);
        Возвращение;
}
```

## Пример полного кода

```java

public static final String[] ESP_DOMAINS = {
            "click.example.com",
            "email.example.com"
    };


AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
appsflyer.setResolveDeepLinkURLs(ESP_DOMAINS);

appsflyer.subscribeForDeepLink(new DeepLinkListener(){
    @Override
    public void onDeepLinking(@NonNull DeepLinkResult deepLinkResult) {
        DeepLink deepLinkObj = deepLinkResult.getDeepLink();

        if (deepLinkObj.isDeferred()) {
            Log.d(LOG_TAG, "This is a deferred deep link");
        } else {
            Log.d(LOG_TAG, "This is a direct deep link");

            // The following `try` is the entry point to the ESP resolution flow
            // The `try` checks if the DeepLink object includes an `original_link` field
            try {
                    Uri espUri = Uri.parse(deepLinkObj.getClickEvent().getString("original_link"));
                    Log.d(LOG_TAG, "This is a resolved ESP flow");
                    
                    // Extract the host
                    String espHost = espUri.getHost();
                    Log.d(LOG_TAG, "ESP host found: " + espHost);

                    // The method `testDomainInEspDomains` checks if the host part of `original_link`
                    // matches one the ESP domains assigned to `setResolveDeepLinkURLs`.
                    // This means this is ESP link wraps another link
                    if (testDomainInEspDomains(espHost)) {
                        Log.d(LOG_TAG, "The ESP domain matches");
                        String espLink = deepLinkObj.getClickEvent().optString("link");
                        // The following `if` checks if the wrapped link should continue deep link or open the link in a browser.
                        // If the wrapped link ends with ".onelink.me" it is obviously a OneLink and will contine the Deep Link flow.
                        // The first condition is a workaround to the unlikely case AF link resolving server are down.
                        if (espUri.toString().equals(espLink) ||
                            Uri.parse(espLink).getHost().endsWith(".onelink.me")) {
                            Log.d(LOG_TAG, "The ESP link is a OneLink link. Deep link continues normally");
                        } else {
                            // The wrapped link is a link meant to be opened in the default web browser
                            Log.d(LOG_TAG, "The ESP link is NOT a OneLink link. It will be opened in a browser");
                            openUrlInBrowser(espLink);
                            return;
                        }
                    } else {
                        Log.d(LOG_TAG, "The ESP domain found doesn't match the domain we wish to resolve");
                    }

            } catch (JSONException e) {
                Log.d(LOG_TAG, "original_link was NOT found in deeplink data. This is a normal flow.");
            }
        }

    }
});

private static boolean testDomainInEspDomains(String testDomain) {
        for (String element : ESP_DOMAINS) {
            if (testDomain.equals(element)) {
                return true; // String matches an element in the array
            }
        }
        return false; // String doesn't match any element in the array
}
```
