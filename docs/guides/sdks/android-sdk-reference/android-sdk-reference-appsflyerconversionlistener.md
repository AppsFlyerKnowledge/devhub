---
title: AppsFlyerConversionListener
slug: android-sdk-reference-appsflyerconversionlistener
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk-reference
privacy:
  view: public
---
[block:api-header]
{
  "title": "Overview"
}
[/block]
The `AppsFlyerConversionListener` is a public interface that lets you listen to [conversions](doc:conversion-data-android).

Go back to the [SDK reference index](doc:android-sdk-reference).

### AppsFlyerConversionListener
The `AppsFlyerConversionListener` interface requires you override the following methods:
 * [onConversionDataSuccess](#onconversiondatasuccess)
 * [onConversionDataFail](#onconversiondatafail)
 * [onAppOpenAttrtibution](#onappopenattribution)
 * [onAttributionFailure](#onattributionfailure)

All methods must be overridden. Otherwise, a compilation error is thrown.
[block:api-header]
{
  "title": "Public Methods"
}
[/block]
### onAppOpenAttribution
**Method signature**
```java
void onAppOpenAttribution(java.util.Map<java.lang.String,java.lang.String> attributionData)
```

**Description**
This callback will NOT be invoked if AppsFlyerLib.subscribeForDeepLink is used.

**Callback parameters**

| Type | name | Description |
|:----------|:-----------------|:--------------|
| `Map<String, String>` | `attributionData` | |

**Returns**
`void`

### onAttributionFailure
**Method signature**
```java
void onAttributionFailure(java.lang.String errorMessage)
```
**Description**
This callback will NOT be invoked if AppsFlyerLib.subscribeForDeepLink is used.

**Callback parameters**

| Type | name | Description |
|:----------|:-----------------|:--------------|
| `String ` | `errorMessage` | |

**Returns**
``void``

### onConversionDataSuccess
**Method signature**
```java
void onConversionDataSuccess(java.util.Map<java.lang.String,java.lang.Object> conversionData)
```

**Description**
Triggered upon successful conversion data resolution.

**Callback parameters**

| Type | name | Description |
|:----------|:-----------------|:--------------|
| `Map<String, Object>` | `conversionData ` |  You must explicitly handle `null` keys. |

**Returns**
`void`.

### onConversionDataFail
**Method signature**
```java
void onConversionDataFail(java.lang.String errorMessage)
```

**Description**
Triggered upon failed conversion data resolution.

**Callback parameters**

| Type | name | Description |
|:----------|:-----------------|:--------------|
| `String ` | `errorMessage` | |

**Returns**
`void`.
