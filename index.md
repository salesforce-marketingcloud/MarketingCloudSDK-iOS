---
layout: default
title: "README"
---
## Requirements

* Xcode 9 or later
* Minimum deployment target of iOS 10
* Compile the target application for arm64, not armv7.

## Get Started

1. Provision Apps with [Apple]({{ site.baseurl }}/get-started/apple.html).
1. [Create your apps]({{ site.baseurl }}/get-started/create-apps-overview.html) in the MobilePush Marketing Cloud app.
1. [Download the SDK]({{site.codeurl}}).
1. [Implement the SDK]({{ site.baseurl }}/get-started/implement-sdk.html).
1. Add [Feature Implementation]({{ site.baseurl }}/features/feature-implementation-overview.html) to your apps.
1. Add optional purchased features, such as [CloudPages]({{ site.baseurl }}/inbox/cloudpage-push-overview.html) and [Location Services]({{ site.baseurl }}/location/geolocation-overview.html), to your apps.

## Additional Resources

* The <a href="http://help.exacttarget.com/en/documentation/mobilepush/" target="_blank">Marketing Cloud MobilePush Documentation</a> contains information on the Marketing Cloud MobilePush app, including information on associating MobilePush with a mobile app.
* The Marketing Cloud provides the <a href="https://github.com/salesforce-marketingcloud/LearningAppIos" target="_blank">Learning App for iOS</a> that implements features of the SDK to allow you to explore how a native app implements the Journey Builder for Apps SDK.
* [Sign up for email updates about the JB4A iOS SDK](http://pub.s1.exacttarget.com/2ujjacpet3t).<br/><br/>

## iOS Version

**SDK version 4.6.0 and higher:** Build your app for iOS version 8.1 or higher.

**SDK version 4.5.1:** Build your app for iOS version 7 or higher.<br/><br/>

## Release History

For releases prior to 4.5.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS-v4.5.0/" target="_blank">Prior Release Documentation</a>

#### Version 4.9.6
_Released October 30, 2017, correlating with the Marketing Cloud October 2017 release_

* This release adds support for rich notifications. Rich notifications include images, audio, video, and titles and subtitles from MobilePush. Host your files with a public URL and use that address to include rich media in your notifications.

* Marketing Cloud now offers a plug-in to enable Cordova functionality in our Android and iOS SDKs. Review our [GitHub repo](https://github.com/salesforce-marketingcloud/MC-Cordova-Plugin) for plug-in files and more information.

#### Version 4.9.5
_Released August 28, 2017, correlating with the Marketing Cloud August 2017 release._

* **App Inbox Enhancements** -- Send a push message to the Inbox at the same time. On iOS, this feature comes with support of unread message count badging on the app icon. The new enhancements also come with additional analytics so you can track the engagement on opened and downloaded messages.
* **Predictive Intelligence Cart Tracking** -- Interested in tracking shopping carts from within your app? Track unique SKUs, which makes it possible to track all of your products through to conversion. Tracking cart events can be used to drive abandoned cart journeys to drive sales.
* We fully tested the JB4A version 4.9.5 SDK with Xcode 8 and Xcode 9 using all supported base SDK and deployment target versions, including iOS 11 as both base SDK and minimum deployment versions in Xcode 9. If you build your application with Xcode 9 and target the iOS 11 SDK, note that SDK 4.9.5/209 and earlier versions display at least one static analyzer warning at debug time in Xcode. These versions also display at least one application log message at app runtime indicating that requestAlwaysAuthorization and registerForRemoteNotifications need to be called on the main thread:
  * Use [UIApplication registerForRemoteNotifications] from the main thread only.
  * This error is _not_ fatal.
  * Our October 2017 release corrects this error.

#### Version 4.9.0
_Released June 19, 2017, correlating with the Marketing Cloud 208 release._

* **Added ability to get inbox messages and counts** -- We added new convenience methods to get all CloudPage inbox messages and the count of read, unread and all inbox messages.

#### Version 4.8.0
_Released April 3, 2017, correlating with the Marketing Cloud 207 release._

* **Updated CloudPage inbox data source** -- We now ensure that the CloudPage inbox refreshes for the entire lifecycle of the data source object.
* **Corrected nullability annotation warning** -- We corrected an annotation that generated a warning in Swift projects.
* **Updated push tokens** -- We now ensure that apps send new or refreshed push tokens back to Marketing Cloud.
* **Improved thread safety** -- We improved the SDK’s behavior with multiple concurrent network connections, which makes the SDK more thread safe.

#### Version 4.7.0
_Released January 30, 2017, correlating with the Marketing Cloud 206 release._

* **Improved internal database** – We resolved a potential error in our internal database to ensure proper app function.
* **Improved network error handling** – We improved network error handling to prevent CloudPage inbox messages from being incorrectly deleted.

#### Version 4.6.0
_Released November 2, 2016, corresponding to the Marketing Cloud 2016-06 release_

* **iOS 10 Support** -- Users can now use the SDK with iOS 10. This update changes the handling of push notifications on iOS devices running version 10 or greater. The SDK remains compatible with previous versions of iOS. On devices running version 10, the SDK now uses the new user notification framework. View details here: [Use iOS 10 Notifications]({{ site.baseurl }}/features/iOS10-notifications.html).

* **Collect API Update** -- If SubscriberKey contains a value, the Collect API payload includes that value whether or not it's in the format of an email address.

* **New Minimum Deployment Target Version: iOS 8.1** -- Build your app for iOS 8.1 or higher to be compatible with the SDK.

* **Upgrade SDK to have ATS supported** -- The JB4A SDK version 4.4.0 or higher supports App Transport Security (ATS). Apple announced that ATS will be required for all apps by January 2017. Upgrade the JB4A SDK and build your app for iOS 9 or higher. See [ATS Considerations]({{ site.baseurl }}/upgrading/ats-considerations.html).

* **Improved error handling** -- We improved the error handling in the ETPush class method `-(void)applicationLaunchedWithOptions:(nullable NSDictionary *)launchOptions`.

#### Version 4.5.1
_Released October 6, 2016_

* **Keychain error handling improvements** - We made improvements to keychain error handling.

#### Version 4.5.0
_Released September 12, 2016, correlating with the Marketing Cloud 2016-05 release._

* **MobilePush Beacons Support** - The SDK supports [MobilePush Beacons]({{ site.baseurl }}/location/add-beacons.html).
* **Use Multiple Push Providers Cautiously** - If you use multiple push providers, there are several things you should be aware of: [Troubleshooting]({{ site.baseurl}}/trouble/multiple-push-sdks.html).

#### Version 4.4.0
_Released July 18 2016, correlating to the Marketing Cloud 2016-04 Release_<br/>

* MOBILESDK-854 - <a href="/JB4A-SDK-iOS/rich-push/inbox.html#CPDelegate">iOS - Created CloudPage+Alert Delegate</a>.
* MOBILESDK-904 - iOS SDK to use NSURLSession for networking. As of release 2016-04 of the JB4A SDK, we are 100% compliant with Apple NSURLSession standards.
* MOBILESDK-907 - <a href="/JB4A-SDK-iOS/features/analytics.html#TrackCartAnalytics">Implemented Predictive Intelligence integration methods for tracking eCommerce cart contents and cart conversions.</a>
* MOBILESDK-909 - Fixed getSDKState() to correctly report data.
* MOBILESDK-910 - Improved Deprecation warnings in SDK.

#### Version 4.3.0
_Released May 23 2016, correlating to the Marketing Cloud 2016-03 Release_<br/>

* MOBILESDK-371 - Remove deprecated functions from public interfaces.
* MOBILESDK-379 - Adjust iOS to be Swift compatible.
* MOBILESDK-604 - Create Event Bus.
* MOBILESDK-779 - Include Appledocs docset file with release code and documentation.
* MOBILESDK-790 - Inaccurate horizontal accuracy may prevent location downloads from occuring.
* MOBILESDK-821 - Reusing a beacon with the same UUID/Major/Minor will result in lookup errors in the SDK.
* MOBILESDK-822 - Do not display geofence or beacon message with an empty alert.
* MOBILESDK-829 - Implement retry logic for beacons, cloudpages and geofences.
* MOBILESDK-830 - Getting OpenDirect delegate crashes app unless has been set.
* MOBILESDK-832 - Add missing fields to PiWama Analytics.
* MOBILESDK-848 - Implement bitcode enabled.
* MOBILESDK-851 - Once a day updates should renew the location fix before getting data.

#### Version 4.2.1
_Released April 06 2016, correlating to the Marketing Cloud 2016-02.1 Release_<br/>

* MOBILESDK-760 - Remove expired Mobile Inbox Cloud Pages from the SDK.
* MOBILESDK-711 - Cloud Page sync for iOS. Cloud pages removed from web app are also removed from SDK.

#### Version 4.2.0
_Released March 21 2016, correlating to the Marketing Cloud 2016-02 Release_<br/>

* MOBILESDK-063 - Fix Geofence and Beacon analytics for region entry, exit, and message displayed.
* MOBILESDK-258 - Improvements to beacon detection and message display.    
* MOBILESDK-268 - Package registration data updates with each update method (such as setTag(), addAttribute()) by
                  issuing REST call 1 minute after first call.  If REST call fails, retry in background until REST
                  call succeeds or app is suspended.
* MOBILESDK-375 - Update the default landing page used to display OpenDirect and CloudPage+Alert URLs when these notifications are tapped, to use WKWebView rather than UIWebview.   
* MOBILESDK-376 - Set CLLocationManager allowsBackgroundLocationUpdates to YES for iOS9 builds (required for Beacons support).
* MOBILESDK-387 - Improve downloading of new Geofences and Beacons.  New [plist entry]({{ site.baseurl }}/location/geolocation.html#plist) if you would like a daily refresh of regions and messages.
* MOBILESDK-389 - Ensure SQL DB is constrained to at most 1000 rows of Marketing Cloud Analytics.
* MOBILESDK-413 - Make sure device ranges for locations after device reboot.
* MOBILESDK-417 - Add boolean in [configureSDK()]({{ site.baseurl }}/sdk-implementation/implement-sdk.html) to turn on Beacon ranging (if you are part of the Beacon Beta Test).
* MOBILESDK-481 - Attribute names that conflict with Contact record attribute names will be rejected.  Check returned boolean if attribute is accepted.
* MOBILESDK-509 - Reject subscriberKey, Tags and attributes that are null.  Trim leading and trailing blanks before sending.  Blank subscriberKey and Tags will also be rejected.
                  Check returned boolean to determine if the values were accepted.
* MOBILESDK-550 - Fix open and time in app sent for Marketing Cloud analytics.
* MOBILESDK-580 - Implement [getSDKState()]({{ site.baseurl }}/trouble/ios-debugging.html) method to return a JSON string with key SDK values for debugging purposes.
* MOBILESDK-616 - Make the device id persistent across app installs.
* MOBILESDK-634 - Add custom [logging handler]({{ site.baseurl }}/features/features-logging.html).
* MOBILESDK-674 - Add getTags() and getAttributes() and deprecate allTags() and allAttributes().                     
* MOBILESDK-727 - Change [updateET()](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/Classes/ETPush.html#//api/name/updateET) so that it sends Registration data immediately on the first call (after app enters
                  foreground state) and in 1 minute intervals for subsequent calls.

#### Version 4.1.0
_Released February 2, 2016, correlating to the Marketing Cloud 2016-01 Release_<br/>

* MOBILESDK-502 - Create an ETAnalytics class to have parity with Android.
* MOBILESDK-493 - Swift unable to resolve LocationManager.
* MOBILESDK-492 - Library has possible issues with debug symbols.
* MOBILESDK-474 - Registration Opt-In Process incorrectly sends TRUE.
* MOBILESDK-444 - Add Retry logic - iOS.
* MOBILESDK-269 - Make end point configurable for WAMA in SDK.
* MOBILESDK-231 - Add constraints to WAMA Analytics.
* MOBILESDK-217 - Update Analytics

#### Version 4.0.3
_Released November 4, 2015, correlating to the Marketing Cloud 2015-06.HF Release_<br/>

* MOBILESDK-439 - iOS SDK returning latitude/longitude with commas instead of decimal points for certain locales.
* MOBILESDK-428 - Database corruption following VACUUM
* MOBILESDK-427 - Fix for ETEvent analytics to handle Array of dictionaries.

#### Version 4.0.2
_Released October 2, 2015, correlating to the Marketing Cloud 2015-06 Release_<br/>

* MOBILESDK-327 - Fix for missing keychain item when applications are restored from an unencrypted backup.
* MOBILESDK-326 - Only send registration data if different from the last one sent
* MOBILESDK-311 - Application crashing in iOS SDK
* MOBILESDK-310 - Reduce Location REST call traffic to Marketing Cloud
* MOBILESDK-300 - Application crashing in iOS SDK

> This version of the JB4A SDK introduces iOS Keychain usage. To ensure that your app retains any relevant data across user backups and restores, encourage your app users to implement encrypted backups for their devices. Otherwise, information (such as tags, attributes, and subscriber keys) will not persist.

#### Version 4.0.1
_Released July 23rd, 2015_<br/>

* MPUSH-3856 - SUPPORT - Upgrade to MobilePush iOS SDK 4.0.0 from SDK 3.4.2 Causes App to Freeze<br/>

#### Version 4.0.0
_Released June 24th, 2015, correlating to the Marketing Cloud 2015-04 Release_<br/>

* MPUSH-3605 - SDK iOS: Modify payload to always send english datetime<br/>
* MPUSH-3472 - Change iOS location_enabled registration field to user location opt-in status<br/>
* MPUSH-3442 - Remove Access Token from REST Route Body - iOS<br/>
* MPUSH-3885 - iOS app crashes after viewing Cloud Page Inbox<br/>
* MPUSH-3341 - SDK Updates & Changes<br/>
* MPUSH-3259 - iOS: Encrypt data on device<br/>
* MPUSH-3717 - Timing issue with ExactTargetEnhancedPushDataSource<br/>
* MPUSH-3713 - Added ability to utilize unicode characters in Rich Push subject lines<br/>

**Required Coding Changes**

The following are changes that must be made in order to upgrade from previous releases of the SDK:<br/><br/>
The latest configureSDKWithAppID has some additional parameters and can be found at [Implement the SDK]({{ site.baseurl }}/sdk-implementation/implement-sdk.html).

You will need to update your configSDK registration call to now read:

<script src="https://gist.github.com/sfmc-mobilepushsdk/71cf71032cfe92c06d76bf5f894cb115.js"></script>

<!--**Recommended Coding Changes** -->
