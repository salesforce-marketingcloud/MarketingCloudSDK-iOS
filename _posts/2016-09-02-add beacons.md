---
layout: page
title: "Beacons"
subtitle: "Add Beacons"
category: location
date: 2016-09-02 08:43:35
order: 3
---
We enable beacon support when you implement the location requirements above.

To range for beacons in the background, add an entry to your app's Info.plist. This permission ensures that your app can range for beacons when your app is in the background or suspended.

Implement this key to enable this function. “App registers for location updates” is required to enable location in the MarketingCloudSDK and to range for beacons in the background.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

> MobilePush prevents the app from displaying a beacon message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app will not display that message.

> To understand how beacons behave in different situations, review the MobilePush beacons help documentation (http://help.marketingcloud.com/en/documentation/mobilepush/beacons_overview/beacon_behavior/).

If you create your own CLLocationManager object, we cannot guarantee that features of our SDK will work as intended.

If you have enabled notifications using MarketingCloudSDK and have called -sfmc_startWatchingLocation,  you can access the device's last known location using the SDK.

```
NSDictionary *location = [[[MarketingCloudSDK sharedInstance] sfmc_lastKnownLocation];
```
```
let location = MarketingCloudSDK.sharedInstance().sfmc_lastKnownLocation()
```
