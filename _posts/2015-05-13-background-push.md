---
layout: page
title: "Silent Pushes"
subtitle: "Using Silent Pushes"
category: features
date: 2015-05-14 12:00:00
order: 10
published: false
---
#### Silent Push Messages for MobilePush
This document contains conceptual and procedural information about sending a silent push message to a mobile app using the MobilePush app and the REST API.

#### What are Silent Push Messages
A silent push message appears on a mobile app without triggering a visual or audible alert on the mobile device. Examples include subscriptions read inside the iOS Newsstand app or updates to messages within an app that do not require notifications.

#### How to Send Silent Push Messages
Follow the steps below to create and send silent push messages:

1. Create an API-triggered MobilePush message.
	*	[Create a single push message](https://code.exacttarget.com/apis-sdks/rest-api/v1/push/createPushMessage.html)
	*	[Create a push message for specified mobile devices](https://code.exacttarget.com/apis-sdks/rest-api/v1/push/postMessageContactSend.html)
	*	[Update a push message](https://code.exacttarget.com/apis-sdks/rest-api/v1/push/updatePushMessage.html)
1. Ensure you set the **content-available** property to 1.
1. Set the **override** property to **true**.
1. Include AMPscript in the **messageText** property as a placeholder for the overriden text. For example, you can include the value %%[]%%.
1. Use the sample payload below as a model for your own message:

<script src="https://gist.github.com/sfmc-mobilepushsdk/4f4ab7311a39657e9356.js"></script>

Note that you cannot use badge count or sound as part of the message. Once you create the original message, you can pass text to the message using subsequent messages as part of the **Override** value.

#### How to Receive Silent Push Messages

<script src="https://gist.github.com/sfmc-mobilepushsdk/3f0fa4278111b0d6a974.js"></script>
