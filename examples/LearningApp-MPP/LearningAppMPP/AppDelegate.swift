//
//  AppDelegate.swift
//  LearningAppMPP
//
//

import UIKit
import FirebaseMessaging
import FirebaseCore
import UserNotifications
import MarketingCloudSDK

// This app showcases Multipush provider implementation with MarketingCloudSDK
// FireBase integration is considered in this example app
// Firebase has Swizzling for notifications which by default fallback to Firebase Delegate methods.
// Disable Swizzling will fallback to default Application delegate methods
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // The appID, accessToken and appEndpoint are required values for MobilePush SDK configuration.
    // See https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/get-started/apple.html for more information.
    let appID = "<your appID here>"
    let accessToken = "<your accessToken here>"
    let appEndpointURL = "<your appEndpoint here>"
    let mid = "<your account MID here>"
    
    // Define features of MobilePush your app will use.
    let inbox = true
    let location = true
    let pushAnalytics = true
    let markMessageReadOnInboxNotificationOpen = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        self.configureSFMCSdk()
        
        // Register for remote notifications. This shows a permission dialog on first run
        // to show the dialog at a more appropriate time move this registration accordingly.
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    /**
        MobilePush SDK: REQUIRED IMPLEMENTATION set deviceToken to MarketingCloudSDK either on successful registration of MarketingCloudSDK or in the FCM delegate method when Firebase Swizzling is disabled.
        Set FirebaseAppDelegateProxyEnabled to NO in the application info.plist
        registerForRemoteNotifications() method gets to this callback
        Uncomment the code to setDeviceToken to MarketingCloudSDK
     */
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // SFMCSdk.requestPushSdk { mp in
        //     mp.setDeviceToken(deviceToken)
        // }
    }
    
    // MobilePush SDK: REQUIRED IMPLEMENTATION when Firebase Swizzling is disabled.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    /**
     MobilePush SDK: REQUIRED IMPLEMENTATION, disable Swizzling by Setting FirebaseAppDelegateProxyEnabled to NO in the application info.plist
     
     This delegate method offers an opportunity for applications with the "remote-notification" background mode to fetch appropriate new data in response to an incoming remote notification.
     You should call the fetchCompletionHandler as soon as you're finished performing that operation, so the system can accurately estimate its power and data cost.
     This method will be invoked even if the application was launched or resumed because of the remote notification.
     The respective delegate methods will be invoked first. Note that this behavior is in contrast to application:didReceiveRemoteNotification:, which is not called in those cases,
     and which will not be invoked if this method is implemented.
     */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //Note: When Swizzling is enabled in Firebase, firebases's appDidRecieveMessage gets called and the userInfo is massaged in the type MessagingMessageInfo. This will result in message not showing up when passed to MarketingCloudSDK
        SFMCSdk.requestPushSdk { mp in
            mp.setNotificationUserInfo(userInfo)
        }
        completionHandler(.newData)
    }
    
    
    // MobilePush SDK: REQUIRED IMPLEMENTATION
    @discardableResult
    func configureSFMCSdk() -> Bool {
        
        // Enable logging for debugging early on. Debug level is not recommended for production apps, as significant data
        // about the MobilePush will be logged to the console.
#if DEBUG
        SFMCSdk.setLogger(logLevel: .debug)
#endif
        
        //Throws fatal error when appId, accessToken, appEndpoint and mid not added to the project
        if(appID.contains("<your") ||
           accessToken.contains("<your") ||
           appEndpointURL.contains("<your") ||
           mid.contains("<your")) {
            fatalError(" Please add proper appID, accessToken, appEndPoint and mid")
        }
        
        //Throws fatal error when MarketingCloudSDK.bundle is not added to project bundle resources
        guard Bundle.main.path(forResource: "MarketingCloudSDK", ofType: "bundle") != nil else {
            print("The path could not be created.")
            fatalError("Please add MarketingCloudSDK.bundle to the project's bundle resources!")
        }
        
        let appEndpoint = URL(string: appEndpointURL)!
        
        //To override the FileProtectionType by the consuming application (default set by SDK : .completeUntilFirstUserAuthentication)
        SFMCSdk.setFileProtectionType(fileProtectionType: .completeUntilFirstUserAuthentication)
        
        // Use the Mobille Push Config Builder to configure the Mobile Push Module. This gives you the maximum flexibility in SDK configuration.
        // The builder lets you configure the module parameters at runtime.
        let mobilePushConfiguration = PushConfigBuilder(appId: appID)
            .setAccessToken(accessToken)
            .setMarketingCloudServerUrl(appEndpoint)
            .setMid(mid)
            .setInboxEnabled(inbox)
            .setLocationEnabled(location)
            .setAnalyticsEnabled(pushAnalytics)
            .setMarkMessageReadOnInboxNotificationOpen(markMessageReadOnInboxNotificationOpen)
            .build()
        
        // Set the completion handler to take action when module initialization is completed. Result indicates if initialization was sucesfull or not.
        let completionHandler: (OperationResult) -> () = { result in
            if result == .success {
                // module is fully configured and is ready for use!
                self.setupMobilePush()
                NotificationCenter.default.post(Notification(name: Notification.Name("SFMCSdkInitCompletedSuccessfully")))
            } else if result == .error {
                // module failed to initialize, check logs for more details
            } else if result == .cancelled {
                // module initialization was cancelled (for example due to re-confirguration triggered before init was completed)
            } else if result == .timeout {
                // module failed to initialize due to timeout, check logs for more details
            }
        }
        
        // Once you've created the mobile push configuration, intialize the SDK.
        SFMCSdk.initializeSdk(ConfigBuilder().setPush(config: mobilePushConfiguration, onCompletion: completionHandler).build())
        
        return true
    }
    
    func setupMobilePush() {
        
        // Set the MarketingCloudSDKURLHandlingDelegate to a class adhering to the protocol.
        // In this example, the AppDelegate class adheres to the protocol (see below)
        // and handles URLs passed back from the SDK.
        // For more information, see https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/sdk-implementation/implementation-urlhandling.html
        SFMCSdk.requestPushSdk { mp in
            mp.setURLHandlingDelegate(self)
        }

        // Set the MarketingCloudSDKEventDelegate to a class adhering to the protocol.
        // In this example, the AppDelegate class adheres to the protocol (see below)
        // and handles In-App Message delegate methods from the SDK.
        SFMCSdk.requestPushSdk { mp in
            mp.setEventDelegate(self)
        }

        //         Set a registration callback to notify your application when
        //         a registration event has occurred
        SFMCSdk.requestPushSdk { mp in
            mp.setRegistrationCallback { reg in
                
                // It is recommended that the registration callback
                // is unset after calling to avoid references
                // being held inadvertently after being triggered.
                // Set and unset registration callbacks can be called independently and
                // anywhere in the lifecycle of AppDelegate, ViewController, or objects
                // after successful initialization of SDK (i.e. when the SDK is "operational")
                mp.unsetRegistrationCallback()
                
                print("Registration callback was called: \(reg)")
            }
        }

        // You can also set the registration callback outside the
        // success callback like so:
        //
        // SFMCSdk.requestPushSdk { mp in
        //      mp.setRegistrationCallback { reg in
        //          mp.unsetRegistrationCallback()
        //          print("Registration callback was called: \(reg)")
        //      }
        //  }

        // Set runtime Push Analytics to enabled/disabled
        // This will override the config value set during the initialization of SDK
        // SFMCSdk.requestPushSdk { mp in
        //    mp.setAnalyticsEnabled(false)
        // }

        
        // Set runtime PI Analytics to enabled/disabled
        SFMCSdk.requestPushSdk { mp in
            mp.setPiAnalyticsEnabled(false)
        }

        
        // Set runtime Location to enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    mp.setLocationEnabled(false)
        // }

        
        //Set runtime Inbox to enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    mp.setInboxEnabled(false)
        // }

        
        // Use the below method to see if Push Analytics is enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    let isAnalyticsEnabled = mp.isAnalyticsEnabled()
        // }
        
        // Use the below method to see if PI Analytics is enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    let isPiAnalyticsEnabled = mp.isPiAnalyticsEnabled()
        // }
        
        // Use the below method to see if Location is enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    let isLocationEnabled = mp.isLocationEnabled()
        // }
        
        // Use the below method to see if Inbox is enabled/disabled
        // SFMCSdk.requestPushSdk { mp in
        //    let isInboxEnabled = mp.isInboxEnabled()
        // }
        
        // To instruct the SDK to start managing and watching location (for purposes of MobilePush
        // location messaging). This will enable geofence and beacon region monitoring, background location monitoring
        // and local notifications when a geofence or beacon is engaged.
        
        // Note: the first time this method is called, iOS will prompt the user for location permissions.
        // A choice other than "Always Allow" will lead to a degraded or ineffective MobilePush Location Messaging experience.
        // Additional app and project setup must be complete in order for Location Messaging to work correctly.
        // See https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/location/geolocation-overview.html
         SFMCSdk.requestPushSdk { mp in
             mp.startWatchingLocation()
         }
        
    }
    
    // MobilePush SDK: OPTIONAL IMPLEMENTATION (if using Data Protection)
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        
        //RequestPushSdk will ensure the self.configureSFMCSdk() will be executed once it's operational
        SFMCSdk.requestPushSdk { mp in
            self.configureSFMCSdk()
        }
    }
}

// MARK: FireBaseMessaging Delegate
/**
 Set deviceToken to MarketingCloudSDK in the FCM delegate method when Swizzling is enabled.
 DeviceToken must be set MANDATORILY to MarketingCloudSDK using`mp.setDeviceToken` API for Push notifications to be received through Mobile Push.
 */
extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token", fcmToken ?? "")
        
        SFMCSdk.requestPushSdk { mp in
            if let apnsToken = messaging.apnsToken {
                print("Setting APNS token in MarketingCloudSDK")
                mp.setDeviceToken(apnsToken)
            } else {
                print("fcm token is null")
            }
        }
    }
}

// MobilePush SDK: REQUIRED IMPLEMENTATION When Firebase Swizzling is disabled
extension AppDelegate: UNUserNotificationCenterDelegate {
    /**
     The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction.
     The delegate must be set before the application returns from applicationDidFinishLaunching:.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Required: tell the MarketingCloudSDK about the notification. This will collect MobilePush analytics
        // and process the notification on behalf of your application.
        //Note: When Swizzling is enabled in Firebase, firebases's appDidRecieveMessage gets called and the userInfo is altered to the type of MessagingMessageInfo.
        //This will result in message not showing up when passed to MarketingCloudSDK
        SFMCSdk.requestPushSdk { mp in
            mp.setNotificationResponse(response)
        }

        completionHandler()
    }
    
    /**
        The method will be called on the delegate only if the application is in the foreground.
        If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented.
        The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list.
        This decision should be based on whether the information in the notification is otherwise visible to the user.
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
}



// MobilePush SDK: REQUIRED IMPLEMENTATION
extension AppDelegate: URLHandlingDelegate {
    /**
     This method, if implemented, can be called when a Alert+CloudPage, Alert+OpenDirect, Alert+Inbox or Inbox message is processed by the SDK.
     Implementing this method allows the application to handle the URL from Marketing Cloud data.
     
     Prior to the MobilePush SDK version 6.0.0, the SDK would automatically handle these URLs and present them using a SFSafariViewController.
     
     Given security risks inherent in URLs and web pages (Open Redirect vulnerabilities, especially), the responsibility of processing the URL shall be held by the application implementing the MobilePush SDK. This reduces risk to the application by affording full control over processing, presentation and security to the application code itself.
     
     @param url value NSURL sent with the Location, CloudPage, OpenDirect or Inbox message
     @param type value NSInteger enumeration of the MobilePush source type of this URL
     */
    func sfmc_handleURL(_ url: URL, type: String) {
        // Very simply, send the URL returned from the MobilePush SDK to UIApplication to handle correctly.
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: {
            (success) in
            print("Open \(url): \(success)")
        })
    }
}

// MobilePush SDK: OPTIONAL IMPLEMENTATION (if using In-App Messaging). If not using In-App Messaging, Appdelegate should confirm the InAppMessageEventDelegate as class AppDelegate: UIResponder, UIApplicationDelegate, InAppMessageEventDelegate to avoid an error  "Argument type 'AppDelegate' does not conform to expected type 'InAppMessageEventDelegate'"
extension AppDelegate: InAppMessageEventDelegate {
    
    /**
     Method called by the SDK when an In-App Message is ready to be shown. The delegate implementing this method returns YES or NO.
     
     YES indicates to the SDK that this message is able to be shown (allowed by the application).
     
     NO indicates that the SDK should not show this message. An application may return NO if its visual hierarchy or user flow is such that an interruption would not be acceptable to the usability or functionality of the application.
     
     If NO is returned, the application may capture the message's identifier (via sfmc_messageIdForMessage:) and attempt to show that message later via sfmc_showInAppMessage:.
     
     @param message NSDictionary representing an In-App Message
     
     @return value reflecting application's behavior
     */
    func sfmc_shouldShow(inAppMessage message: [AnyHashable : Any]) -> Bool {
        print("message should show")
        return true
    }

    /**
     Method called by the SDK when an In-App Message has been shown.
     
     @param message NSDictionary representing an In-App Message
     */
    func sfmc_didShow(inAppMessage message: [AnyHashable : Any]) {
        // message shown
        print("message was shown")
    }
    
    /**
     Method called by the SDK when an In-App Message has been closed.
     
     @param message NSDictionary representing an In-App Message
     */
    func sfmc_didClose(inAppMessage message: [AnyHashable : Any]) {
        // message closed
        print("message was closed")
    }
}
