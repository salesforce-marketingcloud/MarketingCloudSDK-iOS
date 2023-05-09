---
layout: page
title: "Development / Xcode"
subtitle: "Test Your Setup: Send a Push"
category: testing-push
date: 2019-08-01 12:00:00
order: 1
---

#### MobilePush SDK Setup

Before you send a push notification to your device as a test, complete all of the **Get Started** steps:

1. [Provision for Push]({{ site.baseurl }}/get-started/get-started-provision.html)
1. [Setup Push Apps]({{ site.baseurl }}/get-started/get-started-setupapps.html)
1. [Add the SDK]({{ site.baseurl }}/get-started/get-started-addsdk.html)
1. [Configure the SDK]({{ site.baseurl }}/get-started/get-started-configuresdk.html)
1. [Configure for Push]({{ site.baseurl }}/get-started/get-started-configureforpush.html)

> Use a device to test. You can use an iOS simulator for testing some aspects of the SDK, but the simulator cannot receive push notifications.

#### Xcode Setup

1. Attach a device to your Mac and select the device in your active scheme.
2. Build and run your application on your device.

#### Configure the SDK for Development

5. In your configuration of the SDK, use the MobilePush application values created in the steps above.
6. Set a temporary [contact key]({{ site.baseurl }}/sdk-implementation/user-data.html) in your app for testing. For example, use an email address. This allows you to target the device you are testing on when sending the test push.
7. Build and run your application on your connected device.

    > It may take up to {{ site.propagationDelay }} for your contact to be created in Marketing Cloud

{% include tabbed_gists.html sectionId="test_push_dev" names="8.x,7.x" gists="https://gist.github.com/stopczewska/39086ae9914cb687cdf40a3ba59d99bd.js,https://gist.github.com/sfmc-mobilepushsdk/26263f30ab936037e110e191f5514a44.js" %}

#### Send a Test Push

1. In MobilePush in Marketing Cloud, create a [filtered list](https://help.salesforce.com/articleView?id=mc_mp_create_filtered_list.htm&type=5) that targets the contact key you set as in the example above.

    > When creating the filter criteria, use the Contact Key attribute. Find this attribute under System Data > Contact > Contact Key., Set the attribute equal to the contact key in your iOS app.

    > It may take up to five minutes for the contact created by your app to show up in the filtered list. Refresh the list until the new contact is returned before proceeding to the next step.

1. In MobilePush in Marketing Cloud, [create a test message and send it](https://help.salesforce.com/articleView?id=mc_mp_outbound_message.htm&type=5) to your newly created filtered list.


#### Troubleshooting

- If the push notification doesn’t arrive on the device, check the filtered list to confirm that the contact’s status is Opted In.
- If the contact is not opted in, check that you exactly followed the steps to set up the call to config and the other [integration steps]({{ site.baseurl }}/get-started/apple.html).
- Verify that the app settings in MobilePush match those you are using to configure the SDK.
- For further diagnostic steps, see our [Troubleshooting Push Setup]({{ site.baseurl }}/trouble/ios-debugging.html).
