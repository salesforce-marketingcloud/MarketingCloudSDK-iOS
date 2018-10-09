---
layout: page
title: "Personalization Builder and Collect API Integration"
subtitle: "Integrate Personalization Builder and Collect API"
category: analytics
date: 2018-01-10 12:00:00
order: 2
---

The following methods integrate your mobile app with Personalization Builder. You must have an existing [Personalization Builder](http://help.marketingcloud.com/en/documentation/personalization_builder) deployment in order to use these. Also, you must enable the "PiAnalytics" option when you configure your SDK.

> NOTE: The Mobile Push SDK has an optional configuration value: useLegacyPiIdentifier. This allows you to control whether you wish to replace an absent/empty Predictive Intelligence Identifier with existing records information, in this case: contactKey. Should this configuration be FALSE, no replacement will occur.

> WARNING: useLegacyPiIdentifier: This configuration option will be deprecated in a future release. It is recommended that you explicitly set the Predictive Intelligence identifier for future compatibility.

> NOTE: If the Predictive Intelligence Identifier is not set or null and the SDK is configured to use the Legacy PI Identifier then the SDK will automatically send the Contact Key as the PIID.

## Predictive Intelligence Identifier

Predictive Intelligence analytics use an unique identifier to properly attribute collected analytics to a given user. The SDK, by default, uses the Contact Key as the PIID. This value may be explicitly set by your application. 
<script src="https://gist.github.com/c8de13c1b560a19def8bc2d63a2f061c.js"></script>
To clear the value, you can pass in a nil value. 
<script src="https://gist.github.com/8c9d0186ce37fb00aff742880bcbab08.js"></script>


## Track Cart

Use to track the contents of an in-app shopping cart. For more information about this method’s general use with Personalization Builder, see [Track Items in Shopping Cart](https://help.salesforce.com/articleView?id=mc_ctc_track_cart.htm&type=5). Review this sample code for use in your mobile app.
<script src="https://gist.github.com/55cb5aca932689cf9e2935c6980beabe.js"></script>
<script src="https://gist.github.com/0f6d9da815f4799dccdeb4fce13bf77c.js"></script>

## Track Conversion

Use to track a purchase made through your mobile application. For more information about this method’s general use with Personalization Builder, see [Track Purchase Details](https://help.salesforce.com/articleView?id=mc_ctc_track_conversion.htm&type=5). Review this sample code for use in your mobile app.
<script src="https://gist.github.com/6e9ed834a2645463f267ac1c497bb611.js"></script>
<script src="https://gist.github.com/2e0a5c806024da20f4b0abfc77d05957.js"></script>

## Track Page View

Call this method to implement page view analytics in your app. For more information about this method’s general use with Personalization Builder, see [Track Items Viewed](https://help.salesforce.com/articleView?id=mc_ctc_track_page_view.htm&type=5). Sample code for use in your mobile app is below.
<script src="https://gist.github.com/e605564bd235b85255b9c1460f84a8b7.js"></script>
<script src="https://gist.github.com/63511dd483bd521dbeb3b46fbece001a.js"></script>
See MarketingCloudSDK+Intelligence.h for more information.
