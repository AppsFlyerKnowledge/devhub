---
title: "Android legacy security plugin"
slug: "android-legacy-security-plugin"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: true
order: 99
---

[![Maven Central](https://img.shields.io/nexus/r/com.appsflyer/af-security-plugin?server=https%3A%2F%2Foss.sonatype.org)](https://repo1.maven.org/maven2/com/appsflyer/af-security-plugin/)

## Overview

A Gradle plugin for Android applications module that automates the process of creating, downloading, and integrating the AppsFlyer Security SDK for every build and will keep you updated with the latest security updates.

It's crucial to note that this plugin only works within an application module where the `com.android.application` plugin is applied.


## Minimum Versions

Ensure your project meets the following minimum versions for compatibility with the AppsFlyer Security Plugin:

- [AppsFlyer Android SDK](https://dev.appsflyer.com/hc/docs/android-sdk): Version 6.12.5
- [Android Gradle Plugin (AGP)](https://developer.android.com/build): Version 7.0.0
- [Gradle](https://gradle.org/): Version 7.0

## Before You Begin ⚠️
Please send us all the certificate hashes (SHA-256) of all the certificates with which you sign your app. This include the debug and release certificate hashes.</br>
We use them to pre-build the version of the security module that your app will use.</br>
This is a mandatory stage that is essential for the success of the app build when using this plugin.</br>
You will later use these hashes also in the plugin configuration as detailed [below](#configuration-options). </br>
Instruction of getting the certificates can be found [here](#sha256-fingerprint). </br>

## Installation

**Using the [plugins DSL](https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block):**

### Step 1
The plugin is hosted on Maven Central.
You first need to add the Maven Central as a repository in your `settings.gradle` or `settings.gradle.kts` file:
```groovy
pluginManagement {
    repositories {
        mavenCentral()
        // other repositories...
    }
}
```
```kotlin
pluginManagement {
    repositories {
      mavenCentral()
        // other repositories...
    }
}
```

### Step 2
Declare the plugin in the `plugins` block of your root-level (`project-level`) Gradle file.
Usually `<project>/build.gradle` or `<project>/<app-module>/build.gradle.kts` file.

```groovy
plugins {
    id 'com.android.application' version "$AGP_VERSION" apply false
    id 'com.appsflyer.security' version "$APPSFLYER_SECURITY_PLUGIN_VERSION" apply false
    // other plugins ...
}
```
```kotlin
plugins {
    id("com.android.application") version "$AGP_VERSION" apply false
    id("com.appsflyer.security") version "$APPSFLYER_SECURITY_PLUGIN_VERSION" apply false
    // other plugins ...
}
```


### Step 3

Apply the plugin in your app-level Gradle file.
Usually `<project>/<app-module>/build.gradle` or `<project>/<app-module>/build.gradle.kts` file

```groovy
plugins {
    id 'com.android.application'
    id 'com.appsflyer.security'
    // other plugins...
}
```
```kotlin
plugins {
    id("com.android.application")
    id("com.appsflyer.security")
    // other plugins...
}
```

### Legacy Installation
**Using [legacy plugin application](https://docs.gradle.org/current/userguide/plugins.html#sec:old_plugin_application):**
```groovy
buildscript {
  repositories {
    maventCentral()
  }
  dependencies {
    classpath "com.appsflyer:af-security-plugin:$APPSFLYER_SECURITY_PLUGIN_VERSION"
  }
}

apply plugin: "com.appsflyer.security"
```
```kotlin
buildscript {
  repositories {
    maventCentral()
  }
  dependencies {
    classpath("com.appsflyer:af-security-plugin:$APPSFLYER_SECURITY_PLUGIN_VERSION")
  }
}

apply(plugin = "com.appsflyer.security")
```

**Notes:**
1. Replace `$AGP_VERSION` with the actual version of the Android Gradle Plugin.
2. Replace `$APPSFLYER_SECURITY_PLUGIN_VERSION` with the actual version of the AppsFlyer Security Plugin.


## Basic Configuration
Configure the AppsFlyer security plugin in your app-level Gradle file. Usually `<project>/<app-module>/build.gradle` or `<project>/<app-module>/build.gradle.kts` file.
</br>Ensure to keep sensitive information such as `authToken` and `certificateHashes` in a secure place and avoid including these directly as plain text in the configuration block.

```groovy
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
}
```
```kotlin
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = listOf("defaultHash1", "defaultHash2")
        authToken = "defaultAuthToken"
    }
}
```
## Configuration Options

Each configuration block (`defaultConfig` or a specific `flavorConfig`) may include:

| Option              | Type           | Description                                                                                                                                                                                                                                                                                                                                                   | Required | Important Note                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |  
|---------------------|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
| `certificateHashes` | `List<String>` | This field specifies a list of the application signing keys that will be used to validate the Application Integrity. This is mandatory and requires you to supply the certificate hash for your signing key manually as AppsFlyer cannot automatically determine the signing key used to sign your application. Only SHA-256 hashes are supported.            | Yes      | **1.** When using app signing by [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), Google manages and protects your app's signing key for you and signs your APKs on your behalf. In this case it is required that you provide the certificate hash for the signing key **used by Google** using this option. This is **always** the case when you distribute Android app bundles. </br>**2.** If `certificateHashes` is not specified or if the provided value doesn't match the build, the validation will fail and the traffic will be marked as fraud. |  
| `authToken`         | `String`       | This is an API V2 token required for plugin authentication. You can retrieve the token in your AppsFlyer [dashboard](https://support.appsflyer.com/hc/en-us/articles/360004562377).                                                                                                                                                                           | Yes      | If `authToken` is not specified or is incorrect, the plugin cannot connect to the AppsFlyer server.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |  

In the event of any missing required values (`certificateHashes` and `authToken`), the plugin will not work as expected. The absence of `certificateHashes` will result in validation failure and potential detection of traffic as fraud, whereas the absence of a valid `authToken` will prevent the plugin from functioning properly.

## Ignore Flavors
By default, the plugin will register tasks and embed the AppsFlyer Security SDK for every flavor.</br>
If you wish to exclude flavors, you should provide the relevant flavors to exclude in the `ignoreFlavors` set under the `appsFlyerSecurityPlugin` section.</br>

The plugin excludes flavors in the following priority order:

1. **Complete Build Variant:**  A complete build variant is a combination of all flavor dimensions and the build type. For example, given the flavor dimensions "tier" (with values "free", "paid") and "server" (with values "dev", "prod"), a complete build variant could be "freeDevDebug" or "paidProdRelease".

2. **Combined Product Flavor:** Product flavor configuration blocks are named after the combined flavor dimensions. For example, if you're building a variant with a combined flavor of 'paid' and 'prod', the plugin would look for a configuration block named 'paidProd'.

3. **Build Type (Debug/Release):** This will exclude all flavors that are built with this type.


```groovy
appsFlyerSecurityPlugin {
  ignoreFlavors = ["freeDev"]
  defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
}
```
```kotlin
appsFlyerSecurityPlugin {
    ignoreFlavors = setOf("freeDev", "debug")
    defaultConfig {
        certificateHashes = listOf("defaultHash1", "defaultHash2")
        authToken = "defaultAuthToken"
    }
}
```

## Advanced Configuration

### Flavor Configuration Handling and Priorities

The plugin allows you to define specific configurations for certain flavors or build types of your app. The plugin resolves configurations in the following priority order:

1. **Complete Build Variant:** This configuration block is associated with a complete build variant. A complete build variant is a combination of all flavor dimensions and the build type. For example, given the flavor dimensions "tier" (with values "free", "paid") and "server" (with values "dev", "prod"), a complete build variant could be "freeDevDebug" or "paidProdRelease".

2. **Combined Product Flavor:** If there is no configuration specified for the complete build variant, the plugin will attempt to find a configuration that matches the combined product flavor. Product flavor configuration blocks are named after the combined flavor dimensions. For example, if you're building a variant with a combined flavor of 'paid' and 'prod', the plugin would look for a configuration block named 'paidProd'.

3. **Build Type (Debug/Release):** If no configurations for the complete build variant or combined product flavors are found, the plugin will then look for a configuration block named after the build type. This will be applied to all flavors that are built with this type.

4. **Default:** If none of the above match, the plugin defaults to the `defaultConfig`, applying it to all variants.


### Advanced Flavor Configuration

```groovy
appsFlyerSecurityPlugin {
    defaultConfig {
        certificateHashes = ['defaultHash1', 'defaultHash2']
        authToken = 'defaultAuthToken'
    }
    flavorConfigs {
        paidProdRelease {
            certificateHashes = ['paidProdReleaseHash1', 'paidProdReleaseHash2']
            authToken = 'paidProdReleaseAuthToken'
            channel = 'paidProdReleaseChannel'
        }
        paidDev {
            certificateHashes = ['paidDevHash1', 'paidDevHash2']
            authToken = 'paidDevAuthToken'
            channel = 'paidDevChannel'
        }
    }
}
```
```kotlin
appsFlyerSecurityPlugin {
    defaultConfig {
      certificateHashes = listOf("defaultHash1", "defaultHash2")
      authToken = "defaultAuthToken"
    }
    flavorConfigs {
      create("paidProdRelease") {
        certificateHashes = listOf("paidProdReleaseHash1", "paidProdReleaseHash2")
        authToken = "paidProdReleaseAuthToken"
        channel = "paidProdReleaseChannel"
      }
      create("paidDev") {
        certificateHashes = listOf("paidDevHash1", "paidDevHash2")
        authToken = "paidDevAuthToken"
        channel = "paidDevChannel"
      }
    }
}
```

<a name="advanced-configuration-options"></a>
### Advanced Configuration Options


| Option          | Type     | Description                                                                                                                                                                                                                                                                                                                                                   | Required | Important Note                                                                                                                                                            |  
|-----------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
| `channel`       | `String` | This channel specifies the unique store of your Android App when it is added via the Android Out-of-Store APK option. This combination of Android package name and channel uniquely identifies each AppsFlyer dashboard. This option is relevant only when using the dashboard per store option. If not specified, the default value is an empty string `""`. | No       | If the channel value is either blank or is one among "googleplay", "playstore", or "googleplaystore", it is ignored and the returned value will be an empty string, `""`. |  
| `applicationId` | `String` | Specifies the unique identifier for the application associated with the flavor configuration. It can be used to override the default behavior of deriving the AppsFlyer App ID from the variant's package name and the `channel`. If not specified, the default behavior will be followed.                                                                    | No       | If not specified, the AppsFlyer App ID will be derived from the variant's package name and the `channel`.                                                                 |  


## Generating a SHA256 fingerprint

### Debug

**To generate the SHA256 fingerprint:**

1. Locate your [app's keystore](https://developer.android.com/training/articles/keystore).
  While developing your app, a default debug keystore is used unless differently specified in your Gradle configuration.
  The default `debug.keystore` location is:
  * For Windows user: `C:\Users\USERNAME\.android\debug.keystore`
  * For Linux or Mac OS user: `~/.android/debug.keystore`
2. Open the command line and navigate to the folder where the keystore file is located.
3. Run the command:

```shell
// keytool -list -v -keystore KEY_STORE_FILE
// For example, the default keystore file 
keytool -list -v -keystore ~/.android/debug.keystore
```

> 🚧 The password for the debug.keystore is usually \"android\".

The output should look like this:

```text 
Alias name: test
Creation date: Sep 27, 2017
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=myname
Issuer: CN=myname
Serial number: 365ead6d
Valid from: Wed Sep 27 17:53:32 IDT 2017 until: Sun Sep 21 17:53:32 IDT 2042
Certificate fingerprints:
MD5: DB:71:C3:FC:1A:42:ED:06:AC:45:2B:6D:23:F9:F1:24
SHA1: AE:4F:5F:24:AC:F9:49:07:8D:56:54:F0:33:56:48:F7:FE:3C:E1:60
SHA256: A9:EA:2F:A7:F1:12:AC:02:31:C3:7A:90:7C:CA:4B:CF:C3:21:6E:A7:F0:0D:60:64:4F:4B:5B:2A:D3:E1:86:C9
Signature algorithm name: SHA256withRSA
Version: 3
Extensions:
#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
  KeyIdentifier [
   0000: 34 58 91 8C 02 7F 1A 0F  0D 3B 9F 65 66 D8 E8 65 
   0010: 74 42 2D 44                    
 ]
]
```

4. Send the SHA256 to AppsFlyer. 

### Release

> 🚧 If your release build is not signed by [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), follow the [debug](#debug-sha256-fingerprint) instruction with your production key.

When using app signing by [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), Google manages and protects your app's signing key for you and signs your APKs on your behalf. In this case it is required that you provide the certificate hash for the signing key **used by Google** using this option. This is **always** the case when you distribute Android app bundles.</br>

1. In Google Play console Find the public SHA256 fingerprint in **Setup** -> **App signing** (see image below)
![](https://files.readme.io/8574437-Screenshot_2023-11-27_at_11.30.43.png)
2. Send the SHA256 to AppsFlyer.