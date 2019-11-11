---
layout: page
title: "iOS Data Protection"
subtitle: "Troubleshooting iOSData Protection"
category: trouble
date: 2019-11-10 12:00:00
order: 3
---

Note: iOS Data Protection affects the SDK as follows:
1. No protection - SDK works in foreground & background
2. Complete until first user authentication - SDK works in foreground & background after 1st unlock.
3. Complete unless open - SDK works in foreground & background after 1st unlock.
4. Complete - SDK works only in the forground after the device is unlocked.

The MarketingCloud SDK requires access to files on the iOS Device file system. Some iOS Data Protection modes may prevent the SDK from accessing the needed files at certain times. During normal operation, the SDK must have access to files while running in the foreground and while running in the background. If the SDK cannot access these files due to an iOS Data Protection mode an error is logged and the file access will fail. 

#### 1. Configuration Issues
In the case of configuration, if iOS Data Protection is set such that the file system is not accessible when the call to configure the SDK is made, the configuration call will be retried for up to 5 seconds allowing time for a user to unlock the device and make the file system accessible. If the user does not unlock the device within the 5 seconds an error object is returned describing the error and the configuration call will fail returning false. When this happens the SDK is NOT configured and no access to any SDK methods should be attempted until the configure method returns true. The error code returned in the error object will be 'configureDatabaseAccessError'.

#### 2. Foreground/Background Operation Issues
Certain features of the SDK require access to the file system while transitioning to the foregorund or background. Foreground operations include retrieving messages from the Marketing Cloud for Inbox and Location and sending analytic information back to the Marketing Cloud. Background operations include sending analytic information back to the Marketing Cloud. If any of these features are enabled via configuration then an appropriate iOS Data Protection mode must be selected in order for them to work correctly.


