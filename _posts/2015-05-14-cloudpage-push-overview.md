---
layout: page
title: "CloudPage Alert Overview"
subtitle: "Implement CloudPage functionality in Your Mobile App"
category: inbox
date: 2015-05-14 12:00:00
order: 2
---

The CloudPage Inbox customized push message (Alert+Inbox) contains a URL in the payload. Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage push messages.

Enable inbox in your configuration file using the inbox:true value.

The MarketingCloudSDK opens this URL when the message is tapped using a SFSafariViewController.

Override the built-in web view handling of the OpenDirect URL by implementing the MarketingCloudSDKInboxMessagesNotificationHandlerDelegate protocol.

In the class that handles the override, make sure to adhere to the protocol. Use this AppDelegate sample as an example.

```
AppDelegate ()<UNUserNotificationCenterDelegate, MarketingCloudSDKInboxMessagesNotificationHandlerDelegate>
```
```
class AppDelegate: UNUserNotificationCenterDelegate, MarketingCloudSDKInboxMessagesNotificationHandlerDelegate
```
Somewhere in the class that implements this protocol, set the SDK's delegate handler.
```
[[MarketingCloudSDK sharedInstance] sfmc_setInboxMessagesNotificationHandlerDelegate:self];
```
```
MarketingCloudSDK.sharedInstance().sfmc_setInboxMessagesNotificationHandlerDelegate(self)
```
Next, implement the required protocol methods to override the built-in functionality.
```
- (void) sfmc_didReceiveInboxMessagesNotificationWithContents:(NSDictionary *) contents {
    NSString *urlString = [contents objectForKey:MarketingCloudSDKInboxMessageKey];
    if (urlString != nil) {
        // use the url in any way you'd like
        NSLog(urlString);
    }
}
```
```
    func sfmc_didReceiveInboxMessagesNotification(withContents contents: [AnyHashable: Any]?) {
        let urlString = contents![MarketingCloudSDKInboxMessageKey] as? String
        if urlString != nil {
            // use the url in any way you'd like
            print(urlString)
        }
    }
```
See MarketingCloudSDK+InboxMessages.h for more information.
