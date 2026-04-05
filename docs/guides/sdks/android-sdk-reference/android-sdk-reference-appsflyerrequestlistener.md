---
title: AppsFlyerRequestListener
slug: android-sdk-reference-appsflyerrequestlistener
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-reference
privacy:
  view: public
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
