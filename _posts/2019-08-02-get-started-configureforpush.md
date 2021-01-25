---
layout: page
title: "5. Enable Push"
subtitle: "Enable Push"
category: get-started
date: 2019-08-02 12:00:00
order: 4
published: true
---


## Implement Push

#### Before starting, make sure you have provisioned your app for push notifications outlined in our [Setup Push Apps]({{ site.baseurl }}/get-started/get-started-setupapps.html) document.

1. Enable push notifications in your target’s Capabilities settings.

    <img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure8.png" /><br/><br>

1. Set your `AppDelegate` class to adhere to the `UIApplicationDelegate` and `UNUserNotificationCenterDelegate` protocol.
    <script src="https://gist.github.com/88c8b6247e1e1cdce48a19dc0c19e304.js"></script><br>

1. Extend the SDK configuration code outlined in [Configure the SDK]({{ site.baseurl }}/get-started/get-started-configuresdk.html) to add support for push registration. 
    
    <script src="https://gist.github.com/sfmc-mobilepushsdk/75374975e2f386560c04455dec1092bd.js"></script><br>

    > Note: for information on handling URLs in MobilePush messages, see [Handling URLs]({{ site.baseurl }}/sdk-implementation/implementation-urlhandling.html).

1. Add the required `UIApplicationDelegate` protocol methods (to support push registration) to your AppDelegate class.

    <script src="https://gist.github.com/14a82bd3208be864e0ace803e7d6632f.js"></script><br>

1. Add the required `UNUserNotificationCenterDelegate` protocol methods (to support push notifications) to your AppDelegate class.

    <script src="https://gist.github.com/sfmc-mobilepushsdk/53c9322a4b54dd11fe008d76a611b801.js"></script><br>
    
    > These methods use MarketingCloud SDK methods to enable the framework’s functionality to manage push notifications, which includes MobilePush contact registration and push analytics tracking.

    > If you implement the methods without using the MarketingCloud SDK methods as shown, MobilePush functionality does not work as expected. If you **do not** implement the methods, MobilePush functionality **does not** work.
  
## Continue Push Setup with Rich Notifications

See [Rich Notifications]({{ site.baseurl }}/push-notifications/rich-notifications.html) for more information on handling rich notifications (iOS `mutable-content`) in MobilePush.

