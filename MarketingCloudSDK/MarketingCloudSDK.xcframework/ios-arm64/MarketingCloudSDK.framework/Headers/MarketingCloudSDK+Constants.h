//
//  MarketingCloudSDK+Constants.h
//  MarketingCloudSDK
//
//  https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/
//  Copyright © 2017 Salesforce, Inc. All rights reserved.
//

/** MarketingCloudSDK error domain */
FOUNDATION_EXTERN NSString * _Nonnull const MarketingCloudSDKErrorDomain;

/** MarketingCloudSDK finished setting up notification */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCFrameworkDidSetupNotification;

/** MarketingCloudSDK finished tearing down  notification */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCFrameworkDidTeardownNotification;

/** successfuly sent a registration to Salesforce - userinfo contains the HTTP response */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCFoundationRegistrationResponseSucceededNotification;

/** a new location has been determined - userInfo contains the latitude and longitude */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCLocationDidFixLocationNotification;
/** an iOS location update has been received - userInfo contains the CLLocation */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCLocationDidReceiveLocationUpdateNotification;
/** successfuly received updated geo-fence messages from Salesforce */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCLocationGeofenceRefreshCompleteNotification;
/** entered a geo-fence region - userInfo contains region Id */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCDidEnterLocationRegionMessageNotification;
/** exited a geo-fence region - userInfo contains region Id */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCDidExitLocationRegionMessageNotification;

/** a geo-fence or beacon message has been displayed - userInfo contains the MC messageId */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCDidDisplayLocationMessageNotification;

/** successfuly received updated beacon messages from Salesforce */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCBeaconRefreshCompleteNotification;
/** ranged a beacon - userInfo contains UUID, major, minor, and proximity */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCDidRangeBeaconLocationMessageNotification;
/** started monitoring a geo-fence or beacon region - userInfo contains region Id */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCLocationDidStartMonitoringForRegionNotification;
/** SDK blocked a notification */
FOUNDATION_EXPORT NSNotificationName _Nonnull const SFMCFrameworkDidBlockNotification;

/** Configuration Error enumerations */
typedef NS_ENUM(NSUInteger, configureError) {
    /** Initial enum value  */
    firstConfigureErrorIndex = 0,
    /** configureNoError  */
    configureNoError = firstConfigureErrorIndex,
    /** configureInvalidAppIDError  */
    configureInvalidAppIDError,
    /** configureInvalidAccessTokenError  */
    configureInvalidAccessTokenError,
    /** configureUnableToReadRandomError  */
    configureUnableToReadRandomError,
    /** configureDatabaseAccessError  */
    configureDatabaseAccessError,
    /** configureUnableToKeyDatabaseError  */
    configureUnableToKeyDatabaseError,
    /** configureCCKeyDerivationPBKDFError  */
    configureCCKeyDerivationPBKDFError,
    /** configureCCSymmetricKeyWrapError  */
    configureCCSymmetricKeyWrapError,
    /** configureCCSymmetricKeyUnwrapError  */
    configureCCSymmetricKeyUnwrapError,
    /** configureKeyChainError  */
    configureKeyChainError,
    /** configureUnableToReadCertificateError  */
    configureUnableToReadCertificateError,
    /** configureRunOnceSimultaneouslyError  */
    configureRunOnceSimultaneouslyError,
    /** configureRunOnceError  */
    configureRunOnceError,
    /** configureInvalidLocationAndProximityError  */
    configureInvalidLocationAndProximityError,
    /** configureSimulatorBlobError  */
    configureSimulatorBlobError,
    /** configureKeyChainInvalidError  */
    configureKeyChainInvalidError,
    /** configureIncorrectConfigurationCallingSequenceError  */
    configureIncorrectConfigurationCallingSequenceError,
    /** configureMissingConfigurationFileError  */
    configureMissingConfigurationFileError,
    /** configureInvalidConfigurationFileError  */
    configureInvalidConfigurationFileError,
    /** configureInvalidConfigurationIndexError  */
    configureInvalidConfigurationIndexError,
    /** configureFailedFrameworkCreationError  */
    configureFailedFrameworkCreationError,
    /** configureInvalidAppEndpointError  */
    configureInvalidAppEndpointError,
    /** lastconfigureIndex */
    lastConfigureErrorIndex = configureInvalidAppEndpointError
};
