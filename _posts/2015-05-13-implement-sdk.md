---
layout: page
title: "Implement and Configure SDK"
subtitle: "Implement and Configure the SDK in your iOS App"
category: get-started
date: 2015-05-14 12:00:00
order: 3
---
To implement the MarketingCloudSDK framework in your application, use either CocoaPods or a manual setup of the SDK.

## Implement the SDK with CocoaPods

Follow the [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) using **MarketingCloudSDK** as a dependency in the podfile. Open up the .xcworkspace created by the install process with Xcode and start using the SDK.

Do **NOT** use .xcodeproj. An error occurs if you open up a project file instead of a workspace.

## Implement the SDK Manually

1. [Download the SDK]({{site.codeurl}}).
1. Copy the MarketingCloudSDK directory from your download to your project directory
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure1.png" /><br/>
1. Open your application project and select the appropriate target.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure2.png" /><br/>
1. Add MarketingCloudSDK.framework to Linked Frameworks and Libraries in your target's General settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure3.png" /><br/>
1. Add MarketingCloudSDK.bundle to Copy Bundle Resources in your target's Build Phases settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure4.png" /><br/>
1. Add -ObjC to your target's Other Linker Flags build settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure5.png" /><br/>

> [Review additional information about this linker flag](https://developer.apple.com/library/content/qa/qa1490/_index.html)

## Configure the SDK

MarketingCloudSDK framework via a JSON file added to your application. This file contains the parameters unique to your application and feature needs. The MarketingCloudSDK framework reads the values within this file and completes its configuration based on these settings.

1. Add MarketingCloudSDKConfiguration.json to Copy Bundle Resources in your target's Build Phases settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure6.png" /><br/>
1. Change the *appid* and *accesstoken* values to match the information from your Marketing Cloud account when you configured your application. These values represent the unique paring of this iOS application with the Marketing Cloud account used for MobilePush.
1. Enable or disable *analytics*, *location*, or *inbox* entries depending on the unique needs of your application and your usage of Marketing Cloud.
> Marketing Cloud and the Mobile Push MarketingCloudSDK framework support push notifications.
1. To implement push notification handling in your application, ensure you created an APNS Push Certificate in the Apple developer portal and added that to your Marketing Cloud account. Make sure that you added the push notifications feature to your application in the Apple developer portal. Enable push notifications in  your target's Capabilities settings.
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure7.png" /><br/>
> When implementing the MarketingCloudSDK framework, note that all method names contain the prefix *sfmc_*. This convention allows the application implementing the SDK to protect against the possibility of namespace collisions between external libraries it may use. We've taken every precaution to ensure that MarketingCloudSDK does not cause compile, link, or runtime collisions with other code your application may implement. Review Apple's [documentation on customizing existing classes](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html#//apple_ref/doc/uid/TP40011210-CH6-SW4) for further information.
1. In your application delegate, import the framework header to enable MarketingCloudSDK functionality.
<script src="https://gist.github.com/1fd881bd6bd0b81fc53fac4763d758ba.js"></script>
<script src="https://gist.github.com/e98010d99755e03fa470b7f6bea2522e.js"></script>
1. In your application delegate class, add these sections of code to ensure that your application registers for and handles push notifications. Set your AppDelegate class to adhere to the UNUserNotificationCenterDelegate protocol.
<script src="https://gist.github.com/de3ba047a63c27ec8d88fc8e6eaa4f5d.js"></script>
<script src="https://gist.github.com/88c8b6247e1e1cdce48a19dc0c19e304.js"></script>

1. In your application delegate method *-application:didFinishLaunchingWithOptions:*, create an instance of the MarketingCloudSDK and configure it for use, setting the push delegate and requesting push authorization. Only init or configure in didFinishingLaunching.
<script src="https://gist.github.com/1770c3d15eff943946ba254203d9ae87.js"></script>
<script src="https://gist.github.com/9cdc6399bd6adf576371d5a5cc512b71.js"></script>

Configuration of the MarketingCloudSDK includes a synchronous return of the BOOL return value and asynchronous process to complete configuration. We recommend your application rely on the *success* and *error* values returned in the *completionHandler* to verify successful configuration. The *MarketingCloudSDK+Base.h* header file details additional methods for configuration.

Add the required delegate methods to support push notifications to your AppDelegate class.

These methods use  MarketingCloudSDK methods to enable the framework's functionality to manage push notifications, which includes MobilePush contact registration and push analytics tracking.

If the methods below are implemented *without* using the MarketingCloudSDK methods as shown, MobilePush functionality does not work as expected. If the methods below are not implemented, MobilePush functionality **will not** work as expected.

<script src="https://gist.github.com/948f26f2acf00add2655885e3ec5d1aa.js"></script>
<script src="https://gist.github.com/14a82bd3208be864e0ace803e7d6632f.js"></script>
