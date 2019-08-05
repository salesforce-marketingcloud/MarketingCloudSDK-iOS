---
layout: page
title: "Production / Distribution"
subtitle: "Test Your Setup: Send a Push"
category: testing-push
date: 2019-08-01 12:00:00
order: 2
---

#### MobilePush SDK Setup

Before you send a push notification to your deployment app, complete all of the **Get Started* steps:

1. [Provision for Push]({{ site.baseurl }}/get-started/get-started-provision.html)
1. [Setup Push Apps]({{ site.baseurl }}/get-started/get-started-setupapps.html)
1. [Add the SDK]({{ site.baseurl }}/get-started/get-started-addsdk.html)
1. [Configure the SDK]({{ site.baseurl }}/get-started/get-started-configuresdk.html)
1. [Configure for Push]({{ site.baseurl }}/get-started/get-started-configureforpush.html)

> Use a device to test. You can use an iOS simulator for testing some aspects of the SDK, but the simulator cannot receive push notifications.

#### App Build Setup

1. Provision your app for Ad Hoc or App Store distribution. See [Apple's docs](https://developer.apple.com/support/code-signing/) for more information.
2. Archive your application and prepare it for distribution through tools like TestFlight, Fabric, or HockeyApp.

#### Configure the SDK for Production

5. In your configuration of the SDK, use the MobilePush application values created in the steps above.
7. Archive and distribute your application (Ad Hoc and/or App Store).

   > It may take up to 5 minutes for your contact to be created in Marketing Cloud

<script src="https://gist.github.com/sfmc-mobilepushsdk/26263f30ab936037e110e191f5514a44.js"></script>

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
