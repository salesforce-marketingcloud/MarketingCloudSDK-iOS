---
layout: page
title: "Rich Notifications"
subtitle: "Send Rich Notifications"
category: push-notifications
date: 2017-10-04 12:00:00
order: 4
---

## Prerequisites

* Make sure that your iOS app is built for iOS 10 or 11.
* Include a service extension for your app that can handle mutable content. See [Apple’s documentation](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ModifyingNotifications.html).
* Update to version 4.9.6 or higher of the Journey Builder for Apps (JB4A) SDK, which supports iOS 10.
* Make sure that your app is registered for push notifications via the MarketingCloudSDK.

Rich notifications include images, videos, titles and subtitles from the MobilePush app, and mutable content. Mutable content can include personalization in the title, subtitle, or body of your message. Use Xcode 9 from Apple to create a Notification Service Extension in your application project.

1. Click **File**.
1. Click **New**.
1. Click **Target**.
1. Select Notification Service Extension.
1. Name and save the new extension.

> Note: Notification Target must be signed by the same XCode Managed Profile as the main project.

## Service Extension Example

This service extension checks for a "&#95;mediaUrl" element in request.content.userInfo.  If found, the extension attempts to download the media from the URL , creates a thumbnail-size version, and then adds the attachment. The service extension also checks for a ""&#95;mediaAlt" element in request.content.userInfo.  If found, the service extension uses the element for the body text if there are any problems downloading or creating the media attachment.

A service extension can timeout when it is unable to download.  In this code sample, the service extension delivers the original content with the body text changed to the value in "&#95;mediaAlt".

<script src="https://gist.github.com/10fbbfedcb518a88249fcb54e23cb83a.js"></script>
