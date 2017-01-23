//
//  MarketingCloudSDK+Helpers.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

@interface MarketingCloudSDK (Helpers)

/**
 Get SDK Version String (X.Y.Z).
 
 @return NSString value.
 */
+(NSString * _Nonnull)sfmc_sdkVersionString;

/**
 Get SDK Version Code.
 
 @return NSString value.
 */
+(NSString * _Nonnull)sfmc_sdkVersionCode;

/**
 Enable extensive SDK logging.
 
 @param enabled Extensive SDK Logging enabled or disabled.
 */
+(void)sfmc_enableSDKLogging:(BOOL) enabled;

/**
 Set the Log Level.
 
 @return Value indicating if extensive SDK logging is enabled or disabled.
 */
+(BOOL)sfmc_sdkLoggingEnabled;

/**
 To override the logging that the SDK does with your own logging code.  Adding this logging handler will
 replace the logs that the SDK prints to the console.
 
 Typical uses would be to save the logs in your own logging datastore instead of printing to the console.
 
 NOTE: Do not base any program logic on the contents of the String received as a parameter as we do not guarantee
 the contents of a log string will remain the same from one release to another.
 
 @param customLogger - A completion handler that will be called each time the SDK logs to the console.  Instead of
 calling NSLog to log to the console, the SDK will call this customLogger and provide the String
 that was going to be logged.
 */
+(void)sfmc_setSDKLoggerWithHandler:( void (^__nullable)(NSString * _Nonnull))customLogger;

/**
 Outputs a formatted, easily readable block of text describing the current status of the SDK. This is useful for diagnostics and logging.
 
 @return JSON string with values of the current state of the SDK.
 */
+(NSString * _Nullable)sfmc_sdkState;

/**
 Gets the Apple-safe, unique Device Identifier that Salesforce Marketing Cloud will later use to identify the device.
 
 Note that this method is compliant with Apple's compliance rules, but may not be permanent.
 */
+(NSString * _Nullable)sfmc_safeDeviceIdentifier;

@end
