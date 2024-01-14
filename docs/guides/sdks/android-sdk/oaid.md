---
title: "OAID"
slug: "oaid"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: false
createdAt: "2022-11-29T14:54:36.852Z"
updatedAt: "2022-12-13T12:14:03.404Z"
order: 11
---
## Overview

Collect the Android Open Anonymous Device Identifier (OAID) to attribute installs from third-party Android app stores.

The OAID is a user-resettable unique identifier for Android devices. It was introduced by the Mobile Security Alliance (MSA), China Information and Communication Research Institute, and device manufacturers, as a privacy-preserving alternative to non-resettable device identifiers like IMEI.

## Integration

Requires AppsFlyer SDK V5.4.0+

OAID integration consists of 3 steps:

- Integrating the AppsFlyer SDK in the `build.gradle` file of your project
- Integrating the AppsFlyer OAID plugin module in the `build.gradle` file of your project

```groovy
dependencies {
  implementation 'com.appsflyer:af-android-sdk:6.9.4'
  implementation 'com.appsflyer:oaid:6.9.0'
}
```

- Integrating an SDK to generate and provide the OAID (either the [MSA SDK](#msa-sdk-integration) or [Huawei HMS SDK](#huawei-hms-sdk-integration))

**Note**:

- For apps that are intended to be used in China, the MSA SDK must be used.
- For apps that are intended to be used globally on Huawei devices, the Huawei HMS library should be used.

### MSA SDK integration

**To integrate the MSA SDK**:

1. Get from the marketer: The MSA SDK (aar) file and the certificate that needs to be integrated into the app.
    1. Copy the MSA SDK (aar) under the libs folder.
    2. Copy and paste `supplierconfig.json` under the assets folder of the project and make the necessary changes, such as updating the appid of your app in each of the stores.
    3. Copy and paste the certificate file (bundle name.cert.pem) under the assets folder of the project.
    4. See [full instructions on the MSA website](http://www.msa-alliance.cn/col.jsp?id=120)
2. Update the `build.gradle` file of your project as follows:

```groovy
implementation 'com.appsflyer:af-android-sdk:6.9.4'
implementation 'com.appsflyer:oaid:6.9.0'
implementation files('libs/oaid_sdk_2.0.0.aar')
```

### Huawei HMS SDK integration

**To integrate the Hauwei HMS SDK**:

1. Add the Huawei maven repo as follows:

```groovy
repositories {
  maven {
      url "https://developer.huawei.com/repo/"
  }
}
```

2. Update the `build.gradle` file of your app as follows:

```groovy
dependencies {
  implementation 'com.appsflyer:af-android-sdk:6.9.4'
  implementation 'com.appsflyer:oaid:6.9.0'
  implementation 'com.huawei.hms:ads-identifier:3.4.56.300'
}
```

## Additional information

### Opting out of OAID collection

**To opt-out of OAID collection, use one of the following APIs**:

- [setCollectOAID](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setcollectoaid) as follows:

``` java
AppsFlyerlib.setCollectOaid(false);
```

- [setDisableAdvertisingIdentifiers](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setdisableadvertisingidentifiers) as follows:

``` java
AppsFlyerlib.setDisableAdvertisingIdentifiers(true);
```

### Setting OAID manually

**To manually set the OAID into the AppsFlyer SDK**:

- Use the [setOaidData API](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerlib#setoaiddata) as follows:

``` java
AppsFlyerlib.setOaidData(oaid);
```
