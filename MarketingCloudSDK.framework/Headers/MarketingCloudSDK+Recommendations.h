//
//  MarketingCloudSDK+Recommendations.h
//  JB4A-SDK-iOS
//
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "MarketingCloudSDK.h"

@interface MarketingCloudSDK (Recommendations)

/**
 Used to retrieve a JSON formatted string of recommendations from the Predictive Web section of the Marketing Cloud.
 
 @param mid An identifier used to locate the application specific recommendations
 @param page A recommendations page that has been created within the Predictive Web section of the Marketing Cloud
 @param error A pointer to a location to store an NSError object describing any error that occurred while sanity checking the input parameters. Can be nil.
 @param completionHandler A pointer to a user-supplied completion handler block. The completion handler will be called if sfmc_requestPIRecommendations returns YES. The result parameter of the completion handler will contain a JSON formatted string with the recommendations on a successfull call otherwise it will be nil and the error parameter will be filled with an NSError object describing the error.
 @return Returns YES or NO based on sanity checks of the input parameters. If NO is returned the user completion handler will not be called.
 */
+(BOOL)sfmc_requestPIRecommendations:(NSString *)mid page:(NSString *)page error:(NSError **)error completionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
/**
 Used to retrieve a JSON formatted string of recommendations from the Predictive Web section of the Marketing Cloud.
 
 @param mid An identifier used to locate the application specific recommendations
 @param page A recommendations page that has been created within the Predictive Web section of the Marketing Cloud
 @param retailer An identifier used to locate the application specific recommendations
 @param error A pointer to a location to store an NSError object describing any error that occurred while sanity checking the input parameters. Can be nil.
 @param completionHandler A pointer to a user-supplied completion handler block. The completion handler will be called if sfmc_requestPIRecommendations returns YES. The result parameter of the completion handler will contain a JSON formatted string with the recommendations on a successfull call otherwise it will be nil and the error parameter will be filled with an NSError object describing the error.
 @return Returns YES or NO based on sanity checks of the input parameters. If NO is returned the user completion handler will not be called.
 */
+(BOOL)sfmc_requestPIRecommendations:(NSString *)mid page:(NSString *)page retailer:(NSString *)retailer error:(NSError **)error completionHandler:(void (^)(NSString *result, NSError *error))completionHandler;

@end
