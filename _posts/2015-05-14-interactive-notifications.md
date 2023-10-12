---
layout: page
title: "Interactive Notifications"
subtitle: "Display Interactive Notifications"
category: push-notifications
date: 2015-05-14 12:00:00
order: 3
---
Use interactive notifications to add buttons to push notifications from your mobile app. Marketing Cloud sends the category name for these interactive notifications in the message payload.

1. To set up interactive notifications for your app, use the Implementation sample code as a guide and modify for your situation.
 > The sample code applies to the `AppDelegate.m` `didFinishLaunchingWithOptions` application delegate mention.
 > The sample code shows how to create a category named "Example". When you send this category with the payload from Marketing Cloud, the notification displays in the notification center with buttons.

1. To check if your action triggered and to take action, examine the push notification’s payload in your push handler. Use the Handle Action sample code as a guide.
1. After setup, ask the marketer to enable interactive notifications on the MobilePush Administration page in Marketing Cloud.

#### Example: Implementation

{% include tabbed_gists.html sectionId="interactive_notifications-example" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/bd38e5333bdafa5dc5c5f8fdc22bdf1e.js,https://gist.github.com/sfmc-mobilepushsdk/d5214aed3800ece0460273d30aaa1733.js" %}

#### Example: Handle Action

In your push handler, examine the push notification's payload to see if your action triggered and if your application performed the action.

{% include tabbed_gists.html sectionId="interactive_notifications-handler" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/1ca4491f7eb58f98b758d072568f4fff.js,https://gist.github.com/0ef8e0766c13ada7d333495e5d1cabe1.js" %}

### Related Items
* [Interactive Notifications](https://help.salesforce.com/articleView?id=mc_mp_interactive_notifications.htm&type=5#interactiveNotifications)
