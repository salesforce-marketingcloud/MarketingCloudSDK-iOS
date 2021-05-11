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
+ (nullable id <SFMCEvent>) customEventWithKey:(nonnull NSString *) key;

/// Method to return a custom event with key and  parameters.
/// @param key The custom event key
/// @param parameters Custom event parameters
+ (nullable id <SFMCEvent>) customEventWithKey:(nonnull NSString *) key withParameters: (nonnull NSDictionary<NSString *, id> *)parameters;


/// Parse and trim parameters for event creation. Validate key, trim, drop if criteria not met.
/// @param parameters for preparation.
/// @return parsed parameters
+ (nullable NSDictionary<NSString *, id> *) parseAndTrim:(nonnull NSDictionary<NSString *, id> *)parameters;

/// Validate and prepare the key to meet requirements.
/// @param key The custom event key
/// @return key
+ (nullable NSString *) validateAndPrepareKey: (nonnull id) key;
@end
