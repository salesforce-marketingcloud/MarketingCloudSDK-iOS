//
//  MarketingCloudSDK+FeatureToggle.h
//  MarketingCloudSDK
//
//  Copyright © 2023 Salesforce, Inc. All rights reserved.

#import <MarketingCloudSDK/MarketingCloudSDK.h>
#import <SFMCSDK/SFMCSdk.h>

/**
  The Runtime Toggle feature, also known as "feature toggles", allows you to dynamically enable or disable specific functionalities within the SDK without the need to re-initialize it. With Runtime Toggles, you have control over the following features:

    1. Analytics: Enables or disables Salesforce MarketingCloud Analytics services.
    2. PI (Predictive Intelligence) Analytics: Enables or disables Salesforce Predictive Intelligence Analytics services.
    3. Inbox: Enables or disables Inbox messaging services.
    4. Location: Enables or disables location-based push notification and messaging services.

  By utilizing the Runtime Toggles feature, you can fine-tune your application's behavior, adapt to changing requirements, and ensure compliance with GDPR regulations effortlessly
 */
@interface MobilePushSDK (FeatureToggle)

/**
 Developer override to set the state of analytics enablement to YES/NO. If set to NO, the SDK will stop tracking analytics and also purges all the analytics stored locally.
 This value takes precedence over the config setting which is passes during the SDK initialization.
 */
- (void) sfmc_setAnalyticsEnabled: (BOOL)analyticsEnabled;

/**
 The current state of the Analytics enablement override
 
 @return returns a BOOL value of the ET Analytics enablement override considering config setting .
 */
- (BOOL)sfmc_isAnalyticsEnabled;

/**
 Developer override to set the state of PI analytics enablement to YES/NO. If set to NO, the SDK will stop tracking PI analytics and also purges all the PI analytics stored locally.
 This value takes precedence over the config setting which is passes during the SDK initialization.
 */
- (void) sfmc_setPiAnalyticsEnabled: (BOOL)analyticsEnabled;


/**
 The current state of the PI Analytics enablement override
 
 @return returns a BOOL value of the PI Analytics enablement override considering config setting .
 */
- (BOOL)sfmc_isPiAnalyticsEnabled;

/**
 Developer override to set the state of Location enablement to YES/NO.
 If set to NO, the SDK will stop monitoring location and Location services are not available for the consuming application.
 This value takes precedence over the config setting which is passed during the SDK initialization.
 */
- (void) sfmc_setLocationEnabled: (BOOL)locationEnabled;

/**
 The current state of the Location enablement override
 @return returns a BOOL value of the Location enablement override considering config setting .
*/
- (BOOL)sfmc_isLocationEnabled;

/**
Developer override to set the state of Inbox enablement to YES/NO. If set to NO, Inbox feature will be disabled.
This value takes precedence over the config setting which is passed during the SDK initialization.
 */
- (void)sfmc_setInboxEnabled: (BOOL)inboxEnabled;

/**
 The current state of the Inbox enablement override
 @return returns a BOOL value of the Inbox enablement.
 */
- (BOOL)sfmc_isInboxEnabled;

@end


