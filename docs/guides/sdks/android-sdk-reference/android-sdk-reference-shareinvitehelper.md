---
title: ShareInviteHelper
slug: android-sdk-reference-shareinvitehelper
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-reference
privacy:
  view: public
---
## Overview
**Class declaration**
```java
public class ShareInviteHelper
```

**Import the class**
```java Java
import com.appsflyer.share.ShareInviteHelper;
```
```kotlin Kotlin
import com.appsflyer.share.ShareInviteHelper
```

## Methods

### generateInviteUrl
**Method signature**
```java
public static LinkGenerator generateInviteUrl(Context context)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:--------|:-----------|:---------------|
| `Context` | `context` | Application / Activity Context. |

**Returns**
`LinkGenerator`.

### logInvite
**Method signature** 
```java
public static void logInvite(Context context, String channel, Map<String, String> eventParameters)
```

**Description** 

**Input arguments**

| Type | Name | Description |
|:--------|:-----------|:---------------|
| `Context` | `context` | Application / Activity Context. |
| `String` | `channel` | |
| `Map<String, String>` | `eventParameters` | |

**Returns**
`void`.
