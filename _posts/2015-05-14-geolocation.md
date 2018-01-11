---
layout: page
title: "Background Location Updates"
subtitle: "Background Location Updates"
category: location
date: 2015-05-14 08:43:35
order: 2
---

Normally, the app downloads new regions and messages as the device moves more than 5 kilometers from the last location and download of this data. However, if your app serves customers who spend a lot of time within a single 5K radius, consider adding the ability to do a background refresh of regions and messages. Since Apple controls when this background refresh takes place, we cannot guarantee when the refresh occurs. However, Apple allows the SDK to download new regions and messages for those times your customer spends a considerable amount of time in a single 5K region.

In your Info.plist, implement this key to enable this function. We require “App downloads content from the network” to perform a Background App Refresh periodically to refresh geofences and beacons.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

In your application delegate method -application:didFinishLaunchingWithOptions:, implement this code:
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ...

    if ( [[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable )
    {
        // setting this will enable iOS to call the app delegate method performFetchWithCompletionHandler periodically. The implementation of that method (see below)
        // will call the MarketingCloudSDK at most once per day to update location and proximity messages in the background - if those services have been enabled.
        // Only call this method if you have enabled location in your MarketingCloudConfiguration.json file
        // Note that you will require "App downloads content from the network" in your plist for this background app refresh to work
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    ...
    if UIApplication.shared.backgroundRefreshStatus == .available {
        // setting this will enable iOS to call the app delegate method performFetchWithCompletionHandler periodically. The implementation of that method (see below)
        // will call the MarketingCloudSDK at most once per day to update location and proximity messages in the background - if those services have been enabled.
        // Only call this method if you have enabled location in your MarketingCloudConfiguration.json file
        // Note that you will require "App downloads content from the network" in your plist for this background app refresh to work
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
}
```

Implement the handler for this functionality in your application delegate class:

```
// this method will be called by iOS to tell the MarketingCloudSDK to update location and proximity messages. This will only be called if [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:
// has been set to a value other than UIApplicationBackgroundFetchIntervalNever and Background App Refresh is enabled.
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult) completionHandler
{
    [[MarketingCloudSDK sharedInstance] sfmc_refreshWithFetchCompletionHandler:completionHandler];
}
```
```
// this method will be called by iOS to tell the MarketingCloudSDK to update location and proximity messages. This will only be called if [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:
// has been set to a value other than UIApplicationBackgroundFetchIntervalNever and Background App Refresh is enabled.
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    MarketingCloudSDK.sharedInstance().sfmc_refresh(fetchCompletionHandler: completionHandler)
}
```

See MarketingCloudSDK+Base.h for more information regarding this method.
