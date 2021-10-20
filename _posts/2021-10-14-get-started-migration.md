---
layout: page
title: "6. Migrating to SFMCSdk"
subtitle: "SFMCSdk Migration"
category: get-started
date: 2021-10-14 12:00:00
order: 6
published: true
---

# Next-gen SDK migration steps

## Migrating to 8.x

This SDK update set a more modern architectural foundation to enable a variety of improvements and all new features moving forward. The next generation MobilePush SDK was designed with existing MobilePush customers in mind so that the upgrade path is light and straightforward. 


### Step 1 - Add the new iOS SDK build

* Please remove existing cocoa pod dependency, as the MarketingCloudSDK is now included as a Swift Package (MobilePush).
* Both dependencies are available via Swift Package Manager 
    * Core (SFMCSDK) https://github.com/salesforce-marketingcloud/sfmc-sdk-ios (tag 1.0.0)
    * MobilePush https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS (tag 8.0.0)
* Please add both dependencies to your application target
* Manually pull in the Resources/MarketingCloudSDK.bundle from the sources folder in the Mobile Push SPM and link it with the binary in build phase.
* Failing to do so will cause the following error: Thread 1: "Cannot create an NSPersistentStoreCoordinator with a nil model".



### Step 2 - Initialize the SDK 

You will need to replace your existing initialization function to reference the new SDK. Once you have fetched the updated SDK version in your project, the functions that need to be modified will be highlighted in your codebase. 


1. *Update the configuration builder function* as shown in the example below. 
2. *Ensure that the SDK has initialized correctly* by using a check on the status of initialization, or by using the completion handler, as shown in the example below. 

```swift
// Old 

let builder = MarketingCloudSDKConfigBuilder()
            .sfmc_setApplicationId(appID)
            .sfmc_setAccessToken(accessToken)
            .sfmc_setMarketingCloudServerUrl(appEndpoint)
            .sfmc_build()!
        
var success = false
             
 do {
    try MarketingCloudSDK.sharedInstance().sfmc_configure(with:builder)
    success = true
} catch let error as NSError {
    // error logic
}
    
if success == true {
    //function logic
}
 
// New 

// With manual check on the module initialization success
let configuration = PushConfigBuilder(appId: PUSH_APP_ID)
     .setAccessToken(PUSH_ACCESS_TOKEN)
     .setMarketingCloudServerUrl(URL(string: PUSH_TSE)!)
     .build()

SFMCSdk.initializeSdk(ConfigBuilder().setPush(config: configuration).build())

if SFMCSdk.mp.getStatus() == .operational {
     //function logic
} 

// Or with using the completion handler
let configuration = PushConfigBuilder(appId: PUSH_APP_ID)
     .setAccessToken(PUSH_ACCESS_TOKEN)
     .setMarketingCloudServerUrl(URL(string: PUSH_TSE)!)
     .build()
     
SFMCSdk.initializeSdk(ConfigBuilder()
     .setPush(
          config: configuration, 
          onCompletion: {result in print("TODO, Module initialization result is: \(result.rawValue)")}
     ).build())
```     

### Step 3 - Update identity functions

1. *Set the identity/ID of a known user* - Update your existing identity tracking function setContactKey to instead use the new function setProfileID
2. *Set the Attributes of a user* - Update your existing identity tracking function setAttribute to instead use the new function setProfileAttributes

```swift
// Old 
MarketingCloudSDK.sharedInstance().sfmc_setContactKey("john.smith")

// New 
SFMCSdk.identity.setProfileId("john.smith")


// Old 
MarketingCloudSDK.sharedInstance().sfmc_setAttributeNamed("email", value: "john@example.com")

// New 
SFMCSdk.identity.setProfileAttributes("email", "john@example.com")
```

### Step 4 - Update remaining functions

1. Update your existing functions to reference the new SDK. All existing functions that need to be modified will be highlighted as deprecated in your codebase.

