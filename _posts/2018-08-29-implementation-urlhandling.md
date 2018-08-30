---
layout: page
title: "URL Handling"
subtitle: "Messages with a URL"
category: sdk-implementation
date: 2018-08-29 12:00:00
order: 10
---

> The SDK does not automatically preset CloudPage or OpenDirect URLs when handling a push notification, nor does it present the CloudPage associated with an Inbox message when using the built-in UITableView delegate.

In order to handle URLs from the above sources, the application must implement the `MarketingCloudSDKURLHandlingDelegate` protocol and set a delegate for this protocol via the `sfmc_setURLHandlingDelegate:` method.

Implementing the protocol method `sfmc_handleURL:type:`, along with setting the delegate for the SDK, will result in the SDK calling the delegate method upon handling of a push notification with a CloudPage or OpenDirect link or if your Inbox uses the built-in UITableView delegate.

The SDK will pass your implementation of `sfmc_handleURL:type:` a NSURL value containing the URL in the message (push notification or inbox) data. Additionally, a type value will reflect the source of the URL (`SFMCURLTypeCloudPage` or `SFMCURLTypeOpenDirect`).

See `MarketingCloudSDK+URLHandling.h` for more information.

Examples and use cases:

<script src="https://gist.github.com/sfmc-mobilepushsdk/d9f3ef00c2678aced1d4e19acbc66b02.js"></script>

<script src="https://gist.github.com/sfmc-mobilepushsdk/1b58f9577d22daa4467609263b56d922.js"></script>