---
layout: page
title: "Interactive Notifications"
subtitle: "Display Interactive Notification Messages"
category: push-notifications
date: 2015-05-14 12:00:00
order: 3
---
Add buttons called interactive notifications to push notifications in your mobile app. Marketing Cloud sends the category name for these interactive notifications in the message payload. This feature requires [enablement](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#interactiveNotifications) in the Marketing Cloud application.

This sample code applies to the AppDelegate.m didFinishLaunchingWithOptions application delegate mention. Modify this sample code for your specific circumstances.

This sample shows how to create a category named "Example". When you send this category with the payload from Marketing Cloud, the notification displays in the notification center with the buttons shown here.

**Implementation**
```
UNNotificationAction *exampleAction = [UNNotificationAction actionWithIdentifier:@"App" title:@"Example" options:UNNotificationActionOptionNone]

UNNotificationCategory *appCategory = [UNNotificationCategory categoryWithIdentifier:@"Example"
 actions:@[exampleAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];

NSSet *categories = [NSSet setWithObjects:appCategory, nil];
[[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
```
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ...
    // weak reference to avoid retain cycle within block
    __weak __typeof__(self) weakSelf = self;

    NSError *configureError = nil;
        BOOL configured = [[MarketingCloudSDK sharedInstance] sfmc_configure:&configureError
                         completionHandler:^(BOOL success, NSString *appId, NSError *error) {
            // The SDK has been fully configured and is ready for use!

            // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
            [UNUserNotificationCenter currentNotificationCenter].delegate = weakSelf;

            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                            if (error == nil) {
                                                                                if (granted == YES) {
                                                                                    os_log_info(OS_LOG_DEFAULT, "Authorized for notifications = %s", granted ? "YES" : "NO");

                                                                                    // we are authorized to use notifications, request a device token for remote notifications
                                                                                    [[UIApplication sharedApplication] registerForRemoteNotifications];

                                                                                    // Support notification categories
                                                                                    UNNotificationAction *exampleAction = [UNNotificationAction actionWithIdentifier:@"App" title:@"Example" options:UNNotificationActionOptionNone];   

                                                                                    UNNotificationCategory *appCategory = [UNNotificationCategory categoryWithIdentifier:@"Example" actions:@[exampleAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];

                                                                                    NSSet *categories = [NSSet setWithObjects:appCategory, nil];
                                                                                    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
                                                                                }
                                                                            }
                                                                        }];        
        }];
        if (configured == YES) {
            // The configuation process is underway.
        }

    ...
}



UNNotificationAction * exampleAction = UNNotificationAction(identifier: "App", title: "Example", options: [])
var appCategory = UNNotificationCategory(identifier: "Example", actions: [exampleAction] as? [UNNotificationAction] ?? [UNNotificationAction](), intentIdentifiers: [] as? [String] ?? [String](), options: [])
var categories = Set<AnyHashable>([appCategory])
UNUserNotificationCenter.current().setNotificationCategories(categories as? Set<UNNotificationCategory> ?? Set<UNNotificationCategory>())

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // weak reference to avoid retain cycle within block        weak var weakSelf = self
        do {
            try MarketingCloudSDK.sharedInstance().sfmc_configure(completionHandler: {(_ success: Bool, _ appId: String, _ error: Error?) -> Void in
                // The SDK has been fully configured and is ready for use!
                // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
                UNUserNotificationCenter.current().delegate = weakSelf
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(_ granted: Bool, _ error: Error?) -> Void in
                    if error == nil {
                        if granted == true {
                             // we are authorized to use notifications, request a device token for remote notifications
                            UIApplication.shared.registerForRemoteNotifications()

                            // Support notification categories

                            let exampleAction = UNNotificationAction(identifier: "App", title: "Example", options: [])
                            let appCategory = UNNotificationCategory(identifier: "Example", actions: [exampleAction], intentIdentifiers: [] as? [String] ?? [String](), options: [])
                            let categories = Set<AnyHashable>([appCategory])
                            UNUserNotificationCenter.current().setNotificationCategories(categories as? Set<UNNotificationCategory> ?? Set<UNNotificationCategory>())
                        }
                    }
                })
            })
            return true
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return false
```

**Handle Action**

In your push handler, examine the push notification's payload to see if your action triggered and take action.
```
// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {

    // tell the MarketingCloudSDK about the notification
    [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:response.notification.request];

    // Check your notification custom actions
    if ([response.actionIdentifier isEqualToString:@"App"]) {
        // Handle your notification's custom action here
    }

    if (completionHandler != nil) {
        completionHandler();
    }
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // tell the MarketingCloudSDK about the notification
    MarketingCloudSDK.sharedInstance().sfmc_setNotificationRequest(response.notification.request)
    // Check your notification custom actions
    if (response.actionIdentifier == "App") {
        // Handle your notification's custom action here
    }    
}
```
