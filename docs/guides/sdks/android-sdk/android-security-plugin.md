---
title: Android security plugin
slug: android-security-plugin
category:
  uri: AppsFlyer SDKs
parent:
  uri: android-sdk
privacy:
  view: anyone_with_link
position: 7
---

## Overview
This document describes the integration steps for the AppsFlyer Advanced Security module.


## Minimum Versions

Ensure your project meets the following minimum versions for compatibility with the Advanced Security module:

### Compatibility Updates: AppsFlyer Android SDK and Security Module

Security Module v2.x.x is compatible only with AppsFlyer Android SDK version `6.17.4` and above. You can find all SDK versions [here](https://support.appsflyer.com/hc/en-us/articles/115001256006-AppsFlyer-Android-SDK-release-notes).


## Release Notes
All notable changes to the AF Security SDK will be documented in this file.

### [2.2.2] - 2026-08-11

### Fixed
- Resolved a native crash affecting some 32-bit Android devices during internal security checks

### [2.2.1] - 2026-04-06

#### Added
- iOS simulator support for easier integration testing during development

#### Improved
- Security SDK Stability

### [2.2.0] - 2026-02-12

#### Improved
- Strengthened iOS framework packaging with advanced LLVM code transformation
- Optimized security signing function for improved cross-platform verification

### [2.1.0] - 2025-12-29

#### Added
- Enhanced code obfuscation to strengthen protection against reverse engineering and unauthorized analysis
- Support for additional device architectures to ensure broader compatibility

#### Changed
- Upgraded native development toolkit for improved performance and stability
- Enhanced protection against emulator detection bypasses
- Improved security configuration options for advanced threat prevention

#### Improved
- Strengthened binary protection with advanced obfuscation techniques
- Optimized build system for better cross-platform support
- Enhanced application identity verification mechanisms

### [2.0.0] - 2025-10-15

#### Added
- Enhanced data integrity verification with cryptographic hash-based message signing to ensure secure payload transmission
- Advanced application identity validation to detect and prevent package tampering

#### Changed
- Improved security monitoring with enhanced performance tracking capabilities
- Optimized internal security checks for better efficiency

#### Improved
- Strengthened application integrity validation to detect configuration mismatches
- Enhanced error detection and reporting for security-related issues


## Multi-Store and Out-of-Store Apps

The Security module is **built and packaged per app**. Its dependency coordinate -
`af-security-sdk-<YOUR_APP_ID>` — is tied to one specific AppsFlyer **App ID**, and the
module embeds app-specific values (package name and signing certificate hashes) at build time.

When using the dashboard-per-store setup for multiple Android app store distributions, each store you distribute to is registered as a separate app. For the dashboard-per-store setup, the App ID is your Android package name with the store channel appended: `<packageName>-<storeChannel>`. See
[Set up multi-store Android attribution](https://support.appsflyer.com/hc/en-us/articles/207447023-Set-up-multi-store-Android-attribution)
and [Adding an app to AppsFlyer](https://support.appsflyer.com/hc/en-us/articles/207377436-Adding-an-app-to-AppsFlyer).

- **Google Play** — the App ID is the package name itself, e.g. `com.abc.def`.
- **Out-of-store / alternative stores** — the App ID is the package name plus the store
  channel, e.g. `com.abc.def-Custom` (out-of-store / direct download) or `com.abc.def-Amazon`
  (Amazon Appstore).

Because each variant is a distinct App ID, **you must create a separate Security module build
for every variant** and reference the matching dependency in that variant's build.

**Example** — an app shipped to three stores needs three Security modules:

| Distribution | AppsFlyer App ID | Security module dependency |
|---|---|---|
| Out-of-store (direct download) | `com.abc.def-Custom` | `com.appsflyer.security:af-security-sdk-com.abc.def-Custom:<VERSION>` |
| Amazon Appstore | `com.abc.def-Amazon` | `com.appsflyer.security:af-security-sdk-com.abc.def-Amazon:<VERSION>` |

> [!WARNING]
> **Only use a `CHANNEL` value that is registered in HQ.**
> The `AF_CHANNEL` meta-data in your manifest must exactly match a channel already
> configured for the app in the AppsFlyer dashboard. An unregistered value produces an
> App ID that does not exist on the server, so the Security module for that variant
> cannot be built and its traffic will not be attributed.
>
> Do not invent channel names, and do not add a channel for the Google Play build —
> Google Play is the default distribution and uses the plain App ID (`com.abc.def`),
> with no channel suffix. A channel named `Google` is wrong on both counts.

> 🚧 Provide the certificate hashes (SHA-256) for **each** variant when requesting its build.
> If a store re-signs your app (a different signing key per distribution), the hashes differ
> between variants — so the modules are not interchangeable.

Use Gradle build flavors/variants to apply the correct module dependency to each store build.

## Before You Begin

 1. Please prepare all the certificate hashes (SHA-256) of all the certificates with which you sign your app. <br>This includes the debug and release certificate hashes. The certificate hashes are needed to pre-build the version of the security module that your app will use.</br>
Instructions of getting the certificates can be found [here](#generating-a-sha256-fingerprint). </br>

## Integration

Please follow the next two steps. Once completed and the dependency is downloaded successfully, the AppsFlyer Android SDK will use the module automatically.

### Step 1
The artifacts are hosted on AppsFlyer infrastructure.
Add your dedicated repository on AppsFlyer Maven as a repository source in your `settings.gradle` or `settings.gradle.kts` file:
```groovy
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        mavenCentral()
        maven {
           url 'https://art.af-sdk.io/security-sdk/maven'
           credentials(HttpHeaderCredentials) {
               name = 'Authorization'
               // get the token from the environment variable
               value = 'Bearer ' + System.getenv("APPSFLYER_AUTH_V2_TOKEN")
           }
           authentication {
               header(HttpHeaderAuthentication)
           }
           content {
               includeGroup "com.appsflyer.security"
           }
        }
        // other repositories...
    }
}
```
```kotlin
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)    
    repositories {
        mavenCentral()
        maven {
          url = uri("https://art.af-sdk.io/security-sdk/maven")
          credentials(HttpHeaderCredentials::class) {
              name = "Authorization"
              // get the token from the environment variable
              value = "Bearer ${System.getenv("APPSFLYER_AUTH_V2_TOKEN")}"
          }
          authentication {
              create("header", HttpHeaderAuthentication::class.java)
          }
          content {
              includeGroup("com.appsflyer.security")
          }
        }
        // other repositories...
    }
}
```

`APPSFLYER_AUTH_V2_TOKEN` This is an API V2 token required for repository authentication and authorization. You can retrieve the token in your AppsFlyer [dashboard](https://support.appsflyer.com/hc/en-us/articles/360004562377-Managing-AppsFlyer-tokens).

### Step 2

Apply the Security module dependency in your app-level Gradle file.
Usually `<project>/<app-module>/build.gradle` or `<project>/<app-module>/build.gradle.kts` file

```groovy
dependencies{
    // replace <YOUR_APP_ID> with your App ID and <SECURITY_MODULE_VERSION> with the version of the Security module   
    implementation 'com.appsflyer.security:af-security-sdk-<YOUR_APP_ID>:<SECURITY_MODULE_VERSION>'
}
```
```kotlin
dependencies{
    // replace <YOUR_APP_ID> with your App ID and <SECURITY_MODULE_VERSION> with the version of the Security module   
    implementation("com.appsflyer.security:af-security-sdk-<YOUR_APP_ID>:<SECURITY_MODULE_VERSION>")
}
```
## FAQ

Q: How do I know what version of Security module I should use? 
A: In general, you should use the latest version available for your app, that will be provided to you during the onboarding process. If you need the full list of versions available, please ask your contact person at AppsFlyer to provide it to you. 

Q: How do I get a new Security module version for my app? 
A: Please ask your contact person at AppsFlyer to submit a build request on your behalf, and we will provide you with a new version name to integrate.

Q: If I need to rotate my AppsFlyer Maven Auth token, how do I do that? 
A: Please ask your contact person at AppsFlyer to rotate your AppsFlyer Maven Auth token, and we will provide you with a new token.

## Generating a SHA256 fingerprint
### Debug
**To generate the SHA256 fingerprint:**

1. Locate your [app's keystore](https://developer.android.com/training/articles/keystore).
  While developing your app, a default debug keystore is used unless specified differently in your Gradle configuration.
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

> [!WARNING]
> The password for the debug.keystore is usually \"android\".

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

> [!WARNING]
> If your release build is not signed by [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), follow the [debug](#debug-sha256-fingerprint) instruction with your production key.

When using app signing by [Google Play](https://developer.android.com/studio/publish/app-signing#google-play-app-signing), Google manages and protects your app's signing key for you and signs your APKs on your behalf. In this case it is required that you provide the certificate hash for the signing key **used by Google** using this option. This is **always** the case when you distribute Android app bundles.</br>

1. In Google Play console Find the public SHA256 fingerprint in **Setup** -> **App signing** (see image below)
![](https://files.readme.io/8574437-Screenshot_2023-11-27_at_11.30.43.png)
2. Send the SHA256 certificate fingerprint to AppsFlyer.
