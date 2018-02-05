---
layout: page
title: "CloudPage"
subtitle: "Messages with a CloudPage URL"
category: cloudpage
date: 2018-02-05 12:00:00
order: 4
---

The CloudPage customized push message contains a URL in the payload.

The MarketingCloudSDK opens this URL when the message is tapped using a SFSafariViewController.

Override the built-in web view handling of the CloudPage URL by implementing the MarketingCloudSDKCloudPageMessagesNotificationHandlerDelegate protocol.

In the class handling the override, adhere to the protocol. For example, use this AppDelegate example as a sample.
<script src="https://gist.github.com/sfmc-mobilepushsdk/f4733b32aac0a00868a08bb8d2cf81d4.js"></script>
<script src="https://gist.github.com/sfmc-mobilepushsdk/b8ee5891ae6202794e64da64f2837774.js"></script>
Somewhere in the class implementing this protocol, set the SDK's delegate handler.
<script src="https://gist.github.com/sfmc-mobilepushsdk/fe2f95ada86319721ed7b8a446b6fd3f.js"></script>
<script src="https://gist.github.com/sfmc-mobilepushsdk/51068435b45934b06061e0856d0cb528.js"></script>
Next, implement the required protocol methods to override the built-in functionality.
<script src="https://gist.github.com/sfmc-mobilepushsdk/ee99959fc993902e34443dc3629555e2.js"></script>
<script src="https://gist.github.com/sfmc-mobilepushsdk/467731a469890edd057cb4b3b3a7090f.js"></script>
See MarketingCloudSDK+CloudPageMessages.h for more information.
