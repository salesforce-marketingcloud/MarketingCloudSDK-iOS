//
//  MarketingCloudSDK+Events.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>
#import <MarketingCloudSDK/SFMCEvent.h>
/**
 Supporting protocol for In-App Messaging
 
 Implementation of this protocol is not required for In-App Messaging to work, although it provides addition control for an application developer.
 
 In-App messages are presented by the MobilePush SDK in an application's context, inserted into the view hierarchy atop the application's topmost view controller.
 
 This protocol allows for awareness into the SDK's lifecycle for In-App Messages.
 */
@protocol MarketingCloudSDKEventDelegate <NSObject>
@optional

/**
 Method called by the SDK when an In-App Message is ready to be shown. The delegate implementing this method returns YES or NO.
 
 YES indicates to the SDK that this message is able to be shown (allowed by the application).
 
 NO indicates that the SDK should not show this message. An application may return NO if its visual hierarchy or user flow is such that an interruption would not be acceptable to the usability or functionality of the application.
 
 If NO is returned, the application may capture the message's identifier (via sfmc_messageIdForMessage:) and attempt to show that message later via sfmc_showInAppMessage:.
 
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

/** Events */
@interface MarketingCloudSDK (Events)

/**
 Method to set a delegate class (adhering to the MarketingCloudSDKEventDelegate protocol) to implment methods for In-App Message lifecycle events.
 
 @param delegate the class implementing the MarketingCloudSDKEventDelegate.
 */
- (void) sfmc_setEventDelegate:(id<MarketingCloudSDKEventDelegate> _Nullable)delegate;

/**
 Extract a message identifier for an In-App Message dictionary (provided in the MarketingCloudSDKEventDelegate methods).
 
 @param message NSDictionary representing an In-App Message
 
 @return string value of the message identifier
 */
- (NSString *_Nullable) sfmc_messageIdForMessage:(NSDictionary * _Nonnull) message;

/**
 When called, instructs the SDK to attempt to display the In-App Message. This will cause the MarketingCloudSDKEventDelegate methods to be called, if implemented.
 
 @param messageId identifier of In-App Message
 */
- (void) sfmc_showInAppMessage:(NSString * _Nonnull) messageId;

/**
 When called, sets the font for In-App Message display.
 
 @param fontName name of font installed on device or built into application. Note: this may be different than the font family name. If nil, the SDK default (system font) will be used.
 @return value of YES indicating that the font name is valid and can be used, NO if the font name is not valid. If nil is passed as fontName, YES will be returned.
 */
- (BOOL) sfmc_setInAppMessageFontName:(NSString * _Nullable) fontName;

/**
 Method to track events, which could result in actions such as an In-App Message displaying.
 @param events event or an array of events to trigger.
 */

- (void) sfmc_track:(nullable id) events;
@end
