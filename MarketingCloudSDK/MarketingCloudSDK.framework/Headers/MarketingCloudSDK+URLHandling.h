//
//  MarketingCloudSDK+URLHandling.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2018 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

/** These type constants are used by sfmc_handleURL:type: to indicate the MarketingCloud source of the URL
 */
FOUNDATION_EXTERN NSString * _Nonnull const SFMCURLTypeCloudPage;
FOUNDATION_EXTERN NSString * _Nonnull const SFMCURLTypeOpenDirect;
FOUNDATION_EXTERN NSString * _Nonnull const SFMCURLTypeAction;


@protocol MarketingCloudSDKURLHandlingDelegate <NSObject>

@required

/**
 This method, if implemented, can be called when a Alert+CloudPage, Alert+OpenDirect, Alert+Inbox or Inbox message is processed by the SDK.
 Implementing this method allows the application to handle the URL from Marketing Cloud data.
 
 Prior to the MobilePush SDK version 6.0.0, the SDK would automatically handle these URLs and present them using a SFSafariViewController.
 
 Given security risks inherent in URLs and web pages (Open Redirect vulnerabilities, especially), the responsibility of processing the URL shall be held by the application implementing the MobilePush SDK. This reduces risk to the application by affording full control over processing, presentation and security to the application code itself.
 
 @param url value NSURL sent with the Location, CloudPage, OpenDirect or Inbox message
 @param type value NSInteger enumeration of the MobilePush source type of this URL
 */
-(void) sfmc_handleURL:(NSURL *) url type:(NSString * _Nonnull) type;

@end

@interface MarketingCloudSDK (URLHandling)

/**
 Method to set a delegate implmenting the MarketingCloudSDKURLHandlingDelegate.
 
 @param delegate value A class adhering to the MarketingCloudSDKURLHandlingDelegate and implementing the required method.
 */
-(void)sfmc_setURLHandlingDelegate:(id<MarketingCloudSDKURLHandlingDelegate> _Nullable)delegate;

@end


