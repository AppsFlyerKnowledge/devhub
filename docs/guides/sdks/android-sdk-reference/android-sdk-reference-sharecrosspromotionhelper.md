---
title: "CrossPromotionHelper"
slug: "android-sdk-reference-sharecrosspromotionhelper"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T15:46:41.320Z"
updatedAt: "2021-07-04T10:30:31.934Z"
---
## Overview
Android SDK cross-promotion helper class.

Go back to the [SDK reference index](doc:android-sdk-reference).

**Class declaration**
```java
public class CrossPromotionHelper
```

**Import the class**
```java Java
import com.appsflyer.share.CrossPromotionHelper;
```
```kotlin Kotlin
import com.appsflyer.share.CrossPromotionHelper
```

## Methods
### logAndOpenStore
**Method signature**
```java
public static void logAndOpenStore(@NonNull Context context,
                                       String promoted_app_id,
                                       String campaign,
                                       Map<String, String> userParams)
```
**Description**

**Input arguments**

| Type | Name | Description |
|:--------|:---------|:-----------------|
| `Context` | `context` | Application / Activity Context. |
| `String` | `promoted_app_id` | |
| `String` | `campaign` | Name of cross-promotion campaign. |
| `Map<String, String>` | `userParams` | Optional. |

**Returns**
`void`.

### logCrossPromoteImpression
**Method signature**
```java
public static void logCrossPromoteImpression(@NonNull Context context,
                                                 String appID,
                                                 String campaign,
                                                 Map<String, String> userParams)
```
**Description**

**Input arguments**

| Type | Name | Description |
|:--------|:---------|:-----------------|
| `Context` | `context` | Application / Activity Context. |
| `String` | `appID` | |
| `String` | `campaign` | Name of cross-promotion campaign. |
| `Map<String, String>` | `userParams` | Optional. |

**Returns**
`void`.

### setUrl
**Method signature**
```java
public static void setUrl(Map<String, String> mapOfURLs)
```
**Description**

**Input arguments**

| Type | Name | Description |
|:--------|:---------|:-----------------|
| `Map<String, String>` | `mapOfURLs` | |

**Returns**
`void`.