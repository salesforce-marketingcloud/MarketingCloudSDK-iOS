---
layout: page
title: "Custom Keys"
subtitle: "Handling Custom Keys Sent with Message Payload"
category: features
date: 2015-05-14 12:00:00
order: 5
---

Use custom keys to send extra data along with a push notification. You can use custom keys to add tracking or additional functionality to your app. For example, you can define a custom key that allows a third-party application to provide custom tracking information regarding customer usage on your mobile app. This data can include an ID value used by the app to retrieve additional data or other function. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#customkeys) this feature in the Marketing Cloud application.

To implement custom key support in your application, extend your push notification handler should to extract the push's userInfo dictionary and the values contained in it.
```
// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {

    // tell the MarketingCloudSDK about the notification
    [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:response.notification.request];

    // the dictionary containing custom keys
    NSDictionary *userInfo = response.notification.request.content.userInfo;

    // this is a sample only.  Please adjust for your specific circumstances.
    // get the custom key from the payload as defined in the Marketing Cloud
    NSString *someValue = [userInfo objectForKey:@"someKey"];
    // application-specific usage follows
    NSLog(someValue);

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
        // the dictionary containing custom keys    
        let userInfo = response.notification.request.content.userInfo
    let someValue = userInfo["someKey"] as? String
    // application-specific usage follows
    print(someValue)
        completionHandler()
```
