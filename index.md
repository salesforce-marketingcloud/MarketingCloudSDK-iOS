---
layout: default
title: "Home"
---
## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 9

## Get Started

1. [Download and set up the SDK]({{ site.baseurl }}/get-started/apple.html)
Integrate the SDK into your app and configure the SDK to send push notifications.
1. [Test your setup]({{ site.baseurl }}/get-started/test-first-push.html)
Send your first push notification to test your initial SDK setup.
1. Implement additional optional features of the SDK to take full advantage of Salesforce Marketing Cloud.
    * [Add custom sounds, media, custom keys, and interactions]({{ site.baseurl }}/push-notifications/push-notifications.html) -- Use these features to further customize push notifications for your apps.
    * Use a [contact key]({{ site.baseurl }}/sdk-implementation/user-data.html#contact-key) to set the unique identifier used to aggregate a contact’s devices within Marketing Cloud. Set the contact key to a specific value provided by your customer or to another unique identifier for the contact, such as mobile number, email address, customer number, or another value.
    * Add [attributes]({{ site.baseurl }}/sdk-implementation/user-data.html#attributes) and [tags]({{ site.baseurl }}/sdk-implementation/user-data.html#tags) -- Enhance your ability to segment your push message audiences.
    * [Add predictive intelligence]({{ site.baseurl }}/analytics/personalization-collect.html) using Personalization Builder -- Track cart and cart conversions. Purchase this feature separately.
    * Add other features -- Send push notifications along with your [inbox messages]({{ site.baseurl }}/inbox/inbox.html), use OpenDirect for [deep linking]({{ site.baseurl }}/opendirect/opendirect.html), and trigger location-based messages with [location and beacon messaging]({{ site.baseurl }}/location/geolocation-overview.html).

## Contact Us

Sign up for email announcements and contact us with questions or feedback about the iOS SDK.
  * Email us at <marketingcloudsdkfeedback@salesforce.com>.
  * Post on our [Stack Exchange](https://salesforce.stackexchange.com/tags). Example tags: marketing-cloud, salesforcemobilesdk-ios, mobilesdk, and mobilepush-ios
  * Sign up for [email updates](http://pub.s1.exacttarget.com/2ujjacpet3t) about release announcements and other important information. (10 or fewer emails per year)

## Additional Resources

* The MarketingCloudSDK for iOS can be found on [GitHub](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS) and [CocoaPods](https://cocoapods.org/pods/MarketingCloudSDK).
* The <a href="https://help.salesforce.com/articleView?id=mc_mp_mobilepush.htm&type=5">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the <a href="https://github.com/salesforce-marketingcloud/LearningAppIos">Learning App for iOS</a> that implements features of the SDK to allow you to explore how a native app implements the MarketingCloudSDK.
* Review the [Appledocs]({{ site.baseurl }}/appledoc/index.html) for the SDK.
* [Sign up for email updates about the iOS MarketingCloudSDK](http://pub.s1.exacttarget.com/2ujjacpet3t).<br/>
* View the [Android SDK docs](http://salesforce-marketingcloud.github.io/JB4A-SDK-Android/).

## Hybrid Mobile Apps

We provide support for plugins, such as Cordova, to implement the MobilePush SDK for your iOS and Android applications.

* [Cordova Plugin](https://www.npmjs.com/package/cordova-plugin-marketingcloudsdk)

## Deprecations

We remove deprecated methods from the SDK two releases after the initial deprecation announcement.

## Release History

For releases prior to 5.0.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/">Prior Release Documentation</a>

#### Version 6.3.0
_Released June XX, 2019, correlating with the Marketing Cloud June 2019 release._

* **In-App Messaging** -- In-App Messaging (IAM) affords customized in-app experiences for delivering relevant, personalized messages to users of your app. Without relying on push notifications being enabled, Marketing Cloud customers can create engaging full-screen, modal or banner messages for delivery to your application and presentation while your users are interacting with your application. See [In-App Messaging]({{ site.baseurl }}/in-app-message/in-app-messaging.html) for more.

#### Version 6.2.0
_Released April 23, 2019, correlating with the Marketing Cloud April 2019 release._

* **Required app endpoint (tenant-specific endpoint)**—To pass the SDK's configuration, an app endpoint is now required. [Find the app endpoint](https://help.salesforce.com/articleView?id=mc_mp_provisioning_info.htm&type=5#mc_mp_provisioning_info) for your app under Administration in MobilePush. Review [Configuration Requirements]({{ site.baseurl }}/get-started/apple.html#configuration_requirements) for details.

* **Added application badging override**—A new SDK configuration value gives you full control of your app’s badge value. Review [Application Badging]({{ site.baseurl }}/application-badging/application-badging.html) for details.

* **Added ability to delay registration until contact key is set**—Use a new SDK configuration value to delay registrations to Marketing Cloud until a contact key is set via `sfmc_setContactKey:`. Review [Delay Registration]({{ site.baseurl }}/sdk-implementation/user-data.html) for details.

* **Inbox messages support `sendDateUtc` for Sorting**—Inbox messages delivered to your app now include the date that the message was sent. App users can sort their inbox based on this value. Review [Inbox]({{ site.baseurl }}/inbox/inbox.html) for details.

* **Better tracking of open from push analytics**—The tracking of "open from push" analytics when an application is not running will now be captured more effectively if the SDK is configured asynchronously.

* **Fixed issue with the ConfigurationBuilder**—There was an issue with using the builder method of configuring the SDK which may have caused an authorization error when contacting Marketing Cloud.

#### Version 6.1.4
_Released February 28, 2019, correlating with the Marketing Cloud January 2019 release._

* **Location**—Corrected an issue that prevented a location or proximity CloudPage+Alert message from displaying.

#### Version 6.1.3
_Released February 11, 2019, correlating with the Marketing Cloud January 2019 release._

* **Implemented location message segmentation**—The SDK now supports app control over which geofence and beacon messages are displayed. Use the region information provided for geofence and beacon messages in your notification presentation logic. Review [Location Message Segmentation]({{ site.baseurl }}/location/geolocation-segmentation.html).

* **Implemented predictive intelligence identifier (PIID) configuration options and APIs**—You can configure the identifier for predictive intelligence analytics according to how you use Personalization Builder. Configure your applications to use either existing contact key data or a PI-specific identifier. Review [Personalization Builder and Collect API Integration]({{ site.baseurl }}/analytics/personalization-collect.html).

* **Added time for iOS file protection transitions**—To ensure that iOS file protection transitions are complete before the SDK completes configuration, we added a guarding mechanism. Now, to accommodate these transitions, the SDK waits up to 5 seconds, without blocking other functions. If UIApplication's `isProtectedDataAvailable` returns NO, configuration will fail.

* **Fixed predictive intelligence analytics issues**—Fixed issues related to sending predictive intelligence analytics if the `MID` configuration value is used.

* **Fixed location messaging issue**—Previously, reloading location messages from the server could show a display-limited message again, contrary to the message setting. This has been fixed.

#### Version 6.0.1
_Released December 5, 2018, correlating with the Marketing Cloud 215.1 release._

* **Analytics** -- Addressed an issue sending analytics to Predictive Intelligence if the `MID` configuration value is used.

* **Networking** -- Reduced number of network calls made to Marketing Cloud servers during lifecycle of the SDK.

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
