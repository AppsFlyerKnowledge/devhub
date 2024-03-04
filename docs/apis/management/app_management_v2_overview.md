---
title: "Overview"
slug: "app-management-v2-overview"
category: 65d1df96a2f25300104f9fe1
hidden: false
order: 0
---

**At a glance**

The dedicated API allows account admins to manage apps within their accounts, supporting the main features available in the UI. This includes adding, updating, and deleting apps. The API also incorporates the same error verification mechanisms. Please note that we currently allow adding and updating mobile apps only, while deletion is possible for all platforms.

## Add app API parameters

### Default request body parameters

The following API parameters are needed in the request body for adding an app:

| API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- |
| platform | string | Yes | Possible values: ‘android’, ‘ios’, ‘windowsphone’ |
| status | string | Yes | Possible values: ‘available’, ‘pending’, ‘out_of_store’ |
| app_name | string | Yes | A string of up to 100 characters |
| currency | string | Yes | The list of values appears in the [Add app API](https://dev.appsflyer.com/hc/reference/app-mng-v2-post) |
| time_zone | string | Yes | The list of values appears in the [Add app API](https://dev.appsflyer.com/hc/reference/app-mng-v2-post) |
| kidsPrivacy | boolean | Yes | Indicate whether or not your app is directed toward children or a mixed audience (both children and adults) [See more about defining the app audience](https://support.appsflyer.com/hc/en-us/articles/207377436-Adding-an-app-to-AppsFlyer#define-app-audience). Possible values: ‘true’, ‘false’. |

### Android status in the store

Additional request body parameters for the app status in Google Play and when published out of store.

| Status | API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- | --- |
| Available in store | app_url | string | Yes | A well-formatted URL |
| Pending approval/not published | app_id | string | Yes | Link to app id required semantics per platform |
| Published out of store | app_id | string | Yes | Link to app id required semantics per platform |
|  | app_url | string | No | A well-formatted URL |
|  | channel_name | string | Yes | a string that consists only of one or more uppercase or lowercase letters |

### iOS status in the App Store

Additional request body parameters for the app status in the store.

| Status | API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- | --- |
| Available in store | app_url | string | Yes | A well-formatted URL |
| Pending approval/not published | country | string | Yes | The list of values appears in the https://dev.appsflyer.com/hc/reference/app-mng-v2-post |
|  | app_id | string | Yes | Link to app id required semantics per platform |

## Update app API parameters

The following parameters, which are part of the URL, are needed in the URL for updating an app:

| API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- |
| appId | string | Yes | A valid AppsFlyer app ID |
| platform | string | Yes | Possible values: ‘android’, ‘ios’, ‘windowsphone’ |

The following parameters are needed in the request body:

| API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- |
| enableAggregatedAdvancedPrivacy | boolean | No | Enable or disable the Aggregated Advanced Privacy iOS feature for maintaining user privacy. Possible Values: ‘true’ (enabled) or ‘false’ (disabled) |
| minTimeBetweenSessions | number | No | Determine the minimum time between sessions for which sessions are counted. Possible Values: Values should be rendered in seconds, reflecting minutes or hours. The duration can span from 1 minute to 24 hours. Suitable values range between 60 (representing 1 minute) to 86,400 (representing 24 hours). |
| reAttributionWindow | number | No | The number of days after the first install that reinstalls aren’t attributed as new installs. Possible Values: Values should be rendered in days, reflecting months. The duration can span from 1 to 24 months. Suitable values range between 30 (representing 1 month) to 730 (representing 24 months). |
| enableProbabilisticViewThroughAttribution | boolean | No | Enable or disable the probabilistic View-through Attribution (VTA) feature for using probabilistic modeling to attribute conversions to ad impressions that were viewed. Possible values: ’true; (enabled) or ‘false’ (disabled). |
| enableSeoAppAttribution | boolean | No | Enable or disable the organic search attribution feature for attributing re-engagements to various organic search engines. Possible values: ‘true’ (enabled) or ‘false’ (disabled). |
| enableIpMasking | boolean | No | Enable or disable the IP Masking feature for anonymizing end-user device IP addresses in raw data reports and in postbacks sent to partners (for events per app). Possible values: ‘true’ (enabled) or ‘false’ (disabled). |
| enableReinstallDetection | boolean | No | For iOS only: Detect reinstalls without depending on advertising IDs. Determining whether an install was a reinstall or a new install enables deduplicating reinstalls from your NOIs. Possible values: ‘true’ (enabled) or ‘false’ (disabled). |
| reEngagementAttribution | object | No | This property configures the Retargeting Attribution feature. When enabled (reEngagementAttribution.isEnabled is set as true), AppsFlyer tracks and attributes re-engagement events to the appropriate source, providing valuable insights on user retention and re-engagement campaigns. |
| reEngagementAttribution.isEnabled | boolean | Yes | Enable or disable the Retargeting Attribution feature to record re-engagements of users engaging with a retargeting campaign. Possible values: ‘true’ (enabled) or ‘false’ (disabled). |
| reEngagementAttribution.minTimeBetweenReEngagements | number | No | Set the minimum time after a re-engagement conversion occurs so that additional re-engagement events won’t be attributed. This is used to avoid over-counting of conversions. Possible Values: Please provide this input in seconds. Valid values range from 3,600 (representing 1 hour) to 2,592,000 (representing 30 days). |

## Delete app API parameters

The following parameters are needed in the request URL for deleting an app:

| API Parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- |
| appId | string | Yes | A valid AppsFlyer app ID |
| platform | string | Yes | The list of values appears in the [Delete app API](https://dev.appsflyer.com/hc/reference/app-mng-v2-delete) | 
