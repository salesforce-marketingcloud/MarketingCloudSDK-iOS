//
//  MarketingCloudSDK+CloudPage.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"
#import "MarketingCloudSDKCloudPageObject.h"

#pragma mark - Protocol

/**
 Supporting protocol for Cloud Pages with Alert, part of the Salesforce 2016-04 release.
 
 Implementation of this delegate is not required for CloudPage with Alert to function, but it is provided as a convenience to developers who do not wish to parse the push payload on their own.
 
 All CloudPage data is passed down as a JSON String, so you get it as an NSString. Please remember to parse it appropriately from there. Also, please remember to fail gracefully if you can't take action on the message.
 
 Also, please note that setting a CloudPage with Alert Delegate will negate the automatic webpage load to inbox feature added to MobilePush.
 */
@protocol MarketingCloudSDKCloudPageWithAlertDelegate <NSObject>

/**
 Method called when an Cloud Page with Alert payload is received from MobilePush.
 
 @param payload value NSString. The contents of the payload as received from MobilePush.
 */
-(void)sfmc_didReceiveCloudPageWithAlertMessageWithContents:(NSString * _Nonnull)payload;

#pragma mark - Optional

@optional

/**
 Allows you to define the behavior of Cloud Page with Alert based on application state.
 
 If set to YES, the Cloud Page with Alert delegate will be called if a push with an Cloud Page with Alert payload is received and the application state is running. This is counter to normal push behavior, so the default is NO.
 
 Consider that if you set this to YES, and the user is running the app when a push comes in, the app will start doing things that they didn't prompt it to do. This is bad user experience since it's confusing to the user. Along these lines, iOS won't present a notification if one is received while the app is running.
 
 @return BOOL representing whether or not you want action to be taken.
 */
-(BOOL)sfmc_shouldDeliverCloudPageWithAlertMessageIfAppIsRunning;

@end

@interface MarketingCloudSDK (CloudPage)

/**
 Sets the cloudPageWithAlert delegate.
 
 @param delegate The object you wish to be called when an OpenDirect message is delivered.
 */
-(void)sfmc_setCloudPageWithAlertDelegate:(id<MarketingCloudSDKCloudPageWithAlertDelegate> _Nullable)delegate;

/**
 Returns the cloudPageWithAlert delegate.
 
 @return delegate The named cloudPageWithAlert delegate, or nil if there isn't one.
 */
-(id<MarketingCloudSDKCloudPageWithAlertDelegate> _Nullable)sfmc_cloudPageWithAlertDelegate;


@end

/**
 The MarketingCloudSDKCloudPageDataSource is an interface object for CloudPage support. It was designed to be used as the datasource for a UITableView, and can be allocated and used as such without too much other customization. Of course, you are welcomed to use it any way you want other than that.
 
 Should you wish to customize the display of the Data Source, you should subclass from here. At that time, you may override any typical UITableViewDataSource protocol members. You will likely be the most interested in cellForRowAtIndexPath:. If you do, you can access the current message by asking the messages array for the object corresponding to your NSIndexPath row. It will be an ETCloudPage object.
 
 Or, for the most customization, make a new one of these and only access the messages property. If you do that, you'll need to be both the delegate and data source for your table, but you can do whatever you like. The sfmc_messages array will contain MarketingCloudSDKCloudPageObject objects, and you can see which properties are available on that by checking it's header.
 
 */

@interface MarketingCloudSDKCloudPageDataSource : NSObject <UITableViewDataSource>

/**
 This array contains MarketingCloudSDKCloudPageObject, suitable for display in a UITableView or other presentation apparatus of your liking. Please see MarketingCloudSDKCloudPageObject for a list of properties available.
 */
@property (nonatomic, readonly, copy, nullable) NSArray<__kindof MarketingCloudSDKCloudPageObject *>*sfmc_messages;

/**
 This is a reference to the tableview in your UIViewController. We need a reference to it to reload data periodically.
 */
@property (nonatomic, weak, nullable) UITableView *sfmc_inboxTableView ;

@end
