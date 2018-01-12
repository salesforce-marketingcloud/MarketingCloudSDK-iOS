---
layout: page
title: "Interactive Notifications"
subtitle: "Display Interactive Notification Messages"
category: push-notifications
date: 2015-05-14 12:00:00
order: 3
---
Add buttons called interactive notifications to push notifications in your mobile app. Marketing Cloud sends the category name for these interactive notifications in the message payload. This feature requires [enablement](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#interactiveNotifications) in the Marketing Cloud application.

This sample code applies to the AppDelegate.m didFinishLaunchingWithOptions application delegate mention. Modify this sample code for your specific circumstances.

This sample shows how to create a category named "Example". When you send this category with the payload from Marketing Cloud, the notification displays in the notification center with the buttons shown here.

**Implementation**
<script src="https://gist.github.com/100bc30faf9ff027c99462b59726c3b6.js"></script>
<script src="https://gist.github.com/256765c97c9e67f4c1622e1a978e13b2.js"></script>

**Handle Action**

In your push handler, examine the push notification's payload to see if your action triggered and take action.
<script src="https://gist.github.com/997077403e1152972978cc13a243d07d.js"></script>
<script src="https://gist.github.com/0ef8e0766c13ada7d333495e5d1cabe1.js"></script>
