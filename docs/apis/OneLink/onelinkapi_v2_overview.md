---
title: "OneLink API v2.0 - Overview"
slug: "onelinkapi_v2_overview"
category: 6829800b8e61c5005284ad14
parentDoc: 6861240b50e56f0062c68f47
hidden: false
order: 0
---
OneLink Rest API enables programmatic creation, management, and retrieval of short links used for redirection, deep linking, and measurement across different platforms and channels. 

> 📘 Note
> 
> - The current OneLink API version is v2.0, which replaces v1. The v1 developer
> documentation is available [here](https://dev.appsflyer.com/hc/reference/onelinkapi_overview). 
> - OneLink API v1 will sunset on June 1, 2026. Make sure to migrate all OneLink API flows before this
date. To migrate from v1 to v2.0, use the [migration guide](https://dev.appsflyer.com/hc/reference/migrate_to_onelink_api_v2).

**API Limitations:**

| Limits | Remarks |
| ----- | ----- |
| **API quota limit** | The limit for using the OneLink API to create, edit, or delete OneLink links is 7.5 million requests per month (UTC timezone), per account. POST, PUT, and DELETE requests count towards this limit. GET requests and GET QR requests are excluded. All requests that exceed the quota receive status code 429 with the message "Monthly quota exceeded". To check your monthly quota, you can either: Visit the OneLink API page in the AppsFlyer platform to view usage history from the past 4 months, or use the GET quota API to retrieve the current quota status (remaining requests). You can also use it to trigger internal alerts when usage nears your defined threshold. |
| **Link visibility** | Links created via the API do not appear in the list of OneLink custom links in the AppsFlyer dashboard. Best practice: Save API-created links in your own system for future reference. |
| **Parameter validation** | Every link parameter in the body “data” gets validated before the link is created or updated (POST/PUT). If any of the parameters are invalid, the link won’t be created/updated, and the response will be error 400\. The error code will be `invalid_parameter`, and will specify which parameter is invalid and why. |
| **Payload** | The link parameters payload ("data" body parameter) value must not exceed 2048 characters. |
| **Rate limit** | OneLink API endpoints support an increased limit of 1000 requests per second per account. GET QR code endpoint is limited to 25 requests per second per account. Exceeding these thresholds results in a 429 status with the message "Rate limit exceeded". |
| **Link Source compatibility** | <ul><li><strong>QR Code generation:</strong> Supported only for short links created or updated using OneLink API v2.0.</li><li><strong>Update/Delete:</strong><ul><li>Links created using OneLink API v1 can be updated or deleted using v2.0 operations.</li><li>Links created via the UI (OneLink Management), Bulk Link tools, or the SDK link-generator cannot be updated or deleted using OneLink API v2.0.</li></ul></li><li><strong>Migration by update:</strong> Updating a v1-created link with v2.0 effectively migrates the link. It then behaves as if it were originally created with OneLink API v2.0, which enables features such as extended TTL and QR generation.</li><li><strong>Read (GET):</strong> The v2.0 GET endpoint can retrieve any short link, regardless of its creation source.</li></ul> |
| **Special characters** | There is no need to encode the payload parameters (key and values), with the exception of the following characters: `<`, `>`. Failure to encode them may break the link’s functionality. |
| **TTL (Time To Live)** | Default TTL is 31 days. TTL is extended by the specified duration on each click or update. The maximum optional TTL is 365 days, and it can be set per link using the TTL body parameter in POST and PUT requests: `ttl={value}` (e.g., `ttl=7d`, `ttl=12h`). To prevent automatic extension, use `renew_ttl=false`. Default is true. Expired links default to the OneLink template base configuration behavior, but attribution does not work. It can take up to 48 hours for links to be deleted post-expiration date. |
| **URL ID** | The `shortlink_id` can be set or edited to textually identify the link's purpose or unique setup. For example, [https://myapp.onelink.me/abc123/apples](https://myapp.onelink.me/abc123/apples). The URL ID must not exceed 50 characters and can be a combination of letters and numbers. The default ID is 8 characters. If a custom ID already exists, the API returns a 409 error. The failed call still counts toward the monthly quota. |
| **TTL (Time To Live)** | Default TTL is 31 days. TTL is extended by the specified duration on each click or update. The maximum optional TTL is 365 days, and it can be set per link using the TTL body parameter in POST and PUT requests: `ttl={value}` (e.g., `ttl=7d`, `ttl=12h`). To prevent automatic extension, use `renew_ttl=false`. Default is true. Expired links default to the OneLink template base configuration behavior, but attribution does not work. It can take up to 48 hours for links to be deleted post-expiration date. |
| **URL ID** | The `shortlink_id` can be set or edited to textually identify the link's purpose or unique setup. For example, [https://myapp.onelink.me/abc123/apples](https://myapp.onelink.me/abc123/apples). The URL ID must not exceed 50 characters and can be a combination of letters and numbers. The default ID is 8 characters. If a custom ID already exists, the API returns a 409 error. The failed call still counts toward the monthly quota. |

