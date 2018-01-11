---
layout: page
title: "iOS 10 Notifications"
subtitle: "Use iOS 10 Notifications"
category: features
date: 2016-10-21 12:00:00
order: 8.1
published: false
---

> iOS 8 and iOS 9 notifications are still supported.

## Push Notification Registration

iOS 10 offers a more consistent and powerful way to use notifications, which are implemented in UserNotification.framework. The JB4A SDK natively supports UserNotification.framework functionality through ETPush interfaces. ETPush offers a simple wrapper around common interfaces of `UNUserNotificationCenter`, adding logging and error checking on behalf of the application using the SDK.

To use UserNotification.framework in applications that target iOS 10:

- Build your app with XCode 8 and the iOS 10 SDK
- Add UserNotification.framework to the Link Binary With Libraries section of your app target’s Build Phases
- Register your app for notifications using the UserNotification registration method. Do not use older registration methods in UIApplication. The UserNotification registration method allows you to support features such as notification service extensions, foreground push notification display, mutable content, etc.
- Contact your account executive to to enable rich notifications (mutable content) for your app.

Use the following method to enable iOS 10 notifications. When this method is called by an application (in `-applicationDidFinishLaunching:`, for example), it sets the application for full compatibility with iOS 10 notification handling.

```
-(void)registerForRemoteNotificationsWithDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate options:(UNAuthorizationOptions)options categories:(NSSet<UNNotificationCategory *> *_Nullable)categories completionHandler:(void (^)(BOOL granted, NSError *_Nullable error))completionHandler
```

The method can be called like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/5c7fd7dde75b4efeb84f364eda47d9dc.js"></script>

Parameters:
- `delegate` -- Assign the delegate before your app is done launching. For details, see Apple’s [API Reference](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate).

> If necessary, ETPush’s `-setUserNotificationCenterDelegate` can be called early in the app lifecycle and later in registration to satisfy the conditions described by Apple.

>  You can set `delegate` to nil for default notification handling. If a `delegate` is passed, you must ensure that the delegate class adheres to the `UNUserNotificationCenterDelegate` protocol, like this:

```
@interface AppDelegate () <UNUserNotificationCenterDelegate>
```
> You can implement these optional methods:
- `options` -- `UNAuthorizationOptions` must be passed for registration.
- `categories` -- A set of `UNNotificationCategory` objects for push notifications
- `completionHandler` -- Returns `isGranted` and `error` values with the results of registration

### Handling Notification Registration

An application delegate **must** implement `UIApplication` delegate methods to handle registration success and failure cases. At a minimum, implement these methods like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/2f665859f298f85409ae1fc1dc2e1047.js"></script>

> If your application supports iOS 8 and iOS 9 in addition to iOS 10, your notification registration code must make a runtime check for iOS version and call the appropriate registration method, like this example:

<script src="https://gist.github.com/sfmc-mobilepushsdk/0da26f1e972ac80adfd879100464b489.js"></script>

### Convenience Methods

ETPush implements a number of methods that act as pass-throughs to the UNUserNotificationCenter methods. These convenience methods allow ETPush to perform additional logging and error checking. You can consider these as analogues to the method in UNUserNotificationCenter. See `ETPush.h` for more information.

### Delegate Methods

When running on iOS10, the following two methods of the UNUserNotificationCenterDelegate protocol are required in order to process notifications. You must set the delegate property of your UNNotificationCenter instance to the class that implements them. Do this either by setting the delegate in the -[ETPush registerForRemoteNotificationsWithDelegate:options:categories:completionHandler:] call as shown above or by calling -[ETPush setUserNotificationCenterDelegate:]. The delegate must be set before the application returns from applicationDidFinishLaunching.

The first method, didReceiveNotificationResponse, is called to let your app know which action the user selected for a given notification. The second method, willPresentNotification, is called when a notification is delivered to a foregrounded app. The examples below show how to pass the notification to ETPush in order for the SDK to process the notification properly.

<script src="https://gist.github.com/sfmc-mobilepushsdk/597c94101fcbea6b854118576cf9d584.js"></script>
