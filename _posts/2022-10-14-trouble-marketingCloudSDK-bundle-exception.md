---
layout: page
title: "MarketingCloudSDK.bundle inclusion Crash"
subtitle: "Troubleshooting MarketingCloudSDK.bundle inclusion Crash"
category: trouble
date: 2022-10-14 12:00:00
order: 7
---
> The below troubleshooting guide is applicable until MarketingCloudSDK version 8.0.13. Post this version, manual addition of bundle to the application is removed and is automated.

When the SDK is upgraded to latest version, there might be changes to the resources bundle (MarketingCloudSDK.bundle) that comes packaged with the SDK. If the right versions are not copied, the app crashes with the exception as the SDK might not find the required resources in the .bundle file.

### Common Exceptions When latest MarketingCloudSDK.bundle not added in the application

#### NSInvalidArgumentException, NSInternalInconsistencyException

1. `+entityForName: nil is not a legal NSManagedObjectContext parameter searching for entity name 'SFMCEndpointConfigurationEntity'`
2. `'NSFetchRequest could not locate an NSEntityDescription for entity name 'SFMCEventConfigurationEntity''`
3. `'Cannot create an NSPersistentStoreCoordinator with a nil model'`

**Solution:**

* After upgrading to the latest MarketingCloudSDK, make sure to:
    1. Remove the existing MarketingCloudSDK.bundle from `Xcode -> Build phases -> Copy Resources Bundle`
    <br/>
    2. Add the latest MarketingCloudSDK.bundle as mentioned here: [Migrating to SFMCSdk](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/get-started/get-started-migration.html) if **SPM** is used as dependency manager or follow #5 in [Add the SDK](https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/get-started/get-started-addsdk.html) for other methods.

<br/>

**Note:** For every upgrade of the SDK, it is recommended to pull the MarketingCloudSDK.bundle each time as there may be upgrades to the bundle.
