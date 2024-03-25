---
title: "Overview"
slug: "incost-overview"
category: 659fad5eb597bf0045b7c4d0
hidden: false
order: 0
---

# Overview

The InCost API, part of AppsFlyer ROI360, lets ad networks programmatically send advertising cost data to AppsFlyer. AppsFlyer then ingests and processes the data, and makes it available to advertisers and partners via dashboards and reports. The result is advertisers get aggregate cost data that lets them understand the true ROAS impact of your network.

**Prerequisites**:

- The InCost API requires prior implementation of the [App list API for ad networks](https://dev.appsflyer.com/hc/reference/app-list-ad-nets-api-get).
- 90% of campaigns contain the Campaign ID.
- The ability to send data at least 6 times per day for increased data freshness. The specific times are up to the ad network.
- [If the ad network updates data retroactively] The ability to send data for the last 7 days every time, for increased data completion.

**To integrate the API**:

   1. Get the API token from your marketer to use as the bearer authorization token.
   2. Integrate the API methods as explained below.

## InCost API methods

InCost API consists of 3 methods, as explained in the following table.

|Method|What needs to be done|
|--|--|
| [Get app list](https://dev.appsflyer.com/hc/reference/app-list-ad-nets-api-get) | <ul><li>As mentioned in prerequisites, integrate the [App list API for ad networks](https://dev.appsflyer.com/hc/reference/app-list-ad-nets-api-get) to list the apps (app IDs) for which advertisers have enabled a cost integration with you.</li><li>Frequently check the list programmatically to update the list of apps for whom you send data. Remember: advertisers add apps regularly.</li><li>The API returns the app ID, name, timezone, and app-selected currency.</li></ul> |
| [Upload cost](https://dev.appsflyer.com/hc/reference/incost-uploader-post) | <ul><li>Use the API to send cost data in a JSON. Your marketer must tell you what fields to populate the JSON with.</li><li>InCost upload returns a job ID. You can use the job ID to check the job status.</ul> |
| [Get job status](https://dev.appsflyer.com/hc/reference/incost-jobstatus-get) | <ul><li>Use the API to query job status using the job ID.</li><li>Verify that the submitted job has an applied status.</li><li>If this is not the case, correct errors and resubmit.</li><li>A matched record score of less than 100(%) can indicate erroneous data.</li><li>Matching occurs when campaign attribution data, like clicks, matches campaign cost data.</li></ul> |

## Traits and limitations

| Trait | Description |
|----------|-------------|
| Date | <ul><li>Earliest date allowed: Previous 90 days relative to the current date</li><li>Most recent date allowed: The current date</li></ul> |
| Rate | API call-rate limited per ad network account (token):<ul><li>150 calls per minute</li><li>1,000 calls per day </li></ul> |
| File size | 1 MB |
