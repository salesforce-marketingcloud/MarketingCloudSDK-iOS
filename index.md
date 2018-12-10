---
layout: default
title: "README"
---
## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 9

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

* The MarketingCloudSDK for iOS can be found on [GitHub](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS) and [CocoaPods](https://cocoapods.org/pods/MarketingCloudSDK).
* The <a href="https://help.salesforce.com/articleView?id=mc_mp_mobilepush.htm&type=5" target="_blank">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the <a href="https://github.com/salesforce-marketingcloud/LearningAppIos" target="_blank">Learning App for iOS</a> that implements features of the SDK to allow you to explore how a native app implements the MarketingCloudSDK.
* [Sign up for email updates about the iOS MarketingCloudSDK](http://pub.s1.exacttarget.com/2ujjacpet3t).<br/>
* View the [Android SDK docs](http://salesforce-marketingcloud.github.io/JB4A-SDK-Android/).

## Hybrid Mobile Apps
We provide support for plugins, such as Cordova, to implement the MobilePush SDK for your iOS applications.
* [Cordova Plugin](https://github.com/salesforce-marketingcloud/MC-Cordova-Plugin)

## Release History

For releases prior to 5.0.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/" target="_blank">Prior Release Documentation</a>

#### Version 6.1.0
_Released January XX, 2019, correlating with the Marketing Cloud January 2019 release._

* **Implemented Location Message Segmentation** - Offering finer-grained control over geofence and beacon messages, the MobilePush SDK offers support for app control over what location messages will be displayed.

* **Implemented Predictive Intelligence identifier configuration options and APIs** - Marketing Cloud applications can be configured to either use existing contactKey data as the identifier for Predictive Intelligence analytics or use a Predictive Intelligence-specific identifier according to your usage of this Marketing Cloud feature.

* **iOS File Protection** - Added a guarding mechanism in the SDK to ensure that iOS File Protection transitions are complete before the SDK completes configuration. The SDK will wait up to 5 seconds (non-blocking) to accommodate the transition; if UIApplication's `isProtectedDataAvailable` returns NO, configuration will fail.

#### Version 6.0.1
_Released December 5, 2018, correlating with the Marketing Cloud 215.1 release._

* **Analytics** -- Addressed an issue sending analytics to Predictive Intelligence if the `MID` configuration value is used.
* **Networking** --Reduced number of network calls made to Marketing Cloud servers during lifecycle of the SDK.

#### Version 6.0.0
_Released October 22, 2018, correlating with the Marketing Cloud October 2018 release._

* **Implemented Tenant-Specific Endpoint support for Marketing Cloud Accounts** -- New Marketing Cloud MobilePush applications will be configured with account-specific settings. See [Configure the SDK]({{ site.baseurl }}/get-started/apple.html#4-configure-the-sdk) for instructions on configuring your SDK's values.
* **Removed SDK-provided web view for URLs** -- We removed the SDK's built-in URL presenter to remove security concerns.  As such, you must provide the SDK with a delegate and implementation of the `MarketingCloudSDKURLHandlingDelegate` protocol if your message will redirect to a web URL, resource, file or other business logic driven custom application schema. See [Handling URLs]({{ site.baseurl }}/sdk-implementation/implementation-urlhandling.html) for more information.
 
 > SDK API REMOVAL `MarketingCloudSDKCloudPageMessagesNotificationHandlerDelegate`, `MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate` and `MarketingCloudSDKInboxMessagesNotificationHandlerDelegate` protocols and protocol methods have been removed from the SDK. Please change your code to implement the MarketingCloudSDKURLHandlingDelegate protocol.
 
* **Inbox Functionality Improvements** -- When an Alert+Inbox push notification arrives with the app in the foreground, Inbox messages will be reloaded from the server automatically.
* **Inbox Functionality Improvements** -- Inbox message handling better tracks "active" messages in the inbox (according to start and end date values).
* **SDK Configuration** -- Added option to configure SDK via runtime values passed to SDK (`sfmc_configureWithDictionary:`)

#### Version 5.2.1

_Released August 27, 2018, correlating with the Marketing Cloud July 2018 release._

* **Stability** -- We addressed issues related to multithreading and Core Data concurrency.

#### Version 5.2.0
_Released July 11, 2018, correlating with the Marketing Cloud July 2018 release._

* **Added checks to prevent exceptions** -- We added nil checks to prevent potential exceptions that could happen when users swipe to close an app.
* **Improved log string initializers** -- To help prevent Xcode Address Sanitizer warnings, we improved the SDK's use of log string initializers.
* **Device ID migration** -- The SDK attempts to migrate the deviceId from versions of JB4ASDK 4.x.x, if possible.

#### Version 5.1.1

_Released May 31, 2018, correlating with the Marketing Cloud 213.1 release._

* **Corrected issues with multi-threading** -- We corrected issues related to multi-threading in the SDK.
* **Added i386 slice for simulator builds** -- We updated the build process to include i386 ARCH, which allows you to run 32-bit simulators.
* **Addressed issue loading resources on armv7s devices** -- We corrected an issue related to loading resources on armv7s devices.

#### Version 5.1.0
_Released April 23, 2018, correlating with the Marketing Cloud April 2018 release_
* **Added iOS 9 support** -- The iOS MarketingCloudSDK framework now supports iOS 9. Use conditional coding via Apple’s `available` attributes. For notes on using conditional coding for push registration and handling push notifications, see the iOS 9 documentation.
* **Added synchronous configuration calls** -- To prevent developers from trying to set a contact key, tag, or attribute before configuration is complete, we added synchronous configuration calls to the API as the default.
* **Added data privacy compliance** -- This version of the iOS MarketingCloudSDK supports three privacy modes that may affect your application’s use of MobilePush: 1) Right to be Forgotten, 2) Restriction of Processing, and 3) Do Not Track. These changes assist you in preparing for data compliance regulations, such as the European Union's General Data Protection Regulation (GDPR). For more details, visit our SDK-specific [data privacy compliance documentation]( {{ site.baseurl }}/sdk-implementation/data-privacy-iOS.html).
* **Throttled inbox message calls** -- To match the Android SDK, we now prevent the iOS MarketingCloudSDK from calling `sfmc_refreshMessages` too often. Reference the headers for more information.
* **Allowed Predictive Intelligence to be set separately** -- When you configure the iOS MarketingCloudSDK, you can now enable or disable Predictive Intelligence separately from Analytics. If your app uses the iOS MarketingCloudSDK version 5.0.0 framework and if Analytics is enabled, Predictive Intelligence is also enabled. To control Predictive Intelligence separately, add the config flag.
* **Improved registration** -- We improved registration to prevent duplicate tags and attributes.
* **Fixed `isPushEnabled` override issue** -- Previously, disabling push notifications in the Notification Center overrode the `setPushEnable` property. We fixed this issue so that the SDK uses `setPushEnable`.

#### Version 5.0.0
_Released January 22, 2018, correlating with the Marketing Cloud January 2018 release_

* We redesigned the SDK to make it easier to integrate than ever before. This release includes a slimmer API that makes it easier to add Marketing Cloud features to your app. Existing users can upgrade their version to take advantage of the improved SDK. New users can follow the existing Getting Started directions to get the SDK up and running.

* We updated the SDK for full support of iOS 11.
