---
layout: page
title: "Multiple Push SDKs"
subtitle: "Troubleshooting Multiple Push SDKs"
category: trouble
date: 2016-07-15 12:00:00
order: 2
---
MobilePush is able to work in the same app as other push vendor SDKs. However, we recommend checking with your other SDK vendor to ensure they also support a multi-push provider implementation. This page provides considerations for multiple push SDKs to successfully work together.

## Common Issues With Multi-Push Provider (MPP)

There are two common functionalities that are affected which prevents the SDK from behaving as expected. They are:

  1. Receiving DeviceToken
  2. Receiving Push Messages

Without device tokens, the SDK will not register the device properly and MarketingCloud wouldn't be able to send push notifications to the device. The SDK expects you to hand off the push notifications to the setNotificationRequest method, which makes the SDK aware of the notifications and allows it to handle it accordingly (e.g. tracking, URL handling, etc).

Apple has specific delegate methods that must be implemented by the consuming application in order to register to APNS and receive the Push Notifications. When there are Multiple Push providers, the aforementioned functionality may be affected because other vendors may provide wrapper methods for registration and receiving the notifications. Consuming applications often listen to the wrapper methods instead of actual apple provided delegate methods. A typical issue for example, is when registration with Apple is done for one push provider and not setting the deviceToken for other push providers.

## Handling MPP With MarketingCloudSDK

### What Is Method Swizzling?

Method swizzling is the process of changing the implementation of an existing selector at runtime.
If Method Swizzling is enabled, other push providers automatically intercept all the application delegate methods, which will differ from the normal flow in setting up the deviceToken, notification userinfo.

Method swizzling can cause MarketingCloud SDK users to be confused about how and where to set the MarketingCloud SDK required API methods because another provider is changing the implementation without their knowledge.

To determine if non-MarketingCloudSDK push providers uses swizzling, look if they do not use below methods:
* `func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)`

* `func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)`

MarketingCloud SDK users can handle MPP implementations with and without Swizzling enabled.

#### With Swizzling Enabled

If **Swizzling is enabled**, implement the respective PushProvider's delegate methods and set the following to MarketingCloudSDK <br/>

##### Configuration With Another Push Provider

Configure the MarketingCloudSDK along with the other Push provider.

<script src="https://gist.github.com/sfmc-mobilepushsdk/8bf1bbe95c7b8fa2528d89d5640a308e.js"></script>

##### Handling DeviceToken

**API:** `setDeviceToken(apnsToken)`,

<script src="https://gist.github.com/sfmc-mobilepushsdk/ecd3b5f58f8e96700f6e9b6c85f5d77a.js"></script>

##### Handling Notifications

When Swizzling is enabled in the other push provider, respective delegate methods are intercepted. For example, considering **Firebase** as the other Push provider, when a push notification is received from firebase, the payload received in the UNUserNotificationCenterDelegate's `didReceive` notification method is altered to receive a MessagingMessageInfo object. This will result in message not being reported when passed to MarketingCloudSDK as the payload expected by the SDK does not match.

**API:**
  * `setNotificationUserInfo(userInfo)`
  * `setNotificationRequest(response.notification.request)`

<script src="https://gist.github.com/sfmc-mobilepushsdk/44ea9e49f41c2d997a011dc38e74b36d.js"></script>  

> Note: Notification messages from other providers are displayed in the devices's notification centre, however any actions on the notification message from the MarketingCloudSDK will not work (e.g. URL Handling, reporting, etc)

#### With Swizzling Disabled

To **disable Swizzling**, refer to the other push provider's documentation.
When Swizzling is disabled in the other PushProvider, the default AppDelegate methods are called.

##### Implement AppDelegate Methods 

<script src="https://gist.github.com/sfmc-mobilepushsdk/4c399fe43313beea06c3a1616059de55.js"></script>

## Other MPP Call-Outs 

Common areas for poor implementation can include device registration, geolocation and more. Note that this is not an exhaustive list.

**1. Registration**

Only ONE call to a push SDK to register for push notifications can be made. Otherwise, multiple notification banners, alerts, or sounds can trigger in a single push. MarketingCloudSDK gives the app developer the power to register.

**2. Notification Settings**

An app can call **requestAuthorizationWithOptions** and **registerForRemoteNotifications** multiple times as explained above, but only the last call is used. The settings are overwritten each time it is called.

**3. Badging**

There is no way to guarantee the value of a badge.

**4. Custom Payload Keys**

If it is required to distinguish between two notification providers, custom keys or other payload-specific data can be used to ensure that the correct SDK handler is called in an app that supports multiple notification handlers.

Passing a third-party's Notification to `setNotificationRequest` or `setNotificationUserInfo` will essentially be a no-op call. The SDK will only emit logs indicating the origin of the notification was not from MarketingCloud.

**5. Geolocation**

If you implement multiple SDKs that use location-enabled services, use only one SDK’s location enablement. Using more than one leads to unknown and unsupportable consequences.

For example, each provider is likely affected by the methods used by the other providers to interact with iOS CoreLocation services and enablement of location services. An app can monitor a limited number of geofences at any one time. This number depends on iOS version, device type, and other considerations. With multiple implementations competing for a limited resource, user experience may suffer.

In addition, permissions needed to use location-enabled SDKs may overlap or conflict.

**6. Feedback**

All providers may not be able to detect if a device has been unregistered.

------

See the [Learning Application](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/spm/examples/LearningApp/LearningApp/AppDelegate.swift) to see how Notification are handled using Firebase PushProvider.
