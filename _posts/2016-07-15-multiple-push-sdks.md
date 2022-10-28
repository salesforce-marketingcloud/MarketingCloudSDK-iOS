---
layout: page
title: "Multiple Push SDKs"
subtitle: "Troubleshooting Multiple Push SDKs"
category: trouble
date: 2016-07-15 12:00:00
order: 2
---
MobilePush is able to work in the same app as other push vendor SDKs. However, we recommend checking with your other SDK vendor to ensure they also support a multi-push provider implementation. This page provides considerations for multiple push SDKs to successfully work together. Common areas for poor implementation can include device registration, geolocation and more. Note that this is not an exhaustive list.

#### 1. Registration

Only ONE call to a push SDK to register for push notifications can be made. Otherwise, multiple notification banners, alerts, or sounds can trigger in a single push. MarketingCloudSDK gives the app developer the power to register.

#### 2. Notification Settings

An app can call requestAuthorizationWithOptions and registerForRemoteNotifications multiple times, but only the last call is used. The settings are overwritten each time it is called.

#### 3. Badging

There is no way to guarantee the value of a badge.

#### 4. Notification Handling

Notification handling in your application delegate with multiple SDKs depends on the SDKs used. The notifications may be visually stacked, discarded, or otherwise confused.

#### 5. Custom Payload Keys

Use custom keys or other payload-specific data to ensure that the correct SDK handler is called in an app that supports multiple notification handlers.

#### 6. Method Swizzling

> Warning: If a push SDK uses method swizzling as a means of replacing iOS framework code at runtime, the MarketingCloudSDK may not work as expected.

To determine if an SDK uses swizzling, look for SDKs that do not use these methods:

```
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfofetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
```

Some SDKs offer a secondary implementation, which uses standard app delegate methods. If so, you must use the secondary implementation.

#### 7. Geolocation

If you implement multiple SDKs that use location-enabled services, use only one SDK’s location enablement. Using more than one leads to unknown and unsupportable consequences.

For example, each provider is likely affected by the methods used by the other providers to interact with iOS CoreLocation services and enablement of location services. An app can monitor a limited number of geofences at any one time. This number depends on iOS version, device type, and other considerations. With multiple implementations competing for a limited resource, user experience may suffer.

In addition, permissions needed to use location-enabled SDKs may overlap or conflict.

#### 8. Feedback

All providers may not be able to detect if a device has been unregistered.

The binary Apple Push Notification Service (APNS) uses a feedback mechanism to let the provider know if a device unregistered from APNS. This feedback mechanism clears the list of unregistered devices after the provider reads it and only returns failures that happened since the provider last connected. So, the first provider to read from the feedback mechanism would clear the list, preventing the other providers from determining if a device has unregistered. If the other providers can’t tell that a device unregistered, they will still attempt to send to the device.

The HTTP/2 APNS communication mechanism uses a more direct feedback system, which pushes to the device and immediately notifies the provider if the device is unregistered. Once a device is marked as unregistered in APNS and communicates this information to a push provider, the information may not communicate to secondary push providers accessing the feedback mechanism. Therefore, secondary push providers may not know that a device is unregistered and may get errors back from APNS that don’t make sense.
