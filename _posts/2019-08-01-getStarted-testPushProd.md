---
layout: page
title: "Production / Distribution"
subtitle: "Test Your Setup: Send a Push"
category: testing-push
date: 2019-08-01 12:00:00
order: 2
---

#### SDK Setup

Before you send a push notification to your deployment app, complete all of the [steps to set up the SDK]({{ site.baseurl }}/get-started/apple.html).

> Use a device to test. You can use an iOS simulator for testing some aspects of the SDK, but the simulator cannot receive push notifications.

#### App Build Setup

1. Provision your app for Ad Hoc or App Store distribution. See [Apple's docs](https://developer.apple.com/support/code-signing/) for more information.
2. Archive your application and prepare it for distribution through tools like TestFlight, Fabric, or HockeyApp.

#### MobilePush Setup

4. Following [Apple’s instructions](https://help.apple.com/developer-account/#/dev82a71386a), create an **Apple Push Notification service SSL (Sandbox & Production)** certificate. This type of certificate is used to send pushes through Apple’s production push environment, which allows you to receive pushes in your production configuration. The .p12 file resulting from this step will be used in creating your Marketing Cloud MobilePush app in the next step.

    > Note: You *must* select "Apple Push Notification service SSL (Sandbox & Production)" for this step.
    
    > Note: Do *not* select "iOS Apple Push Notification service SSL (Sandbox)" for this step.
    
4. Log in to [Marketing Cloud MobilePush](https://mc.exacttarget.com/cloud/#app/MobilePush/MobilePush/) and select the "Administration" tab.
- On the app settings screen, under *APNS Client*, upload the .p12 file created in the steps above. Enter the .p12 file password in the text field.
- Note and copy the `Access Token`, `App ID` and `App Endpoint`. These values will be used to configure the SDK for production testing.
- Save your settings.

> If you **do not** have a MobilePush app created in Marketing Cloud, click “Create New App” in "Administration" to create an MobilePush app. Save and continue, and follow the instructions above. Suggestion for name: `[product]_PROD-APNS`.

#### Configure the SDK for Production

5. In your configuration of the SDK, use the MobilePush application values created in the steps above.
7. Archive and distribute your application (Ad Hoc and/or App Store).

    > This example uses the MobilePush SDK [ConfigBuilder ](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledoc/Classes/MarketingCloudSDK.html#//api/name/sfmc_configureWithDictionary:error:) configuration, as it is the most flexible means to support your debug environment.
    
    > If using the JSON configuration file, see [Handle Multiple Configurations]({{ site.baseurl }}/sdk-implementation/business-unit-switching.html) for an example of switching between multiple configurations.

    > It may take up to 5 minutes for your contact to be created in Marketing Cloud
    
{% include gist.html sectionId="221_ios_getStartedDevConfigure" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/26263f30ab936037e110e191f5514a44.js" %}

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
