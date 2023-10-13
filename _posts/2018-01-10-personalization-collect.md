---
layout: page
title: "Einstein Recommendations and Collect API Integration"
subtitle: "Integrate Einstein Recommendations and Collect API"
category: analytics
date: 2018-01-10 12:00:00
order: 2
---

### Analytic Attribution

Einstein Recommendations analytics uses an unique identifier to attribute collected analytics to a specific user. By default, the SDK uses the contact key as this identifier, called the PIID. Your app can explicitly set this value.

The Mobile Push SDK has an optional configuration option called useLegacyPiIdentifier. This option replaces an absent or empty PIID with the MobilePush contact key. If this configuration option is false, the SDK doesn’t replace an absent or empty PIID. Review [Configure the SDK]({{ site.baseurl }}/get-started/get-started-configuresdk.html) to configure the SDK with pianalytics and useLegacyPiIdentifier.

> **Important:** To ensure future compatibility, we recommend explicitly setting the PIID. The useLegacyPiIdentifier configuration option will be deprecated in a future release.

#### Example: Analytic Attribution

{% include tabbed_gists.html sectionId="analytics_attribution" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/f7fb1f5cd1456f8b02f05091a3ac29ea.js,https://gist.github.com/8c9d0186ce37fb00aff742880bcbab08.js" %}

### Integration Methods

These methods integrate your mobile app with Einstein Recommendations. To use the methods, you must have an existing [Einstein Recommendations](http://help.marketingcloud.com/en/documentation/personalization_builder) deployment, and you must enable the "pianalytics" option when you configure your SDK.

#### Track Cart

To track the contents of an in-app shopping cart, use the method shown in the example. For more information about this method’s general use with Einstein Recommendations, review [Track Items in Shopping Cart](https://help.salesforce.com/articleView?id=mc_ctc_track_cart.htm&type=5).

{% include tabbed_gists.html sectionId="track_cart" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/37083c88472c4f3ce969f8e5d4175e9b.js,https://gist.github.com/0f6d9da815f4799dccdeb4fce13bf77c.js" %}

#### Track Conversion

To track a purchase made through your mobile app, use the method shown in the example. For more information about this method’s general use with Einstein Recommendations, review [Track Purchase Details](https://help.salesforce.com/articleView?id=mc_ctc_track_conversion.htm&type=5).

{% include tabbed_gists.html sectionId="track_conversion" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/b1f9950be668c85effbd18af5a38826c.js,https://gist.github.com/2e0a5c806024da20f4b0abfc77d05957.js" %}

#### Track Page Views

To implement page-view analytics in your app, use the method shown in the example. For more information about this method’s general use with Einstein Recommendations, review [Track Items Viewed](https://help.salesforce.com/articleView?id=mc_ctc_track_page_view.htm&type=5).

{% include tabbed_gists.html sectionId="track_page_view" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/ee8097154695ddf3f353350f7dca29a6.js,https://gist.github.com/63511dd483bd521dbeb3b46fbece001a.js" %}

> Rights of ALBERT EINSTEIN are used with permission of The Hebrew University of Jerusalem. Represented exclusively by Greenlight.

### Related Items
* _MarketingCloudSDK+Intelligence.h_
