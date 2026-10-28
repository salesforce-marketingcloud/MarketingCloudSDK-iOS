//
//  MarketingCloudSDK+Events.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>
#import <SFMCSDK/SFMCSdk.h>

/** Events */
@interface MobilePushSDK (Events)

/**
 Method to track events, which could result in actions such as an In-App Message displaying.
 @param events event or an array of events to trigger.
 */

- (void)sfmc_track:(nullable id) events;

- (BOOL)isTrackingEnabledForEvent:(id<SFMCSdkEvent>_Nonnull)event;

- (void)addEventTrackStats:(id<SFMCSdkEvent>_Nonnull)event;

@end
