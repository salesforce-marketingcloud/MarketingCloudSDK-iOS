---
layout: page
title: "CloudPage Alert Overview"
subtitle: "Implement CloudPage functionality in Your Mobile App"
category: inbox
date: 2015-05-14 12:00:00
order: 2
published: false
---

The CloudPage Inbox customized push message (Alert+Inbox) contains a URL in the payload. Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage push messages.

Enable inbox in your configuration file using the inbox:true value.

The MarketingCloudSDK can pass this URL to your application to handle according to your custom needs.

See [Handling URLs]({{ site.baseurl }}/sdk-implementation/implementation-urlhandling.html) for more information.

