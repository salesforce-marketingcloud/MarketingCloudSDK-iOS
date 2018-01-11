---
layout: page
title: "Analytics"
subtitle: "Add Analytics"
category: analytics
date: 2015-05-14 12:00:00
order: 1
---
Enable analytics in your configuration file using the analytics:true value.

The SDK collects analytics in the background as well as when SDK methods are called.

## Track Push Notifications

To ensure proper tracking of push notifications by the SDK and Marketing Cloud analytics, call the SDK in your push notification handler method. If you do not, analytic events can’t track open counts for your push messaging campaigns.
```
// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {

    // tell the MarketingCloudSDK about the notification
     [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:response.notification.request];

    if (completionHandler != nil) {
        completionHandler();
    }
}
```
```
// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // tell the MarketingCloudSDK about the notification
    MarketingCloudSDK.sharedInstance().sfmc_setNotificationRequest(response.notification.request)
    if completionHandler != nil {
        completionHandler()
    }
}
```
## TRACK INBOX MESSAGE OPENS

You can also track analytics for Inbox messages. Call trackInboxOpenEvent() to send the open analytic value to Marketing Cloud. We automatically provide analytic information for message downloads. Call sfmc_trackMessageOpened: with an inbox message dictionary to record the analytic.
```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *inboxMessagesDict = [self.dataSource objectAtIndex:indexPath.row];
    if (inboxMessagesDict != nil) {     
        [[MarketingCloudSDK sharedInstance] sfmc_trackMessageOpened:inboxMessagesDict];
    }

    // ... your selection handling
}
```
```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let inboxMessagesDict = dataSource?[indexPath.row] as? [AnyHashable: Any]
    if inboxMessagesDict != nil {
        MarketingCloudSDK.sharedInstance().sfmc_trackMessageOpened(inboxMessagesDict)
    }
    // ... your selection handling
}
```
