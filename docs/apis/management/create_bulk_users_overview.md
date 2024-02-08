---
title: "Overview"
slug: "create-bulk-users-overview"
category: 65b6092bf5a65400575b99ec
hidden: false
order: 0
---

**At a glance:** 

Account admins can add multiple users to their accounts in bulk using a dedicated API. The API supports the main user management features in the UI, covers all fields for adding users, and includes the same error verifications.

## API parameters for adding users in bulk

The following table details all API parameters and properties for adding new users in bulk. See schema examples below the table.

> Note
> 
> - If any of the mandatory parameters aren't entered in the API call or they're written incorrectly, the associated user isn't added. An [error message](notion://www.notion.so/appsflyerrnd/markdown-3ba0de41bbbd4f258fde67e10a718afe#error-messages) is sent through the API.
> - There's a maximum limit of **20 user additions per API call**.
> - There's a maximum **daily limit** of **20 API calls per account**.
  
| API parameter | Type | Mandatory | Remarks |
| --- | --- | --- | --- |
| username | String | ✓ | The username can include letters, numbers, spaces, and the following characters:. - _ ` [ ] ( ) | @ : , + & |
| email | String | ✓ | Enter a valid email address. |
| department | String | — |  |
| role | String | ✓ | admin and security roles must have unrestricted access to apps, media sources, and geos. |
| app_ids | Array: • Empty [] • Specific apps | — | • When empty, the user has no app access • If not included in the schema, the default is access to all apps. |
| allow_access_to_all_future_apps | Boolean: true or false | ✓ | When choosing true, the  app_ids mustn't be limited. |
| media_sources | Array:• Empty [] • Specific media sources | — | When empty or if not included in the schema, the default is access to all media sources. |
| geos | Array: • Empty [] • Specific geos | — | When empty or if not included in the schema, the default is access to all geos. |

### Schema example: full user access

This schema grants user access to all apps (including future apps), and to all media sources and geos:

```
"email": "my_company@my_company.com ",
"username": "Demi Smith",
"department": "MC Marketing",
"role": "marketing",
"allow_access_to_all_future_apps": true,
"media_sources": [],
"geos": []
```

### Schema example: limited user access

This schema limits user access to apps (no future apps), media sources, and geos, according to those specified in the array:

```
"email": "my_company@my_company.com ",
"username": "Demi Smith",
"department": "MC Marketing",
"role": "marketing",
"allow_access_to_all_future_apps": false,
"app_ids": ["my_app1", "my_app2"],
"media_sources": ["amplitude", "airship"],
"geos": ["angola", "aruba"]
```

## Error messages

In some cases, users can't be added. The table below describes the reasons for such cases and explanations about the error messages.

| Error message | Description |
| --- | --- |
| Invalid email address. | The format of the email address isn't correct. |
| This user already exists in this account. | You're trying to add a user to an account in which they already exist. |
| Errors about adding users to multiple accounts |  |
| This user can't be added because their status is "pending" in another account. | You can't add a user to an account if in another account it's in a "pending" status. |
| A user from an advertiser account can't be added to agency or partner accounts. | Users from advertiser accounts can't be added to agency or partner accounts. |
| A user from an agency or a partner account can't be added to an advertiser account. | Users from agency or partner accounts can't be added to advertiser accounts. |
| This user is in another account that doesn't currently support users in multiple accounts. | Not all accounts support multiple users. You're trying to add a user from such an account. |
| This account doesn't currently support adding users in multiple accounts.. | Not all accounts support multiple users. You're trying to add a user to such an account. |
| This user can't be added because they're in an account that uses SSO. | Accounts with SSO authentication don't support multiple users. You're trying to add a user from such an account. |
| This user can't be added because this account uses SSO. | Accounts with SSO authentication don't support multiple users. You're trying to add a user to such an account. |
| This user can't be added because they're in an account that uses 2FA. | Accounts with 2FA authentication don't support multiple users. You're trying to add a user from such an account. |
| This user can't be added because this account uses 2FA. | Accounts with 2FA authentication don't support multiple users. You're trying to add a user to such an account. |
| Mistakes in the API parameters |  |
| Invalid characters were used in the username. | The username can include letters, numbers, spaces, and the following characters only: .-_`[]()|@:,+& |
| The username exceeded the 100-character limit. | The username can contain up to 100 characters. |
| The role was either misspelled or doesn’t exist. | The role that was entered either doesn't exist in the list of roles in your account, or it was misspelled. |
| One or more app IDs were either misspelled or don’t exist in your account. | You've entered one or more app IDs that either don't exist in your account or they were misspelled. |
| "Allow access to all future apps" can be "true" only when there is access to all app IDs. | To enable users access to all future apps, you must grant them access to all apps in the account. |
| One or more media sources were either misspelled or don’t exist. | You've entered one or more media sources that either don't exist in the Partner Marketplace or were misspelled. |
| One or more geos were either misspelled or don’t exist. | You've entered one or more geo that either isn't in the platform or was misspelled. |
| Admin and Security roles must have unrestricted access to apps, media sources, and geos. These fields must be empty. | Admin and Security roles must have unrestricted access to all apps, all media sources, and all geos. You were trying to add this role with restrictions on the above. |
| Invalid field scheme. | One of the fields in the scheme doesn't follow the required format. See scheme examples. |
| Other issues |  |
| Something went wrong. Your request couldn’t be completed. | There was a technical issue that prevented the request from being completed. |
| There was a problem with permissions for this account. | There was an issue with the account that prevented the request from being completed. |
| Exceeded the limit of adding 20 users in a single API call. | An API call can contain up to 20 user additions. |