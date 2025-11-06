//
//  AppDelegate.swift
//  LearningApp
//
//  Created by Brian Criscuolo on 6/4/19.
//  Copyright © 2019 Salesforce. All rights reserved.
//

import UIKit
import SFMCSDK
import MarketingCloudSDK
import PushFeatureSDK
import MobileAppMessagingSDK

/*Note: This app demonstrates SDK integration using the traditional AppDelegate-based lifecycle. For apps using SceneDelegate, the SDK initialization should remain in AppDelegate, with scene-specific UI setup moved to SceneDelegate. */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // The appID, accessToken and appEndpoint are required values for MarketingCloud SDK configuration.
    // See https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/get-started/apple.html for more information.
    
    let appID = "<your appID here>"
    let accessToken = "<your accessToken here>"
    let appEndpointURL = "<your appEndpoint here>"
    let mid = "<your account MID here>"

    // Define features of MarketingCloud SDK your app will use.
    let inbox = true
    let location = true
    let pushAnalytics = true
    let markMessageReadOnInboxNotificationOpen = true
    
    // MobileAppMessaging Configuration
    let mamAppID = "<your MAM appID here>"
    let mamAccessToken = "<your MAM accessToken here>"
    let mamServerURL = "<your MAM serverURL here>"
    let mamTenantId = "<your MAM tenantId here>"
    let mamAnalyticsEnabled = true

    // MobilePush SDK: REQUIRED IMPLEMENTATION
    @discardableResult
    
    func configureSFMCSdk() -> Bool {
        
        // Enable logging for debugging early on. Debug level is not recommended for production apps, as significant data
        // about the SDK will be logged to the console.
#if DEBUG
        SFMCSdk.setLogger(logLevel: .debug)
#endif
        
        //To override the FileProtectionType by the consuming application (default set by SDK : .completeUntilFirstUserAuthentication)
        
        SFMCSdk.setFileProtectionType(fileProtectionType: .completeUntilFirstUserAuthentication)
        
        // Build configuration
        var configBuilder = ConfigBuilder()
        
        // Add Engagement configuration if credentials are valid
        let hasMissingEngagementCredentials = appID.contains("<your") ||
        accessToken.contains("<your") ||
        appEndpointURL.contains("<your") ||
        mid.contains("<your")
        
        if !hasMissingEngagementCredentials, let appEndpoint = URL(string: appEndpointURL) {
            // Use the `MarketingCloudSdkConfigBuilder` to configure the MarketingCloud SDK. This gives you the maximum flexibility in SDK configuration.
            // The builder lets you configure the module parameters at runtime.
            let engagementConfiguration = MarketingCloudSdkConfigBuilder(appId: appID)
                .setAccessToken(accessToken)
                .setMarketingCloudServerUrl(appEndpoint)
                .setMid(mid)
                .setInboxEnabled(inbox)
                .setLocationEnabled(location)
                .setAnalyticsEnabled(pushAnalytics)
                .setMarkMessageReadOnInboxNotificationOpen(markMessageReadOnInboxNotificationOpen)
                .build()
            
            configBuilder = configBuilder
                .setEngagement(config: engagementConfiguration)
        } else {
            print("❌ ERROR: Invalid or missing Engagement credentials - skipping Engagement module")
        }
        
        // Add MobileAppMessaging configuration if credentials are valid
        let hasMissingMAMCredentials = mamAppID.contains("<your") ||
        mamAccessToken.contains("<your") ||
        mamTenantId.contains("<your") ||
        mamServerURL.contains("<your")
        
        if !hasMissingMAMCredentials, let mamURL = URL(string: mamServerURL) {
            let mamConfiguration = MobileAppMessagingConfigBuilder(appId: mamAppID)
                .setAccessToken(mamAccessToken)
                .setMAMUrl(mamURL)
                .setTenantId(mamTenantId)
                .setAnalyticsEnabled(mamAnalyticsEnabled)
                .build()
            
            configBuilder = configBuilder.setMAM(config: mamConfiguration)
        } else {
            print("❌ ERROR: Invalid or missing MobileAppMessaging credentials - skipping MobileAppMessaging module")
        }
        // PushFeatureConfiguration
        let pushFeatureConfiguration = PushFeatureConfigBuilder()
            .setApplicationControlsBadging(true)
            .build()
        
        configBuilder = configBuilder
            .setPushFeature(config: pushFeatureConfiguration)
        
        // Set the completion handler to take action when module initialization is completed.
        let completionHandler: ((_ status: [ModuleInitStatus]) -> Void) = { [weak self] status in
            DispatchQueue.main.async {
                self?.handleSDKInitializationCompletion(status: status)
            }
        }
        
        // Once you've created the configurations, initialize the SDK.
        let config = configBuilder.build()
        SFMCSdk.initializeSdk(config, completion: completionHandler)
        
        return true
    }
    
    // MARK: - SDK Initialization Completion Handler
    
    private func handleSDKInitializationCompletion(status: [ModuleInitStatus]) {
        var allSuccessful = true
        
        for moduleStatus in status {
            print("Module: \(moduleStatus.moduleName.rawValue), Status: \(moduleStatus.initStatus.rawValue)")
            
            if moduleStatus.initStatus == .success {
                // Handle successful initialization for each module
                switch moduleStatus.moduleName {
                case .engagement:
                    setupEngagement()
                case .pushFeature:
                    setupPushFeature()
                case .mobileAppMessaging:
                    setupMobileAppMessaging()
                default:
                    break
                }
            } else {
                allSuccessful = false
                logModuleInitializationFailure(moduleName: moduleStatus.moduleName, status: moduleStatus.initStatus)
            }
        }
        if allSuccessful {
            print("SDK initialization completed successfully")
        } else {
            print("SDK initialization completed with errors - check logs above")
        }
    }
    
    private func logModuleInitializationFailure(moduleName: ModuleName, status: OperationResult) {
        print("❌ ERROR: \(moduleName.rawValue) failed to initialize with status: \(status)")
    }
    
    // MARK: - Module Setup Methods
    
    func setupEngagement() {
        
        // Set the InAppMessageEventDelegate to a class adhering to the protocol.
        // In this example, the AppDelegate class adheres to the protocol (see below)
        // and handles In-App Message delegate methods from the MarketingCloud SDK.
        MarketingCloudSdk.requestSdk { mp in
            mp?.setEventDelegate(self)
        }
        
        // Set a registration callback to notify your application when
        // a registration event has occurred
        MarketingCloudSdk.requestSdk { mp in
            mp?.setRegistrationCallback { reg in
                
                // It is recommended that the registration callback
                // is unset after calling to avoid references
                // being held inadvertently after being triggered.
                // Set and unset registration callbacks can be called independently and
                // anywhere in the lifecycle of AppDelegate, ViewController, or objects
                // after successful initialization of SDK (i.e. when the SDK is "operational")
                mp?.unsetRegistrationCallback()
                
                print("Registration callback was called: \(reg)")
            }
        }
        
        // Set runtime Push Analytics to enabled/disabled
        // This will override the config value set during the initialization of SDK
        // MarketingCloudSdk.requestSdk { mp in
        //    mp?.setAnalyticsEnabled(false)
        // }
        
        
        // Set runtime PI Analytics to enabled/disabled
        // This will override the config value set during the initialization of SDK
        // MarketingCloudSdk.requestSdk { mp in
        //    mp?.setPiAnalyticsEnabled(false)
        // }
        
        
        // Set runtime Location to enabled/disabled
        // MarketingCloudSdk.requestSdk { mp in
        //    mp?.setLocationEnabled(false)
        // }
        
        
        //Set runtime Inbox to enabled/disabled
        //         MarketingCloudSdk.requestSdk { mp in
        //            mp?.setInboxEnabled(false)
        //         }
        
        
        // Use the below method to see if Push Analytics is enabled/disabled
        // MarketingCloudSdk.requestSdk { mp in
        //    let isAnalyticsEnabled = mp?.isAnalyticsEnabled()
        // }
        
        // Use the below method to see if PI Analytics is enabled/disabled
        // MarketingCloudSdk.requestSdk { mp in
        //    let isPiAnalyticsEnabled = mp?.isPiAnalyticsEnabled()
        // }
        
        // Use the below method to see if Location is enabled/disabled
        // MarketingCloudSdk.requestSdk { mp in
        //    let isLocationEnabled = mp?.isLocationEnabled()
        // }
        
        // Use the below method to see if Inbox is enabled/disabled
        // MarketingCloudSdk.requestSdk { mp in
        //    let isInboxEnabled = mp?.isInboxEnabled()
        // }
        
        // To instruct the SDK to start managing and watching location (for purposes of MarketingCloud SDK location messaging). This will enable geofence and beacon region monitoring, background location monitoring
        // and local notifications when a geofence or beacon is engaged.
        
        // Note: the first time this method is called, iOS will prompt the user for location permissions.
        // A choice other than "Always Allow" will lead to a degraded or ineffective MarketingCloud SDK Location Messaging experience.
        // Additional app and project setup must be complete in order for Location Messaging to work correctly.
        // See https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/location/geolocation-overview.html
        MarketingCloudSdk.requestSdk { mp in
            mp?.startWatchingLocation()
        }
    }
    
    // PushFeature Setup
    func setupPushFeature() {
        print("PushFeature module initialized successfully.")
        // Set the URLHandlingDelegate to handle URLs from CloudPage, OpenDirect, Location, and Inbox messages.
        // In this example, the AppDelegate class adheres to the URLHandlingDelegate protocol (see below).
        PushFeature.requestSdk { pushFeature in
            DispatchQueue.main.async {
                pushFeature?.setURLHandlingDelegate(self)
            }
        }
        
        // Set runtime Push to enabled/disabled in SDK
        // This will override the push enablement at SDK level independent of iOS system settings
        // PushFeature.requestSdk { pushFeature in
        //    pushFeature?.setPushEnabled(pushEnabled: true)
        // }
        
        // This checks both iOS system notification settings and SDK-level enablement
        // PushFeature.requestSdk { pushFeature in
        //    let isPushEnabled = pushFeature?.isPushEnabled()
        //    print("Push enabled: \(isPushEnabled)")
        // }
        
        // Use the below method to get the current device token as a string
        // Useful for debugging or displaying device token
        // PushFeature.requestSdk { pushFeature in
        //    if let token = pushFeature?.deviceToken() {
        //        print("Device Token: \(token)")
        //    }
        // }
        
        // Use the below method to get the last notification response
        // Returns the most recent UNNotificationResponse when user interacted with a notification
        // PushFeature.requestSdk { pushFeature in
        //    if let response = pushFeature?.notificationResponse() {
        //        print("Last notification response: \(response)")
        //    }
        // }
        
        // Use the below method to get the last notification userInfo
        // Returns the payload data of the most recent notification received
        // PushFeature.requestSdk { pushFeature in
        //    let userInfo = pushFeature?.notificationUserInfo()
        //    print("Last notification userInfo: \(userInfo)")
        // }
        
        // Make sure to dispatch this to the main thread, as UNUserNotificationCenter will present UI.
        DispatchQueue.main.async {
            // Set the UNUserNotificationCenterDelegate to a class adhering to this protocol.
            // In this example, the AppDelegate class adheres to the protocol (see below)
            // and handles Notification Center delegate methods from iOS.
            UNUserNotificationCenter.current().delegate = self
            
            // Request authorization from the user for push notification alerts.
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(_ granted: Bool, _ error: Error?) -> Void in
                if error == nil {
                    if granted == true {
                        // Your application may want to do something specific if the user has granted authorization
                        // for the notification types specified; it would be done here.
                    }
                }
            })
            
            // In any case, your application should register for remote notifications *each time* your application
            // launches to ensure that the push token used by PushFeature SDK (for silent push) is updated if necessary.
            
            // Registering in this manner does *not* mean that a user will see a notification - it only means
            // that the application will receive a unique push token from iOS.
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    // MobileAppMessaging Setup
    func setupMobileAppMessaging() {
        MobileAppMessaging.requestSdk { mamModule in
            mamModule?.setRegistrationCallback { regDict in
                // It is recommended that the registration callback
                // is unset after calling to avoid references
                // being held inadvertently after being triggered.
                // Set and unset registration callbacks can be called independently and
                // anywhere in the lifecycle of AppDelegate, ViewController, or objects
                // after successful initialization of SDK (i.e. when the SDK is "operational")
                mamModule?.unsetRegistrationCallback()
                print("MobileAppMessaging registration callback: \(regDict)")
            }
        }
        
        // Set runtime MobileAppMessaging Analytics to enabled/disabled.
        // This will override the config value set during the initialization of SDK
        //
        // MobileAppMessaging.requestSdk { mamModule in
        //    mamModule?.setAnalyticsEnabled(true)
        // }
        
        // Use the below method to check if Analytics is enabled/disabled
        // MobileAppMessaging.requestSdk { mamModule in
        //    let isAnalyticsEnabled = mamModule?.isAnalyticsEnabled()
        //    print("MobileAppMessaging Analytics enabled: \(isAnalyticsEnabled)")
        // }
        
        // Use the below method to get the MAM device identifier
        // Useful for debugging or displaying device identifier for support purposes
        // MobileAppMessaging.requestSdk { mamModule in
        //    if let deviceId = mamModule?.deviceIdentifier() {
        //        print("MobileAppMessaging Device Identifier: \(deviceId)")
        //    }
        // }
        
    }
    
    // MobilePush SDK: REQUIRED IMPLEMENTATION
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.configureSFMCSdk()
        setupWindow()
        return true
    }
    
    // MobilePush SDK: OPTIONAL IMPLEMENTATION (if using Data Protection)
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        self.configureSFMCSdk()
    }
    
    // PushFeature SDK: REQUIRED IMPLEMENTATION
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Save the device token
        PushFeature.requestSdk { pushFeature in
            pushFeature?.setDeviceToken(deviceToken)
        }
    }
    
    // MobilePush SDK: REQUIRED IMPLEMENTATION
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    // PushFeature SDK: REQUIRED IMPLEMENTATION
    /**
     This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification.
     
     You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     
     This method will be invoked even if the application was launched or resumed because of the remote notification. The respective delegate methods will be invoked first.
     
     Note that this behavior is in contrast to `application(_:didReceiveRemoteNotification:)`, which is not called in those cases, and which will not be invoked if this method is implemented.
     **/
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushFeature.requestSdk { pushFeature in
            pushFeature?.setNotificationUserInfo(userInfo)
        }
        
        completionHandler(.newData)
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

// PushFeature SDK: REQUIRED IMPLEMENTATION
extension AppDelegate: URLHandlingDelegate {
    /**
     This method is called when a CloudPage, OpenDirect, Location, or Inbox message with a URL is processed by the PushFeature SDK.
     Implementing this method allows the application to handle URLs from Marketing Cloud data.
     
     The SDK delegates URL handling to the application to allow full control over URL processing,
     presentation, and security. This helps mitigate security risks such as Open Redirect vulnerabilities.
     
     - Parameter url: URL from the CloudPage, OpenDirect, Location, or Inbox message
     - Parameter type: String indicating the source type of this URL
     */
    func sfmc_handleURL(_ url: URL, type: String) {
        // Handle the URL returned from the PushFeature SDK by passing it to UIApplication.
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: {
            (success) in
            print("Open \(url): \(success)")
        })
    }
}


// PushFeature SDK: REQUIRED IMPLEMENTATION
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Required: tell the MarketingCloud SDK about the notification. This will collect MarketingCloudSDK analytics & Mobile App Messaging analytics
        // and process the notification on behalf of your application.
        PushFeature.requestSdk { pushFeature in
            pushFeature?.setNotificationResponse(response)
        }
        
        completionHandler()
    }
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
}

// MarketingCloudSDK: OPTIONAL IMPLEMENTATION (if using In-App Messaging)
extension AppDelegate: InAppMessageEventDelegate {
    
    /**
     Method called by the SDK when an In-App Message is ready to be shown. The delegate implementing this method returns true or false.
     
     `true` indicates to the SDK that this message is able to be shown (allowed by the application).
     
     `false` indicates that the SDK should not show this message. An application may return `false` if its visual hierarchy or user flow is such that an interruption would not be acceptable to the usability or functionality of the application.
     
     If `false` is returned, the application may capture the message's identifier (via messageId(forMessage:)) and attempt to show that message later via showInAppMessage(messageId:).
     
     - Parameter message: Dictionary representing an In-App Message
     - Returns: Boolean value reflecting application's behavior
     */
    func sfmc_shouldShow(inAppMessage message: [AnyHashable : Any]) -> Bool {
        print("message should show")
        return true
    }
    
    /**
     Method called by the SDK when an In-App Message has been shown.
     
     - Parameter message: Dictionary representing an In-App Message
     */
    func sfmc_didShow(inAppMessage message: [AnyHashable : Any]) {
        // message shown
        print("message was shown")
    }
    
    /**
     Method called by the SDK when an In-App Message has been closed.
     
     - Parameter message: Dictionary representing an In-App Message
     */
    func sfmc_didClose(inAppMessage message: [AnyHashable : Any]) {
        // message closed
        print("message was closed")
    }
}
