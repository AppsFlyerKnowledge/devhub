---
title: "Overview"
slug: "aggregate_pull_api_v2_overview"
category: 636a481d2d5ae60049dee909
hidden: false
order: 0
---
The Aggregate Pull API provides aggregated data about user acquisition and engagement metrics of specified media sources. The Aggregate Pull API features five distinct endpoints, each presenting the same data categorized into different groupings.

## Authentication

A Pull API authentication token (key) is required to use Pull API. See [API token instructions](https://support.appsflyer.com/hc/en-us/articles/360004562377).

## Base URL

```http
https://hq1.appsflyer.com/api/agg-data/export/app
```

## The Aggregate Pull API Endpoints

The following table lists the different reports and their endpoints, each presenting the same data aggregated by a different parameter set.

| Name                                                           | Aggregated by                                    | Method | Endpoint                                      |
|----------------------------------------------------------------|--------------------------------------------------|--------|------------------------------------------------|
| [Partners report](/hc/reference/get_app-id-partners-report-v5-1)      | Media source and campaign.                       | GET    |  /{app-id}/partners_report/v5              |
| [Partners daily report](/hc/reference/get_app-id-partners-by-date-report-v5-1) | Date, media source, and campaign.                | GET    |  /{app-id}/partners_by_date_report/v5      |
| [Daily report](/hc/reference/get_app-id-daily-report-v5-1)             | Date, media source, and campaign, excluding in-app events. | GET    |  /{app-id}/daily_report/v5            |
| [Geo report](/hc/reference/get_app-id-geo-report-v5-1)                   | Geo, media source, and campaign.                 | GET    |  /{app-id}/geo_report/v5                   |
| [Geo-by-date report](/hc/reference/get_app-id-geo-by-date-report-v5-1)   | Date and geo, plus media source and campaign.    | GET    |  /{app-id}/geo_by_date_report/v5           |


## Path parameters

The path parameters pertain to all reports.

| Parameter  | Data Type | Description                          | Example    |
|------------|-----------|--------------------------------------|------------|
| `app-id`*  | string    | The unique Application ID.           | id1234567  |

## Request parameters

The body parameters pertain to all reports.

| Parameter Name        | Type   | Description     | Example |
|-----------------------|--------|-----------------|---------|
| `from`*                | string | Start date for the report. | "2022-04-22" |
| `to`*                  | string | End date for the report. | "2022-04-22" |
| `media_source`        | string | Use to filter by a specific media source. Set both the `category` and `media_source` parameters as follows: <br> **Facebook:** Set `category` and `media_source` to facebook <br> **Twitter:** Set `category` and `media_source` to twitter <br> **Other media sources:** Set `category` to standard and `media_source` to the name of the media source. <br> 
| `category`            | string | **facebook**: Get only facebook data with the following groupings: `campaign_id`, `adset`, `adset_id`, `adgroup`, `adgroup_id` <br> **organic**: Get only organic data without the following groupings: `campaign_id`, `adset`, `adset_id`, `adgroup`, `adgroup_id` <br> **standard** (default): <br> - `media_source`: Get data only for the specified `media_source` without the following groupings: `campaign_id`, `adset`, `adset_id`, `adgroup`, `adgroup_id` <br> - `media_source=facebook`: Get only facebook data with the following groupings: `campaign_id`, `adset`, `adset_id`, `adgroup`, `adgroup_id` <br> - without `media_source` or `media_source=all`: Get all `media_source` without the following groupings: `campaign_id`, `adset`, `adset_id`, `adgroup`, `adgroup_id` | "standard" |
| `attribution_touch_type` | string | Type of attribution touchpoint (click or impression). | "click" |
| `event_name`          | array  | In-app events to filter by. | "purchase, level_completed, tutorial" |
| `timezone`               | string | Time zone for data return. | "UTC" |
| `geo`                  | string | Country code to filter data. | "US" |
| `currency`             | string | Currency for revenue and cost metrics. | "EUR" |
| `reattr`               | string | Indicates if retargeting conversion data should be returned. | "false" |
| `maximum_rows`         | string | Number of maximum rows returned by the API call. | "1000" |

