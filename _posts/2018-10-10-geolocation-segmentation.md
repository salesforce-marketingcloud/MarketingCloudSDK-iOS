---
layout: page
title: "Location Message Segmentation"
subtitle: "Location Message Segmentation"
category: location
date: 2018-10-01 12:00:00
order: 3
---

You can deliver location messages to a subset of your MobilePush audience by using the MobilePush SDK. When a mobile device breaks a geofence or comes into proximity of a Bluetooth beacon, the SDK triggers a callback to your mobile app to evaluate whether to show the message.

Your app can apply criteria, including information within the MobilePush message itself, to determine whether to show the message. Here are some use cases.

- Show the message if the user’s `my store` location is within the geofence region.
- Show the message if the user has items in the app shopping cart and if the message has an "abandonedCart":"true" custom key.
- Show the message only when the store is open based on the app’s store location list and the region and local time.
- Don’t show messages if the user isn’t logged in to the app.
- Show specific messages based on the user’s customer profile. For example, customers who are coffee lovers get messages about coffee, but customers who prefer pastry receive a message to “add a coffee” when they're in the shop.


### Segment Location Messages
{% include gist.html sectionId="locationSegmentation" names="Obj-C,Swift" gists="https://gist.github.com/db2005951ce433fcdc5f477b39de82f5.js,https://gist.github.com/de2a284ef4462a7358f84c954ae45fb9.js" %}

#### Related Items
* _MarketingCloudSDK+Location.h_ in [Appledocs]({{ site.baseurl }}/get-started/appledocs.html)
