---
layout: page
title: "Geofence and Beacon Messaging"
subtitle: "Geofence and Beacon Messaging"
category: location
date: 2015-05-14 08:44:12
order: 1
---
## iOS 14 Location Changes
>As of iOS 14, users will now have the option to use approximate instead of precise location. Users who choose to use this new approximate location permission should not expect geofences or beacons to be triggered.
Ref: https://developer.apple.com/documentation/corelocation/cllocationmanager/3600215-accuracyauthorization

>The below features require precise location authorization to work in iOS 14 and above. The MobilePush SDK will send only precise location updates to Marketing Cloud Server and approximate location updates of user device will be ignored.

If location is enabled in your MobilePush SDK configuration (via `MarketingCloudSDKConfigBuilder()` `sfmc_setLocationEnabled()`), you can call a single method to use the Marketing Cloud location messaging feature.

## Location Messaging

In addition, Apple requires adding keys to your Info.plist file to enable location services:

* NSLocationAlwaysUsageDescription
* NSLocationAlwaysAndWhenInUseUsageDescription
* NSLocationWhenInUseUsageDescription

Review the [Apple documentation](https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services) for more information.

<img class="img-responsive" src="{{ site.baseurl }}/assets/location.png" /><br/>

> MarketingCloudSDK requires “Always” permissions for full geofence and beacon functionality. An application does not receive location messages if “When-in-use authorization” is selected by the app user.

When your application is ready to enable location features, including geofence and beacon messaging, call the MarketingCloudSDK framework's method to start watching location.

{% include tabbed_gists.html sectionId="geolocation_overview" names="8.x,7.x" gists="https://gist.github.com/stopczewska/f056ee7401789d33055563e8b266a490.js,https://gist.github.com/31864111e51c70fc25581891444ec344.js" %}

The MarketingCloudSDK+Location.h” header file details additional methods to get information about location and control the frameworks behavior.

> MobilePush prevents the app from displaying a geofence message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app does not display that message.

## Beacon Support

We enable beacon support when you implement the location requirements on this page.

To range for beacons in the background, add an entry to your app's Info.plist. This permission ensures that your app can range for beacons when your app is in the background or suspended.

Implement this key to enable this function. “App registers for location updates” is required to enable location in the MarketingCloudSDK and to range for beacons in the background.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

> MobilePush prevents the app from displaying a beacon message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app will not display that message.

> To understand how beacons behave in different situations, review the MobilePush beacons help documentation (http://help.marketingcloud.com/en/documentation/mobilepush/beacons_overview/beacon_behavior/).

If you create your own CLLocationManager object, we cannot guarantee that features of our SDK will work as intended.

If you have enabled notifications using MarketingCloudSDK and have called -sfmc_startWatchingLocation,  you can access the device's last known location using the SDK.

{% include tabbed_gists.html sectionId="beacon_overview" names="8.x,7.x" gists="https://gist.github.com/stopczewska/3dcde481baf924ebbfec9675a11d6c0e.js,https://gist.github.com/02d2c7f15461981015658691d81a4685.js" %}
