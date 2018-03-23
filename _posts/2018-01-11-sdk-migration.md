---
layout: page
title: "SDK Migration to Version 5.x"
subtitle: "Migrate to New SDK from Previous Version"
category: sdk-implementation
date: 2018-01-11 12:00:00
order: 1
---

Version 5.0.0 of the MarketingCloudSDK (formerly JB4ASDK) is a new iOS framework-based SDK. The MarketingCloudSDK uses a model and method naming convention that is incompatible with the model and methods used in the JB4ASDK and is therefore not a drop-in replacement. Review and familiarize yourself with all of the documentation on using and configuring the MarketingCloudSDK before attempting an application migration.

To migrate an existing application to the MarketingCloudSDK, change your application to follow the MarketingCloudSDK model. This step involves changing your application to initialize the MarketingCloudSDK with MarketingCloudSDK.sharedInstance().sfmc_configure instead of the JB4ASDK [ETPush pushManager] configureSDKWithAppID method. Your application contains a single instance of the MarketingCloudSDK. Reference that instance anytime via the MarketingCloudSDK.sharedInstance() singleton.

In addition to changing the configuration method, you must change the use of any other JB4ASDK method to the equivalent MarketingCloudSDK method. MarketingCloudSDK methods use similar method names as JB4ASDK but all methods are prefixed with sfmc_ to avoid namespace collisions.

When configuring the MarketingCloudSDK, the configuration process is initiated by a call to MarketingCloudSDK.sharedInstance().sfmc_configure. The process does not complete until the completion handler is called. If the call to MarketingCloudSDK.sharedInstance().sfmc_configure returns false, an error occurred during the configuration. The process does not call the completion handler and the MarketingCloudSDK is not ready for use. In this case, any returned error parameter contains an NSError object. Examine the returned NSError object for details on the failure.

The MarketingCloudSDK.sharedInstance().sfmc_configure completion handler receives a call asynchronously on a worker thread, but you must also check the error parameter in the completion handler for success before using the MarketingCloudSDK. If an error occurred during the asynchronous configuration portion, the call returns an NSError object in the error parameter if one is supplied and the MarketingCloudSDK is not ready for use. Examine the returned NSError object for details on the failure.

Once your migration to the MarketingCloudSDK is complete, remove all JB4ASDK files and references in your project.

> Do not use both the JB4ASDK and MarketingCloudSDK simultaneously.
