//
//  MarketingCloudSDKConfigBuilder.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2018 Salesforce, Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/** The MarketingCloudSDKConfigBuilder class */
@interface MarketingCloudSDKConfigBuilder : NSObject
/**
 Creates a NSDictionary containing the current builder configuration settings. This can be passed to the MarketingCloudSDK sfmc_configureWithDictionary method(s)

 @return NSDictionary containing the current builder configuration settings.
 */
- (NSDictionary *_Nullable) sfmc_build;

/**
 Sets the configuration value to use for the Salesforce MarketingCloud Application ID.
 
 @param setApplicationId Allows setting the value to use for the Salesforce MarketingCloud application ID.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setApplicationId:(NSString *) setApplicationId;

/**
 Sets the configuration value to use for the Salesforce MarketingCloud Tenant accessToken.
 
 @param setAccessToken Allows setting the value to use for the Salesforce MarketingCloud accessToken.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setAccessToken:(NSString *) setAccessToken;

/**
 Sets the configuration flag that enables or disables location services

 @param setLocationEnabled Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setLocationEnabled:(NSNumber *) setLocationEnabled;

/**
 Sets the configuration flag that enables or disables inbox services

 @param setInboxEnabled Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setInboxEnabled:(NSNumber *) setInboxEnabled;

/**
 Sets the configuration flag that enables or disables Salesforce Predictive Intelligence analytics services

 @param setPiAnalyticsEnabled Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setPiAnalyticsEnabled:(NSNumber *) setPiAnalyticsEnabled;

/**
 Sets the configuration flag that enables or disables Salesforce Predictive Intelligence email override
to take contactKey if no value is set
 
 @param etUseLegacyPIIdentifier Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setUseLegacyPIIdentifier:(NSNumber *) etUseLegacyPIIdentifier;

/**
 Sets the configuration flag that enables or disables Salesforce MarketingCloud Analytics services

 @param setAnalyticsEnabled Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setAnalyticsEnabled:(NSNumber *) setAnalyticsEnabled;

/**
 Sets the configuration value to use for the Salesforce MarketingCloud Tenant Specific mid.

 @param setMid Allows setting the value to use for the Salesforce MarketingCloud Tenant Specific mid.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setMid:(NSString *) setMid;

/**
 Sets the configuration value to use for the Salesforce MarketingCloud Tenant Specific Url.

 @param setMarketingCloudServerUrl Allows setting the value to use for the Salesforce Tenant Specific Url.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setMarketingCloudServerUrl:(NSString *) setMarketingCloudServerUrl;

/**
 Sets the configuration value which enables or disables application control over badging
 
 @param setApplicationControlsBadging Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setApplicationControlsBadging:(NSNumber *) setApplicationControlsBadging;

/**
 Sets the configuration value which enables or disables application control over delaying SDK registration until a contact key is set
 
 @param delayRegistrationUntilContactKeyIsSet Allows setting the state to YES or NO.
 @return returns the MarketingCloudSDKConfigBuilder instancetype value
 */
- (instancetype) sfmc_setDelayRegistrationUntilContactKeyIsSet:(NSNumber *) delayRegistrationUntilContactKeyIsSet;
@end
NS_ASSUME_NONNULL_END
