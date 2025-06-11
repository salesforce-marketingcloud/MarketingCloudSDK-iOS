//
//  SFMCEvent.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2020 Salesforce, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Required protocol for creating event objects to be passed into the SDK
@protocol SFMCEvent <NSObject>
@required

/// Event Key
- (nonnull NSString *) key;

/// Event Id
- (nullable NSString *) eventId;

/// Key value pair of data to be passed
- (nullable NSDictionary<NSString *, id> *) parameters;
@end

/// Authentication Event Types Enum
typedef NS_ENUM(NSInteger, AuthEventType) {
/// Login Event
  LOGIN
};

/// Event class
@interface SFMCEvent : NSObject

/// Method to return a custom event with key.
/// @param key The custom event key
+ (nullable id <SFMCEvent>) customEventWithName:(nonnull NSString *) key;

/// Method to return a custom event with key and id.
/// @param key The custom event key
+ (nullable id <SFMCEvent>) customEventWithName:(nonnull NSString *) key withEventId: (nonnull NSString *) eventId;

/// Method to return a custom event with key and  parameters.
/// @param key The custom event key
/// @param parameters Custom event parameters
+ (nullable id <SFMCEvent>) customEventWithName:(nonnull NSString *) key withAttributes: (nonnull NSDictionary<NSString *, id> *)parameters;

/// Method to return a custom event with key, id,  and  parameters.
/// @param key The custom event key
/// @param parameters Custom event parameters
+ (nullable id <SFMCEvent>) customEventWithName:(nonnull NSString *) key withEventId: (nonnull NSString *)eventId withAttributes: (nonnull NSDictionary<NSString *, id> *)parameters;

@end
