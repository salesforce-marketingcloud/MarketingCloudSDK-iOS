//
//  MarketingCloudSDK.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_12_0
#error IPHONEOS_DEPLOYMENT_TARGET must be 12.0 or above!
#endif

#import <UIKit/UIKit.h>

#import <MarketingCloudSDK/MarketingCloudSDK+Base.h>
#import <MarketingCloudSDK/SFMCEvent.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Intelligence.h>
#import <MarketingCloudSDK/MarketingCloudSDK+InboxMessages.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Location.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Constants.h>
#import <MarketingCloudSDK/MarketingCloudSDK+URLHandling.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Events.h>
#import <MarketingCloudSDK/MarketingCloudSDK+FeatureToggle.h>
#import <MarketingCloudSDK/MarketingCloudSDKConfigBuilder.h>
#if __has_include("MarketingCloudSDK/MarketingCloudSDK-Swift.h")
#import <MarketingCloudSDK/MarketingCloudSDK-Swift.h>
#endif
