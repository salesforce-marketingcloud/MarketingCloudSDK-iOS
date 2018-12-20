---
layout: page
title: "Application Badge Override"
subtitle: "Developer Control of App Badging"
category: application-badging
date: 2015-05-14 12:00:00
order: 1
---
### Application Badging

#### SDK Sets the Badge
The MobilePush SDK automatically sets the application badge value if Inbox messaging is enabled in your SDK configuration. The badge is set by the SDK in the following cases:

- When an *Inbox* message is sent from Marketing Cloud, a silent push is sent containing a badge value reflecting the system's known count of **unread** Inbox messages.
- When an *Alert + Inbox* message is sent from Marketing Cloud, the *Alert* component (a push notification) is sent containing a badge value reflecting the system's known count of **unread** Inbox messages *plus* `1` (indicating the push).
- When the application is sent to the background, the MobilePush SDK will set the badge value to the count of **unread** Inbox messages.

#### iOS Sets the Badge

The application badge is set by iOS directly when a push notification (a message created in Marketing Cloud) has a badge value enabled. Neither the SDK nor the application can prevent the badge from being set via a push notification.

### SDK Badging Override

The MobilePush SDK offers the ability for an application developer to override the SDK's badge setting.

To enable an application's override of badging, a configuration value is passed into the SDK's `sfmc_configure...` method, via the JSON configuration file or the `sfmc_configureWithDictionary:` method. 



#### Configure via JSON file

Use the `applicationcontrolsbadging` key to enable the override, with a value of `true`.

    [{
	    "name": "production",
	    "appid": "<appid from Marketing Cloud here>",
	    "accesstoken": "<accesstoken from Marketing Cloud here>",
	    "applicationcontrolsbadging":true,
	    ...
    }]

#### Configure via Dictionary

Use the `sfmc_setApplicationControlsBadging` method in your configuration builder:

    MarketingCloudSDKConfigBuilder().sfmc_setApplicationId(appID).sfmc_setAccessToken(accessToken).sfmc_setApplicationControlsBadging(true).sfmc_build()!```

Or, in Objective-C, use the builder with: `sfmc_setApplicationControlsBadging:@(YES)`

Once your application takes ownership of badging during SDK configuration, the MobilePush SDK will no longer set badges reflecting Inbox message unread count.