---
layout: page
title: "CloudPage Alert Overview"
subtitle: "Implement CloudPage functionality in Your Mobile App"
category: inbox
date: 2015-05-14 12:00:00
order: 2
---

The CloudPage Inbox customized push message (Alert+Inbox) contains a URL in the payload. Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage push messages.

Enable inbox in your configuration file using the inbox:true value.

The MarketingCloudSDK opens this URL when the message is tapped using a SFSafariViewController.

Override the built-in web view handling of the OpenDirect URL by implementing the MarketingCloudSDKInboxMessagesNotificationHandlerDelegate protocol.

In the class that handles the override, make sure to adhere to the protocol. Use this AppDelegate sample as an example.

<script src="https://gist.github.com/0f39ddd4004118bfee64f2d53c68c88e.js"></script>
<script src="https://gist.github.com/22e93c290c396452f2d12b64e23f2702.js"></script>
Somewhere in the class that implements this protocol, set the SDK's delegate handler.
<script src="https://gist.github.com/18f5292e1fefc3ebdff61cf13757b668.js"></script>
<script src="https://gist.github.com/c534c46e9e9d7f40dec68e1a23bb6fb0.js"></script>
Next, implement the required protocol methods to override the built-in functionality.
<script src="https://gist.github.com/cb67e790b18a9f37632c845d7f03514d.js"></script>
<script src="https://gist.github.com/a25998c1062819d1bc3851c17de191d4.js"></script>

See MarketingCloudSDK+InboxMessages.h for more information.
