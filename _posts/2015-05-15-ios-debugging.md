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
```
[[MarketingCloudSDK sharedInstance] sfmc_setDebugLoggingEnabled:@(YES)];
```
```
MarketingCloudSDK.sharedInstance().sfmc_setDebugLoggingEnabled(true)
```
Query the state of debug-level logging using this call.
```
BOOL enabled = [[MarketingCloudSDK sharedInstance] sfmc_getDebugLoggingEnabled];
```
```
let enabled: Bool = MarketingCloudSDK.sharedInstance().sfmc_getDebugLoggingEnabled()
```
We send all logging output to Apple's unified logging system. Read this information using Xcode's “Devices and Simulators” window or the macOS Console application. When SDK debug logging is enabled, the SDK uses the *OS_LOG_TYPE_DEBUG* value. Make sure to disable logging in your application for release builds to the Apple App Store.

Review Apple documentation for more information about [unified logging](https://developer.apple.com/documentation/os/logging?language=objc).

To obtain information about the state of the MarketingCloudSDK, use this call.
```
NSString *state = [[MarketingCloudSDK sharedInstance] sfmc_getSDKState];
```
```
let state: String = MarketingCloudSDK.sharedInstance().sfmc_getSDKState()!
```
The call returns a JSON string of relevant information.

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

<script src="https://gist.github.com/sfmc-mobilepushsdk/c9d6cd88962c843da694.js"></script>

#### Add SDK State information to log

For a complete list of information that the SDK has and it's current state, you can implement getSDKState() as follows:

<script src="https://gist.github.com/sfmc-mobilepushsdk/d77f990a6d13ab3086da.js"></script>
