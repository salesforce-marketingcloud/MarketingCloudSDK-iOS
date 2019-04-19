//
//  MarketingCloudSDK+Location.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

/**
 Supporting protocol for the MobilePush SDK's support for Locations.
 
 Implementation of this protocol is not required for the Location feature to work, although it provides addition control for an application developer.
 
 This protocol allows for awareness into the SDK's lifecycle for Location tracking and messaging.
 */
@protocol MarketingCloudSDKLocationDelegate <NSObject>

@required

/**
 Method called by the SDK when a Location message is ready to be shown. The delegate implementing this method returns YES or NO.
 
 YES indicates to the SDK that this message is able to be shown (allowed by the application).
 
 NO indicates that the SDK should not show this message.
 
 @param message NSDictionary representing a MobilePush Location message
 @param region NSDictionary representing a MobilePush region (geofence or beacon), which can be converted into a CLRegion object via the method sfmc_regionFromDictionary
 
 @return value reflecting application's behavior
 */
- (BOOL) sfmc_shouldShowLocationMessage:(NSDictionary * _Nonnull) message forRegion:(NSDictionary * _Nonnull) region;

@end


@interface MarketingCloudSDK (Location)

/**
 Method to set a delegate implementing the MarketingCloudSDKLocationDelegate.
 
 @param delegate value A class adhering to the MarketingCloudSDKLocationDelegate and implementing the required method.
 */
- (void) sfmc_setLocationDelegate:(id<MarketingCloudSDKLocationDelegate> _Nullable)delegate;

/**
 Method to convert a region dictionary returned from sfmc_shouldShowLocationMessage into a CLRegion
 */
- (CLRegion *) sfmc_regionFromDictionary:(NSDictionary * _Nonnull) dictionary;

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
