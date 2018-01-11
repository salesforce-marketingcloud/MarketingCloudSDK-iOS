---
layout: page
title: "Overview"
subtitle: "Feature Implementation"
category: features
date: 2015-06-16 12:00:00
order: 1
published: false
---
This section contains information on implementing various features in your mobile app.

Ensure that you understand the functional flow of remote notifications, and where the responsibility for push messages resides at a given time. The graph below demonstrates the flow between Salesforce and Apple APNS servers.

<br />
<img class="img-responsive" src="{{ site.baseurl }}/assets/Overview_Features_Step1_b.png" /><br />
<br />

The remote push notification process includes two major steps:

1. Registration
1. Push to the end device.

* Registration Process
1. In the registration process, the app first makes a registration call to iOS.
1. iOS will then request a device token from APNS.
1. The device receives the device token.
1. The app sends the token to the Marketing Cloud.

<br/>

* Push Process
1. After the registration process completes, the user makes a push from the Marketing Cloud to the Apple APNS servers.
1. The APNS servers will then process and push the notification to your application.
