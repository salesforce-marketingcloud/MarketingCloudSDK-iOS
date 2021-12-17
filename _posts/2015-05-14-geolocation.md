---
layout: page
title: "Background Location Updates"
subtitle: "Background Location Updates"
category: location
date: 2015-05-14 08:43:35
order: 2
---

Normally, the app downloads new regions and messages as the device moves more than 5 kilometers from the last location and download of this data. However, if your app serves customers who spend a lot of time within a single 5K radius, consider adding the ability to do a background refresh of regions and messages. Since Apple controls when this background refresh takes place, we cannot guarantee when the refresh occurs. However, Apple allows the SDK to download new regions and messages for those times your customer spends a considerable amount of time in a single 5K region.

In your Info.plist, implement this key to enable this function. We require “App downloads content from the network” to perform a Background App Refresh periodically to refresh geofences and beacons.

In your Info.plist, add keys under `UIBackgroundModes`:

```
<array>
	<string>fetch</string>
	<string>location</string>
	<string>remote-notification</string>
</array>
```

`fetch` : We require “App downloads content from the network” to perform a background app refresh periodically to refresh geofences and beacons.
`location` : We require “App registers for location updates” to enable location in the MarketingCloudSDK and to range for beacons in the background.


<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

In your application delegate method `-application:didFinishLaunchingWithOptions:`, implement this code:

<script src="https://gist.github.com/afaa7fda97d7a03bbe7e05eb6efb49de.js"></script>

Implement the handler for this functionality in your application delegate class:

{% include tabbed_gists.html sectionId="geolocation_handler_impl" names="8.x,7.x" gists="https://gist.github.com/stopczewska/3dcde481baf924ebbfec9675a11d6c0e.js,https://gist.github.com/b06bc514d446f8a4fd3200aac1b7e5c1.js" %}

See MarketingCloudSDK+Base.h for more information about this method.
