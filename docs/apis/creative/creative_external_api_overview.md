---
title: Overview
slug: creative-external-api-overview
category:
  uri: AppsFlyer Creative External API
privacy:
  view: public
position: 0
---

The Creative External API is a programmatic HTTP API for uploading creatives and publishing ads to ad networks without using the AppsFlyer dashboard. v1.0 targets Facebook (Meta).

## Authentication

All requests require an AppsFlyer HQ1 API V2 token, sent as a standard bearer token:

```http
Authorization: Bearer <token>
```

To obtain a token, sign in to the [AppsFlyer platform](https://hq1.appsflyer.com), open your account's **Security center** → **API tokens**, and generate a token with access to the Creative product.

## Asynchronous model

The API is asynchronous. Submitting a batch and learning its outcome are two separate calls:

1. `POST /creative/v1.0/upload/batch` validates the request and returns a `batch_id` immediately. Per-item processing (download, validation, publish) happens server-side.
2. `GET /creative/v1.0/upload/status/{batch_id}` returns the current state of every item in the batch. Poll it until each item reaches a terminal state — `success` or `failed`.

Recommended polling cadence: start at 5 seconds and back off exponentially, capped at 60 seconds. Items typically reach a terminal state within a few minutes; large batches may take longer.

## Endpoints

Base URL: `https://hq1.appsflyer.com/creative-dashboard/api`

| Method | Path | Description |
| --- | --- | --- |
| POST | `/creative/v1.0/upload/batch` | Submit a creative upload + publish batch. Returns a `batch_id`. |
| GET | `/creative/v1.0/upload/status/{batch_id}` | Get per-item status and results for a batch. |

The status endpoint is scoped to your account — a `batch_id` that belongs to another account returns `404`.

## Validation and error isolation

Each creative is validated against the target network's constraints after it is downloaded. Failures are isolated to the individual creative — a creative that fails validation is marked `failed` while the rest of the batch continues to process.

## Reference

- [Submit a creative upload + publish batch](https://dev.appsflyer.com/hc/reference/creative-external-api-upload-batch-post) — `POST /creative/v1.0/upload/batch`
- [Get the status of an upload batch](https://dev.appsflyer.com/hc/reference/creative-external-api-upload-status-get) — `GET /creative/v1.0/upload/status/{batch_id}`
