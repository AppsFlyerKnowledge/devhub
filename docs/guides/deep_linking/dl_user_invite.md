---
title: User invite attribution
category: 6384c30e5a754e005f668a74
order: 3
hidden: true
---

## Overview
Attributing user invites lets marketers gain insight into how much traffic your app gets from existing users inviting new users to join.

Generally, it consists of the following:
1. Defining the user invitation flow and implementing the generation of OneLink links accordingly.
2. Logging the invitation as an in-app event. This results in:
   - An `af_invite` event that's visible in AppsFlyer dashboards and reports.
   - The `pid` (media source) parameter is set with the default value `af_app_invites`. To change the value, you need to add a custom parameter called `pid` with the value you want. 
   **Note**: For Android, this only works for AppsFlyer SDK V6.4.2+.

## Implementation guides


<div class="button-container">
  <a class="button android" href="https://dev.appsflyer.com/hc/docs/user-invite-attribution-android">Android</a>
  <a class="button ios" href="https://dev.appsflyer.com/hc/docs/user-invite-attribution-ios">iOS</a>
</div>

<style>
  .button-container {
  	display: flex;
  }
  .button {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 150px;
	  border-radius: 6px;
    padding: 8px;
    margin-right: 4px;
	}
  
  .button:before {
  	margin-right: 4px;
  }
  .button.android {
    border: solid 2px #3DDC84;
  }
  .ios {
  	border-radius: 6px;
    padding: 8px;
    border: solid 2px #7D7D7D;
  }
  .ios:before {
        content: url("https://files.readme.io/19fdc72-apple-icon.svg");
  }

  .android:before {
        content: url("https://files.readme.io/d7dc5a3-android-icon.svg");
  }
</style>