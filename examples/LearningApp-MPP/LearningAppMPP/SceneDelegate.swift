//
//  SceneDelegate.swift
//  LearningApp
//
//  Copyright © 2022 Salesforce. All rights reserved.
//
/*
import UIKit
import MarketingCloudSDK

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var notificationRequest: UNNotificationRequest?
    
    let appID = "<your appID here>"
    let accessToken = "<your accessToken here>"
    let appEndpointURL = "<your appEndpoint here>"
    let mid = "<your account MID here>"

    // Define features of MobilePush your app will use.
    let inbox = true
    let location = true
    let pushAnalytics = true
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        debugPrint("scene delegate willConnectTo")
        guard let windowScene_ = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene_)
                // Assign window to SceneDelegate window property
        self.window = window
        
        if let response = connectionOptions.notificationResponse {
                debugPrint("willConnectTo remote notification received")
                debugPrint(response.notification.request.content.userInfo)
                debugPrint("willConnectTo remote notification  %{public}@", log: .default, type: .debug, response.notification.request.content.userInfo)
        
                let message = "notification object is \(response.notification.request.content.userInfo)"
                let alert = UIAlertController(title: "Test", message:message, preferredStyle: UIAlertController.Style.alert)
                        
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       
            self.notificationRequest = response.notification.request
            }
        
        self.configureSFMCSdk()
        // Set initial view controller from Main storyboard as root view controller of UIWindow
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        // Present window to screen
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        debugPrint("scene delegate sceneDidDisconnect")
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        debugPrint("scene delegate sceneDidBecomeActive")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        debugPrint("scene delegate sceneWillResignActive")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        debugPrint("scene delegate sceneWillEnterForeground")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        debugPrint("scene delegate sceneDidEnterBackground")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
 
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
     
     // To override the Keycahin accessibility attribute
     SFMCSdk.setKeychainAccessibleAttribute(accessibleAttribute: kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
     
     // To Override the Keychain Error to be considered fatal or not (Default value is true)
     
     SFMCSdk.setKeychainAccessErrorsAreFatal(errorsAreFatal: false)
     
     // Use the Mobille Push Config Builder to configure the Mobile Push Module. This gives you the maximum flexibility in SDK configuration.
     // The builder lets you configure the module parameters at runtime.
     let mobilePushConfiguration = PushConfigBuilder(appId: appID)
         .setAccessToken(accessToken)
         .setMarketingCloudServerUrl(appEndpoint)
         .setMid(mid)
         .setInboxEnabled(inbox)
         .setLocationEnabled(location)
         .setAnalyticsEnabled(pushAnalytics)
         .build()
     
     // Set the completion handler to take action when module initialization is completed. Result indicates if initialization was sucesfull or not.
     let completionHandler: (OperationResult) -> () = { result in
         if result == .success {
             // module is fully configured and is ready for use!
             self.setupMobilePush()
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
     SFMCSdk.mp.setURLHandlingDelegate(self)
     
     // Set the MarketingCloudSDKEventDelegate to a class adhering to the protocol.
     // In this example, the AppDelegate class adheres to the protocol (see below)
     // and handles In-App Message delegate methods from the SDK.
     SFMCSdk.mp.setEventDelegate(self)
     
     DispatchQueue.main.async {
         self.getNotifRequestFromSceneDelegate()
     }
     
     // To instruct the SDK to start managing and watching location (for purposes of MobilePush
     // location messaging). This will enable geofence and beacon region monitoring, background location monitoring
     // and local notifications when a geofence or beacon is engaged.
     
     // Note: the first time this method is called, iOS will prompt the user for location permissions.
     // A choice other than "Always Allow" will lead to a degraded or ineffective MobilePush Location Messaging experience.
     // Additional app and project setup must be complete in order for Location Messaging to work correctly.
     // See https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/location/geolocation-overview.html
     SFMCSdk.mp.startWatchingLocation()
     
     // Make sure to dispatch this to the main thread, as UNUserNotificationCenter will present UI.
     DispatchQueue.main.async {
         // Set the UNUserNotificationCenterDelegate to a class adhering to thie protocol.
         // In this exmple, the AppDelegate class adheres to the protocol (see below)
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
         // launches to ensure that the push token used by MobilePush (for silent push) is updated if necessary.
         
         // Registering in this manner does *not* mean that a user will see a notification - it only means
         // that the application will receive a unique push token from iOS.
         UIApplication.shared.registerForRemoteNotifications()
     }
 }
 
 func getNotifRequestFromSceneDelegate() {
     debugPrint("getNotifRequestFromSceneDelegate entered")
 
     if let notifReq = self.notificationRequest {
        SFMCSdk.mp.setNotificationRequest(notifReq)
     } else {
        debugPrint("notifReq is nil")
     }
 }
    
}

// MobilePush SDK: OPTIONAL IMPLEMENTATION (if using In-App Messaging)
extension SceneDelegate: InAppMessageEventDelegate {
    
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

// MobilePush SDK: REQUIRED IMPLEMENTATION
extension SceneDelegate: URLHandlingDelegate {
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


// MobilePush SDK: REQUIRED IMPLEMENTATION
extension SceneDelegate: UNUserNotificationCenterDelegate {
    
    // The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Required: tell the MarketingCloudSDK about the notification. This will collect MobilePush analytics
        // and process the notification on behalf of your application.
        SFMCSdk.mp.setNotificationRequest(response.notification.request)
        
        completionHandler()
    }
    
    // The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
}
 
 */
 
