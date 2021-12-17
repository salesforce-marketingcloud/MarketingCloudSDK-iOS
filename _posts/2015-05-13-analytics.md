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

{% include tabbed_gists.html sectionId="track_push_notification" names="8.x,7.x" gists="https://gist.github.com/stopczewska/6f9a29807dddd3657243d852aa5a9fda.js,https://gist.github.com/cb216623a751e16a42a94b09cf666190.js" %}

## TRACK INBOX MESSAGE OPENS

You can also track analytics for Inbox messages. Call trackInboxOpenEvent() to send the open analytic value to Marketing Cloud. We automatically provide analytic information for message downloads. Call sfmc_trackMessageOpened: with an inbox message dictionary to record the analytic.

{% include tabbed_gists.html sectionId="track_inbox_msg_open" names="8.x,7.x" gists="https://gist.github.com/stopczewska/e67a341b0590e0dd3164a5ae2e448aac.js,https://gist.github.com/328c8e3c3b3738e009dda2047b8c9c40.js" %}
