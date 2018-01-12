---
layout: page
title: "OpenDirect"
subtitle: "Messages with an OpenDirect URL"
category: opendirect
date: 2015-05-14 12:00:00
order: 4
---

The OpenDirect customized push message contains a URL in the payload. [Enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#openDirect) this feature in the Marketing Cloud application.

The MarketingCloudSDK opens this URL when the message is tapped using a SFSafariViewController.

Override the built-in web view handling of the OpenDirect URL by implementing the MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate protocol.

In the class handling the override, adhere to the protocol. For example, use this AppDelegate example as a sample.
<script src="https://gist.github.com/4b9d5cf31e1070da2bbfd1af110dc923.js"></script>
<script src="https://gist.github.com/2b7c49526a0a119353b17eb75db18281.js"></script>
Somewhere in the class implementing this protocol, set the SDK's delegate handler.
<script src="https://gist.github.com/1b6f6184299a451fde60a6b095648f47.js"></script>
<script src="https://gist.github.com/bdc513d57b99f929068cf05916ae44b0.js"></script>
Next, implement the required protocol methods to override the built-in functionality.
<script src="https://gist.github.com/49641ff60741cfcfcb4acc32ad4d2db6.js"></script>
<script src="https://gist.github.com/02a000c3f1a42763822f9f3ed3b37cd4.js"></script>
See MarketingCloudSDK+OpenDirectMessages.h for more information.
