---
layout: page
title: "Data Protection and Privacy"
subtitle: "Data Protection and Privacy"
category: sdk-implementation
date: 2018-03-22 12:00:00
order: 1
---
These changes assist you in preparing for data compliance regulations, such as the European Union's General Data Protection Regulation. For a full overview of Salesforce's approach to managing compliance, visit our [comprehensive page regarding GDPR](https://www.salesforce.com/gdpr/overview/).

The MobilePush SDK supports three privacy modes that may affect your application's usage of MobilePush.
1. Right to be Forgotten
1. Restriction of Processing
1. Do Not Track

Each mode restricts the functionality of the MobilePush SDK and may limit your customers' experience.

## Right to be Forgotten
Use this mode when a contact requests that you remove all data related to them from Marketing Cloud. This mode marks a contact, identified by the SDK's [contact key string]({{ site.baseurl }}/sdk-implementation/user-data.html), as forgotten. This setting prevents Marketing Cloud marketing activities from storing data or interacting with the contact for marketing activities. Marketing Cloud servers host this status. This suppression lasts for a period of 14 days. After this time period elapses, Marketing Cloud permanently deletes all contact data.

### What Happens in the SDK?
The MobilePush SDK takes actions to restrict all functionality after it receives the first Right to be Forgotten mode change for a contact from the server, either via a silent push notification or when your application comes to the foreground.

This mode completely disables these functions for the lifecycle of your application regarding this contact.

* Push notifications
* Analytics tracking
* Inbox
* Geofence and beacon messaging
* Configuration changes
* In-App Messaging

For your contact to use Marketing Cloud services again, they must delete and reinstall your application on their mobile device. The MobilePush SDK must then be configured for usage by that contact.

## Restriction of Processing
This mode marks a contact, identified by the SDK's [contact key string]({{ site.baseurl }}/sdk-implementation/user-data.html), as restricted from processing. This mode restricts all data operations for that contact.

* Modifying information
* Deleting information
* Changing registration state
* Sending pushes
* Creating inbox messages
* Processing Analytics

### What Happens in the SDK?
The MobilePush SDK takes actions to restrict all functionality once it receives a Restriction of Processing mode change for a contact from the server.

This mode completely disables this functionality when the contact is in a restricted state.

* Push notifications
* Analytics tracking
* Inbox
* Geofence and beacon messaging
* Configuration changes
* In-App Messaging

If the contact moves off the restriction state and is again usable, the SDK receives a notification of the change in state, either via a silent push notification or when your application comes to the foreground. This change automatically reconfigures the SDK for use, based on your last-used configuration settings.

## Do Not Track
This mode marks a contact, identified by the SDK's [contact key string]({{ site.baseurl }}/sdk-implementation/user-data.html), as restricted from tracking activities. This setting restricts certain data operations that collect or act upon personally identifiable information (PII).

### What Happens in the SDK?
If a contact has been moved to Do Not Track, the MobilePush SDK takes actions to restrict functionality after it receives the first change in mode from the server, either via a silent push notification or when your application comes to the foreground.

This mode completely disables behavioral analytic tracking, and geofence and beacon messaging while Do Not Track is enabled. Behavioral analytic tracking includes these events.

* User events
* Message open events
* App open and close events
* In-App Message events

Push notifications and Inbox functionality continue to work. The SDK can also continue to change registration attributes, such as tags and attributes.

If the contact moves out of the Do Not Track state, the SDK receives notification of the change in state, either via a silent push notification or when your application comes to the foreground. This change automatically reconfigures the SDK for use, based on your last-used configuration settings.

## How to Prepare?
To prepare your application for data privacy compliance, implement the April 2018 version or newer of the MobilePush SDKs as soon as possible.

### Android
* Ensure that you implement version 5.5.0 or above of the Marketing Cloud MobilePush SDK. This version of the SDK uses the necessary underlying architecture to enable data compliance functionality.

### iOS
* Ensure that you implement version 5.1.0 or above of the Marketing Cloud MobilePush SDK. This version of the SDK uses the necessary underlying architecture to enable data compliance functionality.
* Enable background refresh in your application to assure the best opportunity for silent push notification delivery for seamless mode enablement. Review the [iOS SDK documentation]({{ site.baseurl }}) for more details.
