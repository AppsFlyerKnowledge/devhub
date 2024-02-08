---
title: "AppsFlyerLib"
slug: "android-sdk-reference-appsflyerlib"
category: 5f9705393c689a065c409b23
parentDoc: 60ca3f03ceb11a00db127bd8
hidden: false
createdAt: "2021-06-16T18:12:50.747Z"
updatedAt: "2023-05-03T08:48:19.400Z"
---
## Overview

`AppsFlyerLib` is the main class of the AppsFlyer Android SDK, and encapsulates most of the methods.

Go back to the [SDK reference index](doc:android-sdk-reference).

#### Import the library

```java
import com.appsflyer.AppsFlyerLib;
```



#### Access the SDK instance

Access the SDK singleton instance:

```java
AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
```



## Methods

### addPushNotificationDeepLinkPath

**Method signature**

```java
void addPushNotificationDeepLinkPath(java.lang.String... deepLinkPath)
```



**Description**  
Configures how the SDK extracts deep link values from push notification payloads.

**Input arguments**

| Type        | Name           | Description                                                               |
| :---------- | :------------- | :------------------------------------------------------------------------ |
| `String...` | `deepLinkPath` | An array of `String`s that corresponds to the JSON path of the deep link. |

**Returns**  
`void`.

**Usage example**  
Basic configuration:

```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link");
```
```kotlin
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("af_push_link")
```



Advanced configuration:

```java
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("deeply", "nested", "deep_link");
```
```kotlin
AppsFlyerLib.getInstance().addPushNotificationDeepLinkPath("deeply", "nested", "deep_link")
```



This call matches the following payload structure:

```json
{
  "deeply": {
    "nested": {
      "deep_link": "https://yourdeeplink2.onelink.me"
    }
  }
}
```



### anonymizeUser

**Method signature**

```java
void anonymizeUser(boolean shouldAnonymize)
```



**Description**  
Anonymize a user's installs, events, and sessions.

**Input arguments**

| Type      | Name              | Description          |
| :-------- | :---------------- | :------------------- |
| `boolean` | `shouldAnonymize` | Defaults to `false`. |

**Returns**  
`void`

**Usage example**

```java
AppsFlyerLib.getInstance().anonymizeUser(true);
```
```kotlin
AppsFlyerLib.getInstance().anonymizeUser(true)
```



### appendParametersToDeepLinkingURL

**Method signature**

```java
void appendParametersToDeepLinkingURL(java.lang.String contains,
                                                      java.util.Map<java.lang.String,java.lang.String> parameters)
```



**Description**  
Enables app owners using App Links for deep linking (without OneLink) to attribute sessions initiated via a domain associated with their app. 

> 🚧 
> 
> Call this method before calling [`start`](#start)

You must provide the following parameters in the `parameters` `Map`:

- `pid`
- `is_retargeting` must be set to `true`

**Input arguments**

| Type                  | Name         | Description                                               |
| :-------------------- | :----------- | :-------------------------------------------------------- |
| `String`              | `contains `  | A string contained in the deep link URL                   |
| `Map<String, String>` | `parameters` | Attribution parameters to be appended to the matched URLs |

**Returns**  
`void`

**Usage example**

```java
HashMap<String, String> urlParameters = new HashMap<>();
urlParameters.put("pid", "exampleDomain"); // Required
urlParameters.put("is_retargeting", "true"); // Required
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com", urlParameters);
```
```kotlin
AppsFlyerLib.getInstance().appendParametersToDeepLinkingURL("example.com",
mapOf("pid" to "exampleDomain", "is_retargeting" to "true")) // Required
```



In the example above, the resulting attribution URL sent to AppsFlyer servers is:

```
example.com?pid=exampleDomain&is_retargeting=true
```



### enableFacebookDeferredApplinks

**Method signature**

```java
void enableFacebookDeferredApplinks(boolean isEnabled)
```



**Description**  
Enable the collection of Facebook Deferred AppLinks. Requires Facebook SDK and Facebook app on target/client device.

This API must be invoked before initializing the AppsFlyer SDK in order to function properly.  
**Input arguments**

| Type      | Name         | Description                                                             |
| :-------- | :----------- | :---------------------------------------------------------------------- |
| `boolean` | `isEnabled ` | Should Facebook's deferred app links be processed by the AppsFlyer SDK. |

**Returns**  
`void`

### enableLocationCollection

<span class="annotation-removed">Removed in V6.8.0</span>

**Method signature**

```java
AppsFlyerLib enableLocationCollection(boolean flag)
```



**Description**  
Enable the AppsFlyer SDK to collect the last known location. Requires `ACCESS_COARSE_LOCATION` and `ACCESS_FINE_LOCATION` Manifest permissions.

**Input arguments**

| Type      | Name    | Description |
| :-------- | :------ | :---------- |
| `boolean` | `flag ` |             |

**Returns**  
`void`

### getAppsFlyerUID

**Method signature**

```java
java.lang.String getAppsFlyerUID(Context context)
```



**Description**  
Get AppsFlyer's unique device ID. The SDK generates an AppsFlyer unique device ID upon app installation. When the SDK is started, this ID is recorded as the ID of the first app install.

**Input arguments**

| Type      | Name       | Description                     |
| :-------- | :--------- | :------------------------------ |
| `Context` | `context ` | Application / Activity context. |

**Returns**  
AppsFlyer's unique device ID.

**Usage example**

```java Java
String appsFlyerId = AppsFlyerLib.getInstance().getAppsFlyerUID(this);
```
```kotlin Kotlin
String appsFlyerId = AppsFlyerLib.getInstance().getAppsFlyerUID(this)
```



### getAttributionId

**Method signature**

```java
java.lang.String getAttributionId(Context context)
```



**Description**  
Get the Facebook attribution ID, if one exists.

**Input arguments**

| Type      | Name      | Description                     |
| :-------- | :-------- | :------------------------------ |
| `Context` | `context` | Application / Activity context. |

**Returns**  
`void`

**Usage example**

```java Java
String attributionId = AppsFlyerLib.getInstance().getAttributionId(this);
```
```kotlin Kotlin
String attributionId = AppsFlyerLib.getInstance().getAttributionId(this)
```



### getHostName

**Method signature**

```java
java.lang.String getHostName()
```



**Description**  
Get the host name.  
Default value is "appsflyer.com"

**Input arguments**  
This function takes no parameters.

**Returns**

| Type     | Description             |
| :------- | :---------------------- |
| `String` | Currently set hostname. |

**Usage example**

### getHostPrefix

**Method signature**

```java
java.lang.String getHostPrefix()
```



**Description**  
Get the custom set host prefix.

**Input arguments**  
This function takes no parameters.

**Returns**  
Host prefix.

### getInstance

**Method signature**

```java
AppsFlyerLib getInstance()
```



**Description**  
Returns the SDK instance, through which you can access the methods described in this document.

**Input arguments**  
This function takes no parameters.

**Returns**  
AppsFlyerLib singleton instance.

### getOutOfStore

**Method signature**

```java
java.lang.String getOutOfStore(Context context)
```



**Description**  
Get the third-party app store referrer value.

**Input arguments**

| Type      | Name       | Description                     |
| :-------- | :--------- | :------------------------------ |
| `Context` | `context ` | Application / Activity context. |

**Returns**  
`AF_Store` value.

### getSdkVersion

**Method signature**

```java
java.lang.String getSdkVersion()
```



**Description**  
Get the AppsFlyer SDK version used in app.

**Input arguments**  
This function takes no parameters.

**Returns**  
AppsFlyer SDK version.

### init

**Method signature**

```java
AppsFlyerLib init(java.lang.String key,
                                  AppsFlyerConversionListener conversionDataListener,
                                  Context context)
```



**Description**  
Use this method to initialize AppsFlyer SDK. This API should be called inside the Application's `onCreate` method.

**Input arguments**

| Type                              | Name                     | Description                                                                                                  |
| :-------------------------------- | :----------------------- | :----------------------------------------------------------------------------------------------------------- |
| `String`                          | `key`                    | AppsFlyer dev key                                                                                            |
| `AppsFlyerConversionDataListener` | `conversionDataListener` | (Optional) implement the AppsFlyerConversionDataListener to access AppsFlyer's conversion data. Can be null. |
| `Context`                         | `context`                | Application Context.                                                                                         |

**Returns**  
`void`

**Usage example**  
See [initializing the SDK](doc:integrate-android-sdk#initializing-the-android-sdk).

### isPreInstalledApp

**Method signature**

```java
boolean isPreInstalledApp(Context context)
```



**Description**  
Boolean indicator for preinstall by Manufacturer.

**Input arguments**

| Type      | Name       | Description                     |
| :-------- | :--------- | :------------------------------ |
| `Context` | `context ` | Application / Activity context. |

**Returns**  
`boolean`.

**Usage example**

### isStopped

**Method signature**

```java
boolean isStopped()
```



**Description**  
Check if the SDK was stopped.

**Input arguments**  
This function takes no parameters.

**Returns**

| Type       | Description                           |
| :--------- | :------------------------------------ |
| `boolean ` | `true` if stopped, `false` otherwise. |

**Usage example**

### logEvent

**Method signature**

```java
void logEvent(Context context,
                              java.lang.String eventName,
                              java.util.Map<java.lang.String,java.lang.Object> eventValues)
```



**Description**  
Log an in-app event.

**Input arguments**

| Type      | Name           | Description                    |
| :-------- | :------------- | :----------------------------- |
| `Context` | `context `     | Application / Activity context |
| `String`  | `eventName `   | Event name                     |
| `Map`     | `eventValues ` | Event values                   |

**Returns**  
`void`

**Usage example**

### logEvent

**Method signature**

```java
void logEvent(Context context,
                              java.lang.String eventName,
                              java.util.Map<java.lang.String,java.lang.Object> eventValues,
                              AppsFlyerRequestListener listener)
```



**Description**  
Same as logEvent, with AppsFlyerRequestListener. `HttpURLConnection.HTTP_OK` from  
 server will invoke the AppsFlyerRequestListener#onSuccess()  
 method. AppsFlyerRequestListener#onError(int, String) will return  
 the error in case one occurs

**Input arguments**  
This function takes no parameters.  
**Returns**  
`void`

**Usage example**

### logLocation

**Method signature**

```java
void logLocation(Context context,
                                 double latitude,
                                 double longitude)
```



**Description**  
Manually log the location of the user.

This method creates an `af_location_coordinates` in-app event, with the `af_lat` and `af_long` event parameters.

**Input arguments**

| Type      | Name         | Description                    |
| :-------- | :----------- | :----------------------------- |
| `Context` | `context `   | Application / Activity context |
| `double`  | `latitude `  | Latitude                       |
| `double`  | `longitude ` | Longitude                      |

**Returns**  
`void`

**Usage example**

### logSession

**Method signature**

```java
void logSession(Context ctx)
```



**Description**  
If your app is a background utility app, you can use this API in your Activity’s onCreate() to manually log and send a session.

**Input arguments**

| Type      | Name  | Description                    |
| :-------- | :---- | :----------------------------- |
| `Context` | `ctx` | Application / Activity context |

**Usage example**

```java Java
public void logSession(Context context);
```
```kotlin Kotlin
public void logSession(Context context)
```



**Returns**  
`void`

### onPause

**Method signature**

```java
void onPause(Context context)
```



**Description**  
For Cocos2dx platform only  
 Cocos2dx has his own applicationDidEnterBackground event.  
 Therefore 'onPause' will be called from C++ by JNI

**Input arguments**

| Type      | Name       | Description                    |
| :-------- | :--------- | :----------------------------- |
| `Context` | `context ` | Application / Activity context |

**Returns**  
`void`

**Usage example**

### performOnAppAttribution

<span class="annotation-deprecated">Deprecated since V6.3.2</span>  
**Method signature**

```java
void performOnAppAttribution(Context context,
                                             java.net.URI link)
```



**Description**  
Used to manually resolve deep links.

**Input arguments**

| Type           | Name       | Description                    |
| :------------- | :--------- | :----------------------------- |
| `Context`      | `context ` | Application / Activity context |
| `java.net.URI` | `link `    | Link to resolve                |

**Returns**  
`void`

**Usage example**

```java Java
AppsFlyerLib.getInstance().performOnAppAttribution(context, uri);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().performOnAppAttribution(context, uri)
```



### performOnDeepLinking

<span class="annotation-added">Added in V6.3.1+</span>

**Method signature**

```java
 public void performOnDeepLinking(@NonNull Intent intent, @NonNull Context context);
```



**Description**  
Enables manual triggering of deep link resolution. This method allows apps that are delaying the call to start to resolve deep links before the SDK starts.

- If a `DeepLinkListener` is registered, supports both deferred and direct deep linking
- If a `AppsFlyerConversionListener` is registered, only supports direct deep linking

It's recommended to call this from an `Activity`'s `onResume`, for activities that can be launched via deep linking.  
**Note**: Direct deep links processed by this API will not be reported to the server.

**Usage example**

```java
@Override
protected void onResume() {
  super.onResume();

  AppsFlyerLib appsflyer = AppsFlyerLib.getInstance();
  appsflyer.performOnDeepLinking(getIntent(),this);
}
```



**Input arguments**

| Type      | Name       | Description                     |
| :-------- | :--------- | :------------------------------ |
| `Intent`  | `intent `  |                                 |
| `Context` | `context ` | Application / Activity context. |

**Returns**  
`void`

### registerConversionListener

**Method signature**

```java
void registerConversionListener(Context context,
                                                AppsFlyerConversionListener conversionDataListener)
```



**Description**  
Register a [conversion data listener](doc:conversion-data-android). You can also use [`init`](#init) to register the listener.

**Input arguments**

| Type                          | Name                     | Description                                           |
| :---------------------------- | :----------------------- | :---------------------------------------------------- |
| `Context`                     | `context `               | Application / Activity context.                       |
| `AppsFlyerConversionListener` | `conversionDataListener` | The `AppsFlyerConversionListener` object to register. |

**Returns**  
`void`

**Usage example**

```java Java
// conversionDataListener is an object of type AppsFlyerConversionListener.
AppsFlyerLib.getInstance().registerConversionListener(getApplicationContext(), conversionDataListener);
```
```kotlin Kotlin
// conversionDataListener is an object of type AppsFlyerConversionListener.
AppsFlyerLib.getInstance().registerConversionListener(getApplicationContext(), conversionDataListener)
```



Here's an [example implementation](doc:conversion-data-android#organic-vs-non-organic-conversions) of `AppsFlyerConversionListener`.

### registerValidatorListener

**Method signature**

```java
void registerValidatorListener(Context context,
                                               AppsFlyerInAppPurchaseValidatorListener validationListener)
```



**Description**  
Register a validation listener for the `validateAndLogInAppPurchase` API.

**Input arguments**

| Type                                      | Name                 | Description                                                       |
| :---------------------------------------- | :------------------- | :---------------------------------------------------------------- |
| `Context`                                 | `context`            | Application / Activity context.                                   |
| `AppsFlyerInAppPurchaseValidatorListener` | `validationListener` | The `AppsFlyerInAppPurchaseValidatorListener` object to register. |

**Returns**  
`void`

**Usage example**

### sendAdRevenue

**Method signature**

```java
void sendAdRevenue(Context context,
                                   java.util.Map<java.lang.String,java.lang.Object> eventValues)
```



**Description**

**Input arguments**

| Type                  | Name                 | Description                     |
| :-------------------- | :------------------- | :------------------------------ |
| `Context`             | `context`            | Application / Activity context. |
| `Map<String, Object>` | `validationListener` |                                 |

**Returns**  
`void`

### sendPushNotificationData

**Method signature**

```java
void sendPushNotificationData(Activity activity)
```



**Description**  
Measure and get data from push-notification campaigns. Call this method inside the `onCreate` method of `Activity`s that are launched from push notifications.

**Input arguments**

| Type       | Name       | Description                                            |
| :--------- | :--------- | :----------------------------------------------------- |
| `Activity` | `activity` | The `Activity` which is launched via the notification. |

**Returns**  
`void`.

**Usage example**

### setAdditionalData

> 📘
> Calling `setAddiotionalData` before first launch will have the additional data included in installs, sessions, as well as in-app events.

**Method signature**

```java
void setAdditionalData(java.util.Map<java.lang.String,java.lang.Object> customData)
```



**Description**  
Use to add custom data to events' payload. It will appear in raw-data reports.  
**Input arguments**

| Type      | Name         | Description |
| :-------- | :----------- | :---------- |
| `HashMap` | `customData` |             |

**Returns**  
`void`.

### setAndroidIdData

**Method signature**

```java
void setAndroidIdData(java.lang.String aAndroidId)
```



**Description**  
By default, IMEI and Android ID are not collected by the SDK if the Android version is higher than KitKat (4.4) and the device contains Google Play Services. Use this API to explicitly send Android ID to AppsFlyer.

**Input arguments**

| Type     | Name         | Description        |
| :------- | :----------- | :----------------- |
| `String` | `aAndroidId` | Android device ID. |

**Returns**  
`void`

### setAppId

**Method signature**

```java
void setAppId(java.lang.String id)
```



**Description**

**Input arguments**

| Type     | Name | Description     |
| :------- | :--- | :-------------- |
| `String` | `id` | Android App ID. |

**Returns**  
`void`

### setAppInviteOneLink

**Method signature**

```java
void setAppInviteOneLink(java.lang.String oneLinkId)
```



**Description**  
Set the OneLink ID that should be used for attributing user-Invite. The link that is generated for the user invite will use this OneLink as the base link. See [setting OneLink for user-invite attribution](https://support.appsflyer.com/hc/en-us/articles/115004480866-User-invite-attribution-#setting-onelink).

**Input arguments**

| Type     | Name        | Description                                       |
| :------- | :---------- | :------------------------------------------------ |
| `String` | `oneLinkId` | OneLink ID obtained from the AppsFlyer Dashboard. |

**Returns**  
`void`.

### setCollectAndroidID

**Method signature**

```java
void setCollectAndroidID(boolean isCollect)
```



**Description**  
Opt-in to Android ID collection. Forces the SDK to collect Android ID.

**Input arguments**

| Type      | Name        | Description              |
| :-------- | :---------- | :----------------------- |
| `boolean` | `isCollect` | Set to `true` to opt-in. |

**Returns**  
`void`.

### setCollectIMEI

**Method signature**

```java
void setCollectIMEI(boolean isCollect)
```



**Description**  
Opt-in to IMEI collection. Forces the SDK to collect IMEI.

**Input arguments**

| Type      | Name        | Description              |
| :-------- | :---------- | :----------------------- |
| `boolean` | `isCollect` | Set to `true` to opt-in. |

**Returns**  
`void`.

### setCollectOaid

**Method signature**

```java
void setCollectOaid(boolean isCollect)
```



**Description**  
Opt-in/opt-out of OAID collection. By default, the SDK tries to collect OAID.

**Input arguments**

| Type      | Name        | Description                                    |
| :-------- | :---------- | :--------------------------------------------- |
| `boolean` | `isCollect` | Defaults to `true`. Set to `false` to opt-out. |

**Returns**  
`void`.

### setConsentData

**Method signature**

```java
AppsFlyerLib.getInstance().setConsentData(AppsFlyerConsent afConsent)
```

**Description**

Transfers consent data to the SDK.

**Input arguments**

| Type | Name | Description |
| --- | --- | --- |
| [AppsFlyerConsent](https://dev.appsflyer.com/hc/docs/android-sdk-reference-appsflyerconsent) | afConsent | An object containing user consent data |
|  |  |  |

### setCurrencyCode

**Method signature**

```java
void setCurrencyCode(java.lang.String currencyCode)
```



**Description**  
Sets the currency for in-app purchases. The currency code should be a 3 character ISO 4217 code.

**Input arguments**

| Type     | Name           | Description                                     |
| :------- | :------------- | :---------------------------------------------- |
| `String` | `currencyCode` | 3 character ISO 4217 code. Defaults to `"USD"`. |

**Returns**  
`void`.

### setCustomerIdAndLogSession

> ⚠️ Before calling this method, the method [`waitForCustomerUserId`](#waitforcustomeruserid) must be called

**Method signature**

```java
void setCustomerIdAndLogSession(java.lang.String id,
                                                Context context)
```



**Description**  
Use to set customer user id and starts the SDK.

**Input arguments**

| Type     | Name      | Description                     |
| :------- | :-------- | :------------------------------ |
| `String` | `id`      | Customer ID for client.         |
| `String` | `context` | Application / Activity context. |

**Returns**  
`void`

### setCustomerUserId

**Method signature**

```java
void setCustomerUserId(java.lang.String id)
```



**Description**  
Setting your own customer ID enables you to cross-reference your own unique ID with AppsFlyer’s unique ID and other devices’ IDs.  
This ID is available in raw-data reports and in the Postback APIs for cross-referencing with your internal IDs.

**Input arguments**

| Type     | Name | Description             |
| :------- | :--- | :---------------------- |
| `String` | `id` | Customer ID for client. |

**Returns**  
`void`.

### setDebugLog

**Method signature**

```java
void setDebugLog(boolean shouldEnable)
```



**Description**  
Enables Debug logs for the AppsFlyer SDK. Should only be set to true in development environments.

**Input arguments**

| Type      | Name           | Description          |
| :-------- | :------------- | :------------------- |
| `boolean` | `shouldEnable` | Defaults to `false`. |

**Returns**  
`void`.

**Usage example**

### setDisableAdvertisingIdentifiers

<span class="annotation-added">Added in V6.3.2</span>  
**Method signature**

```java
void setDisableAdvertisingIdentifiers(boolean disable);
```



**Description**  
Disables collection of various Advertising IDs by the SDK. This includes Google Advertising ID (GAID), OAID and Amazon Advertising ID (AAID).

**Input arguments**

| Type      | Name      | Description          |
| :-------- | :-------- | :------------------- |
| `boolean` | `disable` | Defaults to `false`. |

**Returns**  
`void`.

### setDisableNetworkData

<span class="annotation-added">Added in V6.7.0</span>  
**Method signature**

```java
void setDisableNetworkData(boolean disable);
```



**Description**  
Use to opt-out of collecting the network operator name (carrier) and sim operator name from the device.

**Input arguments**

| Type      | Name      | Description          |
| :-------- | :-------- | :------------------- |
| `boolean` | `disable` | Defaults to `false`. |

**Returns**  
`void`.

### setExtension

**Method signature**

```java
void setExtension(java.lang.String extension)
```



**Description**  
SDK plugins and extensions will set this field.

**Input arguments**

| Type     | Name        | Description     |
| :------- | :---------- | :-------------- |
| `String` | `extension` | Extension name. |

**Returns**  
`void`.

### setHost

**Method signature**

```java
void setHost(java.lang.String hostPrefixName,
                             java.lang.String hostName)
```



**Description**  
Set a custom host. **Note**: Starting SDK V6.10, if the host is sent with an empty or null value, the API call is ignored.

**Input arguments**

| Type     | Name             | Description  |
| :------- | :--------------- | :----------- |
| `String` | `hostPrefixName` | Host prefix. |
| `String` | `hostName`       | Host name.   |

**Returns**  
`void`.

### setImeiData

**Method signature**

```java
void setImeiData(java.lang.String aImei)
```



**Description**  
By default, IMEI and Android ID are not collected by the SDK if the OS version is higher than KitKat (4.4) and the device contains Google Play Services.

**Input arguments**

| Type     | Name    | Description  |
| :------- | :------ | :----------- |
| `String` | `aImei` | Device IMEI. |

**Returns**  
`void`.

### setIsUpdate

**Method signature**

```java
void setIsUpdate(boolean isUpdate)
```



**Description**  
Manually set that the application was updated.

**Input arguments**

| Type      | Name       | Description |
| :-------- | :--------- | :---------- |
| `boolean` | `isUpdate` |             |

**Returns**  
`void`.

### setLogLevel

**Method signature**

```java
void setLogLevel(AFLogger.LogLevel logLevel)
```



**Description**  
Set the SDK log level.

**Input arguments**

| Type     | Name       | Description |
| :------- | :--------- | :---------- |
| `String` | `logLevel` | Log level.  |

**Returns**  
`void`.

### setMinTimeBetweenSessions

**Method signature**

```java
void setMinTimeBetweenSessions(int seconds)
```



**Description**  
Set a custom value for the minimum required time between sessions.

**Input arguments**

| Type  | Name      | Description                                                                                                                                                          |
| :---- | :-------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `int` | `seconds` | Sets the minimum time that must pass between two app launches to count as two separate sessions. If not set, the default minimum time between sessions is 5 seconds. |

**Returns**  
`void`.

### setOaidData

**Method signature**

```java
void setOaidData(java.lang.String oaid)
```



**Description**  
By default, OAID is not collected by the SDK.  Use this API to explicitly send OAID to AppsFlyer.

**Input arguments**

| Type     | Name   | Description  |
| :------- | :----- | :----------- |
| `String` | `oaid` | Device OAID. |

**Returns**  
`void`.

### setOneLinkCustomDomain

**Method signature**

```java
void setOneLinkCustomDomain(java.lang.String... domains)
```



**Description**  
In order for AppsFlyer SDK to successfully resolve hidden (decoded in shortlink ID) attribution parameters, any domain that is configured as a branded domain in the AppsFlyer Dashboard should be provided to this method.

**Input arguments**

| Type        | Name      | Description                                                                                                   |
| :---------- | :-------- | :------------------------------------------------------------------------------------------------------------ |
| `String...` | `domains` | Array of domains that the SDK should treat as branded domains (the SDK will try to resolve them as OneLinks). |

**Returns**  
`void`.

### setOutOfStore

**Method signature**

```java
void setOutOfStore(java.lang.String sourceName)
```



**Description**  
Specify the alternative app store that the app is downloaded from.

**Input arguments**

| Type     | Name         | Description                 |
| :------- | :----------- | :-------------------------- |
| `String` | `sourceName` | Third-party app store name. |

**Returns**  
`void`.

**Usage example**

```java Java
AppsFlyerLib.getInstance().setOutOfStore("baidu");
```
```kotlin Kotlin
AppsFlyerLib.getInstance().setOutOfStore("baidu")
```



### setPartnerData

**Method signature**

```java
void setPartnerData(@NonNull String partnerId, Map<String, Object> data);
```



**Description**  
Allows sending custom data for partner integration purposes.

**Input arguments**

| Type     | Name        | Description                                                                        |
| :------- | :---------- | :--------------------------------------------------------------------------------- |
| `String` | `partnerId` | ID of the partner (usually suffixed with "\_int").                                 |
| `Map`    | `data`      | Customer data, depends on the integration configuration with the specific partner. |

**Returns**  
`void`.

**Usage example**

```java Java
Map<String, Object> partnerData = new HashMap();
partnerData.put("puid", "123456789");
AppsFlyerLib.getInstance().setPartnerData("test_int", partnerData);
```
```kotlin Kotlin
val partnerData = mapOf("puid" to "123456789")
AppsFlyerLib.getInstance().setPartnerData("test_int", partnerData)
```



### setPhoneNumber

**Method signature**

```java
void setPhoneNumber(java.lang.String phoneNumber)
```



**Description**  
Will be sent as an SHA-256 encrypted string.

**Input arguments**

| Type     | Name          | Description |
| :------- | :------------ | :---------- |
| `String` | `phoneNumber` |             |

**Returns**  
`void`.

### setPreinstallAttribution

**Method signature**

```java
void setPreinstallAttribution(java.lang.String mediaSource,
                                              java.lang.String campaign,
                                              java.lang.String siteId)
```



**Description**  
Specify the manufacturer or media source name to which the preinstall is attributed.  
**Input arguments**

| Type     | Name          | Description                                                   |
| :------- | :------------ | :------------------------------------------------------------ |
| `String` | `mediaSource` | Manufacturer or media source name for preinstall attribution. |
| `String` | `campaign`    | Campaign name for preinstall attribution.                     |
| `String` | `siteId`      | Site ID for preinstall attribution.                           |

**Returns**  
`void`.

### setResolveDeepLinkURLs

**Method signature**

```java
void setResolveDeepLinkURLs(java.lang.String... urls)
```



**Description**  
Advertisers can wrap an AppsFlyer OneLink within another Universal Link. This Universal Link will invoke the app but any deep linking data will not propagate to AppsFlyer.

`setResolveDeepLinkURLs` enables you to configure the SDK to resolve the wrapped OneLink URLs, so that deep linking can occur correctly.

**Input arguments**

| Type        | Name   | Description                       |
| :---------- | :----- | :-------------------------------- |
| `String...` | `urls` | Be sure to provide explicit URLs. |

**Returns**  
`void`

**Usage example**

```java
AppsFlyerLib.getInstance().setResolveDeepLinkURLs("clickdomain.com", "myclickdomain.com", "anotherclickdomain.com");
```



### setSharingFilterForPartners

<span class="annotation-added">Added in V6.4</span>  
**Method signature**

```java
void setSharingFilterForPartners(java.lang.String... partners)
```
This function replaces the deprecated [`setSharingFilter`](#setsharingfilter) and [`setSharingFilterForAllPartners`](#setsharingfilterforallpartners)


**Description**  
Lets you configure how which partners should the SDK exclude from data-sharing.

**Input arguments**

| Type        | Name       | Description                                                                                                                          |
| :---------- | :--------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| `String...` | `partners` | One or more partner identifiers you wish to exclude. Must include letters/digits and underscores only. Maximum partner ID length: 45 |

**Note:** 
To find out the required partner IDs:
1. Run the [Get active integrations API](https://dev.appsflyer.com/hc/reference/get_v1-integrations) for a list of all active integrations
2. Use the `media_source_name` values from the [API response](https://dev.appsflyer.com/hc/reference/get_v1-integrations) as input values to the method `partners` array. 

**Exceptions**:
- For Twitter, use `twitter` (and not `twitter_int`)

**Usage example**

```java
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int"); // Single partner
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int", "partner2_int"); // Multiple partners
AppsFlyerLib.getInstance().setSharingFilterForPartners("all"); // All partners
AppsFlyerLib.getInstance().setSharingFilterForPartners(); // Reset list (default)
```
```kotlin
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int") // Single partner
AppsFlyerLib.getInstance().setSharingFilterForPartners("partner1_int", "partner2_int") // Multiple partners
AppsFlyerLib.getInstance().setSharingFilterForPartners("all") // All partners
AppsFlyerLib.getInstance().setSharingFilterForPartners("") // Reset list (default)
```



### setSharingFilter

<span class="annotation-deprecated">Deprecated in V6.4</span>  
**Method signature**

```java
void setSharingFilter(java.lang.String... partners)
```
This function is deprecated and has been replaced by [`setSharingFilterForPartners`](#setsharingfilterforpartners)


**Description**  
Stops events from propagating to the specified AppsFlyer partners. 
(Deprecated and replaced by setSharingFilterForPartners)
**Input arguments**

| Type        | Name       | Description                                                                                           |
| :---------- | :--------- | :---------------------------------------------------------------------------------------------------- |
| `String...` | `partners` | One or more partner identifiers. Must include letters/digits and underscores only. Maximum length: 45 |

**Returns**  
`void`

### setSharingFilterForAllPartners

<span class="annotation-deprecated">Deprecated in V6.4</span>  
**Method signature**

```java
void setSharingFilterForAllPartners()
```
This function is deprecated and has been replaced by [`setSharingFilterForPartners`](#setsharingfilterforpartners)


**Description**  
Stops events from propagating to all AppsFlyer partners. Overwrites [`setSharingFilter`](#setsharingfilter).

**Input arguments**  
This function takes no parameters.

**Returns**  
`void`

### setUserEmails

**Method signature**

```java
void setUserEmails(AppsFlyerProperties.EmailsCryptType cryptMethod,
                                   java.lang.String... emails)
```



**Description**  
Set the user emails and encrypt them.

**Input arguments**

| Type                                  | Name          | Description                                                                                                                                                                                                                         |
| :------------------------------------ | :------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AppsFlyerProperties.EmailsCryptType` | `cryptMethod` | Encryption methods: <ul><li>AppsFlyerProperties.EmailsCryptType.NONE</li><li> AppsFlyerProperties.EmailsCryptType.SHA256</li></ul> |
| `String...`                           | `emails`      | One or more  user emails.                                                                                                                                                                                                           |

**Returns**  
`void`.

### start

**Method signature**

```java
void start(Context context,
                           java.lang.String key,
                           AppsFlyerRequestListener listener)
```



**Description**  
Starts the SDK.

**Input arguments**

| Type                       | Name       | Description                                                                                                                          |
| :------------------------- | :--------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| `Context`                  | `context`  | Application Context if calling in the Application `onCreate` method, Activity Context if calling after Activity's `onResume` method. |
| `String`                   | `key`      | Your AppsFlyer dev key                                                                                                               |
| `AppsFlyerRequestListener` | `listener` | (Optional) Listener for getting the request status.                                                                                  |

**Returns**  
`void`.

**Usage example**  
See [integrating the SDK](doc:integrate-ios-sdk) for an example implementation.

### stop

**Method signature**

```java
void stop(boolean shouldStop,
                          Context context)
```



**Description**  
Once this API is invoked, our SDK no longer communicates with our servers and stops functioning.  
Useful when implementing user opt-in/opt-out.

> 📘 SDK restart
> 
> After `stop(true)` was called, you need to call `stop(false)` and only then call `start()`

**Input arguments**

| Type      | Name         | Description                     |
| :-------- | :----------- | :------------------------------ |
| `boolean` | `shouldStop` | should logging be stopped.      |
| `Context` | `context`    | Application / Activity context. |

**Returns**  
`void`.

### subscribeForDeepLink

**Method signature**

```java
void subscribeForDeepLink(DeepLinkListener deepLinkListener,
                                          long timeout)
```



**Description**

**Input arguments**

[block:parameters]
{
  "data": {
    "h-0": "Type",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "`DeepLinkListener`",
    "0-1": "`deepLinkListener`",
    "0-2": "",
    "1-0": "`long`",
    "1-1": "`timeout`",
    "1-2": "Optional.  \nUnits in milliseconds"
  },
  "cols": 3,
  "rows": 2,
  "align": [
    "left",
    "left",
    "left"
  ]
}
[/block]

**Returns**  
`void`

### unregisterConversionListener

**Method signature**

```java
void unregisterConversionListener()
```



**Description**  
Unregister a previously registered `AppsFlyerConversionListener`.

**Input arguments**  
This function takes no parameters.

**Returns**  
`void`

### updateServerUninstallToken

**Method signature**

```java
void updateServerUninstallToken(Context context,
                                                java.lang.String token)
```



**Description**  
For developers who use Firebase for purposes other than uninstall measurement. For more information, see [uninstall measurement](https://support.appsflyer.com/hc/en-us/articles/360017822118).

**Input arguments**

| Type      | Name      | Description                     |
| :-------- | :-------- | :------------------------------ |
| `Context` | `context` | Application / Activity context. |
| `String`  | `token`   | Firebase Device Token.          |

**Returns**  
`void`

**Usage example**

```java Java
AppsFlyerlib.getInstance().updateServerUninstallToken(getApplicationContext(), <TOKEN>);
```
```kotlin Kotlin
AppsFlyerlib.getInstance().updateServerUninstallToken(getApplicationContext(), <TOKEN>);
```



### validateAndLogInAppPurchase

**Method signature**

```java
void validateAndLogInAppPurchase(Context context,
                                                 java.lang.String publicKey,
                                                 java.lang.String signature,
                                                 java.lang.String purchaseData,
                                                 java.lang.String price,
                                                 java.lang.String currency,
                                                 java.util.Map<java.lang.String,java.lang.String> additionalParameters)
```



**Description**  
API for server verification of in-app purchases. An `af_purchase` event with the relevant values will be automatically logged if the validation is successful.

See detailed instructions in [validating purchases](doc:in-app-events-android#validating-purchases).

**Input arguments**

| Type                  | Name                   | Description                                                                                   |
| :-------------------- | :--------------------- | :-------------------------------------------------------------------------------------------- |
| `Context`             | `context`              | Application / Activity context.                                                               |
| `String`              | `publicKey`            | License Key obtained from the Google Play Console.                                            |
| `String`              | `signature`            | data.INAPP_DATA_SIGNATURE from onActivityResult(int requestCode, int resultCode, Intent data) |
| `String`              | `purchaseData`         | data.INAPP_PURCHASE_DATA from onActivityResult(int requestCode, int resultCode, Intent data)  |
| `String`              | `price`                | Purchase price, should be derived from skuDetails.getStringArrayList("DETAILS_LIST")          |
| `String`              | `currency`             | Purchase currency, should be derived from skuDetails.getStringArrayList("DETAILS_LIST")       |
| `Map<String, String>` | `additionalParameters` | Freehand parameters to be logged with the purchase (if validated).                            |

**Returns**  
`void`.

### waitForCustomerUserId

**Method signature**

```java
void waitForCustomerUserId(boolean wait)
```



**Description**  
This method defers the SDK initialization, until a `customerUserID` is provided.  
All in-app events and any other SDK API calls are discarded until the `customerUserID` is provided and logged.

**Input arguments**

| Type      | Name   | Description |
| :-------- | :----- | :---------- |
| `boolean` | `wait` |             |

**Returns**  
`void`.

**Usage example**

```java Java
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
```
```kotlin Kotlin
AppsFlyerLib.getInstance().waitForCustomerUserId(true);
```
