---
layout: page
title: "In-App Messaging"
subtitle: "In-App Messaging"
category: in-app-message
date: 2019-02-05 12:00:00
order: 1
---

Deliver relevant, personalized messages to your app’s users with in-app messaging. You can now send messages without relying on users having enabled push notifications. Engaging full-screen, modal, or banner messages are presented while your users are interacting with your app.

To ensure that your app has the latest message data, in-app messages are delivered via MobilePush’s silent push feature to your app while it’s in the background and each time your app comes to the foreground. When your app comes to the foreground, any messages marked for display are presented at the top of your app's view stack.

To use in-app messages, enable them in [Marketing Cloud Journey Builder](https://help.salesforce.com/articleView?id=mc_jb_configure_inapp_in_journey_builder.htm&type=5). No SDK configuration specific to in-app messages is required. However, in-app messaging requires some other SDK methods.

### Required Methods
Marketers can configure the action that occurs when an end-user taps a button on an in-app message. To use these configurable actions, implement [URL handling]({{ site.baseurl }}/sdk-implementation/implementation-urlhandling.html). URL handling ensures that in-app messages properly handle these button action types:
* Web URL
* App URL
* Notification Settings
* Location Settings

### Optional Methods

You can use the SDK’s optional delegate functionality to control aspects of message display and to get information about the in-app message display lifecycle.

#### setEventDelegate

To make your application a delegate of the SDK's in-app messaging functionality, use `sfmc_setEventDelegate`.

{% include gist.html sectionId="sfmc_setEventDelegate" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/3fc38fc54f3637a8dadcf19a08aee243.js" %}

#### didShowInAppMessage and didCloseInAppMessage
The following delegate methods help ensure that you can appropriately manage your app's view state. In-app messages are shown as the top view controller in your app's hierarchy. Your application may need to respond to a view appearing or disappearing.

`sfmc_didShowInAppMessage`

`sfmc_didCloseInAppMessage`
{% include gist.html sectionId="sfmc_showClose" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/7ed692c0cc01f58583f175f06a8f71a1.js" %}

#### Prevent or Delay Message Display
You can delay or prevent an in-app message’s display. For example, prevent an in-app message from displaying during loading, instructions, the sign-in flow, and other situations. To prevent display of the message, make the shouldShowInAppMessage method return false.

`sfmc_shouldShowInAppMessage`
{% include gist.html sectionId="sfmc_shouldShow" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/ad9cf5dce00d9650a73ecb4d701169b7.js" %}

You can capture the message data and show that message later. For example, present the message after the end-user has signed in. To present the message later, use the following methods.

`sfmc_messageIdForMessage`

`sfmc_showInAppMessage`
{% include gist.html sectionId="sfmc_showInAppMessage" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/211d6335447a1c0b746d277c755562bb.js" %}

#### Customize Display

In-app messages use your device's system font. You can override the default font face to customize the display of an in-app message title, body, and button labels.

> You can’t alter the font size because this is defined by the message's design.

To set the display font, use the following method to pass the SDK a valid font name for the device's installed fonts or your app's custom fonts.

`sfmc_setInAppMessageFontName`
{% include gist.html sectionId="sfmc_setInAppMessageFontName" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/41603e39d5cef8ad9c84842a9e805320.js" %}

If the font is not a valid font, the SDK returns false and reverts to the system font.

### Related Items
See _MarketingCloudSDK+Events.h_ for more information.
