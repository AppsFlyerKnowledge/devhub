---
title: "Overview"
slug: "raw_data_pull_api_tokenv2-overview"
category: 624594011aecc40014db6e4e
hidden: false
order: 0
---

Get your raw data reports in CSV files.

## Base URL

```http
https://hq1.appsflyer.com/api/raw-data/export/app/
```

## Endpoints

| Name                                                                                                                        | Path                                            | API Method | Description                                                                                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Raw data reports (non-organic)**                                                                                          |                                                 |            |                                                                                                                                                                                       |
| [Installs](https://dev.appsflyer.com/hc/reference/get_app-id-installs-report-v5)                                            | `/{app-id}/installs_report/v5`                  | `GET`      | Records non-organic installs. The record is created when a user opens the app for the first time. Data is updated in real-time.                                                       |
| [In-app events](https://dev.appsflyer.com/hc/reference/get_app-id-in-app-events-report-v5)                                  | `/{app-id}/in_app_events_report/v5`             | `GET`      | Records in-app events performed by users. Data is updated in real-time.                                                                                                               |
| [Uninstalls](https://dev.appsflyer.com/hc/reference/get_app-id-uninstall-events-report-v5)                                  | `/{app-id}/uninstall_events_report/v5`          | `GET`      | Records when a user uninstalls the app. Data is updated daily.                                                                                                                        |
| [Reinstalls](https://dev.appsflyer.com/hc/reference/get_app-id-reinstalls-v5)                                               | `/{app-id}/reinstalls/v5`                       | `GET`      | Records users who reinstall the app after uninstalling and engaging with a User Acquisition (UA) media source during the reattribution window. Data is updated in real-time.          |
| **Raw data reports (organic)**                                                                                              |                                                 |            |                                                                                                                                                                                       |
| [Organic Installs](https://dev.appsflyer.com/hc/reference/get_app-id-organic-installs-report-v5)                            | `/{app-id}/organic_installs_report/v5`          | `GET`      | Records when the app is opened by a user for the first time without attribution to an advertising source. Data is updated continuously.                                               |
| [Organic in-app events](https://dev.appsflyer.com/hc/reference/get_app-id-organic-in-app-events-report-v5)                  | `/{app-id}/organic_in_app_events_report/v5`     | `GET`      | Records details about events performed by users organically. Data is updated continuously.                                                                                            |
| [Organic uninstalls](https://dev.appsflyer.com/hc/reference/get_app-id-organic-uninstall-events-report-v5)                  | `/{app-id}/organic_uninstall_events_report/v5`  | `GET`      | Records users uninstalling the app without prior engagement with non-organic sources. Data is updated daily.                                                                          |
| [Organic reinstalls](https://dev.appsflyer.com/hc/reference/get_app-id-reinstalls-organic-v5)                               | `/{app-id}/reinstalls_organic/v5`               | `GET`      | Records organically attributed reinstalls of the app. Data is updated in real-time.                                                                                                   |
| **Retargeting**                                                                                                             |                                                 |            |                                                                                                                                                                                       |
| [Conversions (re-engagements & re-attributions)](https://dev.appsflyer.com/hc/reference/get_app-id-installs-retarget-v5)    | `/{app-id}/installs-retarget/v5`                | `GET`      | Records conversions (re-engagements & re-attributions) from retargeting campaigns. Data is updated in real-time.                                                                      |
| [In-app events retargeting](https://dev.appsflyer.com/hc/reference/get_app-id-in-app-events-retarget-v5)                    | `/{app-id}/in-app-events-retarget/v5`           | `GET`      | Records in-app events during re-engagement window triggered by retargeting campaigns. Data is updated in real-time.                                                                   |
| **Ad Revenue Raw data**                                                                                                     |                                                 |            |                                                                                                                                                                                       |
| [Attributed ad revenue](https://dev.appsflyer.com/hc/reference/get_app-id-ad-revenue-raw-v5)                                | `/{app-id}/ad_revenue_raw/v5`                   | `GET`      | Records ad revenue for users attributed to a media source. Data is updated daily.                                                                                                     |
| [Organic ad revenue](https://dev.appsflyer.com/hc/reference/get_app-id-ad-revenue-organic-raw-v5)                           | `/{app-id}/ad_revenue_organic_raw/v5`           | `GET`      | Records ad revenue for users not attributed to any media source. Data is updated daily.                                                                                               |
| [Retargeting ad revenue](https://dev.appsflyer.com/hc/reference/get_app-id-ad-revenue-raw-retarget-v5)                      | `/{app-id}/ad-revenue-raw-retarget/v5`          | `GET`      | Records ad revenue for users attributed to retargeting campaigns during the re-engagement window. Data is updated daily.                                                              |
| **Protect360 fraud**                                                                                                        |                                                 |            |                                                                                                                                                                                       |
| [Installs (Protect360 fraud)](https://dev.appsflyer.com/hc/reference/get_app-id-blocked-installs-report-v5)                 | `/{app-id}/blocked_installs_report/v5`          | `GET`      | Records installs identified as fraudulent and therefore not attributed to any media source. Data freshness: Real-time                                                                 |
| [Post-attribution installs](https://dev.appsflyer.com/hc/reference/get_app-id-detection-v5)                                 | `/{app-id}/detection/v5`                        | `GET`      | Reports include installs attributed to a media source but later found to be fraudulent. Data freshness: Real-time                                                                     |
| [In-app events (Protect360 fraud)](https://dev.appsflyer.com/hc/reference/get_app-id-blocked-in-app-events-report-v5)       | `/{app-id}/blocked_in_app_events_report/v5`     | `GET`      | Records in-app events identified as fraudulent by Protect360. Data freshness: Daily                                                                                                   |
| [Post-attribution in-app events](https://dev.appsflyer.com/hc/reference/get_app-id-fraud-post-inapps-v5)                    | `/{app-id}/fraud-post-inapps/v5`                | `GET`      | Records in-app events for installs identified as fraudulent after being attributed to a media source or judged fraudulent without regard to the install itself. Data freshness: Daily |
| [Clicks (Protect360 fraud)](https://dev.appsflyer.com/hc/reference/get_app-id-blocked-clicks-report-v5)                     | `/{app-id}/blocked_clicks_report/v5`            | `GET`      | Records clicks performed by users blocked by Protect360. Data freshness: Daily                                                                                                        |
| [Blocked install postbacks](https://dev.appsflyer.com/hc/reference/get_app-id-blocked-install-postbacks-v5)                 | `/{app-id}/blocked_install_postbacks/v5`        | `GET`      | Records install postbacks that were blocked due to being identified as fraudulent. Data updated in real time.                                                                         |
| **Postbacks**                                                                                                               |                                                 |            |                                                                                                                                                                                       |
| [Install postbacks](https://dev.appsflyer.com/hc/reference/get_app-id-postbacks-v5)                                         | `/{app-id}/postbacks/v5`                        | `GET`      | Records install events generated when a user opens the app for the first time. Data freshness: Daily                                                                                  |
| [In-app event postbacks](https://dev.appsflyer.com/hc/reference/get_app-id-in-app-events-postbacks-v5)                      | `/{app-id}/in-app-events-postbacks/v5`          | `GET`      | Records in-app event postbacks sent to the media source. Data freshness: Daily                                                                                                        |
| [Retargeting in-app event postbacks](https://dev.appsflyer.com/hc/reference/get_app-id-retarget-in-app-events-postbacks-v5) | `/{app-id}/retarget_in_app_events_postbacks/v5` | `GET`      | Records in-app events users performed during the re-engagement window. Data freshness: Real-time                                                                                      |
| [Retargeting conversions postbacks](https://dev.appsflyer.com/hc/reference/get_app-id-retarget-install-postbacks-v5)        | `/{app-id}/retarget_install_postbacks/v5`       | `GET`      | Records retargeting conversion postbacks sent to the media source. Data freshness: Real-time                                                                                          |

## Path parameters

The path parameters are identical for all raw data pull APIs. 

| Parameter | Data Type | Description    | Example    |
| --------- | --------- | -------------- | ---------- |
| `app_id*` | string    | Application ID | `id121244` |

## Query parameters

The query parameters are identical for all raw data pull APIs

[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Type",
    "h-2": "Description",
    "h-3": "Example",
    "0-0": "`from` (required)",
    "0-1": "string",
    "0-2": "From date (report start date).",
    "0-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "1-0": "`to` (required)",
    "1-1": "string",
    "1-2": "To date (report end date).",
    "1-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "2-0": "`media_source`",
    "2-1": "string",
    "2-2": "**Support only single value** <br> Use to filter by a specific media source. Set both the `category` and `media_source` parameters as follows: <br> - Facebook: set `category` and `media_source` to facebook <br> - Twitter, set `category` and `media_source` to twitter; <br> - Other media sources, set `category` to standard and `media_source` to the name of the media source.",
    "2-3": "`facebook`",
    "3-0": "`category`",
    "3-1": "string",
    "3-2": "Use to filter the call for a specific media source. Set both the `category` and `media_source` parameters as follows: <br> - Facebook: set `category` and `media_source` to facebook <br> - Twitter, set `category` and `media_source` to twitter; <br> - Other media sources, set `category` to standard and `media_source` to the name of the media source.",
    "3-3": "`standard`, `facebook`, `twitter`",
    "4-0": "`event_name`",
    "4-1": "array",
    "4-2": "**Applicable only for in-app event report type** <br> Filter in-app events by specific events. Select multiple events by using a comma-separated list, for example: <br> `event_name=af_purchase,ftd`.",
    "4-3": "`af_purchase`, `ftd`",
    "5-0": "`timezone`",
    "5-1": "string",
    "5-2": "\\- **Default**: If the parameter is not provided, data is returned using UTC. <br> - Otherwise, data is returned using the app-specific time zone <br> - The time zone format takes daylight saving time into account. <br> - The time zone value must match the value in the app settings. For example, if the setting is Paris, use `timezone=Europe/Paris` in the the PULL API URL. <br> - Data in the selected time zone is available from the date the time zone setting was made; any earlier data uses UTC.<br>",
    "5-3": "",
    "6-0": "`geo`",
    "6-1": "string",
    "6-2": "Filter the data by country code. Limitation: Only one country code can be set per API call.",
    "6-3": "`f`",
    "7-0": "`currency`",
    "7-1": "string",
    "7-2": "\\- Specify the currency for revenue and cost reports. <br> - Use 'preferred' for the app-specific currency or 'USD' for US dollars. <br> - Aggregate Pull API reports always use the app-specific currency.<br>",
    "7-3": "`preferred`, `USD`",
    "8-0": "`maximum_rows`",
    "8-1": "integer",
    "8-2": "The maximum number of rows to be returned in the report.",
    "8-3": "",
    "9-0": "`from_install_time`",
    "9-1": "string",
    "9-2": "Start date for filtering by install time.",
    "9-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "10-0": "`to_install_time`",
    "10-1": "string",
    "10-2": "End date for filtering by install time.",
    "10-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "11-0": "`agency`",
    "11-1": "string",
    "11-2": "Filter by specific agency or multiple agencies. For non-transparent agencies, using both the `agency` and `media_source` filters together may return data from all agencies, regardless of the filtered media sources.",
    "11-3": "`\"agency=transparent_agency\"`, `\"media_source=media-source-name&agency=transparent_agency\"`, `\"agency=transparent_agency&agency=non_transparent_agency\"`",
    "12-0": "`additional_fields`",
    "12-1": "array",
    "12-2": "For the list of the additional fields and their description see the [Raw data field dictionary](https://support.appsflyer.com/hc/en-us/articles/208387843-Raw-data-field-dictionary#rawdata-fields-dictionary) table.",
    "12-3": "`[\"blocked_reason_rule\",\"store_reinstall\",\"impressions\"]`",
    "13-0": "`from_detect_time`",
    "13-1": "string",
    "13-2": "**Applicable only on Post-attribution installs and in-app events reports** <br> Start date for filtering by detect time.<br>",
    "13-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "14-0": "`to_detect_time`",
    "14-1": "string",
    "14-2": "**Applicable only on Post-attribution installs and in-app events reports** <br> End date for filtering by detect time.<br>",
    "14-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`"
  },
  "cols": 4,
  "rows": 15,
  "align": [
    null,
    null,
    null,
    null
  ]
}
[/block]


[block:parameters]
{
  "data": {
    "h-0": "Name",
    "h-1": "Type",
    "h-2": "Description",
    "h-3": "Example",
    "0-0": "`from`\\*",
    "0-1": "string",
    "0-2": "From date (report start date).",
    "0-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "1-0": "`to`\\*",
    "1-1": "string",
    "1-2": "To date (report end date).",
    "1-3": "`\"2022-04-22\"`, `\"2022-04-22 21:45\"`, `\"2022-04-22 21:45:23\"`",
    "2-0": "`media_source`",
    "2-1": "string",
    "2-2": "**Support only single value** <br> Use to filter by a specific media source. Set both the `category` and `media_source` parameters as follows: <br> - **Facebook**: set `category` and `media_source` to facebook <br> - **Twitter**: set `category` and `media_source` to twitter; <br> - **Other media sources**: set `category` to standard and `media_source` to the name of the media source.",
    "2-3": "`facebook`",
    "3-0": "`category`",
    "3-1": "string",
    "3-2": "Use to filter the call for a specific media source. Set both the `category` and `media_source` parameters as follows: <br> - **Facebook**: set `category` and `media_source` to facebook <br> - **Twitter**: set `category` and `media_source` to twitter; <br> - **Other media sources:** set `category` to standard and `media_source` to the name of the media source.",
    "3-3": "`standard`, `facebook`, `twitter`",
    "4-0": "`event_name`",
    "4-1": "array",
    "4-2": "**Applicable only for in-app event report type** <br> Filter in-app events by specific events. Select multiple events by using a comma-separated list, for example: <br> `event_name=af_purchase,ftd`.",
    "4-3": "`af_purchase`, `ftd`",
    "5-0": "`timezone`",
    "5-1": "string",
    "5-2": "- Default: If the parameter is not provided, data is returned using UTC. <br> - Otherwise, data is returned using the app-specific time zone <br> - The time zone format takes daylight saving time into account. <br> - The time zone value must match the value in the app settings. For example, if the setting is Paris, use `timezone=Europe/Paris` in the the PULL API URL. <br> - Data in the selected time zone is available from the date the time zone setting was made; any earlier data uses UTC.<br>",
    "5-3": "",
    "6-0": "`geo`",
    "6-1": "string",
    "6-2": "Filter the data by country code. Limitation: Only one country code can be set per API call.",
    "6-3": "`FR`",
    "7-0": "`currency`",
    "7-1": "string",
    "7-2": "- Specify the currency for revenue and cost reports. <br> - Use 'preferred' for the app-specific currency or 'USD' for US dollars. <br> - Aggregate Pull API reports always use the app-specific currency.<br>",
    "7-3": "`USD`",
    "8-0": "`maximum_rows`",
    "8-1": "integer",
    "8-2": "The maximum number of rows to be returned in the report.",
    "8-3": "`1000000`",
    "9-0": "`from_install_time`",
    "9-1": "string",
    "9-2": "Start date for filtering by install time.",
    "9-3": "`\"2022-04-22\"`",
    "10-0": "`to_install_time`",
    "10-1": "string",
    "10-2": "End date for filtering by install time.",
    "10-3": "`\"2022-04-29\"`",
    "11-0": "`agency`",
    "11-1": "string",
    "11-2": "Filter by specific agency or multiple agencies. For non-transparent agencies, using both the `agency` and `media_source` filters together may return data from all agencies, regardless of the filtered media sources.",
    "11-3": "`\"agency=transparent_agency\"`",
    "12-0": "`additional_fields`",
    "12-1": "array",
    "12-2": "For the list of the additional fields and their description see the [Raw data field dictionary](https://support.appsflyer.com/hc/en-us/articles/208387843-Raw-data-field-dictionary#rawdata-fields-dictionary) table.",
    "12-3": "`[\"blocked_reason_rule\",\"store_reinstall\",\"impressions\"]`"
  },
  "cols": 4,
  "rows": 13,
  "align": [
    null,
    null,
    null,
    null
  ]
}
[/block]