---
layout: page
title: "Keychain Crash"
subtitle: "Troubleshooting Keychain Crash"
category: trouble
date: 2022-10-14 12:00:00
order: 6
---

 When the device is setup with FaceId/Passcode based authentication and when any of the application which has MarketingCloudSDK integrated access the Keychain when the device is in a locked state, a fatal exception is thrown where the SDK cannot access these files due to an iOS Data Protection mode.

### Common Exceptions with Keychain thrown by the SDK

#### errSecInteractionNotAllowed

1. `Fatal Exception: com.salesforce.security.keychainException dictionaryItemFromKeychain: Error attempting to look up keychain item: errSecInteractionNotAllowed`

2. `Fatal Exception: com.salesforce.security.keychainException setObject:forKey:: Error saving value to the keychain: errSecInteractionNotAllowed.`

3. `Fatal Exception: com.salesforce.security.keychainException writeToKeychain: Error adding keychain item: errSecInteractionNotAllowed.`

**Solution:**

* Upgrade to **MarketingCloudSDK** version - `8.0.8` and **SFMCSDK** version - `1.0.6`
* Before initializing the SDK, add the code to **setKeychainAccessErrorsAreFatal** as **false** as => `SFMCSdk.setKeychainAccessErrorsAreFatal(errorsAreFatal: false)`
* The above just logs the exception to console instead of crashing the application.

<br/>

**Note:** `setKeychainAccessErrorsAreFatal` is by default set to **true** in the SDK.

#### Unknown status code (-34018)

`Terminating app due to uncaught exception 'com.salesforce.security.keychainException', reason: 'dictionaryItemFromKeychain: Error attempting to look up keychain item: Unknown status code (-34018)'`

**Solution:**

Enable **Keychain sharing** in the Xcode `Signing & Capabilities`. Please note that no identifiers need to be added specific to SDK in keychain sharing.

#### Related Items

[Learning App](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS/tree/spm/LearningApp)
- Please note that the code sample shows how to integrate SDK, not all piece of code is mandatory and it is upto consuming application.
