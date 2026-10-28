//
//  MarketingCloudSDK+InboxMessages.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>
#import <SFMCSDK/SFMCSdk.h>

/** key used in notification payload to determine an inbox message's content  */
FOUNDATION_EXTERN NSString * _Nonnull const MarketingCloudSDKInboxMessageKey;

/** Inbox Messages */
@interface MobilePushSDK (InboxMessages)

/**
 Get all *active* Inbox messages already downloaded from the MarketingCloud

 @return array of NSDictionaries representing Inbox messages
 
 @see Public properties in inbox message dictionary https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/inbox/inbox.html
 */
- (NSArray * _Nullable) sfmc_getAllMessages;

/**
 Get unread *active* Inbox messages (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 
 @see Public properties in inbox message dictionary https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/inbox/inbox.html
 */
- (NSArray * _Nullable) sfmc_getUnreadMessages;

/**
 Get *active* Inbox messages marked as read (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 
 @see Public properties in inbox message dictionary https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/inbox/inbox.html
 */
- (NSArray * _Nullable) sfmc_getReadMessages;

/**
 Get *active* Inbox messages marked as deleted (already downloaded from the MarketingCloud)
 
 @return array of NSDictionaries representing Inbox messages
 
 @see Public properties in inbox message dictionary https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/inbox/inbox.html
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
 Mark a Inbox message as read using messageId.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).
 
 @param messageId a string representing an Inbox message identifier
 @return a value indicatating success in setting the message to read
 */
- (BOOL) sfmc_markMessageWithIdRead:(NSString *_Nonnull) messageId;

/**
 Mark an Inbox message as deleted using messageId.
 
 Note: this information is persisted locally and would be reset if the SDK's data is reset (via app delete and reinstall, for instance).
 
 @param messageId a string representing an Inbox message identifier
 @return a value indicatating success in setting the message to deleted
 */
- (BOOL) sfmc_markMessageWithIdDeleted:(NSString *_Nonnull) messageId;

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
 Reload and refresh Inbox messages from the Marketing Cloud server.
 
Note: The underlying request to the server will be throttled such that it will execute at most every 60 seconds. If the method has been called less than 60 seconds after the preceeding method call, NO will be returned and the request will not be made. If NO is returned, best practice is that any UI used to reflect the refresh operation is updated (pull to refresh indicators, loading spinners, etc.). 

DDoS Protection

The SDK has several built in mechanisms to protect Marketing Cloud servers and services. For message GET routes, we allow at most one manual refresh request per minute. This prevents bad application implementations or mobile app users from calling refresh over and over when there will be no new data available.

Within the SDK and it’s logging, this presents a 429 - Too Many Requests log statement.

Throttling

To protect the workload and ensure optimal performance, the Inbox Message routes may throttle incoming requests. This throttling is based on adaptive logic, which operates as a percentage of traffic depending on the current load. The system is designed to automatically determine when throttling is necessary or when it can be reduced.

During periods of traffic throttling, some customer requests may receive a 429 - Too Many Requests response. This will log a 429 response within the SDK. The Marketing Cloud has considerable server-side logic to monitor and adjust this throttling mechanism.

 This method will cause notifications to be posted to NSNotificationCenter: 
 
 - SFMCInboxMessagesRefreshCompleteNotification: posted when the refresh process has completed
 - SFMCInboxMessagesNewInboxMessagesNotification: posted if there are new Inbox messages
 
  @return A BOOL value indicating that refreshing has been started.
 */
- (BOOL) sfmc_refreshMessages;

@end


