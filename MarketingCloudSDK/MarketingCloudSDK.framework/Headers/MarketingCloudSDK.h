//
//  MarketingCloudSDK.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
#error IPHONEOS_DEPLOYMENT_TARGET must be 9.0 or above!
#endif

#import <UIKit/UIKit.h>

#import <MarketingCloudSDK/MarketingCloudSDK+Base.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Intelligence.h>
#import <MarketingCloudSDK/MarketingCloudSDK+InboxMessages.h>
#import <MarketingCloudSDK/MarketingCloudSDK+Location.h>
//TODO:IAM Only
#ifdef INCLUDE_IAM
#import <MarketingCloudSDK/MarketingCloudSDK+Events.h>
#endif
#import <MarketingCloudSDK/MarketingCloudSDK+Constants.h>
#import <MarketingCloudSDK/MarketingCloudSDK+URLHandling.h>
#import <MarketingCloudSDK/MarketingCloudSDKConfigBuilder.h>

