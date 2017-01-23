//
//  MarketingCloudSDKEventMessageObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketingCloudSDK.h"

/**
 MarketingCloudSDKEventMessage is the local representation of a Message from Salesforce. They are multipurpose, sometimes representing a message that should be scheduled because of the entrance or exit of a Geofence, the proximal arrival to an iBeacon, or a CloudPage message downloaded from Salesforce Marketing Cloud. Because of their multipurpose nature, there are a lot of different attributes on them, many of which may be null at any give time depending on the type of message.
 */

@interface MarketingCloudSDKEventMessageObject : NSObject

/**
 Encoded ID from Salesforce. Will match the ID in MobilePush. This is the primary key.
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageIdentifier;

/**
 This is the name which is set on Salesforce Marketing Cloud, while setting the message
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageName;

/**
 The type of ETMessage being represented.
 */
@property (nonatomic, readonly) MarketingCloudSDKMobilePushMessageType messageType;

/**
 Bitmask of features that this message has on it (CloudPage, Push only)
 */
@property (nonatomic, readonly) MarketingCloudSDKMobilePushContentType contentType;

/**
 The alert text of the message. This displays on the screen.
 */
@property (nonatomic, readonly, copy, nullable) NSString *alert;

/**
 The sound that should play, if any. Most of the time, either "default" or "custom.caf", conventions enforced in MobilePush.
 */
@property (nonatomic, readonly, copy, nullable) NSString *sound;

/**
 The badge modifier. This should be a NSString in the form of "+1" or nothing at all. It's saved as a string because of that.
 */
@property (nonatomic, readonly, copy, nullable) NSString *badge;

/**
 The category name for an interactive notification if it has one.
 */
@property (nonatomic, readonly, copy, nullable) NSString *category;

/**
 An array of Key Value Pairs, or Custom Keys in local parlance, for this message. This will contain NSDictionary objects.
 */
@property (nonatomic, readonly, copy, nullable) NSArray *keyValuePairs;

/**
 The message's start date. Messages shouldn't show before this time.
 */
@property (nonatomic, readonly, copy, nullable) NSDate *startDate;

/**
 The message's end date. Messages shouldn't show after this time.
 */
@property (nonatomic, readonly, copy, nullable) NSDate *endDate;

/**
 The Site URL for the CloudPage attached to this message. 
 */
@property (nonatomic, readonly, copy, nullable) NSString *siteUrlAsString;

/**
 OpenDirect payload for this message, if there is one.
 */
@property (nonatomic, readonly, copy, nullable) NSString *openDirectPayload;

/**
 Use this for display in an inbox.
 */
@property (nonatomic, readonly, copy, nullable) NSString *subject;

/**
 A Cleansed Site URL as a proper NSURL. This is mostly for convenience.
 */
@property (nonatomic, readonly, copy, nullable) NSURL *siteURL;

@end
