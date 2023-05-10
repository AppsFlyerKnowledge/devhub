---
title: "AppsFlyerRequestListener"
slug: "android-sdk-reference-appsflyerrequestlistener"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T18:21:31.120Z"
updatedAt: "2021-06-26T21:06:04.880Z"
---
## Overview
Intercept requests to the AppsFlyer servers by implementing the `AppsFlyerRequestListener` interface and [registering it with `start`](doc:android-sdk-reference-appsflyerlib#start).

**Interface declaration**
```java
public interface AppsFlyerRequestListener {
    void onSuccess();
    void onError(int code, @NonNull String error);
}
```

**Import the interface**
```java Java
import com.appsflyer.attribution.AppsFlyerRequestListener;
```
```kotlin Kotlin
import com.appsflyer.attribution.AppsFlyerRequestListener
```

## Methods
### onSuccess
**Method signature**
```java
void onSuccess();
```

**Callback parameters**
This callback returns no parameters.

**Description**
Triggered upon a successful response.

### onError
**Method signature**
```java
void onError(int code, @NonNull String error);
```

**Description**
Triggered upon a successful response.

**Callback parameters**

| Type | Name | Description |
|:--------|:----------|:------------------|
| `int` | `code` | Error code. |
| `String` | `error` | Error message. |