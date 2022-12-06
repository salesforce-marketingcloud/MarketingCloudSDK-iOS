---
layout: page
title: "Multiple Push SDKs"
subtitle: "Troubleshooting Multiple Push SDKs"
category: trouble
date: 2016-07-15 12:00:00
order: 2
---
MobilePush is able to work in the same app as other push vendor SDKs. However, we recommend checking with your other SDK vendor to ensure they also support a multi-push provider implementation. This page provides considerations for multiple push SDKs successfully work together.

## Most common Issues faced with Multi Push Provider (MPP)

  * Receiving DeviceToken
  * Receiving Push Messages

  Apple has specific delegate methods that should be implemented by the consuming application in order to register to APNS and receive the Push Notifications henceforth. When Multiple Push providers comes to a picture, the above functionality may get affected as the MMPs  provide a wrapper methods for registration and receiving the notifications. Consuming applications generally listen to the wrapper methods instead of actual apple provided delegate methods. This causes messages not being displayed as the registration is done with one push provider and not setting the **deviceToken**, **notification userinfo** to other push providers.

## Steps to handle Multiple Push provider with MarketingCloudSDK

### When Swizzling Enabled

If **Swizzling is enabled**, implement the respective PushProvider's delegate methods and set the following to MarketingCloudSDK <br/>
##### DeviceToken
**API:** `SFMCSdk.mp.setDeviceToken(apnsToken)`,

  <script src="https://gist.github.com/sfmc-mobilepushsdk/afc15f2ef78c055af57d343d8fe27acc.js"></script>

##### Notification userInfo or notificationRequest
**API:**
  * `SFMCSdk.mp.setNotificationUserInfo(userInfo)`
  * `SFMCSdk.mp.setNotificationRequest(response.notification.request)`

**Note:** When Swizzling is enabled in the third party push provider, respective delegate methods are intercepted (eg. Considering Firebase as other Push provider, appDidRecieveMessage method gets intercepted automatically) and the notification userinfo  is altered to the MessagingMessageInfo object . This will result in message not showing up when passed to MarketingCloudSDK as the payload expected by the SDK does not match

To determine if an SDK uses swizzling, look for SDKs that do not use these methods:
* `func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)`

* `func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)`

#### Configure MarketingCloudSDK along with other PushProvider

Configure the MarketingCloudSDK along with the other Push providers.

<script src="https://gist.github.com/sfmc-mobilepushsdk/8bf1bbe95c7b8fa2528d89d5640a308e.js"></script>

### When Swizzling Disabled

Few Push Providers automatically setup SDKs through **Method Swizzling** (Method swizzling is the **process of changing the implementation of an existing selector at runtime**). If Method Swizzling is enabled, other push providers automatically intercept all the application delegate methods, which will differ from the normal flow in setting up the deviceToken, notification userinfo.
To **disable Swizzling**, refer to the other Push provider documentation.

#### Implement Application delegate methods and set deviceToken and Notification userInfo

<script src="https://gist.github.com/sfmc-mobilepushsdk/68a8f6f093c45d1278f349b040bf1fd1.js"></script>

## Other Areas affected with Multi Push Provider(MPP)

Common areas for poor implementation can include device registration, geolocation and more. Note that this is not an exhaustive list.

**1. Registration**

Only ONE call to a push SDK to register for push notifications can be made. Otherwise, multiple notification banners, alerts, or sounds can trigger in a single push. MarketingCloudSDK gives the app developer the power to register.

**2. Notification Settings**

An app can call **requestAuthorizationWithOptions** and **registerForRemoteNotifications** multiple times as explained above, but only the last call is used. The settings are overwritten each time it is called.

**3. Badging**

There is no way to guarantee the value of a badge.

**4. Notification Handling**

Notification handling in your application delegate with multiple SDKs depends on the SDKs used. The notifications may be visually stacked, discarded, or otherwise confused.

**5. Custom Payload Keys**

Use custom keys or other payload-specific data to ensure that the correct SDK handler is called in an app that supports multiple notification handlers.

**6. Geolocation**

If you implement multiple SDKs that use location-enabled services, use only one SDK’s location enablement. Using more than one leads to unknown and unsupportable consequences.

For example, each provider is likely affected by the methods used by the other providers to interact with iOS CoreLocation services and enablement of location services. An app can monitor a limited number of geofences at any one time. This number depends on iOS version, device type, and other considerations. With multiple implementations competing for a limited resource, user experience may suffer.

In addition, permissions needed to use location-enabled SDKs may overlap or conflict.

**8. Feedback**

All providers may **not be able to detect if a device has been unregistered**.

The binary Apple Push Notification Service (APNS) uses a feedback mechanism to let the provider know if a device unregistered from APNS. This feedback mechanism clears the list of unregistered devices after the provider reads it and only returns failures that happened since the provider last connected. So, the first provider to read from the feedback mechanism would clear the list, preventing the other providers from determining if a device has unregistered. If the other providers can’t tell that a device unregistered, they will still attempt to send to the device.

The HTTP/2 APNS communication mechanism uses a more direct feedback system, which pushes to the device and immediately notifies the provider if the device is unregistered. Once a device is marked as unregistered in APNS and communicates this information to a push provider, the information may not communicate to secondary push providers accessing the feedback mechanism. Therefore, secondary push providers may not know that a device is unregistered and may get errors back from APNS that don’t make sense.

##### Note
* The document showcases a sample implementation on how to handle registration and notifications received. Similar implementation might be needed which is decided based on the other Push Provider used.
* When swizzling is disabled, Apple provided delegates are invoked which will not affect the normal flow.
* Some of the samples provided uses **Firebase** push provider and this may differ based on the Push provider used by the consuming application.

See the [Learning Application](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/spm/example/LearningApp/LearningApp/AppDelegate.swift) to see how Notification are handled using Firebase PushProvider.
