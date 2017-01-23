//
//  MarketingCloudSDKEventRegionObject.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

/**---------------------------------------------------------------------------------------
 * @name Representation of a shopping cart item for analytics usage.
 *  ---------------------------------------------------------------------------------------
 */
@interface MarketingCloudSDKCartItem : NSObject <NSCoding, NSCopying>

/**
 Initialize a Cart Item object for use in analytics.
 
 @param price The price amount (USD) of this item (non-nil value; 0 permissable)
 @param quantity The count of items in the cart for this particular product (non-nil value; 0 permissable)
 @param item The unique product code from the e-commerce system representing this cart item (non-nil string value)
 @return instancetype a MarketingCloudSDKCartItem
 */
- (instancetype _Nullable)initWithPrice:(NSNumber * _Nonnull)price quantity:(NSNumber * _Nonnull)quantity item:(NSString * _Nonnull)item NS_DESIGNATED_INITIALIZER;

/**
 Convert MarketingCloudSDKCartItem to dictionary.
 
 @return NSDictionary
 */
- (NSDictionary * _Nonnull)dictionaryRepresentation;

@end
