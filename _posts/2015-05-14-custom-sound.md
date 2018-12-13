---
layout: page
title: "Custom Sound"
subtitle: "Specify a Custom Notification Sound"
category: push-notifications
date: 2015-05-14 12:00:00
order: 2
---

This feature uses a sound included in your mobile app as a custom audio signal when a push message arrives on the mobile device.

1. Add a file named custom.caf to your project. The cloud push payload looks for a file named custom.caf.
1. Add the custom.caf audio file to the Copy Bundle Resources folder for your app.
1. To prevent Xcode from using cached files, perform a clean build folder in Xcode. In the Product menu, hold the Option key and select **Clean Build Folder**.
1. Ask the marketer to enable custom sound on the MobilePush Administration page in Marketing Cloud.

### Related Items
* [Custom Sound](https://help.salesforce.com/articleView?id=mc_mp_custom_sound.htm&type=5#customSound)
