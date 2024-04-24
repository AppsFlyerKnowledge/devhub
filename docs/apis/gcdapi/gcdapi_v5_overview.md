---
title: "Overview"
slug: "gcdapi_v5_overview"
category: 638628a899eda80f20cababa
hidden: false
order: 0
---

You can trigger this API to confirm that your SDK is integrated correctly into your app.

Follow [these instructions](https://dev.appsflyer.com/hc/docs/testing-android#inspect-conversion-data) to simulate an ad click that leads to an app installation. Then, trigger this API to retrieve from AppsFlyer the detailed information about the simulated install.

## Endpoint

```http
GET https://gcdsdk.appsflyer.com/install_data/v4.0/{app-id}
```
## Path parameters

| Parameter | Data Type | Description                       | Example    |
|-----------|-----------|-----------------------------------|------------|
| app-id*   | string    | The unique Application ID.        | id1234567  |

## Query parameters

| Name       | Type   | Description                                                         | Example                   |
|------------|--------|---------------------------------------------------------------------|---------------------------|
| devkey*    | string | Application's devkey. Learn [here](https://support.appsflyer.com/hc/en-us/articles/207032066-Basic-SDK-integration-guide#retrieve-the-dev-key) how to get it.                                              | ABCDEw4F78vGTeTuY12345    |
| device_id* | string | The UID of this specific install (Not to be confused with Advertiser ID)<br>Instructions on how to retrieve the UID:<br> - [Android](https://dev.appsflyer.com/hc/docs/testing-android#inspect-conversion-data)<br> - [iOS](https://dev.appsflyer.com/hc/docs/testing-ios#inspect-conversion-data) | 1600009251234-1234567     |

