---
layout: page
title: "Analytics"
subtitle: "Add Analytics"
category: analytics
date: 2015-05-14 12:00:00
order: 1
---
Enable analytics in your configuration file using the analytics:true value.

The SDK collects analytics in the background as well as when SDK methods are called.

## Track Push Notifications

To ensure proper tracking of push notifications by the SDK and Marketing Cloud analytics, call the SDK in your push notification handler method. If you do not, analytic events can’t track open counts for your push messaging campaigns.
<script src="https://gist.github.com/bbc18d768405d431b0f904c923e9e661.js"></script>

<script src="https://gist.github.com/cb216623a751e16a42a94b09cf666190.js"></script>

## TRACK INBOX MESSAGE OPENS

You can also track analytics for Inbox messages. Call trackInboxOpenEvent() to send the open analytic value to Marketing Cloud. We automatically provide analytic information for message downloads. Call sfmc_trackMessageOpened: with an inbox message dictionary to record the analytic.
<script src="https://gist.github.com/8cd1af8a76398e920d93259ea578930c.js"></script>
<script src="https://gist.github.com/328c8e3c3b3738e009dda2047b8c9c40.js"></script>