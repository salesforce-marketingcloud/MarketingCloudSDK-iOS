//
//  MarketingCloudSDK.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
#error IPHONEOS_DEPLOYMENT_TARGET must be 9.0 or above!
#endif

#ifndef MarketingCloudSDK_h
#define MarketingCloudSDK_h

/**---------------------------------------------------------------------------------------
 * @name This is the framework umbrella header for MarketingCloudSDK.
 *  ---------------------------------------------------------------------------------------
 */

#import <MarketingCloudSDK/MarketingCloudSDK+Base.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Analytics.h>
#import <MarketingCloudSDK/MarketingCloudSDK+ClientData.h>
#import <MarketingCloudSDK/MarketingCloudSDK+CloudPage.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Helpers.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Location.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Notifications.h>
#import <MarketingCloudSDK/MarketingCloudSDK+OpenDirect.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Recommendations.h>
#import <MarketingCloudSDK/MarketingCloudSDK+LandingPageWebView.h>

#import <MarketingCloudSDK/MarketingCloudSDKCloudPageObject.h>
#import <MarketingCloudSDK/MarketingCloudSDKEventMessageObject.h>
#import <MarketingCloudSDK/MarketingCloudSDKEventRegionObject.h>
#import <MarketingCloudSDK/MarketingCloudSDKCartItemObject.h>
#import <MarketingCloudSDK/MarketingCloudSDKCartObject.h>
#import <MarketingCloudSDK/MarketingCloudSDKOrderObject.h>


#endif /* MarketingCloudSDK_h */
