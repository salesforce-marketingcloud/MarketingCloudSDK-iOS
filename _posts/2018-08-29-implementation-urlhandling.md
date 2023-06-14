---
layout: page
title: "Handle URLs"
subtitle: "Handle Messages with a URL"
category: sdk-implementation
date: 2018-08-29 12:00:00
order: 3
---

The SDK doesn’t automatically present URLs from these sources.
* CloudPage URLs from push notifications
* OpenDirect URLs from push notifications
* CloudPage URLs from inbox messages using the built-in `UITableView` delegate

To handle URLs from these sources, follow these instructions.

1. Implement the `URLHandlingDelegate` (v8.x) or `MarketingCloudSDKURLHandlingDelegate` (v7.x) protocol in your app.
2. Use the `sfmc_setURLHandlingDelegate:` method to set a delegate for this protocol.

The `URLHandlingDelegate` (v8.x) or `MarketingCloudSDKURLHandlingDelegate` (v7.x) is set using `sfmc_setURLHandlingDelegate:` method. This enforces the protocol method `sfmc_handleURL:type:`. When an OpenDirect or CloudPage push notification is received, the SDK passes an `NSURL` value to `sfmc_handleURL:type:`. This value contains the push notification or inbox message, and includes the URL. A type value also reflects the source of the URL, which is either `SFMCURLTypeCloudPage` or `SFMCURLTypeOpenDirect`.

> The class that implements the `URLHandlingDelegate` (v8.x) or `MarketingCloudSDKURLHandlingDelegate` (v7.x) delegate must be Objective-C compatible.

> See `MarketingCloudSDK+URLHandling.h` for more information.

## Examples

{% include tabbed_gists.html sectionId="url_handling" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/3584f70fa52bef0788e93895baf1880f.js,https://gist.github.com/sfmc-mobilepushsdk/80bf2165a5f3e0ebf11c4a3111437238.js" %}
