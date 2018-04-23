//
//  MarketingCloudSDK+CloudPageMessages.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

FOUNDATION_EXTERN NSString * _Nonnull const MarketingCloudSDKCloudPageMessageKey;

/**
 Supporting protocol for Alert with CloudPage, part of the Salesforce 213 release.
 
 Implementation of this delegate is not required for Alert with CloudPage to function, but it is provided as a convenience to developers who do not wish to parse the push payload on their own.
 
 All CloudPage data is passed down as a JSON String, the MarketingCloud SDK will parse and return as a NSDictionary. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting a Alert with CloudPage Delegate will negate the automatic webpage load feature in the MarketingCloud SDK.
 */
@protocol MarketingCloudSDKCloudPageMessagesNotificationHandlerDelegate <NSObject>

@required
/**
 Method called when notification containing a CloudPage message payload is received.
 
 @param cloudPageMessage value NSDictionary representing a CloudPage message
 */
-(void) sfmc_didReceiveCloudPageMessagesNotificationWithContents:(NSDictionary * _Nullable) cloudPageMessage;

@end

@interface MarketingCloudSDK (CloudPageMessages)

/**
 Set a delegate class (adhering to the MarketingCloudSDKCloudPageMessagesNotificationHandlerDelegate protocol) to implment a handler for an CloudPage payload as part of a push notification

 @param delegate the class implementing sfmc_didReceiveCloudPageMessagesNotificationWithContents:
 */
-(void)sfmc_setCloudPageMessagesNotificationHandlerDelegate:(id<MarketingCloudSDKCloudPageMessagesNotificationHandlerDelegate> _Nullable)delegate;

@end
