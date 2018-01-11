---
layout: page
title: "Switch Business Units"
subtitle: "Switch Business Units"
category: trouble
date: 2018-01-10 12:00:00
order: 4
---

Switch between multiple Marketing Cloud business units using the MarketingCloudSDK. This process can be necessary for your application implementation, such as switching between production and debug tasks.

Switching business units using the AppID value used to configure the application requires you to issue *tearDown* to the SDK. Follow this call with a standard configure, as typically done in *applicationDidFinishLaunching...*.

Any switch in business units removes any MarketingCloudSDK data from the system. If you enable the previous business unit later via the SDK, data like contactKey, tags and attributes will no longer be set.
```
- (void) switchToBusinessUnit2
{
    // Tear down the existing instance of the SDK
    [[MarketingCloudSDK sharedInstance] sfmc_tearDown];

    // weak reference to avoid retain cycle within block
    __weak __typeof__(self) weakSelf = self;

    // Reconfigure with a different configuration file.
    NSURL *configurationFileURL = // code to reference your configuration file for BU2
    NSError *configureError = nil;
        BOOL configured = [[MarketingCloudSDK sharedInstance] sfmc_configureWithURL:configurationFileURL configurationIndex:0 error:&configureError
                         completionHandler:^(BOOL success, NSString *appId, NSError *error) {
            // The SDK has been fully configured and is ready for use!

            // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
            [UNUserNotificationCenter currentNotificationCenter].delegate = weakSelf;

            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                            if (error == nil) {
                                                                                if (granted == YES) {
                                                                                    os_log_info(OS_LOG_DEFAULT, "Authorized for notifications = %s", granted ? "YES" : "NO");

                                                                                    // we are authorized to use notifications, request a device token for remote notifications
                                                                                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                                                                                }
                                                                            }
                                                                        }];        
        }];
        if (configured == YES) {
            // The configuation process is underway.
        }
    }
    ...
}
```
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

    // Tear down the existing instance of the SDK
    MarketingCloudSDK.sharedInstance().sfmc_tearDown()
                                weak var weakSelf = self
        do {
            try MarketingCloudSDK.sharedInstance().sfmc_configure(completionHandler: {(_ success: Bool, _ appId: String, _ error: Error?) -> Void in
                // The SDK has been fully configured and is ready for use!
                // set the delegate if needed then ask if we are authorized - the delegate must be set here if used
                UNUserNotificationCenter.current().delegate = weakSelf
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(_ granted: Bool, _ error: Error?) -> Void in
                    if error == nil {
                        if granted == true {
                             // we are authorized to use notifications, request a device token for remote notifications
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                })
            })
            return true
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return false
    }
```

Use a similar approach if you switch between business units for development purposes, such as using a development business unit for testing Marketing Cloud notifications and another business unit for for production releases.

Use a configuration file to contain multiple JSON dictionaries of configuration data, each with a unique appid and access token value from Marketing Cloud.
```
// MarketingCloudConfiguration.json
[{
  "name": "prod",
  "appid": "<your production appid>",
  "accesstoken": "<your production accesstoken",
  "analytics": true,
  "location": true,
  "inbox": true,
  "loglevel": 0,
}, {
  "name": "development",  
  "appid": "<your development appid>",
  "accesstoken": "<your development accesstoken",
  "analytics": true,
  "location": true,
  "inbox": true,
  "loglevel": 0
 }]
```
Use the index of your configuration when configuring the SDK using the configureWithURL:configuationIndex:error: method.
```
NSURL *configurationFileURL = // code to reference your configuration file
NSInteger productionIndex = 0; // index of production configuration in the JSON file dictionary
NSInteger debugIndex = 1;
NSError *configureError = nil;
    BOOL configured = [[MarketingCloudSDK sharedInstance] sfmc_configureWithURL:configurationFileURL configurationIndex:debugIndex error:&configureError
                         completionHandler:^(BOOL success, NSString *appId, NSError *error) {
```
```
var configurationFileURL = (    // code to reference your configuration file
NSInteger) as? URL
// index of production configuration in the JSON file dictionary
var debugIndex: Int = 1
do {
     try MarketingCloudSDK.shar
```
