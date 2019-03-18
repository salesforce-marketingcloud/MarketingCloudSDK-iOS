---
layout: page
title: "Handle URLs"
subtitle: "Handle Messages with a URL"
category: sdk-implementation
date: 2018-08-29 12:00:00
order: 7
---

The SDK doesn’t automatically present URLs from these sources.
* CloudPage URLs from push notifications
* OpenDirect URLs from push notifications
* CloudPage URLs from inbox messages using the built-in `UITableView` delegate

To handle URLs from these sources, follow these instructions.

1. Implement the `MarketingCloudSDKURLHandlingDelegate` protocol in your app.
1. Use the `sfmc_setURLHandlingDelegate:` method to set a delegate for this protocol.

> If you implement the `sfmc_handleURL:type:` protocol method and set `MarketingCloudSDKURLHandlingDelegate`, the SDK calls the `sfmc_setURLHandlingDelegate:` method. The SDK passes to your implementation of `sfmc_handleURL:type:` an NSURL value. This value contains the data of the push notification or inbox message, including the URL. A type value also reflects the source of the URL, either `SFMCURLTypeCloudPage` or `SFMCURLTypeOpenDirect`.

> See `MarketingCloudSDK+URLHandling.h` for more information.

## Examples

{% include gist.html sectionId="attributes_set" names="Obj-C,Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/d9f3ef00c2678aced1d4e19acbc66b02.js,https://gist.github.com/sfmc-mobilepushsdk/1b58f9577d22daa4467609263b56d922.js" %}
