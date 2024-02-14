---
title: "Overview"
slug: "app-list-ad-nets-overview"
category: 649adc4b66993d000bd3b723
hidden: false
order: 0
---

**At a glance:**

The [App list API for ad networks](https://dev.appsflyer.com/hc/reference/app-list-ad-nets-api-get) gives ad networks a list of the apps (app IDs) for which advertisers have enabled an integration with you. The response is returned as a JSON file.

**To integrate the API**:

Get the API token from your marketer to use as the bearer authorization token.
Follow the [App list API for ad networks instructions](https://dev.appsflyer.com/hc/reference/app-list-ad-nets-api-get).

## Limitations

|Limitation|Remarks|
|--|--|
| Request limit | <ul><li>20 requests per minute</li><li>100 requests per day</li></ul> |
| Record limit | 1,000 records per request. See [Pagination](https://dev.appsflyer.com/hc/reference/pagination) for when there are more than 1,000 records.|

## Pagination

### Pagination principles

The API has a pagination mechanism that's always operational and implemented.

The API returns up to 1,000 records per request (page).

Response JSONs contain the following pagination-related keys:

- `meta.total_items`: The number of records to be returned by all pages combined. This represents the number of apps for which you have been granted the capabilities being queried.  
- `links.prev`: If there was a previous request, the pagination link for the request used to generate the previous page.
- `links.self`: The pagination link for the current request, used to generate the current page.
- `links.next`: The pagination link for the request required to get the next page. If there is no next key, this is the last page.

Use one of the following pagination control methods:

- **Best practice**: Use the links in the JSON: If the `links.next` key exists, use it to create a request to get the next page. Continue to do so until you receive a JSON without a links.next key.
- Programmatically implement limit and offset parameters in conjunction with the `total_items` key.

### Pagination JSON example

- The JSON example that follows contains the result of the first request, where the second request contains two records in the data section (not displayed).
- The total number of records to return is 6.
- The  `links.next`  key contains the request that returns the next page, meaning records 5 and 6.

```json
{                                                                                         
    "data": {[...]},   
    "meta": {
        "total_items": 6
    },
    "links": {
        "prev": "https://hq1.appsflyer.com/api/mng/apps?capabilities=protect_360&offset=0&limit=2",
        "self": "https://hq1.appsflyer.com/api/mng/apps?capabilities=protect_360&offset=2&limit=2",
        "next": "https://hq1.appsflyer.com/api/mng/apps?capabilities=protect_360&offset=4&limit=2"
    }
}
```
