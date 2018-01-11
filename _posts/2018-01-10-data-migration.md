---
layout: page
title: "User Data Migration"
subtitle: "Migrate User Data from Previous SDK Version"
category: trouble
date: 2018-01-10 12:00:00
order: 3
---

Version 5.0.0 of the MarketingCloudSDK (formerly JB4ASDK) introduces new methods for data storage encryption that are incompatible with the methods used in JB4ASDK.

For applications upgrading from a version of JB4ASDK to version 5.x.x, the framework provides for migrating prior customer data, including contact key, tags and attributes, from the JB4ASDK database into the new framework's storage, re-encrypting the data, and cleaning up of old data files.

Meet these conditions for successful migration of the data.

* Use the same values for Application Id and Access Token between app versions.
* Migration requires an app store update. The user cannot delete and reinstall the app.
* The app must maintain the same bundle id.
* The app cannot delete JB4ASDK data on its own.
