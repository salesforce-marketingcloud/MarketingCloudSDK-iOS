---
layout: page
title: "Push Setup"
subtitle: "iOS Debugging"
category: trouble
date: 2015-05-14 12:00:00
order: 1
---
The MarketingCloudSDK.framework uses extensive internal logging to record actions taken by the SDK to informational and diagnostic purposes.

General, default-level logging is enabled at all times. Additionally, the SDK writes error and fault-level logs when conditions occur which must be recorded.

Enable debug-level logging after configuration using this call.

{% include gist.html sectionId="sfmc_setDebugLoggingEnabled" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/0bd9cdf402145e97136a222bbcad426d.js" %}

Query the state of debug-level logging using this call.

{% include gist.html sectionId="sfmc_getDebugLoggingEnabled" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/0663b6b494a586e86228b878673a97e5.js" %}

We send all logging output to Apple's unified logging system. Read this information using Xcode's “Devices and Simulators” window or the macOS Console application. When SDK debug logging is enabled, the SDK uses the *OS_LOG_TYPE_DEBUG* value. Make sure to disable logging in your application for release builds to the Apple App Store.

Review Apple documentation for more information about [unified logging](https://developer.apple.com/documentation/os/logging?language=objc).

#### Device Token

For testing and troubleshooting purposes, retrieve your device token from a running app by calling `sfmc_deviceToken()` and sending the result to yourself via email, alert, or other method.

{% include gist.html sectionId="testPushDeviceToken" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/5d549d0e283ca303f293995d35ded4e7.js" %}

#### Send a test push

Test that your app can receive a push directly from APNS (Apple Push Notification Service).

- Get the push token from the SDK

{% include gist.html sectionId="sendTestPushDeviceToken" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/5d549d0e283ca303f293995d35ded4e7.js" %}

- Trigger the APNS API directly from the command line

{% include gist.html sectionId="sendTestPush" names="Shell" gists="https://gist.github.com/sfmc-mobilepushsdk/453df3208247c74b7c50bebb23d53a87.js" %}

#### Additional Resources

Use this information when testing your app and the device either does not receive messages or receives messages sporadically. Testing the app while connected to a corporate Wi-Fi network could cause issues if your IT team does not correctly configure port accessibility (preventing the test device from receiving messages).
<br/>

* <a href="https://developer.apple.com/library/ios/technotes/tn2265/_index.html" target="_blank">APNS Debugging Information</a>
* <a href="https://developer.apple.com/library/ios/technotes/tn2265/tn2265_PersistentConnectionLogging.zip" target="_blank">APNS Debugging Provisioning File</a>
* <a href="http://support.apple.com/kb/TS4264" target="_blank">APNS Port Functionality Information</a>

#### Unblock network ports

Ensure that your network team unblocks the following ports to provide communication between the moble device and APNS servers for MobilePush functionality:

* TCP port 5223 (used by devices to communicate to the APNS servers)
* TCP port 2195 (used to send notifications to the APNS servers)
* TCP port 2196 (used by the APNS feedback service)
* TCP port 443 (used as a fallback service for Wi-Fi devices when those devices cannot communicate to the APNS service on port 5223)

#### Add SDK State information to log

For a complete list of information that the SDK has and it's current state, you can implement getSDKState() as follows:

{% include gist.html sectionId="getsdkstate" names="Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/c5b95248b98586894e68e70dbdcbbf3b.js" %}


The SDK will output a JSON string like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/7d1961dd86d5dbde2552293490257505.js"></script>
