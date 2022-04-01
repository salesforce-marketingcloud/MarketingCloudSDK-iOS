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

> - The MobilePush SDK version 6.4.0 and up has been tested against and is compatible with iOS 13.
> - Our [LearningApp for iOS](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/master/LearningApp) has been tested against and is compatible with iOS 13.
> - Building with XCode11 or greater requires SDK version 5.x or later in order to continue receiving push notifications on iOS 13 devices.

## iOS 14 Support

> - No changes required to support iOS 14 devices.

> - AppTrackingTransparency: Apple introduced a new permission setting called Asking Permission to Track. With iOS 14.5, you must obtain a user’s permission through the AppTrackingTransparency (ATT) framework to access their device’s advertising identifier (IDFA) and track them across multiple apps. By default, MobilePush SDK does not collect IDFAs nor do we use such values to track users across multiple apps. As such, at the moment, there are no changes required for MobilePush customers. If your organization plans to capture IDFA, you must explicitly obtain user’s permission through ATT in your app. To submit this value to the Marketing Cloud, set it as an attribute within the MobilePush SDK.

## iOS Data Protection
> - The MobilePush SDK version 6.4.1 includes new troubleshooting information and code examples to demonstrate proper configuration and usage when iOS Data Protection is in use. See [iOS Data Protection]({{ site.baseurl }}/trouble/trouble-ios-data-protection.html).
> - The [LearningApp for iOS](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/master/LearningApp) has been modified to show proper usage.

## Requirements

* Xcode 12.5 or later (Compatible with Xcode 12.5 onwards)
* Minimum deployment target of iOS 10.0

## Get Started

1. [Download and set up the SDK]({{ site.baseurl }}/get-started/apple.html)
Integrate the SDK into your app and configure the SDK to send push notifications.
1. [Test your setup]({{ site.baseurl }}/testing-push/getStarted-testPushDev.html)
Send your first push notification to test your initial SDK setup.
1. Implement additional optional features of the SDK to take full advantage of Salesforce Marketing Cloud.
    * [Add custom sounds, media, custom keys, and interactions]({{ site.baseurl }}/push-notifications/push-notifications.html) -- Use these features to further customize push notifications for your apps.
    * Use a [contact key]({{ site.baseurl }}/sdk-implementation/user-data.html#contact-key) to set the unique identifier used to aggregate a contact’s devices within Marketing Cloud. Set the contact key to a specific value provided by your customer or to another unique identifier for the contact, such as mobile number, email address, customer number, or another value.
    * Add [attributes]({{ site.baseurl }}/sdk-implementation/user-data.html#attributes) and [tags]({{ site.baseurl }}/sdk-implementation/user-data.html#tags) -- Enhance your ability to segment your push message audiences.
    * [Add predictive intelligence]({{ site.baseurl }}/analytics/personalization-collect.html) using Einstein Recommendations -- Track cart and cart conversions. Purchase this feature separately.
    * Add other features -- Send push notifications along with your [inbox messages]({{ site.baseurl }}/inbox/inbox.html), use OpenDirect for [deep linking]({{ site.baseurl }}/push-notifications/opendirect.html), and trigger location-based messages with [location and beacon messaging]({{ site.baseurl }}/location/geolocation-overview.html).

## Contact Us

Post on our [Stack Exchange](https://salesforce.stackexchange.com/tags). Example tags: marketing-cloud, salesforcemobilesdk-ios, mobilesdk, and mobilepush-ios

## Additional Resources

* The MarketingCloudSDK for iOS can be found on [GitHub](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS) and [CocoaPods](https://cocoapods.org/pods/MarketingCloudSDK).
* The <a href="https://help.salesforce.com/articleView?id=mc_mp_mobilepush.htm&type=5">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the [LearningApp for iOS](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/master/LearningApp) which implements features of the SDK to allow you to explore how a native app properly utilizes the MarketingCloudSDK.
* Review the [Appledocs]({{ site.baseurl }}/appledoc/index.html) for the SDK.
<br/>
* View the [Android SDK docs](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-Android).

## Hybrid Mobile Apps

We provide support for the plugins below to implement the MobilePush SDK for your iOS and Android applications.

* [Cordova Plugin](https://www.npmjs.com/package/cordova-plugin-marketingcloudsdk)
* [React Native Plugin](https://www.npmjs.com/package/react-native-marketingcloudsdk)

## Deprecations

We remove deprecated methods from the SDK two releases after the initial deprecation announcement.

### 3rd Party Product Language Disclaimers
Where possible, we changed noninclusive terms to align with our company value of Equality. We retained noninclusive terms to document a third-party system, but we encourage the developer community to embrace more inclusive language. We can update the term when it’s no longer required for technical accuracy.

## Release History

For releases prior to 5.0.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/">Prior Release Documentation</a>

{% include release_notes.html %}
