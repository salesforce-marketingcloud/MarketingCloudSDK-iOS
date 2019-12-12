---
layout: default
title: "Home"
---

## MobilePush SDK: Important Forward-Compatibility Statement

> In the January, 2020 Marketing Cloud MobilePush SDK release, support for older Android and iOS versions will be removed from the SDK.
>
> - Android will require a minimum API version of 21
> - iOS will require a minimum deployment target of 10.0
>
> Existing mobile applications built with SDK version 5.x or later will continue to function, without change. Mobile applications may continue to reference older SDK versions, without change. Applications which adopt the January, 2020 MobilePush SDK release may require a project change if your application build still supports an older value (Android: earlier than API 21, iOS: iOS 9).

## iOS 13 Support

> - The MobilePush SDK version {{ site.currentVersion }} has been tested against and is compatibile with iOS 13.
> - Our [LearningApp for iOS](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/master/LearningApp) has been tested against and is compatibile with iOS 13.
> - Building with XCode11 or greater requires SDK version 5.x or later in order to continue receiving push notifications on iOS13 devices.


## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 9

## Get Started

1. [Download and set up the SDK]({{ site.baseurl }}/get-started/apple.html)
Integrate the SDK into your app and configure the SDK to send push notifications.
1. [Test your setup]({{ site.baseurl }}/testing-push/getStarted-testPushDev.html)
Send your first push notification to test your initial SDK setup.
1. Implement additional optional features of the SDK to take full advantage of Salesforce Marketing Cloud.
    * [Add custom sounds, media, custom keys, and interactions]({{ site.baseurl }}/push-notifications/push-notifications.html) -- Use these features to further customize push notifications for your apps.
    * Use a [contact key]({{ site.baseurl }}/sdk-implementation/user-data.html#contact-key) to set the unique identifier used to aggregate a contact’s devices within Marketing Cloud. Set the contact key to a specific value provided by your customer or to another unique identifier for the contact, such as mobile number, email address, customer number, or another value.
    * Add [attributes]({{ site.baseurl }}/sdk-implementation/user-data.html#attributes) and [tags]({{ site.baseurl }}/sdk-implementation/user-data.html#tags) -- Enhance your ability to segment your push message audiences.
    * [Add predictive intelligence]({{ site.baseurl }}/analytics/personalization-collect.html) using Personalization Builder -- Track cart and cart conversions. Purchase this feature separately.
    * Add other features -- Send push notifications along with your [inbox messages]({{ site.baseurl }}/inbox/inbox.html), use OpenDirect for [deep linking]({{ site.baseurl }}/push-notifications/opendirect.html), and trigger location-based messages with [location and beacon messaging]({{ site.baseurl }}/location/geolocation-overview.html).

## Contact Us

Sign up for email announcements and contact us with questions or feedback about the iOS SDK.
  * Email us at <marketingcloudsdkfeedback@salesforce.com>.
  * Post on our [Stack Exchange](https://salesforce.stackexchange.com/tags). Example tags: marketing-cloud, salesforcemobilesdk-ios, mobilesdk, and mobilepush-ios
  * Sign up for [email updates](http://pub.s1.exacttarget.com/2ujjacpet3t) about release announcements and other important information. (10 or fewer emails per year)

## Additional Resources

* The MarketingCloudSDK for iOS can be found on [GitHub](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS) and [CocoaPods](https://cocoapods.org/pods/MarketingCloudSDK).
* The <a href="https://help.salesforce.com/articleView?id=mc_mp_mobilepush.htm&type=5">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the [LearningApp for iOS](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/master/LearningApp) which implements features of the SDK to allow you to explore how a native app properly utilizes the MarketingCloudSDK.
* Review the [Appledocs]({{ site.baseurl }}/appledoc/index.html) for the SDK.
* [Sign up for email updates about the iOS MarketingCloudSDK](http://pub.s1.exacttarget.com/2ujjacpet3t).<br/>
* View the [Android SDK docs](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-Android).

## Hybrid Mobile Apps

We provide support for plugins, such as Cordova, to implement the MobilePush SDK for your iOS and Android applications.

* [Cordova Plugin](https://www.npmjs.com/package/cordova-plugin-marketingcloudsdk)

## Deprecations

We remove deprecated methods from the SDK two releases after the initial deprecation announcement.

## Release History

For releases prior to 5.0.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/">Prior Release Documentation</a>

{% include release_notes.html %}
