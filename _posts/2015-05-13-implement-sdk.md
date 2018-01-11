---
layout: page
title: "Implement and Configure SDK"
subtitle: "Implement and Configure the SDK in your iOS App"
category: get-started
date: 2015-05-14 12:00:00
order: 3
---
To implement the MarketingCloudSDK framework in your application, use either CocoaPods or a manual setup of the SDK.

## Implement the SDK with CocoaPods

Follow the [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) using **MarketingCloudSDK** as a dependency in the podfile. Open up the .xcworkspace created by the install process with Xcode and start using the SDK.

Do **NOT** use .xcodeproj. An error occurs if you open up a project file instead of a workspace.

## Implement the SDK Manually

1. [Download the SDK]({{site.codeurl}}).
1. Copy the MarketingCloudSDK directory from your download to your project directory
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure1.png" /><br/>
1. Open your application project and select the appropriate target.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure2.png" /><br/>
1. Add MarketingCloudSDK.framework to Linked Frameworks and Libraries in your target's General settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure3.png" /><br/>
1. Add MarketingCloudSDK.bundle to Copy Bundle Resources in your target's Build Phases settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure4.png" /><br/>
1. Add -ObjC to your target's Other Linker Flags build settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure5.png" /><br/>

> [Review additional information about this linker flag](https://developer.apple.com/library/content/qa/qa1490/_index.html)

## Configure the SDK

MarketingCloudSDK framework via a JSON file added to your application. This file contains the parameters unique to your application and feature needs. The MarketingCloudSDK framework reads the values within this file and completes its configuration based on these settings.

1. Add MarketingCloudSDKConfiguration.json to Copy Bundle Resources in your target's Build Phases settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure6.png" /><br/>
1. Change the *appid* and *accesstoken* values to match the information from your Marketing Cloud account when you configured your application. These values represent the unique paring of this iOS application with the Marketing Cloud account used for MobilePush.
1. Enable or disable *analytics*, *location*, or *inbox* entries depending on the unique needs of your application and your usage of Marketing Cloud.
> Marketing Cloud and the Mobile Push MarketingCloudSDK framework support push notifications.
1. To implement push notification handling in your application, ensure you created an APNS Push Certificate in the Apple developer portal and added that to your Marketing Cloud account. Make sure that you added the push notifications feature to your application in the Apple developer portal. Enable push notifications in  your target's Capabilities settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure7.png" /><br/>
> When implementing the MarketingCloudSDK framework, note that all method names contain the prefix *sfmc_*. This convention allows the application implementing the SDK to protect against the possibility of namespace collisions between external libraries it may use. We've taken every precaution to ensure that MarketingCloudSDK does not cause compile, link, or runtime collisions with other code your application may implement. Review Apple's [documentation on customizing existing classes](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW4) for further information.
1. In your application delegate, import the framework header to enable MarketingCloudSDK functionality.
```
#import <MarketingCloudSDK/MarketingCloudSDK.h>
```
```
import MarketingCloudSDK
```
1. In your application delegate class, add these sections of code to ensure that your application registers for and handles push notifications. Set your AppDelegate class to adhere to the UNUserNotificationCenterDelegate protocol.
```
AppDelegate ()<UNUserNotificationCenterDelegate>
...
```
```
class AppDelegate: UNUserNotificationCenterDelegate
...
```
1. In your application delegate method *-application:didFinishLaunchingWithOptions:*, create an instance of the MarketingCloudSDK and configure it for use, setting the push delegate and requesting push authorization. Only init or configure in didFinishingLaunching.
```
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ...
    // weak reference to avoid retain cycle within block
    __weak __typeof__(self) weakSelf = self;

    NSError *configureError = nil;
        BOOL configured = [[MarketingCloudSDK sharedInstance] sfmc_configure:&configureError
                         completionHandler:^(BOOL success, NSString *appId, NSError *error) {
            // The SDK has been fully configured and is ready for use!

            // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
            [UNUserNotificationCenter currentNotificationCenter].delegate = weakSelf;

            dispatch_async(dispatch_get_main_queue(), ^{
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                            if (error == nil) {
                                                                                if (granted == YES) {
                                                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                                    // we are authorized to use notifications, request a device token for remote notifications
                                                                                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                                                                                    });
                                                                                }
                                                                            }
                                                                        }];
                                                                        });        
        }];
        if (configured == YES) {
            // The configuation process is underway.
        }
    }
    ...  
  ```
  ```
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    // weak reference to avoid retain cycle within block
    weak var weakSelf = self
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
                    }
                }
            })
        })
        return true
    } catch let error as NSError {
        print("Error: \(error)")
    }
    return false
}
```

Configuration of the MarketingCloudSDK includes a synchronous return of the BOOL return value and asynchronous process to complete configuration. We recommend your application rely on the *success* and *error* values returned in the *completionHandler* to verify successful configuration. The *MarketingCloudSDK+Base.h* header file details additional methods for configuration.

Add the required delegate methods to support push notifications to your AppDelegate class.

These methods use  MarketingCloudSDK methods to enable the framework's functionality to manage push notifications, which includes MobilePush contact registration and push analytics tracking.

If the methods below are implemented *without* using the MarketingCloudSDK methods as shown, MobilePush functionality does not work as expected. If the methods below are not implemented, MobilePush functionality **will not** work as expected.

```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[MarketingCloudSDK sharedInstance] sfmc_setDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    os_log_debug(OS_LOG_DEFAULT, "didFailToRegisterForRemoteNotificationsWithError = %@", error);
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {

    // tell the MarketingCloudSDK about the notification
     [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:response.notification.request];

    if (completionHandler != nil) {
        completionHandler();
    }
}

// This method is REQUIRED for correct functionality of the SDK.
// This method will be called on the delegate when the application receives a silent push

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    UNMutableNotificationContent *theSilentPushContent = [[UNMutableNotificationContent alloc] init];
    theSilentPushContent.userInfo = userInfo;
    UNNotificationRequest *theSilentPushRequest = [UNNotificationRequest requestWithIdentifier:[NSUUID UUID].UUIDString content:theSilentPushContent trigger:nil];

    [[MarketingCloudSDK sharedInstance] sfmc_setNotificationRequest:theSilentPushRequest];

    completionHandler(UIBackgroundFetchResultNewData);
}
```
```
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        MarketingCloudSDK.sharedInstance().sfmc_setDeviceToken(deviceToken)
    }


    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    }

    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // tell the MarketingCloudSDK about the notification
        MarketingCloudSDK.sharedInstance().sfmc_setNotificationRequest(response.notification.request)
        completionHandler()
        }
    }

    // This method is REQUIRED for correct functionality of the SDK.
    // This method will be called on the delegate when the application receives a silent push
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let theSilentPushContent = UNMutableNotificationContent()
        theSilentPushContent.userInfo = userInfo
        let theSilentPushRequest = UNNotificationRequest(identifier:UUID().uuidString, content: theSilentPushContent, trigger: nil)
        MarketingCloudSDK.sharedInstance().sfmc_setNotificationRequest(theSilentPushRequest)

        completionHandler(.newData)
    }
```
