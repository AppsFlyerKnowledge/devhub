---
title: "Overview"
slug: "onelinkapi_overview"
category: 624693c6fa631302dde62cf5
hidden: false
order: 0
---

## Prerequisites

Authentication token. Learn [how to obtain the API token](https://support.appsflyer.com/hc/en-us/articles/360001250345-OneLink-API#setup).

<br>

## Create OneLink attribution link

### HTTP request

```http
POST https://onelink.appsflyer.com/shortlink/v1/{onelink-id}&id={id}
```

### Path parameters

| Parameter     | Type | Description           | Example |
| ------------- | --------- | --------------------- | ------- |
| `onelink-id` | string    | Required. The link template ID. | `A1b3`  |

### Query parameters

| Parameter | Type | Description                                                                                             | Example           |
| --------- | --------- | ------------------------------------------------------------------------------------------------------- | ----------------- |
| `id`      | string    | The ID of the created short link. When the ID is not provided in the request, a random ID is generated. | `my_shortlink_id` |

### Body parameters

| Name           | Type   | Description                                                                                                                                                                                                                                                                 | Example                                                 |
| -------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `brand_domain` | string | Only use this param and request it in the payload if: <br>1) The Branded Links feature is enabled in your account.<br>2) The branded link is configured in your account. <br><br>If these conditions are not met, do not use this parameter, as the API call will not work. | [`mybranded.com`](http://mybranded.com/)                |
| `ttl`          | string | Time to Live for the full attribution link. The default is 31 days. The value can be specified in days (default), minutes, or hours (for example, 10m, 20h, 14d).                                                                                                           | `25d`                                                   |
| `data`        | JSON   | Required. JSON format of the query parameters following the AppsFlyer macros for attribution links. <br><br>**Note**: The media source (`pid`) parameter is mandatory.                                                                                                                | `'{"pid": "my_media_source_SMS", "c": "my_campaign" }'` |

<br>

## Get OneLink attribution link

### HTTP request

```http
GET https://onelink.appsflyer.com/shortlink/v1/{onelink-id}&id={id}
```

### Path parameters

| Parameter     | Type | Description           | Example |
| ------------- | --------- | --------------------- | ------- |
| `onelink-id` | string    | Required. The link template ID. | `A1b3`  |

### Query parameters

| Parameter | Type | Description                                                                                                                                                       | Example           |
| --------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `id`      | string    | The ID of the short OneLink query params. For example, for the following OneLink attribution link: myapp.onelink.me/abc123/qwer9876, the shortlink-id is qwer9876 | `my_shortlink_id` |

<br>

## Update OneLink attribution link

### HTTP request

```http
PUT https://onelink.appsflyer.com/shortlink/v1/{onelink-id}&id={id}
```
### Path parameters

| Parameter     | Type | Description           | Example |
| ------------- | --------- | --------------------- | ------- |
| `onelink-id` | string    | Required. The link template ID. | `A1b3`  |

### Query parameters

| Parameter | Data Type | Description                                                                                                                                          | Example           |
| --------- | --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `id`     | string    | Required. The ID of the short OneLink. For example, for the following OneLink attribution link: myapp.onelink.me/abc123/qwer9876, the shortlink-id is qwer9876 | `my_shortlink_id` |

### Body parameters

| Name           | Type   | Description                                                                                                                                                                                                                                                                 | Example                                  |
| -------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| `brand_domain` | string | Only use this param and request it in the payload if: <br>1) The Branded Links feature is enabled in your account.<br>2) The branded link is configured in your account. <br><br>If these conditions are not met, do not use this parameter, as the API call will not work. | [`mybranded.com`](http://mybranded.com/) |
| `ttl`          | string | Time to Live for the full attribution link. The default is 31 days. The value can be specified in days (default),                                                                                                                                                           |                                          |

<br>

## Delete OneLink attribution link

### HTTP request

```http
DELETE https://onelink.appsflyer.com/shortlink/v1/{onelink-id}&id={id}
```

### Path parameters

| Parameter     | Type | Description           | Example |
| ------------- | --------- | --------------------- | ------- |
| `onelink-id` | string    | Required. The link template ID. | `A1b3`  |

### Query parameters

| Parameter | Type | Description                                                                                                                                              | Example           |
| --------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `id`     | string    | Required. The ID of the short OneLink to be deleted. For example, for the following OneLink attribution link: myapp.onelink.me/abc123/qwer9876, the ID is qwer9876 | `my_shortlink_id` |

## API Limitations

| Limits             | Remarks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| API quota limit    | • The limit for using the OneLink API to create, edit, or delete OneLink links is 7.5 million per month (UTC timezone), per account.<br>• All requests that are made **after** exceeding this quota are not served, and the links are not created; the API call receives error status code 429 with the message "Monthly quota exceeded".<br>• Information regarding how much of the rate quota is used/remains is displayed in the OneLink API dashboard.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Rate limit         | • The API rate limit per account is 500 requests per second (30000 per minute).<br>• All requests that are made exceeding 500 requests per second (30000 per minute) are not served, and the links are not created; the API call receives error status code 429 with the message "Rate limit exceeded".                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Link visibility    | • Links created via the API do not appear in the list of OneLink custom links in the AppsFlyer dashboard.<br>• Best practice: Save API-created links to a local table, so you can access the links for any future purpose.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| TTL                | • The default time to live (TTL) for OneLink short URLs created via OneLink API is 31 days. It's extended by 31 days each time the link is clicked. Clicking on a link once the TTL expires still defaults to the behavior defined in the OneLink base configuration, but the attribution will not work.<br>• It can take up to 48 hours for a OneLink short URL to be deleted after the TTL expires.<br>• Maximum TTL is 31 days. Any TTL value larger than 31 is overridden with the default TTL of 31.<br>• You can change the default TTL by adding the parameter `ttl={value}` and specifying how many days, hours, or minutes. For example `ttl=7d`, `ttl=12h`, or `ttl=10m`.<br>• You can send an [update request](https://dev.appsflyer.com/reference/onelink_rest_api#update-onelink-attribution-link) to specify the TTL. Any update request resets the TTL (for existing links) to the one specified in the request body.<br>• If you don't want link TTLs to automatically extend, add the parameter `renew_ttl=false` to your links. The value for this parameter is boolean, either true (default) or false. |
| Special characters | The following characters must be encoded if used for API created links: ;, \*, !, @, #, ?, $, ^, :, &, ~, \`, =, +, ’, >, \<, /If you don't encode these characters, they are replaced with a blank space, and the link and its functionality could potentially break.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Payload            | Query string from the payload can't exceed 2,048 characters.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| URL ID             | The URL ID (or shortlink ID) can be edited to highlight your campaign offering. For example: <https://myapp.onelink.me/abc123/**apples>**. The URL ID must not exceed 50 characters and can be a combination of letters and numbers. By default, it is 8 characters.<br>**Note:\*\*<br>• You can only edit the URL ID if the current ID isn't already in use.<br>• If the URL ID is already in use, link creation fails and returns an error response (400). You and your developer need to decide and configure what happens in such an event.<br>• The failed call still counts toward your monthly API quota.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |