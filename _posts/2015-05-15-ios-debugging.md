---
layout: page
title: "Push Setup"
subtitle: "Troubleshooting Push Setup"
category: trouble
date: 2015-05-14 12:00:00
order: 1
---
The MarketingCloudSDK.framework uses extensive internal logging to record actions taken by the SDK to informational and diagnostic purposes.

General, default-level logging is enabled at all times. Additionally, the SDK writes error and fault-level logs when conditions occur which must be recorded.

Enable logging using this call. When using version < 8.x enable it after configuration.

{% include tabbed_gists.html sectionId="enable_debug_logs" names="8.x,7.x" gists="https://gist.github.com/stopczewska/a1a56b76d0dd7cbbcbcaf19f8329079a.js,https://gist.github.com/sfmc-mobilepushsdk/0bd9cdf402145e97136a222bbcad426d.js" %}

Enable logging with a custom log outputter.

{% include tabbed_gists.html sectionId="enable_debug_logs_outputter" names="8.x" gists="https://gist.github.com/stopczewska/56754efd7ad52c9779e971aabf837508.js" %}

Enable logging with a standard log outputter and a log filter. Check Xcode autocompletion for more filtering options.

{% include tabbed_gists.html sectionId="enable_debug_logs_outputter_filter" names="8.x" gists="https://gist.github.com/stopczewska/3cc45f5c01de599939223480caff04c0.js" %}

Clear previously set filtering options

{% include tabbed_gists.html sectionId="enable_debug_logs_clear_filter" names="8.x" gists="https://gist.github.com/stopczewska/996fabe74a3fa5b471f8d4c95600ec1b.js" %}


Query the state of debug-level logging using this call.

{% include tabbed_gists.html sectionId="query_state_of_debug_log" names="7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/0663b6b494a586e86228b878673a97e5.js" %}

We send all logging output to Apple's unified logging system. Read this information using Xcode's “Devices and Simulators” window or the macOS Console application. When SDK debug logging is enabled, the SDK uses the *OS_LOG_TYPE_DEBUG* value. Make sure to disable logging in your application for release builds to the Apple App Store.

Review Apple documentation for more information about [unified logging](https://developer.apple.com/documentation/os/logging?language=objc).

#### Device Token

For testing and troubleshooting purposes, retrieve your device token from a running app by calling `sfmc_deviceToken()` and send the result to yourself via email, alert, or other method.

{% include tabbed_gists.html sectionId="device_token" names="8.x,7.x" gists="https://gist.github.com/stopczewska/b9931a9cae9eb4c3a0a6cc3b78308d8f.js,https://gist.github.com/sfmc-mobilepushsdk/5d549d0e283ca303f293995d35ded4e7.js" %}

#### Send a test push

Test that your app can receive a push directly from APNS (Apple Push Notification Service).

- Get the push token from the SDK

{% include tabbed_gists.html sectionId="get_sdk_push_token" names="8.x,7.x" gists="https://gist.github.com/stopczewska/b9931a9cae9eb4c3a0a6cc3b78308d8f.js,https://gist.github.com/sfmc-mobilepushsdk/5d549d0e283ca303f293995d35ded4e7.js" %}

- Trigger the APNS API directly from the command line **If using a .p8 Auth Key File**

<script src="https://gist.github.com/sfmc-mobilepushsdk/bfdb1c811049507428a3b10c84c57bf0.js"></script>

- Trigger the APNS API directly from the command line **If using a .p12 cert (Legacy)**

<script src="https://gist.github.com/sfmc-mobilepushsdk/88f9f3e05fc76a15e8e01b50e5e3adde.js"></script>

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

{% include tabbed_gists.html sectionId="add_sdk_state_info" names="8.x,7.x" gists="https://gist.github.com/stopczewska/cfcab4e6664a0cc1c99d2647f2091676.js,https://gist.github.com/sfmc-mobilepushsdk/c5b95248b98586894e68e70dbdcbbf3b.js" %}


The SDK will output a JSON string like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/7d1961dd86d5dbde2552293490257505.js"></script>
