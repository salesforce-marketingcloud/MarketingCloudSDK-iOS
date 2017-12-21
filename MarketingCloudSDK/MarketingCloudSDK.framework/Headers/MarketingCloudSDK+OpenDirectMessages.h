//
//  MarketingCloudSDK+OpenDirectMessages.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

FOUNDATION_EXTERN NSString * _Nonnull const MarketingCloudSDKOpenDirectMessageKey;

/**
 Supporting protocol for OpenDirect with Alert, part of the Salesforce 2016-04 release.
 
 Implementation of this delegate is not required for OpenDirect with Alert to function, but it is provided as a convenience to developers who do not wish to parse the push payload on their own.
 
 All OpenDirect data is passed down as a JSON String, the MarketingCloud SDK will parse and return as a NSDictionary. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting a OpenDirect with Alert Delegate will negate the automatic webpage load feature in the MarketingCloud SDK.
 */
@protocol MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate <NSObject>

@required
/**
 Method called when notification containing a OpenDirect message payload is received.
 
 @param openDirectMessage value NSDictionary representing a OpenDirect message
 */
-(void) sfmc_didReceiveOpenDirectMessagesNotificationWithContents:(NSDictionary * _Nullable) openDirectMessage;

@end

@interface MarketingCloudSDK (OpenDirectMessages)

/**
 Set a delegate class (adhering to the MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate protocol) to implment a handler for an OpenDirect payload as part of a push notification

 @param delegate the class implementing sfmc_didReceiveOpenDirectMessagesNotificationWithContents:
 */
-(void)sfmc_setOpenDirectMessagesNotificationHandlerDelegate:(id<MarketingCloudSDKOpenDirectMessagesNotificationHandlerDelegate> _Nullable)delegate;

@end
