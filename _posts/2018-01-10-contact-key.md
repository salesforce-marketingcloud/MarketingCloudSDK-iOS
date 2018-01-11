---
layout: page
title: "Contact Key"
subtitle: "Contact Key"
category: user-data
date: 2018-01-12 12:00:00
order: 2
---

Use the contact key setter method to implement a specific value as the unique identifier for the contact record. You can use a mobile number, email address, device ID, or other appropriate value. Contact keys cannot include a null or blank value.

By default, Marketing Cloud generates a default contact key value if your app does not set that value using the setter. The getter method returns the value set in the last setter call and will return a nil value until you call the setter with a valid value. The getter retrieves only the local copy of the value and not the value from the Marketing Cloud server.

```
[[MarketingCloudSDK sharedInstance] sfmc_setContactKey:@"user@mycompany.com"];
```
```
NSString *contactKey = [[MarketingCloudSDK sharedInstance] sfmc_contactKey];

        MarketingCloudSDK.sharedInstance().sfmc_setContactKey("user@mycompany.com")
        let contactKey: String
```
