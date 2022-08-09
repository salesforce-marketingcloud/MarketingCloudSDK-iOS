---
layout: page
title: "Data Migration"
subtitle: "Troubleshooting Data Migration"
category: trouble
date: 2022-08-08 12:00:00
order: 5
---

## Overview

When the version 8 of the SDK (Unified SDK) was introduced there was a change in how the configuration is being processed by the SDK. As the application ID is being provided to the SDK by the application developer, the configuration builder validates if the provided application ID is a valid uuid String. With this process, the application ID was implicitly uppercased by the Swift programming language class. 

To persist the data, the SDK uses “datastores” which are database files. The files are named after the application ID. This means that after the upgrade, database files would be named using an uppercased version of the provided application ID. The iOS device file systems are case sensitive and this resulted in a data inconsistency as the v8 SDK reached out to the new datastore. This means that currently (v8.0.0 - v8.0.6), devices leveraging SDK v8 hold two separate datastores.

## Migration Guide

The following guide will walk through the requirements for migrating databases successfully.

The process of "migration" is a unification of the two databases. A migration tool has been provided with the SDK to facilitate a merging of the two databases that are currently in the file system.

There are three scenarios regarding SDK users:

1. Users who've already migrated to v8.x from v7.x
2. Users who've started using the SDK from v8.x
3. Users who've not yet migrated to v8.x, but intend to

Users who fall under the second and third scenario need only upgrade to the latest version of the SDK.

The following steps are only applicable to the aforementioned first scenario.

### Steps

1. Upgrade the SDK to the latest version (v8.0.7)
2. Opt into the Migration

### Upgrade SDK 

Using SPM, upgrade to the latest version of MarketingCloudSDK (v8.0.7) and SFMCSDK (v1.0.5).

### Opting To Migrate

The migration tool allows you to opt-out of the migration process, should an application developer want to avoid initiating this process until they're ready.

The migration tool defaults to an "opted-out" state if you do not implement the below code examples.

However, users who need to ensure tags and attributes (for example) are migrated from the prior database into your current database (i.e. the database used by v8.x of the SDK) should continue following the steps.

The migration tool offers two options for migrating data such as ContactKey, DeviceToken, Attributes, and Tags.

#### Option 1: Automatic Migration

The automatic migration option attempts to migrate the old data into the current database by merging the two, with data within the current database taking precedence over the data within the v7.x database.

Below is an illustration of the behavior of the automatic migration tool and how data will be migrated:

-------

##### ContactKey

| Prior Database | Current Database | Migration Result |
| :----: | :----: | :----: |
| old@example.com | _empty_ | old@example.com |
| _empty_ | current@example.com | current@example.com |
| old@example.com | current@example.com | current@example.com |

-------

##### DeviceToken


| Prior Database | Current Database | Migration Result |
| :----: | :----: | :----: |
| device_token_1 | _empty_ | device_token_1 |
| _empty_ | device_token_2 | device_token_2 |
| device_token_1 | device_token_2 | device_token_2 |

-------

##### Attributes

_Note: For this example we denote Key:Value pairs by denoting ":" as the separator_

| Prior Database | Current Database | Migration Result |
| :----: | :----: | :----: |
| A:B | _empty_ | A:B |
| _empty_ | A:B | A:B |
| A:B, C:D | A:E | A:E, C:D |
| A:B | A:_cleared_ | A:_cleared_|

-------

##### Tags

| Prior Database | Current Database | Migration Result |
| :----: | :----: | :----: |
| SHIRTS | _empty_ | SHIRTS |
| _empty_ | PANTS | PANTS |
| SHIRTS | PANTS | PANTS |
| SHIRTS | SHIRTS, PANTS | SHIRTS, PANTS |

##### Code Example

_Note: It's recommended to place the following code prior to the initialization of the SDK_

{% include tabbed_gists.html sectionId="automatic_migration_optin" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/45eff5f9d313ea752b12a7a74acd7667.js,https://gist.github.com/sfmc-mobilepushsdk/b462cec6e9a2b66dbcf64d75a0406839.js" %}

#### Option 2: Manual Migration

The manual migration option allows the application developer to receive both the prior data and the current data in a callback, giving the developer the opportunity to choose what data will ultimately end up in the database.


##### Code Example

_Note: It's recommended to place the following code prior to the initialization of the SDK_

{% include tabbed_gists.html sectionId="manual_migration_optin" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/ecddccc7199ce27df08996014a7b623e.js,https://gist.github.com/sfmc-mobilepushsdk/8dfce5a8b9d6686eeae8c2c290cd4db8.js" %}

### Retrying

In the event the migration doesn't operate as intended or the application developer needs to run the migration tool again, there is the option to attempt the migration again.

However, **this does not rollback the current database.** It allows the developer to regain access to the data within the old v7.x database.

##### Code Example

{% include tabbed_gists.html sectionId="reset_migration" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/8e8370884b1cf5ce2cd93ed27119d4ee.js,https://gist.github.com/sfmc-mobilepushsdk/aa4c4f0108ad003cf4a97e0c57365ed8.js" %}
