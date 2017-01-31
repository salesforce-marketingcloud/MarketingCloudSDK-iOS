//
//  MarketingCloudSDK+OpenDirect.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

#pragma mark - Protocol

/**
 Supporting protocol for OpenDirect, part of the Salesforce 2013-02 release.
 
 Implementation of this delegate is not required for OpenDirect to function, but it is provided as a convenience to developers who do not with to parse the push payload on their own.
 
 All OpenDirect data is passed down as a JSON String, so you get it as an NSString. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting an OpenDirect Delegate will negate the automatic webpage loading feature added to MobilePush recently. This is deliberately to not stomp on your URLs and deep links.
 */
@protocol MarketingCloudSDKOpenDirectDelegate <NSObject>

/**
 Method called when an OpenDirect payload is received from MobilePush.
 
 @param payload value NSString. The contents of the payload as received from MobilePush.
 */
-(void)sfmc_didReceiveOpenDirectMessageWithContents:(NSString * _Nonnull)payload;

#pragma mark - Optional

@optional

/**
 Allows you to define the behavior of OpenDirect based on application state.
 
 If set to YES, the OpenDirect delegate will be called if a push with an OpenDirect payload is received and the application state is running. This is counter to normal push behavior, so the default is NO.
 
 Consider that if you set this to YES, and the user is running the app when a push comes in, the app will start doing things that they didn't prompt it to do. This is bad user experience since it's confusing to the user. Along these lines, iOS won't present a notification if one is received while the app is running.
 
 @return BOOL representing whether or not you want action to be taken.
 */
-(BOOL)sfmc_shouldDeliverOpenDirectMessageIfAppIsRunning;

@end

@interface MarketingCloudSDK (OpenDirect)

/**
 Sets the OpenDirect delegate.
 
 @param delegate The object you wish to be called when an OpenDirect message is delivered.
 */
-(void)sfmc_setOpenDirectDelegate:(id<MarketingCloudSDKOpenDirectDelegate> _Nullable)delegate;

/**
 Returns the OpenDirect delegate.
 
 @return delegate The named MarketingCloudSDKOpenDirect delegate, or nil if there isn't one.
 */
-(id<MarketingCloudSDKOpenDirectDelegate> _Nullable)sfmc_openDirectDelegate;



@end
