---
layout: page
title: "In-App Messaging"
subtitle: "In-App Messaging"
category: in-app-message
date: 2019-02-05 12:00:00
order: 1
---

## Introduction
In-App Messaging (IAM) affords customized in-app experiences for delivering relevant, personalized messages to users of your app. Without relying on push notifications being enabled, Marketing Cloud customers can create engaging full-screen, modal or banner messages for delivery to your application and presentation while your users are interacting with your application.

In-App Messages are fully enabled as part of Marketing Cloud Journey Builder and supported without additional SDK configuration.

In-App Messages are delivered to your application while in the background (using MobilePush's silent push technology) and each time your application comes to the foreground, ensuring your application has the latest message data.

When your app comes to the foreground, any messages which are valid for display will be prepared to be presented atop your application's view stack.

## Optional Methods

The MobilePush SDK offers optional delegate functionality so that your application can be informed of the In-App Message display lifecycle and control aspects of the message display.

> These methods are optionally implemented in your application and are not required for In-App Messaging functionality.


You can make your application a delegate of the SDK's In-App Messaging functionality by using

`sfmc_setEventDelegate`
{% include gist.html sectionId="sfmc_setEventDelegate" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/3fc38fc54f3637a8dadcf19a08aee243.js" %}

The delegate methods help ensure that your application's view state can be managed appropriately, as the IAM will be shown as the topmost view controller in your application's hierarchy. Your application may need to respond to a view appearing or disappearing.

`sfmc_didShowInAppMessage`

`sfmc_didCloseInAppMessage`
{% include gist.html sectionId="sfmc_showClose" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/7ed692c0cc01f58583f175f06a8f71a1.js" %}

Additionally, your application can be informed that a message is about to be shown and choose to prevent or defer a message's display.

Typically, this would be used if your application is in a process where an IAM would be inappropriate to present (you are showing a loading indicator, instructional information, sign-in flow, etc.). In that case, returning false from the shouldShowInAppMessage method will prevent the SDK from displaying the IAM.

`sfmc_shouldShowInAppMessage`
{% include gist.html sectionId="sfmc_shouldShow" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/ad9cf5dce00d9650a73ecb4d701169b7.js" %}

If you choose to return false, you may capture the message data the SDK would like to display and show that message later, if appropriate (for instance, sign-in has been completed, so the message can be shown).

`sfmc_messageIdForMessage`

`sfmc_showInAppMessage`
{% include gist.html sectionId="sfmc_showInAppMessage" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/211d6335447a1c0b746d277c755562bb.js" %}

## Display Customization

In-App Messages use, by default, your device's system font. You may override the default font face in order to customize the display of an In-App Message title, body and button labels.

Note: the application is not able to alter the font size, as this is defined by the message's design.

To set the display font, pass the SDK a valid font name for your device's installed fonts or application's custom fonts to the SDK via

`sfmc_setInAppMessageFontName`
{% include gist.html sectionId="sfmc_setInAppMessageFontName" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/41603e39d5cef8ad9c84842a9e805320.js" %}

This method will return a boolean value indicating if the font name is a valid font for the device and can be used by the SDK. If this is not a valid font, the SDK will return false and revert to the system font.

See _MarketingCloudSDK+Events.h_ for more information.