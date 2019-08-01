---
layout: page
title: "Development / Xcode"
subtitle: "Test Your Setup: Send a Push"
category: testing-push
date: 2019-08-01 12:00:00
order: 1
---
Before you send a push notification to your device as a test, complete all of the [steps to set up the SDK]({{ site.baseurl }}/get-started/apple.html).
> Use a device to test. You can use an iOS simulator for testing some aspects of the SDK, but the simulator does not receive push notifications as part of the testing process.

1. Verify that your app is built appropriately for the type of push certificate you uploaded to Marketing Cloud.
  - If you set up the app in Marketing Cloud with an Apple Production certificate, build your app for distribution. Examples include Ad Hoc, TestFlight, and Enterprise.
  - If you set up the app in Marketing Cloud with a Development Certificate, build your app for development. An example is Debug.
1. Set a temporary [contact key]({{ site.baseurl }}/sdk-implementation/user-data.html) in your app for testing. For example, use an email address. This allows you to target the device you are testing on when sending the test push.
1. In MobilePush in Marketing Cloud, create a [filtered list](https://help.salesforce.com/articleView?id=mc_mp_create_filtered_list.htm&type=5) that targets the contact key you set.
  - Tip: When creating the filter criteria, use the Contact Key attribute. Find this attribute under System Data > Contact > Contact Key., Set the attribute equal to the contact key in your iOS app.
  - Tip: It may take up to five minutes for the contact created by your app to show up in the filtered list. Refresh the list until the new contact is returned before proceeding to the next step.
1. In MobilePush in Marketing Cloud, [create a test message and send it](https://help.salesforce.com/articleView?id=mc_mp_outbound_message.htm&type=5) to your newly created filtered list.
<br/>
> Troubleshooting: If the push notification doesn’t arrive on the device, check the filtered list to confirm that the contact’s status is Opted In. If the contact is not opted in, check that you exactly followed the steps to set up the call to config and the other [integration steps]({{ site.baseurl }}/get-started/apple.html). Also check that the app is built appropriately for the type of push certificate you uploaded to Marketing Cloud.
