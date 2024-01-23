---
title: "iOS Deep Linking ESP 2.0"
slug: "dl_ios_esp_2_setup"
category: 6384c30e5a754e005f668a74
parentDoc: 63a8517990401800247b99ce
hidden: false
---

## Overview

The provided code aims to regulate the functionality of wrapped links within an email campaign, specifically addressing two types: Weblinks, intended to open a website, and links designed to open the app through a universal link or App link.

## Flow description

1. Put of your support ESP domains in a constant list. We will refer to this below

```swift
   var espResolvedDeepLinkDomains = ["click.example.com", "email.example.com"]
```

2. Inform the SDK to resolve the ESP domains

```swift
AppsFlyerLib.shared().resolveDeepLinkURLs = espResolvedDeepLinkDomains
```

3. In the `didResolveDeepLink` callback check if `original_link` appears in the returned `clickEvent`

```swift
func didResolveDeepLink(_ result: DeepLinkResult) {
    if( result.deepLink?.isDeferred == true) {
        NSLog("[AFSDK] This is a deferred deep link")        
    } else {
        NSLog("[AFSDK] This is a direct deep link")

         if let originalLink = result.deepLink?.clickEvent["original_link"] as? String {
            NSLog("[AFSDK] This is a resolved ESP flow")

            // ... More code here in the next steps

         }
    }
}    
```

4. Check if the `host` of the `original_link` matches of ESP domains you declared in `ESP_DOMAINS` (see step #1)

```swift
    // Extract the host
    if let url = URL(string: originalLink) {
        if let host = url.host {
            NSLog("[AFSDK] Host:", host)
            // Check if the host part of `original_link` matches one the ESP domains assigned to `resolveDeepLinkURLs`.
            // This means this is ESP link wraps another link
            if espResolvedDeepLinkDomains.contains(host) {
                NSLog("[AFSDK] The ESP domain matches")

                // ... More code here in the next steps

            } else {
                NSLog("[AFSDK] No host found in the URL")
            }
        } else {
            NSLog("[AFSDK] Invalid URL")
        }
    } else {
        NSLog("[AFSDK] The original_link is not in click_event")
    } 
```

5. Check if the wrapped `link` is a OneLink link. If it is, the deep link flow will continue as usual.
   If not, `link` will be open in the default browser.

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

## Full code example

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
