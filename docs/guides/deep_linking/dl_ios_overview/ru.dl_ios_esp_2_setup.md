---
title: Глубокая связь с iOS 2.0
slug: dl_ios_esp_2_setup
category:
  uri: Глубокая связь и OneLink
parent:
  uri: дл_ios_обзор
privacy:
  view: публичный
---

## Общий обзор

Предоставленный код призван регулировать функциональность сворачиваемых ссылок в кампании по электронной почте, в частности для двух типов: веб-ссылки, предназначена для открытия веб-сайта и ссылок, предназначенных для открытия приложения через универсальную ссылку или ссылку на приложение.

## Описание потока

1. Поддерживайте ESP домены в постоянном списке. Ссылки на это приведены ниже

```swift
   var espResolvedDeepLinkDomains = ["click.example.com", "email.example.com"]
```

2. Информировать SDK для разрешения ESP доменов

```swift
AppsFlyerLib.shared().resolveDeepLinkURLs = espResolvedDeepLinkDomains
```

3. В `didResolveDeepLink` проверьте, появляется ли `original_link` в возвращаемом `clickEvent`

```swift
func didResolveDeepLink(_ результат: DeepLinkResult) {
    if( result.deepLink?. sDeferred == true) {
        NSLog("[AFSDK] Это отсроченная глубокая ссылка")        
    } else {
        NSLog("[AFSDK] Это прямая глубокая ссылка")

         если пусть originalLink = результат. eepLink?. lickEvent["original_link"] как? String {
            NSLog("[AFSDK] Это разрешенный ESP поток")

            // . . Больше кода здесь на следующих шагах

         }
    }
}    
```

4. Проверьте, совпадает ли `host` доменов `original_link` с ESP, указанных вами в `ESP_DOMAINS` (см. шаг #1)

```swift
    // Извлечь хост
    if let url = URL(string: originalLink) {
        if let host = url. ost {
            NSLog("[AFSDK] Host:", host)
            // Проверьте, соответствует ли хост-часть `original_link` доменам ESP, назначенным `resolveDeepLinkURLs`.
            // Это означает, что это ESP связь завершает другую ссылку
            если espResolvedDeepLinkDomains. ontains(host) {
                NSLog("[AFSDK] ESP domain match")

                // ... Код больше здесь на следующих шагах

            } else {
                NSLog("[AFSDK] Не найден хост в URL")
            }
        } else {
            NSLog("[AFSDK] Недопустимый URL")
        }
    } else {
        NSLog("[AFSDK] original_link не находится в click_event")
} 
```

5. Проверьте, является ли завернутая ссылкой OneLink. Если это так, то глубокий поток ссылок будет продолжаться как обычно.
   Если нет, `link` будет открыт в браузере по умолчанию.

```swift
    if let espLink = result.deepLink?.clickEvent["link"] as? String {
        if let espUrl = URL(string: espLink) {
            if let espHost = espUrl.host {
                NSLog("[AFSDK] Host: ", espHost)
                // The following `if` checks if the wrapped link should continue deep link or open the link in a browser.
                // If the wrapped link ends with ".onelink.me" it is obviously a OneLink and will continue the Deep Link flow.
                // The first condition is a workaround to the unlikely case AF link resolving server are down.
                if espHost.hasSuffix(".onelink.me") {
                    NSLog("[AFSDK] The ESP link is a OneLink link. Deep link continues normally")
                } else {
                    // Use the 'url' instance here, for example, print the absoluteString
                    print("URL created:", url.absoluteString)
                    NSLog("[AFSDK] The ESP link is NOT a OneLink link. It will be opened in a browser")
                    NSLog("[AFSDK] ESP marks to divert the link to the browser")
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(espUrl, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        UIApplication.shared.openURL(espUrl)
                    }
                }
            } else {
                NSLog("[AFSDK] No host found in the URL")
            }
        } else {
            NSLog("[AFSDK] Invalid URL")
        }
    } else {
        NSLog("[AFSDK] No link found")
    }
```

## Пример полного кода

```swift

func didResolveDeepLink(_ result: DeepLinkResult) {
    if( result.deepLink?.isDeferred == true) {
        NSLog("[AFSDK] This is a deferred deep link")
    } else {
        NSLog("[AFSDK] This is a direct deep link")

        // The following `if` is the entry point to the ESP resolution flow
                    // The `if` checks if the DeepLink object includes an `original_link` field
        if let originalLink = result.deepLink?.clickEvent["original_link"] as? String {
            NSLog("[AFSDK] This is a resolved ESP flow")
            // Extract the host
            if let url = URL(string: originalLink) {
                if let host = url.host {
                    NSLog("[AFSDK] Host:", host)
                    // Check if the host part of `original_link` matches one the ESP domains assigned to `resolveDeepLinkURLs`.
                    // This means this is ESP link wraps another link
                    if espResolvedDeepLinkDomains.contains(host) {
                        NSLog("[AFSDK] The ESP domain matches")
                        if let espLink = result.deepLink?.clickEvent["link"] as? String {
                            if let espUrl = URL(string: espLink) {
                                if let espHost = espUrl.host {
                                    NSLog("[AFSDK] Host: ", espHost)
                                    // The following `if` checks if the wrapped link should continue deep link or open the link in a browser.
                                    // If the wrapped link ends with ".onelink.me" it is obviously a OneLink and will continue the Deep Link flow.
                                    // The first condition is a workaround to the unlikely case AF link resolving server are down.
                                    if espHost.hasSuffix(".onelink.me") {
                                        NSLog("[AFSDK] The ESP link is a OneLink link. Deep link continues normally")
                                    } else {
                                        // Use the 'url' instance here, for example, print the absoluteString
                                        print("URL created:", url.absoluteString)
                                        NSLog("[AFSDK] The ESP link is NOT a OneLink link. It will be opened in a browser")
                                        NSLog("[AFSDK] ESP marks to divert the link to the browser")
                                        if #available(iOS 10.0, *) {
                                            UIApplication.shared.open(espUrl, options: [:], completionHandler: nil)
                                        } else {
                                            // Fallback on earlier versions
                                            UIApplication.shared.openURL(espUrl)
                                        }
                                    }
                                } else {
                                    NSLog("[AFSDK] No host found in the URL")
                                }
                            } else {
                                NSLog("[AFSDK] Invalid URL")
                            }
                        } else {
                            NSLog("[AFSDK] No link found")
                        }
                    }
                } else {
                    NSLog("[AFSDK] No host found in the URL")
                }
            } else {
                NSLog("[AFSDK] Invalid URL")
            }
        } else {
            NSLog("[AFSDK] The original_link is not in click_event")
        }
    }
}
```
