---
layout: page
title: "Multiple Push SDKs"
subtitle: "Troubleshooting Multiple Push SDKs"
category: trouble
date: 2016-07-15 12:00:00
order: 2
---
MobilePush is able to work in the same app as other push vendor SDKs. However, we recommend checking with your other SDK vendor to ensure they also support a multi-push provider implementation. This page provides considerations for multiple push SDKs successfully work together. Common areas for poor implementation can include device registration, geolocation and more. Note that this is not an exhaustive list.

### Steps to handle Multiple Push provider with MarketingCloudSDK

#### Disable Swizzling

Few Push Providers automatically setup SDKs through Swizzling. If Swizzling is enabled, other push providers automatically intercept all the application delegate methods, which will differ from the normal flow in setting up the deviceToken, notification userinfo.
To **disable Swizzling**, refer to the other Push provider documentation.

If choosing **automatic SDK setup by other Push provider**, implement the respective PushProvider's delegate methods and set the following to MarketingCloudSDK <br/>
  <br/>
    i) deviceToken using the API `SFMCSdk.mp.setDeviceToken(apnsToken)`,

      <script src="https://gist.github.com/sfmc-mobilepushsdk/afc15f2ef78c055af57d343d8fe27acc.js"></script>

    ii)userInfo using the API `SFMCSdk.mp.setNotificationUserInfo(userInfo)` or notificationRequest using `SFMCSdk.mp.setNotificationRequest(response.notification.request)`

    **Note:** When Swizzling is enabled in the third party push provider, respective delegate methods are intercepted (eg. Considering Firebase as other Push provider, appDidRecieveMessage method gets intercepted automatically) and the notification userinfo  is massaged to the MessagingMessageInfo object . This will result in message not showing up when passed to MarketingCloudSDK.

It is recommended to **disable Swizzling** for the third party push provider and implement the Apple provided delegate methods for the straight forward functioning of MarketingCloudSDK.

To determine if an SDK uses swizzling, look for SDKs that do not use these methods:

```
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfofetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
```

#### Configure MarketingCloudSDK along with other PushProvider

Configure the MarketingCloudSDK along with the other Push providers.

<script src="https://gist.github.com/sfmc-mobilepushsdk/8bf1bbe95c7b8fa2528d89d5640a308e.js"></script>

#### Implement Application delegate methods and set deviceToken and userInfo

<script src="https://gist.github.com/sfmc-mobilepushsdk/68a8f6f093c45d1278f349b040bf1fd1.js"></script>

##### Note

With Multiple Push Providers integrated in the application, there are chances for swizzling other features namely `Device Registration`, `Notification Settings`, `Badging`, `Custom Payload Keys`, `Geolocation`, `APNS Feedback on Unregistering the device`.

The document showcases a sample implementation on how to handle registration and notifications received. Similar implementation might be needed for the above listed features where the calls are intercepted by the other Push Provider. When swizzling is disabled, Apple provided delegates are invoked which will not affect the normal flow.

See the [learning application](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/spm/example/LearningApp/LearningApp/AppDelegate.swift) to see how Notification are handled using Firebase PushProvider.
