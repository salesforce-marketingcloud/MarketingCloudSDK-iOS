//
//  MarketingCloudSDK+Location.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

/** Location */
@interface MobilePushSDK (Location)

/**
 Method to set a delegate implementing the SFMCSdkLocationDelegate.
 
 @param delegate value A class adhering to the SFMCSdkLocationDelegate and implementing the required method.
 */
- (void) sfmc_setSFMCSdkLocationDelegate:(id<SFMCSdkLocationDelegate> _Nullable)delegate;

/**
 Method to convert a region dictionary returned from sfmc_shouldShowLocationMessage into a CLRegion
 
 @param dictionary value representing a region object from the sfmc_shouldShowLocationMessage method
 */
- (CLRegion *_Nullable) sfmc_regionFromDictionary:(NSDictionary * _Nonnull) dictionary;

/**
 Determines the state of Location Services based on developer setting and OS-level permission. This is the preferred method for checking for location state.
 
 @return A boolean value reflecting if location services are enabled (i.e. authorized) or not.
 */
- (BOOL) sfmc_locationEnabled;

/**
 Use this method to initiate Location Services through the MobilePush SDK.
 */
- (void) sfmc_startWatchingLocation;

/**
 Use this method to disable Location Services through the MobilePush SDK.
 */
- (void) sfmc_stopWatchingLocation;

/**
 Use this method to determine if the SDK is actively monitoring location.

 @return A boolean value reflecting if the SDK has called startWatchingLocation.
 */
- (BOOL) sfmc_watchingLocation;

/**
 A dictionary version of the last known Location. The dictionary will contain two keys, latitude and longitude, which are NSNumber wrappers around doubles. Use doubleValue to retrieve.
 */
- (NSDictionary<NSString *, NSString *> * _Nullable) sfmc_lastKnownLocation;

@end
