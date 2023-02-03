---
layout: page
title: "4. Configure the SDK"
subtitle: "Configure the SDK"
category: get-started
date: 2019-08-02 12:00:00
order: 4
published: true
---

## Configure the SDK

#### See the SDK header MarketingCloudSDK/MarketingCloudSDK+Base.h ([AppleDoc](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledocs/MarketingCloudSdk/7.6/Classes/MarketingCloudSDK.html)) for detailed documentation on SDK configuration methods.

This example uses the MarketingCloudSDK [ConfigBuilder](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledocs/SFMCSdk/8.0/Classes/ConfigBuilder.html#/c:@M@SFMCSDK@objc(cs)SFMCSdkConfigBuilder(im)setPushWithConfig:onCompletion:) configuration method, as it is the most flexible means to support your application's usage of MobilePush.

> Configuration of the SDK using a JSON file (included in our [GitHub repository](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS)) is **deprecated**. We encourage you to move existing implementations to the builder method. For more information on our configuration methods, see the [AppleDoc](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledocs/MarketingCloudSdk/8.0/Classes/PushModule.html)).

> All method names contain the prefix `sfmc_`. This convention allows the application implementing the SDK to avoid namespace collisions between the external libraries it uses. MarketingCloudSDK does not cause compile, link, or runtime collisions with other code your application implements. Review Apple’s [documentation on customizing existing classes](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW4) for further information.

1. Using the `Access Token`, `App ID`, `App Endpoint`, and `MID` values noted when you [Setup Push Apps]({{ site.baseurl }}/get-started/get-started-setupapps.html), configure the SDK in your application.

{% include tabbed_gists.html sectionId="configure_the_sdk" names="8.x,7.x" gists="https://gist.github.com/stopczewska/4f58a460e42ca7fc4eb2f9aca8b9db03.js,https://gist.github.com/018c4f6f89501a4599031a701563441b.js" %}

1. Enable or disable `analytics`, `location`, or `inbox` entries depending on the unique needs of your application and your usage of Marketing Cloud.

Note: iOS Data Protection affects the SDK as follows:
1. No protection - SDK works in foreground & background
2. Complete until first user authentication - SDK works in foreground & background after 1st unlock.
3. Complete unless open - SDK works in foreground & background after 1st unlock.
4. Complete - SDK works only in the forground after the device is unlocked.


### Next Steps

[Configure for Push]({{ site.baseurl }}/get-started/get-started-configureforpush.html)
