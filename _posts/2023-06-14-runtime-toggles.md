---
layout: page
title: "Runtime Toggles"
subtitle: "SFMCSdk Runtime Toggles"
category: sdk-implementation
date: 2023-06-14 12:00:00
order: 4
---

The Runtime Toggles feature, also known as "feature toggles," allows you to dynamically enable or disable specific functionalities within the SDK without the need to re-initialize it. With Runtime Toggles, you have granular control over the following features:


1. Analytics: Enables or disables Salesforce MarketingCloud Analytics services.
2. PI (Predictive Intelligence) Analytics: Enables or disables Salesforce Predictive Intelligence Analytics services.
3. Inbox: Enables or disables Inbox messaging services.
4. Location: Enables or disables location-based push notification and messaging services.

## API Usage

To interact with the Runtime Toggles, the SDK provides two APIs for each feature. One API is used to set the toggle, and the other is used to check the status of the toggle.

### Analytics Toggle

```swift
SFMCSdk.mp.setAnalyticsEnabled(_: Bool)
SFMCSdk.mp.isAnalyticsEnabled()
```

The setAnalyticsEnabled function allows you to enable or disable the Analytics feature. By passing true, Analytics services will be enabled, while passing false will disable them. The isAnalyticsEnabled function returns the current status of the Analytics toggle.

Note: The remaining feature toggle APIs follow a similar pattern.

## GDPR Configuration

The Runtime Toggles take into consideration GDPR (General Data Protection Regulation) configurations passed down from the Marketing Cloud servers, the initial configuration set in the PushConfigBuilder during SDK initialization, and whether or not the toggle has been set.

In the event that GDPR configurations are set, they take precedence over both the initial configuration and the toggle. The following GDPR settings are considered:

1. Right to be Forgotten
2. Restriction of Processing
3. Do Not Track

If any of these GDPR settings are configured, the corresponding feature will be automatically disabled, overriding any other configuration.

### Advantages

The main advantage of using Runtime Toggles is that application developers can seamlessly enable or disable features without the need to re-initialize the SDK. This flexibility allows for easier experimentation, testing, and control over the functionality of the SDK within your application.

By utilizing the Runtime Toggles feature, you can fine-tune your application's behavior, adapt to changing requirements, and ensure compliance with GDPR regulations effortlessly.

