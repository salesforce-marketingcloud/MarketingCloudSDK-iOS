//
//  MarketingCloudSDKCloudPageObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 MarketingCloudSDKCloudPage class defines the cloudpage message type. The MarketingCloudSDKCloudPage object defines the inbox message properties which are used to support and store rich messages from the MarketingCloud. This class works with the MarketingCloudSDKCloudPageDataSource which is suitable for displaying the inbox UITableView.
 */
@interface MarketingCloudSDKCloudPageObject : NSObject

/**
 Encoded ID from Salesforce. Will match the ID in MobilePush. This is the primary key.
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageIdentifier;

/**
 This is the name which is set on Salesforce Marketing Cloud, while setting the message
 */
@property (nonatomic, readonly, copy, nullable) NSString *messageName;

/**
 The alert text of the message. This displays on the screen.
 */
@property (nonatomic, readonly, copy, nullable) NSString *alert;

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
 The Site URL for the ClouePage attached to this message. It is saved as an NSString and converted later to NSURL.
 */
@property (nonatomic, readonly, copy, nullable) NSString *siteUrlAsString;

/**
 OpenDirect payload for this message, if there is one.
 */
@property (nonatomic, readonly, copy, nullable) NSString *openDirectPayload;

/**
 Whether or not the message has been read. This must be set through sfmc_markAsRead by the developer.
 */
@property (nonatomic, readonly) BOOL read;

/**
 Use this for display in an inbox.
 */
@property (nonatomic, readonly, copy, nullable) NSString *subject;

/**
 A Cleansed Site URL as a proper NSURL. This is mostly for convenience.
 */
@property (nonatomic, readonly, copy, nullable) NSURL *siteURL;

/**
 Marks a message as deleted. They will not be returned after this, and it is irreversable.
 */
-(BOOL)sfmc_markAsDeleted;

/**
 Marks a message as read in the local cache. Read messages do not show up in the Inbox.
 */
-(BOOL)sfmc_markAsRead;

@end
