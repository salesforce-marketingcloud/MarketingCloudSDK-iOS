//
//  MarketingCloudSDK+Intelligence.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

#import <MarketingCloudSDK/MarketingCloudSDK.h>

@interface MarketingCloudSDK (Intelligence)

/**
 Set the identifier to associate with Predictive Intelligence data sent to Salesforce Marketing Cloud
 
 The clear the value, pass a nil value.
 
 Will trim leading and trailing whitespace from the string.
 
 An identifier will persist until it is cleared or changed and will used to associate with all analytic events generated while set.
 
 @param identifier The string you want to associate analytics with.
 @return YES if set successfully.
 */
- (BOOL)sfmc_setPiIdentifier:( NSString * _Nullable)identifier;

/**
 Returns a read-only copy of the Analytics identity set
 
 @return All attributes currently set.
 */
- (NSString * _Nullable)sfmc_piIdentifier;


/**
 When an Inbox message is opened (for instance, you implement an inbox and present the CloudPage URL in your webview) this method should be called with the Inbox message so that the MarketingCloudSDK can track the proper analytics and state of the message.

 @param inboxMessage a non-nil NSDictionary object representing an Inbox message
 */
-(void) sfmc_trackMessageOpened:(NSDictionary *_Nonnull) inboxMessage;

/**
 Track page views within your application.
 @param url a non-nil NSString to identify the location within your app traversed by your customers.  For example: com.yourpackage.viewcontrollername
 @param title a NSString (nil if n/a) to identify the title of the location within your app traversed by your customers. For example: Screen Name
 @param item a NSString (nil if n/a) to identify an item viewed by your customer.  For example: UPC-1234
 @param search a NSString (nil if n/a) to identify search terms used by your customer.  For example: blue jeans.
 */
-(void) sfmc_trackPageViewWithURL:(NSString * _Nonnull)url title:(NSString * _Nullable)title item:(NSString *_Nullable)item search:(NSString * _Nullable)search;

/**
 Track cart contents within your application.
 @param cartDictionary a non-nil NSDictionanry object containing a cartID and an array of cart item dictionaries
 */
- (void) sfmc_trackCartContents:(NSDictionary * _Nonnull) cartDictionary;

/**
 Track cart conversion within your application.
 @param orderDictionary a non-nil NSDictionanry object representing an order; created from a cart and cart items and "converted" into a sale of some sort
 */
- (void) sfmc_trackCartConversion:(NSDictionary * _Nonnull) orderDictionary;

/**
 Initialize a Cart Item dictionary for use in analytics.
 
 @param price The price amount (USD) of this item (non-nil value; 0 permissable)
 @param quantity The count of items in the cart for this particular product (non-nil value; greater than zero)
 @param item The unique product code from the e-commerce system representing this cart item (non-nil string value)
 @param uniqueId The unique product id. from the e-commerce system representing this cart item (string value; nil permissable)
 @return instancetype a NSDictionary representing a cart item.
 */
- (NSDictionary *_Nullable) sfmc_cartItemDictionaryWithPrice:(NSNumber *_Nonnull)price quantity:(NSNumber *_Nonnull)quantity item:(NSString *_Nonnull)item uniqueId:(NSString *_Nullable) uniqueId;

/**
 Initialize a Cart dictionary for use in analytics.
 
 @param cartItemDictionaryArray An array of cart item dictionary objects (non-nil array). An empty array indicates an empty cart, and will be used to indicate a cleared cart to the analytics system.
 @return instancetype a MarketingCloudSDKCart.
 */
- (NSDictionary *_Nullable) sfmc_cartDictionaryWithCartItemDictionaryArray:(NSArray *_Nonnull) cartItemDictionaryArray;

/**
 Initialize an Order dictionary for use in analytics.
 
 @param orderNumber The order number of from the e-commerce system (non-nil string)
 @param shipping The shipping amount (USD) of this order (non-nil value; 0 permissable)
 @param discount The discount amount (USD) of this order (non-nil value; 0 permissable)
 @param cartDictionary The order's shopping cart object (non-nil object)
 @return instancetype a NSDictionary representing an order.
 */
- (NSDictionary *_Nullable) sfmc_orderDictionaryWithOrderNumber:(NSString *_Nonnull) orderNumber shipping:(NSNumber *_Nonnull) shipping discount:(NSNumber *_Nonnull) discount cart:(NSDictionary *_Nonnull) cartDictionary;


@end
