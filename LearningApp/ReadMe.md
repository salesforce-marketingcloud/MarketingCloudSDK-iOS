# MobilePush SDK LearningApp Documentation

The MobilePush SDK LearningApp is offered as an example of MobilePush SDK project configuration and implementation best practices.

To easily integrate the MobilePush SDK into your new or existing mobile app, use the LearningApp in conjunction with the [iOS](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/) MobilePush SDK documentation and the [iOS Appledoc](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/get-started/appledocs.html) references.

Additionally, should you face a challenge in your MobilePush SDK implementation, the LearningApp can serve as a simple, streamlined test application to validate integration and configuration outside of the complexities of a modern, fully featured mobile app.

The LearningApp demonstrates

* Configuring the SDK
* Enabling push notifications
* Supporting Rich Push functionality
* Handling Marketing Cloud push URLs
* Enabling location messaging
* Setting contact values via SDK registration
* Logging SDK diagnostic information via sdkState
* A fully-featured app inbox, enabling inbox messaging
* Support for In-App Message callbacks
* Access to the MobilePush SDK documentation

For further information about implementing the MobilePush SDK, see the documentation

* https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
* https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledoc/index.html

**Requirements**

* Xcode 12

**Setup**

1. Clone or download the SDK and LearningApp from the source repository.
2. Open `LearningApp.xcodeproj` in Xcode.
3. Open `AppDelegate.swift` and replace the values for `appId`, `accessToken`, `appEndpoint` and `mid`. Find these values on the MobilePush Administration screen in Marketing Cloud.

        let appID = "<your appID here>"
        let accessToken = "<your accessToken here>"
        let appEndpoint = "<your appEndpoint here>"
        let mid = "<your account MID here>"

4. In the Xcode Project Navigator, select the LearningApp project.
5. In the Project Editor, select the LearningApp target.
6. On the General tab, set your unique Bundle Identifier and Signing values.
7. Build and run the LearningApp project.

**iOS SDK Development Notes**

* If you debug in Xcode to a connected device, your push notification environment is considered Development. You must use an Apple Push Notification service SSL (Sandbox) certificate on the MobilePush Administration screen in Marketing Cloud.
    * To create a certificate, review Apple's documentation: https://help.apple.com/developer-account/#/dev82a71386a
* If you build and install the LearningApp as an archive or via app distribution such as TestFlight, Hockey, or Fabric, your push notification environment is considered Production. You must use an Apple Push Notification service SSL (Sandbox & Production) certificate on the MobilePush Administration screen in Marketing Cloud.
    * To create a certificate, review Apple's documentation: https://help.apple.com/developer-account/#/dev82a71386a
* If you build and debug in a simulator, push notifications and inbox messages are not delivered from Marketing Cloud.
* While the LearningApp is implemented in Swift, the methods and conventions also apply directly to Objective-C.

