---
layout: page
title: "OpenDirect"
subtitle: "Messages with an OpenDirect URL"
category: opendirect
date: 2015-05-14 12:00:00
order: 4
---

The OpenDirect customized push message contains a URL in the payload. [Enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#openDirect) this feature in the Marketing Cloud application.

The MarketingCloudSDK opens this URL when the message is tapped using a SFSafariViewController.

Override the built-in web view handling of the OpenDirect URL by implementing the MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate protocol.

In the class handling the override, adhere to the protocol. For example, use this AppDelegate example as a sample.
```
AppDelegate ()<UNUserNotificationCenterDelegate, MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate>
```
```
class AppDelegate: UNUserNotificationCenterDelegate, MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate
```
Somewhere in the class implementing this protocol, set the SDK's delegate handler.
```
[[MarketingCloudSDK sharedInstance] sfmc_setOpenDirectMessagesNotificationHandlerDelegate:self];
```
```
MarketingCloudSDK.sharedInstance().sfmc_setOpenDirectMessagesNotificationHandlerDelegate(self)
```
Next, implement the required protocol methods to override the built-in functionality.
```
- (void) sfmc_didReceiveOpenDirectMessagesNotificationWithContents:(NSDictionary *) contents {
    NSString *urlString = [contents objectForKey:MarketingCloudSDKOpenDirectMessageKey];
    if (urlString != nil) {
        // use the url in any way you'd like
        NSLog(urlString);
    }
}
```
```
func sfmc_didReceiveOpenDirectMessagesNotification(withContents contents: [AnyHashable: Any]?) {
        let urlString = contents![MarketingCloudSDKOpenDirectMessageKey] as? String
        if urlString != nil {
            // use the url in any way you'd like
            print(urlString)
        }
    }
```
See MarketingCloudSDK+OpenDirectMessages.h for more information.
