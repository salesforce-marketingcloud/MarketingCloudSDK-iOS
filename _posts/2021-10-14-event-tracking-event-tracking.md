---
layout: page
title: "Mobile App Event Tracking"
subtitle: "Mobile App Event Tracking"
category: event-tracking
date: 2021-10-14 12:00:00
order: 0
published: true
---

# Mobile App Event Tracking (For 8.x)

With v8 onwards of the MobilePush SDK, you can track analytic events about end users’ actions with the app. Your app calls new methods in the MobilePush SDK to track events. These events can be used to orchestrate journeys or trigger in-app messages based on real-time user behavior.

To start tracking events, ensure that you are on the v8 and above of the SDK. See [Migration]({{ site.baseurl }}/get-started/get-started-migration.html)

## Implement Event Tracking

A tracked event consists of the event name and event attributes (optional parameters). Your app builds an event object based on your business requirements and then passes it to the MobilePush SDK. Ensure that the event implemented in the SDK is identical to the event defined in the Marketing Cloud UI.

### Create the event

```swift
let event = CustomEvent(name: "EventName", attributes: ["key1": "value1", "key2": "value2"])
```

### Track the event

```swift
SFMCSdk.track(event: CustomEvent(name: "EventName", attributes: ["key": "value"])!)
```
