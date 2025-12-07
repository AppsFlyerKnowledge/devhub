---
title: "Migrate to OneLink API v.2.0"
slug: "migrate_to_onelink_api_v2"
category: 6829800b8e61c5005284ad14
parentDoc: 6861240b50e56f0062c68f47
hidden: false
order: 0
---

Use this document to understand what has changed in V2.0 and how to transition to the new version effectively:

- **[V1 to V2.0 version comparison](#onelink-api-version-1-and-version-2-side-by-side-comparison)**. This section outlines the changes and new features in V2.0

- **[Recommended migration plan](#recommended-migration-plan)**. This section provides a recommended multi-step migration plan and tips to support a phased rollout of the new version.

## OneLink API Version 1 and Version 2 Side by side comparison

Use the following table to compare OneLink API v1 with v2.0 across endpoints, behaviors, validation, quota, and other functional changes.

[block:parameters]
{
  "data": {
    "h-0": "**Area**",
    "h-1": "**v1 (today)**",
    "h-2": "**v2.0 (GA)**",
    "h-3": "** Recommendations**",
    "0-0": "**Base URL & versioning**",
    "0-1": "`https://onelink.appsflyer.com/\nshortlink/v1/{onelink-id}`",
    "0-2": "`https://onelink.appsflyer.com/\napi/v2.0/shortlinks/{onelink-id}`",
    "0-3": "Externalize the base path in config and update the client routing.",
    "1-0": "**Create link (endpoint)**",
    "1-1": "**POST**  \n`/shortlink/v1/{onelink-id}`.  \nThe optional custom shortlink ID is a **query** parameter.  \n**→ Response:** plain **string URL**",
    "1-2": "**POST** `/api/v2.0/shortlinks/{onelink-id}`  \nThe optional custom shortlink ID is a **body** parameter.  \n**→ Response:** JSON containing the short URL under `shortlink_url`.",
    "1-3": "Align to v2.0 request syntax, update parsing to read JSON and extract `shortlink_url`, and handle the stricter validation where invalid parameters now error clearly.",
    "2-0": "**Get link (endpoint)**",
    "2-1": "**GET**  \n`/shortlink/v1/{onelink-id}?id={shortlink_id}`.  \nShortlink ID is a **query **parameter (easy to misread as optional).  \n**→ Response:** JSON of short-link parameters **only**",
    "2-2": "**GET** `/api/v2.0/shortlinks/{onelink-id}/{shortlink_id}`.  \nShortlink ID is a mandatory **path parameter**.  \n**→ Response:** JSON with **payload** + **expiry** + **TTL**",
    "2-3": "This improves maintainability, since the TTL window and expiry time can be read directly.  \nAlign to v2.0 syntax and update consumers to read the payload, expiry, and TTL.",
    "3-0": "**Update link (endpoint)**",
    "3-1": "**PUT**  \n`/shortlink/v1/{onelink-id}?id={shortlink_id}`.  \n** → Response:** plain **string URL**",
    "3-2": "**PUT**  \n`/api/v2.0/shortlinks/{onelink-id}/{shortlink_id}`.  \n**→ Response:** JSON with short URL under `shortlink_url`.",
    "3-3": "Align to v2.0 request syntax, update parsing to read JSON and extract shortlink_url, and handle the stricter validation where invalid parameters now error clearly.",
    "4-0": "**Delete link (endpoint)**",
    "4-1": "**DELETE**  \n`/shortlink/v1/{onelink-id}?id={shortlink_id}`",
    "4-2": "**DELETE**  \n`/api/v2.0/shortlinks/{onelink-id}/{shortlink_id}`",
    "4-3": "Align to v2.0 request syntax.",
    "5-0": "**TTL model & value**",
    "5-1": "Max TTL **31 days**. TTL auto-renews on **click or update**, unless `renew_ttl=false.`.",
    "5-2": "TTL configurable **up to 730 days**.  \nSame auto-renew logic on **click or update**.  \nSupports **non-renewing** (one-time) links via `renew_ttl=false.`.",
    "5-3": "Per-link TTL control supports one-time links (login, temp promos) or evergreen printed QRs that can live ≥1 year and longer if active, without needing to revive or delete them. Set TTL policies per use case.",
    "6-0": "**QR code**",
    "6-1": "Typically done via 3rd-party tools.",
    "6-2": "**New:** GET **QR image** for an existing short link.",
    "6-3": "This feature is only available for links created through the OneLink API v2.0.  \nGet QR returns 400 for short Links created via UI/Bulk/SDK.  \nGET QR does not count toward the monthly quota. It can be used programmatically, including generating a link and immediately getting its QR.",
    "7-0": "**Monthly quota (account)**",
    "7-1": "One monthly quota shared across v1. Counted: **POST/PUT/DELETE**. ",
    "7-2": "During migration: quota is doubled (you get the same quota for each version, v1.o and v2.0).  \nCounted: POST/PUT/DELETE.  \nNot counted: GET QR.",
    "7-3": "Dual-run is safe during migration. After v1 sunset, only the standard v2.0 quota applies.",
    "8-0": "**Quota / usage visibility**",
    "8-1": "Visible only in the AppsFlyer UI.",
    "8-2": "OneLink API page provides a split view for both versions during migration, and includes a quota and usage API that returns the remaining monthly count.",
    "8-3": "You can add lightweight alerts off the quota API at thresholds such as 80% or 90%.",
    "9-0": "**Rate limit**",
    "9-1": "**500 rps** per account.",
    "9-2": "**1000 rps** per account.",
    "9-3": "If throttling is enabled on the client side, increase the cap and maintain exponential backoff for 429 responses.",
    "10-0": "**Error responses**",
    "10-1": "Often plain **string** errors.",
    "10-2": "Standard JSON errors (`code`, `message`, `details`).",
    "10-3": "Update error handling and logging to parse JSON for success and error, and map error codes to monitoring for faster triage.",
    "11-0": "**Validation**",
    "11-1": "Basic validation",
    "11-2": "Stricter parameter validation.",
    "11-3": "Parameters that worked in v1 may fail in v2.0.  \nFix formatting, encoding, and required fields at the source.",
    "12-0": "**Encoding of parameters**",
    "12-1": "Must encode parameters yourself.",
    "12-2": "OneLink handles encoding automatically.",
    "12-3": "If a URL parameter contains a query string, encode that query string (e.g., `&` and `?`) so the parameter value does not break parsing or logic.",
    "13-0": "**Authentication**",
    "13-1": "API token in the header.",
    "13-2": "API token in the header.",
    "13-3": "No change in authentication.  \nKeep existing token management best practices."
  },
  "cols": 4,
  "rows": 14,
  "align": [
    null,
    null,
    null,
    null
  ]
}
[/block]


<br />

## Recommended migration plan

Use the following steps to guide your migration from OneLink API v1 to v2.0.

[block:parameters]
{
  "data": {
    "h-0": "Step",
    "h-1": "Name",
    "h-2": "Description",
    "0-0": "**01**",
    "0-1": "**Usage Inventory**",
    "0-2": "Identify and list all locations calling the OneLink API. Includes CRM systems, mobile/web backend, internal link tools, landing pages, and call-center tools. Knowing where links are created or updated helps avoid surprises.",
    "1-0": "**02**",
    "1-1": "**Switch base URL**",
    "1-2": "Point the API client to the new version using a configuration flag or environment variable. This keeps rollback simple and avoids code duplication.",
    "2-0": "**03**",
    "2-1": "**Update request & response handling**",
    "2-2": "Update response handling to read JSON for both success and error responses. Adjust the request syntax changes, including the use of path/body parameters for the shortlink ID.",
    "3-0": "**04**",
    "3-1": "**Fix parameter validation issues**",
    "3-2": "Test common payloads. Stricter validation may reject parameters that previously passed. Adjust formatting, encoding, and dynamic fields. This is typically the main migration effort.",
    "4-0": "**05**",
    "4-1": "**Pilot one low-risk flow**",
    "4-2": "Run the updated integration in a safe or low-impact environment. Verify link creation, correct returns, end-to-end resolution, and proper handling of success and error responses before moving to higher-traffic flows.",
    "5-0": "**06**",
    "5-1": "**Gradually roll out**",
    "5-2": "Once the pilot is stable, migrate additional flows one at a time. v1 and v2 have parallel quotas, so gradual rollout will not throttle volume.",
    "6-0": "**07**",
    "6-1": "**Optimize after migration**",
    "6-2": "Once on the new version:  \n  \n- Use extended TTL for long-term links.\n- Replace external QR generators with the new QR endpoint.\n- Increase throttling limits to use the 1000 RPS rate.\n- Set internal quota alerts using the Quota endpoint for proactive monitoring."
  },
  "cols": 3,
  "rows": 7,
  "align": [
    null,
    null,
    null
  ]
}
[/block]