---
layout: page
title: "SDK Migration to Version 5.x"
subtitle: "Migrate Existing App to SDK Version 5.x"
category: sdk-implementation
date: 2018-01-11 12:00:00
order: 10
---

Starting with version 5.0.0, the iOS MarketingCloudSDK replaces the iOS Journey Builder for Apps, or JB4A, SDK. The model and method-naming conventions are incompatible between the JB4A SDK and the MarketingCloudSDK. Do not use both the JB4A SDK and MarketingCloudSDK simultaneously.

Because this is not a simple drop-in replacement, review how to use and configure the MarketingCloudSDK before attempting an application migration.

To migrate an existing application to the MarketingCloudSDK, update your application to follow the MarketingCloudSDK model:

1. Update your application to initialize the MarketingCloudSDK with `MarketingCloudSDK.sharedInstance().sfmc_configure` instead of the `JB4ASDK [ETPush pushManager] configureSDKWithAppID` method.
1. Check the error parameter in the completion handler for any errors.
> The `MarketingCloudSDK.sharedInstance().sfmc_configure` completion handler receives a call asynchronously on a worker thread. If an error occurs during the asynchronous configuration portion, the call returns an NSError object in the error parameter if one is supplied, and the MarketingCloudSDK is not ready to use. Examine the returned NSError object for details on the failure before using the MarketingCloudSDK.

1. Change all JB4A SDK methods to the equivalent MarketingCloudSDK methods found in the Appledocs headers.
> MarketingCloudSDK method names are similar to the JB4A SDK method names but contain the prefix sfmc_ to avoid namespace collisions.

1. After migration is complete, remove all JB4A SDK files and references in your project.

Your application contains a single instance of the MarketingCloudSDK. Reference that instance any time via the `MarketingCloudSDK.sharedInstance()` singleton.

The MarketingCloudSDK configuration process is initiated by a call to `MarketingCloudSDK.sharedInstance().sfmc_configure`. The process is not complete until the completion handler is called. If the call to `MarketingCloudSDK.sharedInstance().sfmc_configure` returns false, an error occurred during the configuration, the process does not call the completion handler, and the MarketingCloudSDK is not ready to use. Examine the returned `NSError` object in any returned error parameter for details on the failure.
