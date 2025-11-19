---
title: "Android security plugin"
slug: "android-security-plugin"
category: 5f9705393c689a065c409b23
parentDoc: 5fa0443749be540011850e51
hidden: true
order: 99
---

## Overview
This document describes the integration steps for the AppsFlyer Advanced Security module.


## Minimum Versions

Ensure your project meets the following minimum versions for compatibility with the Advanced Security module:

### Compatibility Updates: AppsFlyer Android SDK and Security Module


- Security Module v1.x.x (latest `1.3.4`) is compatible with [AppsFlyer Android SDK versions](https://support.appsflyer.com/hc/en-us/articles/115001256006-AppsFlyer-Android-SDK-release-notes) `6.15.2 – 6.17.3`.
- Security Module v2.x.x (currently `2.0.0`) is compatible only with AppsFlyer Android SDK version `6.17.4` and above.

Please ensure that the versions you integrate follow the compatibility ranges above to avoid build or runtime issues.
If you plan to upgrade the SDK to `6.17.4+`, make sure to update the Security Module to v2.0.0 and above as well.
Conversely, if you are using SDK versions below 6.17.4, please continue using Security Module v1.x.x (latest `1.3.4`).


## Release Notes
All notable changes to the AF Security SDK will be documented in this file.

### [2.0.0] - 2025-10-15

### Added
- Enhanced data integrity verification with cryptographic hash-based message signing to ensure secure payload transmission
- Advanced application identity validation to detect and prevent package tampering

### Changed
- Improved security monitoring with enhanced performance tracking capabilities
- Optimized internal security checks for better efficiency

### Improved
- Strengthened application integrity validation to detect configuration mismatches
- Enhanced error detection and reporting for security-related issues



### [1.3.4] - 2025-08-25

#### Added
- Support for 16 KB page size systems

### [1.3.3] - 2025-06-19

#### Fixed
- Improved input validation to strengthen security checks and prevent null pointer exceptions

### [1.3.2] - 2025-06-16

#### Added
- Enhanced security verification with improved certificate hash validation

#### Changed
- Improved event handling and security validation process


### [1.3.1] - 2025-05-21

#### Fixed
- Resolved a stability issue in the SDK's internal data handling to improve reliability in high-concurrency scenarios.

### [1.3.0] - 2025-04-30

#### Added
- Enhanced runtime protection against unauthorized access and tampering attempts.
- Implemented advanced security checks to strengthen application integrity verification.
- Introduced new memory protection mechanisms to safeguard sensitive operations.

#### Improved
- Optimized performance of security checks to minimize impact on application responsiveness.
- Enhanced detection capabilities for identifying compromised environments.
- Refined security verification process to handle edge cases more effectively.

- Resolved a stability issue related to internal integrity checks to improve reliability in sensitive environments.


### [1.2.1] - 2025-04-07

#### Fixed

- Resolved a stability issue related to internal integrity checks to improve reliability in sensitive environments.

### [1.2.0] - 2025-03-21

#### Added

- Introduced a flexible code injection mechanism to support advanced deployment scenarios.
- Implemented new runtime defenses to enhance protection against dynamic instrumentation tools.
- Added early-stage integrity validation to detect and respond to compromised environments.
- Optimized system-level interactions by transitioning select API calls to lower-level mechanisms for improved stealth and performance.

## Before You Begin

 1. Please send us all the certificate hashes (SHA-256) of all the certificates with which you sign your app. <br>This includes the debug and release certificate hashes. The certificate hashes are needed to pre-build the version of the security module that your app will use.</br>
Instructions of getting the certificates can be found [here](#sha256-fingerprint). </br>

2. Make sure to ask the following information from your contact person at AppsFlyer:
    1. Maven repository name
    2. Maven Auth token
    3. Latest Advanced Security module version that was built for your app.


## Integration

Please follow the next two steps. Once completed and the dependency is downloaded successfully, the AppsFlyer Android SDK will use the module automatically.

### Step 1
The artifacts are hosted on AppsFlyer infrastructure.
Add the your dedicated repository on AppsFlyer Maven as a repository source in your `settings.gradle` or `settings.gradle.kts` file:
```groovy
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        mavenCentral()
        maven {
            // replace YOUR_APPSFLYER_MAVEN_REPO_ID with your AppsFlyer Maven Repo ID (starting with af-rn-)
            url "https://art.af-sdk.io/maven/${YOUR_APPSFLYER_MAVEN_REPO_ID}"
            credentials(HttpHeaderCredentials) {
                name = 'af-security-sdk-token'
                // get the token from the environment variable
                value = System.getenv("APPSFLYER_MAVEN_TOKEN")
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
            // replace YOUR_APPSFLYER_MAVEN_REPO_ID with your AppsFlyer Maven Repo ID (starting with af-rn-)
            url = uri("https://art.af-sdk.io/maven/${YOUR_APPSFLYER_MAVEN_REPO_ID}")
            credentials(HttpHeaderCredentials::class) {
                name = "af-security-sdk-token"
                // get the token from the environment variable
                value = System.getenv("APPSFLYER_MAVEN_TOKEN")
            }
            authentication {
                create<HttpHeaderAuthentication>("header")
            }
            content {
                includeGroup("com.appsflyer.security")
            }
        }
        // other repositories...
    }
}
```

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
2. Send the SHA256 certificate fingerprint to AppsFlyer.
