---
layout: default
title: "README"
---
## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 9
* Compile the target application for arm64, not armv7.

## Get Started

1. [Perform initial SDK setup]({{ site.baseurl }}/get-started/apple.html)
Integrate the SDK into your app and configure the SDK to send push notifications.
1. [Test your setup]({{ site.baseurl }}/get-started/test-first-push.html)
Send your first push notification to test your initial SDK setup.
1. Implement optional features
Implement additional optional features of the SDK to take full advantage of Salesforce Marketing Cloud.
    * [Add custom sounds, media, custom keys, and interactions]({{ site.baseurl }}/push-notifications/push-notifications.html) -- Use these features to further customize push notifications for your apps.
    * Add [attributes]({{ site.baseurl }}/user-data/attributes.html) and [tags]({{ site.baseurl }}/user-data/tags.html) -- Enhance your ability to segment your push message audiences.
    * [Add predictive intelligence]({{ site.baseurl }}/analytics/personalization-collect.html) using Personalization Builder -- Track cart and cart conversions. Purchase this feature separately.
    * Add other features -- Send push notifications along with your [inbox messages]({{ site.baseurl }}/inbox/inbox.html), use OpenDirect for [deep linking]({{ site.baseurl }}/opendirect/opendirect.html), and trigger location-based messages with [location and beacon messaging]({{ site.baseurl }}/location/geolocation-overview.html).

## Contact Us

To receive the latest SDK news or to contact us with questions and feedback, use these channels:
  * Email us at <marketingcloudsdkfeedback@salesforce.com>.
  * Post on our [Stack Exchange](https://salesforce.stackexchange.com/tags). Example tags: marketing-cloud, salesforcemobilesdk-ios, mobilesdk, and mobilepush-ios
  * Sign up for [email updates](http://pub.s1.exacttarget.com/2ujjacpet3t) about release announcements and other important information. (10 or fewer emails per year)

## Additional Resources

* The <a href="https://help.salesforce.com/articleView?id=mc_mp_mobilepush.htm&type=5" target="_blank">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the <a href="https://github.com/salesforce-marketingcloud/LearningAppIos" target="_blank">Learning App for iOS</a> that implements features of the SDK to allow you to explore how a native app implements the MarketingCloudSDK.
* [Sign up for email updates about the iOS MarketingCloudSDK](http://pub.s1.exacttarget.com/2ujjacpet3t).<br/><br/>

## Release History

For releases prior to 5.0.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/" target="_blank">Prior Release Documentation</a>

#### Version 5.1.0
_Released April 23, 2018, correlating with the Marketing Cloud April 2018 release_
* **Added iOS 9 support** -- The iOS MarketingCloudSDK framework now supports iOS 9. Use conditional coding via Apple’s `available` attributes. For notes on using conditional coding for push registration and handling push notifications, see the iOS 9 documentation.
* **Added synchronous configuration calls** -- To prevent developers from trying to set a contact key, tag, or attribute before configuration is complete, we added synchronous configuration calls to the API as the default.
* **Added data privacy compliance** -- This version of the iOS MarketingCloudSDK supports three privacy modes that may affect your application’s use of MobilePush: 1) Right to be Forgotten, 2) Restriction of Processing, and 3) Do Not Track. These changes assist you in preparing for data compliance regulations, such as the European Union's General Data Protection Regulation (GDPR). For more details, visit our SDK-specific [data privacy compliance documentation]( {{ site.baseurl }}/sdk-implementation/data-privacy-iOS.html).
* **Throttled inbox message calls** -- To match the Android SDK, we now prevent the iOS MarketingCloudSDK from calling `SFMCInboxMessagesRefreshCompleteNotification` and `SFMCInboxMessagesNewInboxMessagesNotification` too often. Reference the headers for more information.
* **Allowed Predictive Intelligence to be set separately** -- When you configure the iOS MarketingCloudSDK, you can now enable or disable Predictive Intelligence separately from Analytics. If your app uses the iOS 212 framework and if Analytics is enabled, Predictive Intelligence is also enabled. To control Predictive Intelligence separately, add the config flag.
* **Improved registration** -- We improved registration to prevent duplicate tags and attributes.
* **Fixed `isPushEnabled` override issue** -- Previously, disabling push notifications in the Notification Center overrode the `setPushEnable` property. We fixed this issue so that the SDK uses `setPushEnable`.

#### Version 5.0.0
_Released January 22, 2018, correlating with the Marketing Cloud January 2018 release_

* We redesigned the SDK to make it easier to integrate than ever before. This release includes a slimmer API that makes it easier to add Marketing Cloud features to your app. Existing users can upgrade their version to take advantage of the improved SDK. New users can follow the existing Getting Started directions to get the SDK up and running.

* We updated the SDK for full support of iOS 11.
