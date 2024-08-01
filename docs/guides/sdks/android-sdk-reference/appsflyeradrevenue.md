---
title: "AppsFlyerAdRevenue [LEGACY]"
slug: "appsflyeradrevenue"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2022-01-12T08:42:56.136Z"
updatedAt: "2023-02-09T14:37:08.648Z"
---
<span class="annotation-deprecated">Deprecated in v6.15.0</span>  

(Supported until SDK v6.14.2 For versions including and above v6.15.0 use [`logAdRevenue`](doc:android-sdk-reference-appsflyerlib#logadrevenue))

[block:api-header]
{
  "title": "Overview"
}
[/block]
AppsFlyerAdRevenue is the parent class for the ad revenue SDK.
[block:api-header]
{
  "title": "Methods"
}
[/block]
### initaliaze
**Method signature**
```java
public static void initialize(AppsFlyerAdRevenue revenue)
```

**Description**
Initializes the ad revenue SDK.
 
**Input arguments**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `AppsFlyerAdRevenue` | `revenue` |  Creates and initializes an AdRevenue singleton object. |

**Returns**
`void`.

**Usage example**
```java
AppsFlyerAdRevenue.Builder afRevenueBuilder = new AppsFlyerAdRevenue.Builder( this);
AppsFlyerAdRevenue.initialize(afRevenueBuilder.build());
```

### logAdRevenue
**Method signature**
```java
public static void logAdRevenue(@NonNull String monetizationNetwork, @NonNull MediationNetwork mediationNetwork, @NonNull Currency eventRevenueCurrency, @NonNull Double eventRevenue, @Nullable Map<String, String> nonMandatory)
```

**Description**
Logs an ad revenue impression.

**Input arguments**

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `String` | `monetizationNetwork` | The name of the monetization network. |
| [`MediationNetwork`](https://dev.appsflyer.com/hc/docs/appsflyeradrevenue#mediationnetwork) | `mediationNetwork` | Enum of the medation network. |
| [`Currency`](https://docs.oracle.com/javase/8/docs/api/java/util/Currency.html) | `eventRevenueCurrency` | Currency of the ad revenue event. |
| `Double` | `eventRevenue` | Amount of the ad revenue event. |
| `Map<String, String>` | `nonMandatory` | Contains native and custom fields for the ad revenue payload, as described in the following usage example. |

**Returns**
`void`.

**Usage example**
```java
// Creating optional customParams
        Map<String, String> customParams = new HashMap<>();
        customParams.put(Scheme.COUNTRY, "US");
        customParams.put(Scheme.AD_UNIT, "89b8c0159a50ebd1");
        customParams.put(Scheme.AD_TYPE, AppsFlyerAdNetworkEventType.BANNER.toString());
        customParams.put(Scheme.PLACEMENT, "place");
        customParams.put(Scheme.ECPM_PAYLOAD, "encrypt");
        customParams.put("foo", "test1");
        customParams.put("bar", "test2");

        // Actually recording a single impression
        AppsFlyerAdRevenue.logAdRevenue(
                "ironsource",
                MediationNetwork.googleadmob,
                Currency.getInstance(Locale.US),
                0.99,
                customParams
        );
```
[block:api-header]
{
  "title": "Variables"
}
[/block]
### MediationNetwork

#### Constants

| Type | Name | Description |
|:--------|:-----------------|:--------------|
| `String` | `ironsource` | The name of the mediation network. |
| `String` | `applovinmax` |  The name of the mediation network. |
| `String` | `googleadmob` |  The name of the mediation network. |
| `String` | `fyber` | The name of the mediation network. |
| `String` | `appodeal` | The name of the mediation network. |
| `String` | `admost` | The name of the mediation network. |
| `String` | `topon` | The name of the mediation network. |
| `String` | `tradplus` | The name of the mediation network. |
| `String` | `yandex` | The name of the mediation network. |
| `String` | `chartboost` | The name of the mediation network. |
| `String` | `unity` | The name of the mediation network. |
| `String` | `customMediation` | The mediation solution is not on the list of supported mediation partners. |
| `String` | `directMonetizationNetwork` | The app integrates directly with monetization networks without mediation. |