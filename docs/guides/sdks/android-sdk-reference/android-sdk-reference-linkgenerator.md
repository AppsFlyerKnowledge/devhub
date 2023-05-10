---
title: "LinkGenerator"
slug: "android-sdk-reference-linkgenerator"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-26T15:50:40.649Z"
updatedAt: "2022-04-14T12:05:33.361Z"
---
## Overview
**Public constructor**
```java
public LinkGenerator(String mediaSource)
```

**Import the class**
```java Java
import com.appsflyer.share.LinkGenerator;
```
```kotlin Kotlin
import com.appsflyer.share.LinkGenerator
```

## Methods
### setBrandDomain
**Methods signature**
```java
public LinkGenerator setBrandDomain(String brandDomain)
```

**Returns**
`LinkGenerator`.

### getBrandDomain
**Method signature**
```java
public String getBrandDomain()
```

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`String`.

### setDeeplinkPath
**Method signature**
```java
public LinkGenerator setDeeplinkPath(String deeplinkPath)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `deeplinkPath` | |

**Returns**
`LinkGenerator`.

### setBaseDeeplink
**Method signature**
```java
public LinkGenerator setBaseDeeplink(String baseDeeplink)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `baseDeeplink` | |

**Returns**
`LinkGenerator`.

### getChannel
**Method signature**
```java
public String getChannel()
```

**Description**

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`String`.

### setChannel
**Method signature**
```java
public LinkGenerator setChannel(String channel)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `channel` | |

**Returns**
`LinkGenerator`.

### setReferrerCustomerId
**Method signature**
```java
public LinkGenerator setReferrerCustomerId(String referrerCustomerId)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `referrerCustomerId` | |

**Returns**
`LinkGenerator`.

### getMediaSource
**Method signature**
```java
public String getMediaSource()
```

**Description**

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`String`.

### getUserParams

> **Notice** - The method was names `getParameters` prior to SDK version 6.4.2

**Method signature**
```java
public Map<String, String> getUserParams()
```

**Description**

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`Map<String, String>`.

### getCampaign
**Method signature**
```java
public String getCampaign()
```

**Description**

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`String`.

### setCampaign
**Method signature**
```java
public LinkGenerator setCampaign(String campaign)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `campaign` | |

**Returns**
`LinkGenerator`.

### addParameter
**Method signature**
```java
public LinkGenerator addParameter(String key, String value)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `key` | Parameter name. |
| `String` | `value` | Parameter value. |

**Returns**
`LinkGenerator`.

### addParameters
**Method signature**
```java
public LinkGenerator addParameters(Map<String, String> parameters)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `Map<String, String>` | `parameters` | |

**Returns**
`LinkGenerator`.

### setReferrerUID
**Method signature**
```java
public LinkGenerator setReferrerUID(String referrerUID)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `referrerUID` | |

**Returns**
`LinkGenerator`.

### setReferrerName
**Method signature**
```java
public LinkGenerator setReferrerName(String referrerName)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `referrerName` | |

**Returns**
`LinkGenerator`.

### setReferrerImageURL
**Method signature**
```java
public LinkGenerator setReferrerImageURL(String referrerImageURL)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `referrerImageURL` | |

**Returns**
`LinkGenerator`.

### setBaseURL
**Method signature**
```java
public LinkGenerator setBaseURL(String onelinkID, String domain, String appPackage)
```

**Description**

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `String` | `onelinkID` | |
| `String` | `domain` | |
| `String` | `appPackage` | |

**Returns**
`LinkGenerator`.

### generateLink
**Method signature**
```java
public String generateLink()
```

**Description**
Generates a long link.

**Input arguments**
This method doesn't take any input arguments.

**Returns**
`String`.

### generateLink
**Method signature**
```java
public void generateLink(Context context, CreateOneLinkHttpTask.ResponseListener listener)
```

**Description**
Generates a short link using the OneLink API.

**Input arguments**

| Type | Name | Description |
|:-------|:-----------|:-----------------|
| `Context` | `context` | Application / Activity Context |
| `CreateOneLinkHttpTask.ResponseListener` | `listener` | |

**Returns**
`void`.