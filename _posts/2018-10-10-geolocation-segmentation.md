---
layout: page
title: "Location Message Segmentation"
subtitle: "Location Message Segmentation"
category: location
date: 2018-10-01 12:00:00
order: 3
---

Geofence and Beacon Messages are delivered from the Marketing Cloud server to all devices within the general area of a MobilePush Location. MobilePush does not allow audience segmentation or filtering of Location messages at the time of message creation.

To support delivery of messages to a subset of contacts in a MobilePush audience, the MobilePush SDK offers support for app control over what location messages will be displayed. 

When the device breaks a geofence, or is in proximity to a Bluetooth beacon, the SDK can trigger a call back to your mobile app to evaluate if that message should be shown. Your application can apply a variety of criteria in determining if the message should be shown, including using information within the MobilePush message itself.

### Implementation:

{%- include gist.html names="Obj-C,Swift" gists="https://gist.github.com/db2005951ce433fcdc5f477b39de82f5.js,https://gist.github.com/de2a284ef4462a7358f84c954ae45fb9.js" -%}

See _MarketingCloudSDK+Location.h_ for more information.

### Some potential use cases:
    
- Check if the user's "my store" location is within the geofence region and show the message only if true.
- Check if the user has items in their app shopping cart. If the message has a custom key "abandonedCart":"true" show the message.
- Based on the region and current time, check the app's store location list to only show the location message when the store is open.
- Do not allow messages to be shown if the user is not logged in to their account.
- Show specific messages based on the user's customer profile - customers who are coffee lovers get messages about coffee, but customers who prefer pastry receive a message to "add a coffee" when they're in the shop.

