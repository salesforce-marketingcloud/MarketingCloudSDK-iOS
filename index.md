---
layout: default
title: "README"
---
## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 10
* Compile the target application for arm64, not armv7.

## Get Started

1. [Perform initial SDK setup]({{ site.baseurl }}/get-started/apple.html)
Integrate the SDK into your app and configure the SDK to send push notifications.
1. [Test your setup]({{ site.baseurl }}/get-started/test-first-push.html)
Send your first push notification to test your initial SDK setup.
1. Implement optional features
Implement additional optional features of the SDK to take full advantage of Salesforce Marketing Cloud.
    1. [Add custom sounds, media, custom keys, and interactions]({{ site.baseurl }}/push-notifications/push-notifications.html) -- Use these features to further customize push notifications for your apps.
    1. Add [attributes]({{ site.baseurl }}/user-data/attributes.html) and [tags]({{ site.baseurl }}/user-data/tags.html) -- Enhance your ability to segment your push message audiences.
    1. [Add predictive intelligence]({{ site.baseurl }}/analytics/personalization-collect.html) using Personalization Builder -- Track cart and cart conversions. Purchase this feature separately.
    1. Add other features -- Send push notifications along with your [inbox messages]({{ site.baseurl }}/inbox/inbox.html), use OpenDirect for [deep linking]({{ site.baseurl }}/opendirect/opendirect.html), and trigger location-based messages with [location and beacon messaging]({{ site.baseurl }}/location/geolocation-overview.html).

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

#### Version 5.0.0
_Released January 22, 2018, correlating with the Marketing Cloud January 2018 release_

* We redesigned the SDK to make it easier to integrate than ever before. This release includes a slimmer API that makes it easier to add Marketing Cloud features to your app. Existing users can upgrade their version to take advantage of the improved SDK. New users can follow the existing Getting Started directions to get the SDK up and running.

* We updated the SDK for full support of iOS 11.
