---
title: "Android Deep Linking ESP 2.0"
slug: "dl_android_esp_2_setup"
category: 6384c30e5a754e005f668a74
parentDoc: 6387276d97e08d00104d4435
hidden: false
---

## Overview

The provided code aims to regulate the functionality of wrapped links within an email campaign, specifically addressing two types: Weblinks, intended to open a website, and links designed to open the app through a universal link or App link.

## Flow description

1. Put of your support ESP domains in a constant list. We will refer to this below

```java
   public static final String[] ESP_DOMAINS = {
            "click.example.com",
            "email.example.com"
    };
```

2. Inform the SDK to resolve the ESP domains

```java
AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
appsflyer.setResolveDeepLinkURLs(ESP_DOMAINS);
```

3. In the `onDeepLinking` callback check if `original_link` appears in the returned `clickEvent`

```java
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

            // ... More code here in the next stages

        } catch (JSONException e) {
            Log.d(LOG_TAG, "original_link was NOT found in deeplink data. This is a normal flow.");
        }
    }
```

4. Check if the `host` of the `original_link` matches of ESP domains you declared in `ESP_DOMAINS` (see step #1)

```java
    // Extract the host
    String espHost = espUri.getHost();
    Log.d(LOG_TAG, "ESP host found: " + espHost);

    // The method `testDomainInEspDomains` checks if the host part of `original_link`
    // matches one the ESP domains assigned to `setResolveDeepLinkURLs`.
    // This means this is ESP link wraps another link
    if (testDomainInEspDomains(espHost)) {
    Log.d(LOG_TAG, "The ESP domain matches");

    // ... More code here in the next stages 
        
    } else {
        Log.d(LOG_TAG, "The ESP domain found doesn't match the domain we wish to resolve");
    }}


// Implement this method in your class
private static boolean testDomainInEspDomains(String testDomain) {
    for (String element : ESP_DOMAINS) {
        if (testDomain.equals(element)) {
            return true; // String matches an element in the array
        }
    }
    return false; // String doesn't match any element in the array
}
```

5. Check if the wrapped `link` is a OneLink link. If it is, the deep link flow will continue as usual. 
   If not, `link` will be open in the default browser.

```java
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
```

## Full code example

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
