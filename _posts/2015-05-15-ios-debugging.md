---
layout: page
title: "iOS Debugging"
subtitle: "iOS Debugging"
category: trouble
date: 2015-05-14 12:00:00
order: 1
---
The MarketingCloudSDK.framework uses extensive internal logging to record actions taken by the SDK to informational and diagnostic purposes.

General, default-level logging is enabled at all times. Additionally, the SDK writes error and fault-level logs when conditions occur which must be recorded.

Enable debug-level logging after configuration using this call.

<script src="https://gist.github.com/sfmc-mobilepushsdk/e952d4f8272e3b926f7eaa20031359aa.js"></script>

<script src="https://gist.github.com/sfmc-mobilepushsdk/0bd9cdf402145e97136a222bbcad426d.js"></script>

Query the state of debug-level logging using this call.

<script src="https://gist.github.com/sfmc-mobilepushsdk/7670d9404859b1a758c775e1add602a9.js"></script>

<script src="https://gist.github.com/sfmc-mobilepushsdk/0663b6b494a586e86228b878673a97e5.js"></script>

We send all logging output to Apple's unified logging system. Read this information using Xcode's “Devices and Simulators” window or the macOS Console application. When SDK debug logging is enabled, the SDK uses the *OS_LOG_TYPE_DEBUG* value. Make sure to disable logging in your application for release builds to the Apple App Store.

Review Apple documentation for more information about [unified logging](https://developer.apple.com/documentation/os/logging?language=objc).

#### Device Token

For testing and troubleshooting purposes, retrieve your device token from a running app by calling [[MarketingCloudSDK sharedInstance] sfmc_deviceToken] and sending the result to yourself via email, alert, or other method.

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

#### Add debugging statements to the log

You can toggle the SDK logging facility by including the following lines in your code:

<script src="https://gist.github.com/sfmc-mobilepushsdk/9d9f0a6e38f66e637871fcbdeffef9bb.js"></script>

<script src="https://gist.github.com/sfmc-mobilepushsdk/0e519d3566a62c340f4708464bda77ea.js"></script>

#### Add SDK State information to log

For a complete list of information that the SDK has and it's current state, you can implement getSDKState() as follows:

{% include gist.html sectionId="getsdkstate" names="Obj-C,Swift" gists="https://gist.github.com/sfmc-mobilepushsdk/9275c899342cb46ea4f9f6367bfd7f92.js,https://gist.github.com/sfmc-mobilepushsdk/c5b95248b98586894e68e70dbdcbbf3b.js" %}


The SDK will output a JSON string like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/7d1961dd86d5dbde2552293490257505.js"></script>
