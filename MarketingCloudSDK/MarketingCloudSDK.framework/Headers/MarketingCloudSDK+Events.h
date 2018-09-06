//
//  MarketingCloudSDK+Events.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>


/**
 Supporting protocol for In-App Messaging, part of the Salesforce Marketing Cloud October 2018 release.
 
 Implementation of this protocol is not required for In-App Messaging to work, although it provides addition control for an application developer.
 
 In-App messages are presented by the MobilePush SDK in an application's context, inserted into the view hierarchy atop the application's topmost view controller.
 
 This protocol allows for awareness into the SDK's lifecycle for In-App Messages.
 */
@protocol MarketingCloudSDKEventProtocol <NSObject>
@optional

/**
 Method called by the SDK when an In-App Message is ready to be shown. The delegate implementing this method returns YES or NO.
 
 YES indicates to the SDK that this message is able to be shown (allowed by the application).
 
 NO indicates that the SDK should not show this message. An application may return NO if its visual hierarchy or user flow is such that an interruption would not be acceptable to the usability or functionality of the application.
 
 If NO is returned, the application may capture the message's identifier (via sfmc_messageIdForMessage:) and attempt to show that message later via sfmc_showInAppMessage:.
 
 Note: if ANY delegate returns NO from this method, the In-App Message will not be presented.
 
 @param message NSDictionary representing an In-App Message
 
 @return value reflecting application's behavior
 */
- (BOOL) sfmc_shouldShowInAppMessage:(NSDictionary * _Nonnull) message;

/**
 Method called by the SDK when an In-App Message has been shown.

 @param message NSDictionary representing an In-App Message
 */
- (void) sfmc_didShowInAppMessage:(NSDictionary * _Nonnull) message;

/**
 Method called by the SDK when an In-App Message has been closed.
 
 @param message NSDictionary representing an In-App Message
 */
- (void) sfmc_didCloseInAppMessage:(NSDictionary * _Nonnull) message;

@end

@interface MarketingCloudSDK (Events)

/**
 Add a delegate class (adhering to the MarketingCloudSDKEventProtocol protocol) to implment methods for In-App Message lifecycle events.

 @param delegate the class implementing the MarketingCloudSDKEventProtocol.
 
 @return value indicating that the delegate was added to the SDK
 */
- (BOOL) sfmc_addEventDelegate:(id<MarketingCloudSDKEventProtocol> _Nonnull) delegate;

/**
 Remove a delegate class (adhering to the MarketingCloudSDKEventProtocol protocol).
 
 @param delegate the class implementing the MarketingCloudSDKEventProtocol.
 
 @return value indicating that the delegate was removed from the SDK
 */
- (BOOL) sfmc_removeEventDelegate:(id<MarketingCloudSDKEventProtocol> _Nonnull) delegate;

/**
 Extract a message identifier for an In-App Message dictionary (provided in the MarketingCloudSDKEventProtocol methods).
 
 @param message NSDictionary representing an In-App Message
 
 @return string value of the message identifier
 */
- (NSString *) sfmc_messageIdForMessage:(NSDictionary * _Nonnull) message;

/**
 When called, instructs the SDK to attempt to display the In-App Message. This will cause the MarketingCloudSDKEventProtocol methods to be called, if implemented.
 
 @param messageId identifier of In-App Message
 */
- (void) sfmc_showInAppMessage:(NSString * _Nonnull) messageId;

@end
