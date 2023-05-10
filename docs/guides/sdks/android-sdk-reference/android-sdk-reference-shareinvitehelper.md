---
title: "ShareInviteHelper"
slug: "android-sdk-reference-shareinvitehelper"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T15:47:39.568Z"
updatedAt: "2021-07-28T11:21:23.971Z"
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