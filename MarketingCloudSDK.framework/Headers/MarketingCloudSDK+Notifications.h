//
//  MarketingCloudSDK+Notifications.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface MarketingCloudSDK (Notifications)

/** Handles a notification received by the app
 
 @param userInfo The dictionary containing the push notification payload.
 @param applicationState UIApplicationState value used as a hint to the SDK to describe if the app was in the foreground or background when the notification payload is received by the application delegate, thereby facilitating propery SDK behavior and logging.
 */
- (void) sfmc_handleNotification:(NSDictionary * _Nullable)userInfo forApplicationState:(UIApplicationState)applicationState;

/** Handles a notification received by the app (typically, in response to -application:didReceiveRemoteNotification:fetchCompletionHandler:).
 
 @param userInfo The dictionary containing the push notification payload.
 */
- (void) sfmc_handleRemoteNotification:( NSDictionary * _Nullable ) userInfo;

/** Handles a notification received by the app (in response to -application:didReceiveLocalNotification:).
 
 @param localNotification The localNotification received by the application.
 */
- (void) sfmc_handleLocalNotification:( UILocalNotification * _Nullable ) localNotification;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
/** Handles an iOS 10 notification received by the app (in response to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:).

 @param notificationResponse The UNNotificationResponse received by the application.
 */
- (void) sfmc_handleUserNotificationResponse:(UNNotificationResponse * _Nullable ) notificationResponse;
#endif


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

/**
 
 A one-shot method to get notification up and running in your app.
 
 @param delegate From Apple: "To guarantee that your app is able to respond to actionable notifications, you must set the delegate before your app finishes launching. For example, this means setting the delegate before an iOS app’s applicationDidFinishLaunching: method returns." If desired, -setUserNotificationCenterDelegate may be called early in the app lifecycle, and registration later.
 @param options UNAuthorizationOptions must be passed for registration.
 @param categories A set of UNNotificationCategory objects for push notifications. These may be modified after registration via setUserNotificationCenterCategories.
 @param completionHandler Returns isGranted and error values to convey the results of registration.
 
 */
-(void) sfmc_registerForRemoteNotificationsWithDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate options:(UNAuthorizationOptions)options categories:(NSSet<UNNotificationCategory *> *_Nullable) categories completionHandler:(void (^ _Nullable)(BOOL granted, NSError *_Nullable error))completionHandler;

/**
 
 A convenience method around UNNotificationSettings's authorizationStatus to return registration status as well as the set of options.
 @param completionHandler A handler returning the following: (registered A BOOL value reflecting the authorizationStatus is UNAuthorizationStatusAuthorized or not) (options UNAuthorizationOptions for current registration).
 
 */
- (void) sfmc_registeredForRemoteNotificationsWithCompletionHandler:(void (^ _Nullable)(BOOL registered, UNAuthorizationOptions options))completionHandler;

/**
 
 A convenience method to return UNNotificationSettings.
 @param completionHandler A handler returning the following: (settings UNNotificationSettings).
 
 */
- (void) sfmc_currentUserNotificationSettingsWithCompletionHandler:(void(^ _Nullable)(UNNotificationSettings * _Nullable settings))completionHandler;

/**
 
 A convenience method to set UNUserNotificationCenter's delegate.
 @param delegate A pointer to a class (typically, self) adhering to the UNUserNotificationCenterDelegate protocol.
 
 */
- (void) sfmc_setUserNotificationCenterDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate;

/**
 
 A convenience method to set UNUserNotificationCenter's categories.
 @param categories A set of UNNotificationCategory objects.
 
 */
- (void) sfmc_setUserNotificationCenterCategories:(NSSet<UNNotificationCategory *> *_Nullable)categories;

/**
 
 A convenience method to return get UNUserNotificationCenter categories.
 @param completionHandler A handler returning the following: (categories A set of UNNotificationCategory objects).
 
 */
- (void) sfmc_getUserNotificationCenterCategoriesWithCompletionHandler:(void(^ _Nullable)(NSSet<UNNotificationCategory *> * _Nullable categories))completionHandler;

/**
 
 A convenience method to add a notification for delivery.
 @param request A deliverable notification request.
 @param completionHandler A handler returning the following: (error An error signifying success or failure).
 
 */
- (void) sfmc_addNotificationRequest:(UNNotificationRequest * _Nonnull)request withCompletionHandler:(void(^ _Nullable)(NSError *_Nullable error))completionHandler;

/**
 
 A convenience method to get notifications pending delivery.
 @param completionHandler A handler returning the following: (requests An array of notification requests).
 
 */
- (void) sfmc_getPendingNotificationRequestsWithCompletionHandler:(void(^ _Nullable)(NSArray<UNNotificationRequest *> * _Nullable requests))completionHandler;

/**
 
 A convenience method to remove notifications pending delivery.
 @param identifiers An array of notification identifiers to remove.
 
 */
- (void) sfmc_removePendingNotificationRequestsWithIdentifiers:(NSArray<NSString *> * _Nonnull)identifiers;

/**
 
 A convenience method to remove all notifications pending delivery.
 
 */
- (void) sfmc_removeAllPendingNotificationRequests;
/**
 
 A convenience method to get notifications already delivered.
 @param completionHandler A handler returning the following: (notifications An array of delivered notifications).
 
 */
- (void) sfmc_getDeliveredNotificationsWithCompletionHandler:(void(^ _Nullable)(NSArray<UNNotification *> * _Nullable notifications))completionHandler;
/**
 
 A convenience method to remove notifications which have been delivered.
 @param identifiers An array of notification identifiers to remove.
 
 */
- (void) sfmc_removeDeliveredNotificationsWithIdentifiers:(NSArray<NSString *> * _Nonnull )identifiers;

/**
 
 A convenience method to remove all notifications which have been delivered.
 
 */
- (void) sfmc_removeAllDeliveredNotifications;

#endif

// IPHONEOS_DEPLOYMENT_TARGET >= 8.X
// Supports IOS SDK 8.X (i.e. XCode 6.X and up)
/**
 Wrapper for iOS' application:registerForRemoteNotification; call. It will check that push is allowed, and if so, register with Apple for a token. If push is not enabled, it will notify Salesforce that push is disabled.
 
 */
-(void) sfmc_registerForRemoteNotifications;

/**
 Wrapper for iOS' isRegisteredForRemoteNotifications; call.
 
 @return BOOL
 */
- (BOOL) sfmc_isRegisteredForRemoteNotifications;

/**
 Wrapper for iOS' application:registerUserNotificationSettings; call.
 
 @param notificationSettings The UIUserNotificationSettings object that the application would like to use for push. These are pipe-delimited, and use Apple's native values.
 */
- (void) sfmc_registerUserNotificationSettings:(UIUserNotificationSettings * _Nonnull)notificationSettings;

/**
 Wrapper for iOS' currentUserNotificationSettings; call.
 
 @return Returns the current UIUserNotificationSettings object.
 */
- (UIUserNotificationSettings * _Nullable) sfmc_currentUserNotificationSettings;

/**
 Wrapper for iOS' didRegisterUserNotificationSettings; callback.
 
 @param notificationSettings A UIUserNotificationSettings object.
 */
- (void) sfmc_didRegisterUserNotificationSettings:(UIUserNotificationSettings * _Nullable)notificationSettings;


/**
 Responsible for sending a received token back to Salesforce. It marks the end of the token registration flow. If it is unable to reach Salesforce Marketing Cloud server, it will save the token and try again later.
 
 This method is necessary to implementation of MarketingCloudSDK.
 
 @param deviceToken Token as received from Apple, still an NSData object.
 */
-(void) sfmc_registerDeviceToken:(NSData * _Nonnull)deviceToken;

/**
 Returns the device token as a NSString.
 
 @return A stringified version of the Device Token.
 */
-(NSString * _Nullable) sfmc_deviceToken;

/**
 Handles a registration failure.
 
 @param error The error returned to the application on a registration failure.
 */
-(void) sfmc_applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError * _Nullable)error;

/**
 Reset the application's badge number to zero (aka, remove it). Call sfmc_updateMarketingCloud to refresh the server with the current badge number. Note: sfmc_updateMarketingCloud may not be fully processed by the server for a number of minutes; the server's badge value may be out of sync with the app for a short amount of time.
 
 */
-(void) sfmc_resetBadgeCount;

/**
 Tell the SDK to display a UIAlertView if a push is received while the app is already running. Default behavior is set to NO.
 
 Please note that all push notifications received by the application will be processed, but iOS will *not* present an alert to the user if the app is running when the alert is received. If you set this value to true (YES), then the SDK will generate and present the alert for you. It will not play a sound, though.
 
 @param desiredState YES/NO if you want to display an alert view while the app is running.
 */
-(void) sfmc_setShowRemoteNotificationWhenAppInForeground:(BOOL)desiredState;

/**
 @return If the SDK is set to display an alert view while the app is running.
 */
-(BOOL) sfmc_showRemoteNotificationWhenAppInForeground;

/**
 Notifies the SDK of an app launch, including the dictionary sent to the app by iOS. The launchOptions dictionary is necessary because it will include the APNS dictionary, necessary for processing opens and other analytic information.
 
 @param launchOptions The dictionary passed to the application by iOS on launch.
 */
-(void)sfmc_applicationLaunchedWithOptions:(NSDictionary * _Nullable)launchOptions;

@end
