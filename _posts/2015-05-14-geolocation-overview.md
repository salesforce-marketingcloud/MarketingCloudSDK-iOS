---
layout: page
title: "Overview"
subtitle: "Implement Location Services"
category: location
date: 2015-05-14 08:44:12
order: 1
---
If location is enabled in your MarketingCloudSDKConfiguration.json file, you can call a single method to use the Marketing Cloud location messaging feature.

In addition, Apple requires adding keys to your Info.plist file to enable location services:

* NSLocationAlwaysUsageDescription
* NSLocationAlwaysAndWhenInUseUsageDescription
* NSLocationWhenInUseUsageDescription

Review the [Apple documentation](https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services) for more information.

<img class="img-responsive" src="{{ site.baseurl }}/assets/location.png" /><br/>

> MarketingCloudSDK requires “Always” permissions for full geofence and beacon functionality. An application does not receive location messages if “When-in-use authorization” is selected by the app user.

When your application is ready to enable location features, including geofence and beacon messaging, call the MarketingCloudSDK framework's method to start watching location.
<script src="https://gist.github.com/07e4a6508960c6b96276cc71cb08a772.js"></script>
<script src="https://gist.github.com/31864111e51c70fc25581891444ec344.js"></script>

The MarketingCloudSDK+Location.h” header file details additional methods to get information about location and control the frameworks behavior.

> MobilePush prevents the app from displaying a geofence message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app does not display that message.
