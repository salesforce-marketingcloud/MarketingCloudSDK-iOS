---
layout: page
title: "Application Badge Override"
subtitle: "Control App Badging"
category: application-badging
date: 2015-05-14 12:00:00
order: 1
---
### SDK and iOS Badging

#### When the SDK Sets the Badge
The MobilePush SDK automatically sets the application badge value if inbox messaging is enabled in your SDK configuration. The badge is set by the SDK in the following cases:

- When an *Inbox* message is sent from Marketing Cloud, a silent push is also sent. The slient push contains a badge value that reflects the system's count of **unread** inbox messages.
- When an *Alert + Inbox* message is sent from Marketing Cloud, the *Alert* component, which is a push notification, is sent containing a badge value that reflects the system's count of **unread** inbox messages plus `1`. The plus one indicates the push notification.
- When the application is sent to the background, the MobilePush SDK sets the badge value to the count of **unread** Inbox messages.

#### When iOS Sets the Badge

The application badge is set by iOS directly when a push notification created in Marketing Cloud has a badge value enabled. Neither the SDK nor the application can prevent this badge value from being set via a push notification.

### Application Badging Override

You can allow your application to override the SDK's badge setting. After your application takes ownership of badging during SDK configuration, the MobilePush SDK no longer sets badges reflecting Inbox message unread count.

To enable an application's override of badging, pass a configuration value into the SDK's `sfmc_configure...` method via the JSON configuration file, or use the `sfmc_configureWithDictionary:` method.

#### Configure via JSON file

To enable override via JSON, set the `applicationcontrolsbadging` key to `true`.

    [{
	    "name": "production",
	    "appid": "<appid from Marketing Cloud here>",
	    "accesstoken": "<accesstoken from Marketing Cloud here>",
	    "applicationcontrolsbadging":true,
	    ...
    }]

#### Configure via Dictionary

To enable override via dictionary, use the `sfmc_setApplicationControlsBadging` method in your configuration builder.

    MarketingCloudSDKConfigBuilder().sfmc_setApplicationId(appID).sfmc_setAccessToken(accessToken).sfmc_setApplicationControlsBadging(true).sfmc_build()!`

Or, in Objective-C, use the builder with `sfmc_setApplicationControlsBadging:@(YES)`.

#### Clearing the badge

When your application controls badging, it may be desirable to clear the badge value when events or data change within your app.

This is done by setting the badge value to `0`.

    // example: clear the badge when app comes to foreground
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }


#### Related Item
[Configure the SDK]({{ site.baseurl }}/get-started/apple.html#4-configure-the-sdk)
