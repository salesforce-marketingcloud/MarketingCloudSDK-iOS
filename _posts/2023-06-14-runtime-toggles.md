---
layout: page
title: "Runtime Toggles"
subtitle: "SFMCSdk Runtime Toggles"
category: sdk-implementation
date: 2023-06-14 12:00:00
order: 4
---

The Runtime Toggle feature, also known as "feature toggles", allows you to dynamically enable or disable specific functionalities within the SDK without the need to re-initialize it. With Runtime Toggles, you have control over the following features:

1. Analytics: Enables or disables Salesforce MarketingCloud Analytics services.
2. PI (Predictive Intelligence) Analytics: Enables or disables Salesforce Predictive Intelligence Analytics services.
3. Inbox: Enables or disables Inbox messaging services.
4. Location: Enables or disables location-based push notification and messaging services.

By utilizing the Runtime Toggles feature, you can fine-tune your application's behavior, adapt to changing requirements, and ensure compliance with GDPR regulations effortlessly.

## API Usage

To interact with the Runtime Toggles, the SDK provides APIs for each feature to set and get status of toggled feature.

### Toggle APIs

```swift
SFMCSdk.mp.setAnalyticsEnabled(_: Bool)
SFMCSdk.mp.isAnalyticsEnabled()
```

For more details see the [Feature Toggle Apple Documentation]({{site.baseurl}}/appledocs/MarketingCloudSdk/8.0/Classes/PushModule.html#/c:@M@MarketingCloudSDK@objc(cs)SFMCSdkPushModule(im)setAnalyticsEnabled:).

The setAnalyticsEnabled function allows you to enable or disable the Analytics feature. By passing true, Analytics services will be enabled, while passing false will disable them. The isAnalyticsEnabled function returns the current status of the Analytics toggle.

Note: The remaining feature toggle APIs follow a similar pattern.


## Explaining Analytic Runtime Toggle

The functionality of analytic runtime toggles entails several actions when disabling it. Firstly, it involves the removal of all non-billable analytics, and secondly, it ensures that the SDK does not record any non-billable analytics. 

Non-billable analytics encompass data that appears in reports and relates to how marketers monitor the performance of their messaging. For example, tracking of push notifications and inbox opens. See Analytics documentation for more details on this. On the other hand, billable analytics serve the purpose of informing Marketing Cloud whether a billable action occurred, without tracking any user-specific information. Therefore, although certain "analytics" will still be transmitted to Marketing Cloud when the toggle is disabled, they exclusively pertain to billable events and do not involve any user-related data from the device.

