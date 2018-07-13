//
//  MarketingCloudSDK+Events.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>


@protocol MarketingCloudSDKEventProtocol <NSObject>
@optional

- (BOOL) sfmc_inAppMessageShouldShow:(NSString * _Nonnull) triggerKey message:(NSDictionary * _Nullable) message;
- (void) sfmc_inAppMessageDidShow:(NSString * _Nonnull) triggerKey message:(NSDictionary * _Nullable) message;
- (void) sfmc_inAppMessageDidNotShow:(NSString * _Nonnull) triggerKey message:(NSDictionary * _Nullable) message;
- (void) sfmc_inAppMessageButtonTapped:(NSString * _Nonnull) triggerKey message:(NSDictionary * _Nullable) message button:(NSDictionary * _Nonnull)button;

@end

@interface MarketingCloudSDK (Events)

- (void) sfmc_logEvent:(NSArray * _Nonnull) events;
- (void) sfmc_logEvent:(NSArray * _Nonnull) events delegate:(id<MarketingCloudSDKEventProtocol> _Nullable) delegate;

- (BOOL) sfmc_addEventDelegate:(id<MarketingCloudSDKEventProtocol> _Nonnull) delegate;
- (BOOL) sfmc_removeEventDelegate:(id<MarketingCloudSDKEventProtocol> _Nonnull) delegate;


// Event creators

// custom event
- (NSDictionary * _Nullable) sfmc_event:(NSString * _Nonnull) eventName;

- (NSDictionary * _Nullable) sfmc_completeAnyPurchaseEvent;

- (NSDictionary * _Nullable) sfmc_completeMinimumPurchaseEventComparatorString:(NSString * _Nonnull) value;
- (NSDictionary * _Nullable) sfmc_completeMinimumPurchaseEventComparatorInteger:(NSInteger) value;
- (NSDictionary * _Nullable) sfmc_completeMinimumPurchaseEventComparatorDouble:(double) value;
- (NSDictionary * _Nullable) sfmc_completeMinimumPurchaseEventComparatorBoolean:(BOOL) value;

- (NSDictionary * _Nullable) sfmc_completeSpecificPurchaseEventComparatorString:(NSString * _Nonnull) value;
- (NSDictionary * _Nullable) sfmc_completeSpecificPurchaseEventComparatorInteger:(NSInteger) value;
- (NSDictionary * _Nullable) sfmc_completeSpecificPurchaseEventComparatorDouble:(double) value;
- (NSDictionary * _Nullable) sfmc_completeSpecificPurchaseEventComparatorBoolean:(BOOL) value;

- (NSDictionary * _Nullable) sfmc_completeConversionEvent;
- (NSDictionary * _Nullable) sfmc_completeConversionEventComparatorString:(NSString * _Nonnull) value;
- (NSDictionary * _Nullable) sfmc_completeConversionEventComparatorInteger:(NSInteger) value;
- (NSDictionary * _Nullable) sfmc_completeConversionEventComparatorDouble:(double) value;
- (NSDictionary * _Nullable) sfmc_completeConversionEventComparatorBoolean:(BOOL) value;

- (NSDictionary * _Nullable) sfmc_appVersionEventComparatorString:(NSString * _Nonnull) value;
- (NSDictionary * _Nullable) sfmc_appVersionEventComparatorInteger:(NSInteger) value;
- (NSDictionary * _Nullable) sfmc_appVersionEventComparatorDouble:(double) value;
- (NSDictionary * _Nullable) sfmc_appVersionEventComparatorBoolean:(BOOL) value;

- (NSDictionary * _Nullable) sfmc_goalEvent;
- (NSDictionary * _Nullable) sfmc_goalEventComparatorString:(NSString * _Nonnull) value;
- (NSDictionary * _Nullable) sfmc_goalEventComparatorInteger:(NSInteger) value;
- (NSDictionary * _Nullable) sfmc_goalEventComparatorDouble:(double) value;
- (NSDictionary * _Nullable) sfmc_goalEventComparatorBoolean:(BOOL) value;

@end
