---
title: "Error messages"
slug: "app-management-v2-errors"
category: 65d1df96a2f25300104f9fe1
hidden: false
order: 1
---

## Errors for adding an app

| Error | Description |
| --- | --- |
| Invalid app ID length | The app ID that was entered exceeded the 100-character limit |
| Invalid app ID | An invalid app ID was entered. See the [required format per platform](https://support.appsflyer.com/hc/en-us/articles/207377436#enter-app-details). |
| Invalid app status | An invalid app status was entered. Possible statuses: <br> For Android: ​​‘available’, ‘pending’, ‘out_of_store’ <br> For iOS:  ‘available’, ‘pending’ |
| Invalid app name | An invalid app name was entered. |
| Invalid app URL | The provided app URL is invalid. See the [required format per platform](https://support.appsflyer.com/hc/en-us/articles/207377436#enter-app-details). |
| App already in the account | The app is already associated with the user’s account and cannot be added again. |
| Security error | The application cannot be added due to security reasons. Please contact the support team for assistance. |
| Failed to add the app | This app can’t be added. Please contact your CSM or hello@appsflyer.com. |

## Errors for updating an app

| Error | Description |
| --- | --- |
| Invalid app entry | The app that was entered either doesn’t exist in the account, the app ID was misspelled, or the wrong platform was entered. Please try again with the correct details. If the issue persists, contact your CSM or hello@appsflyer.com. |
| Failed to update app | There was a failure to update the app. Please try again later and if the issue persists, contact your CSM or hello@appsflyer.com. |
| Invalid minTimeBetweenSessions value | An invalid value was entered for the time between sessions. The value must be a whole number,  expressed in seconds, representing either 1-59 minutes or 1-24 hours. |
| Invalid reAttributionWindow value | An invalid value was entered for the attribution window. The value must be a whole number,  expressed in days, representing either 1-23 months (each month is typically considered to have 30 days) or 730 days. |
| Invalid minTimeBetweenReEngagements value | An invalid value was entered for the time between re-engagements. The value must be a whole number,  expressed in seconds, representing either 1-23 hours or 1-30 days. |
| Missing required value reEngagementAttribution.isEnabled | A value for the property reEngagementAttribution.isEnabled wasn’t sent. <br> Possible values: ‘true’ or ‘false’. |
| Invalid property ‘enableAggregatedAdvancedPrivacy’ | An invalid platform was entered ‘enableAggregatedAdvancedPrivacy’ is for iOS apps only. |
| Invalid property enableReinstallDetection | An invalid platform was entered. ‘enableReinstallDetection’ is for iOS apps only. |
| Invalid property enableSeoAppAttribution | An invalid platform was entered. ‘enableSeoAppAttribution’ is for iOS or Android apps only. |
| Invalid property type | The property type sent doesn’t match the types defined in the scheme. |
| Invalid platform url param | Expected platform URL parameter: ‘android’, ‘ios’, or ‘windowsphone’. Received ‘androidd’. |
| Invalid property type | An invalid data type was provided for the property. |

## Errors for deleting an app

| Error | Description |
| --- | --- |
| Invalid platform ${platform}, platform should be one of ${platforms} | The platform name was either misspelled or isn’t in the list of supported app platforms. [Learn more about the platforms and required details](https://support.appsflyer.com/hc/en-us/articles/207377436#enter-app-details). |
| App not found. | The app wasn’t found. Possible reasons: The app doesn’t exist in your account, the app ID was misspelled, or the wrong platform was entered. Please try again with the correct details. If the issue persists, contact your CSM or hello@appsflyer.com |
| Can’t delete a web app with bundles. | A web app can’t be deleted if it’s part of a bundle. [Learn more about deleting apps from a bundle](https://support.appsflyer.com/hc/en-us/articles/360000646498#how-do-i-add-or-remove-delete-apps-from-a-bundle). |
| The app can’t be deleted. | Failure in deleting the app. Please try again later and if the issue persists, contact your CSM or hello@appsflyer.com. |

## Errors in other issues

| Error | Description |
| --- | --- |
| API token verification failed | The API access token that was entered either doesn’t exist in the account or was misspelled. Please try again with the correct token. If the issue persists, contact your CSM or hello@appsflyer.com. |
| Authentication failure | The API access token that was entered either doesn’t exist in the account or was misspelled. Please try again with the correct token. If the issue persists, contact your CSM or hello@appsflyer.com. |
| Permissions | There was a problem with permissions for this account that prevented the request from being completed. |
