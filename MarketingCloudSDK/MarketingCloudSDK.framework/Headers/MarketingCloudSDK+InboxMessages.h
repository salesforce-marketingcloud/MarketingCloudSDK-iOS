//
//  MarketingCloudSDK+InboxMessages.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

FOUNDATION_EXTERN NSString * _Nonnull const MarketingCloudSDKInboxMessageKey;

/**
 The MarketingCloudSDKInboxMessagesDataSource is an interface object for Inbox support. It was designed to be used as the datasource for a UITableView, and can be allocated and used as such without too much other customization. Of course, you are welcomed to use it any way you want other than that.
 
 Should you wish to customize the display of the Data Source, you should subclass from here. At that time, you may override any typical UITableViewDataSource protocol members. You will likely be the most interested in cellForRowAtIndexPath:. If you do, you can access the current message by asking the messages array for the object corresponding to your NSIndexPath row. It will be a NSDictionary object representing an Inbox object.
 */
@interface MarketingCloudSDKInboxMessagesDataSource : NSObject <UITableViewDataSource>

/**
 Create an instance of a basic UITableView data source to handle all loading for a simple view controller showing Inbox messages.
 
 @param sdk An instance of MarketingCloudSDK.
 @param tableView The UITableView used in the view controller. The data source will "own" population of the data and display of simple cells.
 @return An instance of MarketingCloudSDKInboxMessagesDataSource, a class which implements a simple set of methods from the UITableViewDataSource protocol.
 */
-(id _Nullable) initWithMarketingCloudSDK:(MarketingCloudSDK * _Nonnull) sdk tableView:(UITableView * _Nonnull) tableView;

@end


/**
 The MarketingCloudSDKInboxMessagesDelegate is an interface object for Inbox support. It was designed to be used as a simple delegate for a UITableView, and can be allocated and used as such without too much other customization. It only supports tableView:didSelectRowAtIndexPath: to offer (along with the data source) a VERY simple inbox implementation.
 */
@interface MarketingCloudSDKInboxMessagesDelegate : NSObject <UITableViewDelegate>

/**
 Create an instance of a basic UITableView delegate to handle cell selection for a simple view controller showing Inbox messages.
 
 @param sdk An instance of MarketingCloudSDK.
 @param tableView The UITableView used in the view controller. The delegate will "own" selection of the cells.
 @param dataSource An instance of MarketingCloudSDKInboxMessagesDataSource, a class which implements a simple set of methods from the UITableViewDataSource protocol.
 @return An instance of MarketingCloudSDKInboxMessagesDelegate, a class which implements a simple set of methods from the UITableViewDelegate protocol.
 */
-(id _Nullable) initWithMarketingCloudSDK:(MarketingCloudSDK * _Nonnull) sdk tableView:(UITableView * _Nonnull) tableView dataSource:(MarketingCloudSDKInboxMessagesDataSource * _Nonnull) dataSource;

@end


/**
 Supporting protocol for CloudPage Inbox with Alert, part of the Salesforce 2016-04 release.
 
 Implementation of this delegate is not required for CloudPage Inbox with Alert to function, but it is provided as a convenience to developers who do not wish to parse the push payload on their own.
 
 All CloudPage Inbox data is passed down as a JSON String, the MarketingCloud SDK will parse and return as a NSDictionary. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting a CloudPage Inbox with Alert Delegate will negate the automatic webpage load to inbox feature in the MarketingCloud SDK.
 */
@protocol MarketingCloudSDKInboxMessagesNotificationHandlerDelegate <NSObject>

@required

/**
 Method called when notification containing an inbox message payload is received.
 
 @param inboxMessage value NSDictionary representing an Inbox message
 */
-(void) sfmc_didReceiveInboxMessagesNotificationWithContents:(NSDictionary * _Nullable) inboxMessage;

@end

@interface MarketingCloudSDK (InboxMessages)

/**
 Get all *active* Inbox messages already downloaded from the MarketingCloud

 @return array of NSDictionaries representing Inbox messages
 */
- (NSArray * _Nullable) sfmc_getAllMessages;

/**
 Get unread *active* Inbox messages (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 */
- (NSArray * _Nullable) sfmc_getUnreadMessages;

/**
 Get *active* Inbox messages marked as read (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 */
- (NSArray * _Nullable) sfmc_getReadMessages;

/**
 Get *active* Inbox messages marked as deleted (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 */
- (NSArray * _Nullable) sfmc_getDeletedMessages;

/**
 Get count of all *active* Inbox messages already downloaded from the MarketingCloud.
 
 Useful for inbox count badges or other interface elements, without having to fetch messages directly.
 
 @return number of messages
 */
- (NSUInteger) sfmc_getAllMessagesCount;

/**
 Get count of unread *active* Inbox messages (already downloaded from the MarketingCloud)
 
 Useful for inbox count badges or other interface elements, without having to fetch messages directly.
 
 @return number of messages
 */
- (NSUInteger) sfmc_getUnreadMessagesCount;

/**
 Get count of *active* Inbox messages marked as read (already downloaded from the MarketingCloud)
 
 Useful for inbox count badges or other interface elements, without having to fetch messages directly.
 
 @return number of messages
 */
- (NSUInteger) sfmc_getReadMessagesCount;

/**
 Get count of *active* Inbox messages marked as deleted (already downloaded from the MarketingCloud)
 
 Useful for inbox count badges or other interface elements, without having to fetch messages directly.
 
 @return number of messages
 */
- (NSUInteger) sfmc_getDeletedMessagesCount;

/**
 Mark a Inbox message as read.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).

 @param messageDictionary a dictionary representing an Inbox message
 @return a value indicatating success in setting the message to read
 */
- (BOOL) sfmc_markMessageRead:(NSDictionary *_Nonnull) messageDictionary;

/**
 Mark an Inbox message as deleted.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).
 
 @param messageDictionary a dictionary representing an Inbox message
 @return a value indicatating success in setting the message to deleted
 */
- (BOOL) sfmc_markMessageDeleted:(NSDictionary *_Nonnull) messageDictionary;

/**
 Mark all Inbox messages as read.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).
 
 @return a value indicatating success in setting the messages to read
 */
- (BOOL) sfmc_markAllMessagesRead;

/**
 Mark all Inbox messages as deleted.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).
 
 @return a value indicatating success in setting the messages to deleted
 */
- (BOOL) sfmc_markAllMessagesDeleted;

/**
 Reload and refresh Inbox messages from the MarketingCloud server.
 
 This method will cause notifications to be posted to NSNotificationCenter: 
 
 - SFMCInboxMessagesRefreshCompleteNotification: posted when the refresh process has completed
 - SFMCInboxMessagesNewInboxMessagesNotification: posted if there are new Inbox messages
 */
- (void) sfmc_refreshMessages;

/**
 Create an instance of a basic UITableView data source to handle all loading for a simple view controller showing Inbox messages.

 @param tableView The UITableView used in the view controller. The data source will "own" population of the data and display of simple cells.
 @return An instance of MarketingCloudSDKInboxMessagesDataSource, a class which implements a simple set of methods from the UITableViewDataSource protocol.
 */
- (MarketingCloudSDKInboxMessagesDataSource * _Nullable) sfmc_inboxMessagesTableViewDataSourceForTableView:(UITableView * _Nonnull) tableView;

/**
 Create an instance of a basic UITableView delegate to handle cell selection for a simple view controller showing Inbox messages.

 @param tableView The UITableView used in the view controller. The delegate will "own" selection of the cells.
 @param dataSource An instance of MarketingCloudSDKInboxMessagesDataSource, a class which implements a simple set of methods from the UITableViewDataSource protocol.
 @return An instance of MarketingCloudSDKInboxMessagesDelegate, a class which implements a simple set of methods from the UITableViewDelegate protocol.
 */
- (MarketingCloudSDKInboxMessagesDelegate * _Nullable) sfmc_inboxMessagesTableViewDelegateForTableView:(UITableView * _Nonnull) tableView dataSource:(MarketingCloudSDKInboxMessagesDataSource * _Nonnull) dataSource;

/**
 Set a delegate class (adhering to the MarketingCloudSDKInboxMessagesNotificationHandlerDelegate protocol) to implment a handler for an Inbox payload as part of a push notification
 
 @param delegate the class implementing sfmc_didReceiveInboxMessagesNotificationWithContents:
 */
-(void)sfmc_setInboxMessagesNotificationHandlerDelegate:(id<MarketingCloudSDKInboxMessagesNotificationHandlerDelegate> _Nullable)delegate;

@end


