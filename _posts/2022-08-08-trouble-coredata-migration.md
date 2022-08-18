---
layout: page
title: "Data Merge"
subtitle: "Troubleshooting The Data Merge"
category: trouble
date: 2022-08-08 12:00:00
order: 5
---

For iOS devices upgraded from v7.x to versions up to v8.0.6, the previous v7.x tags/attributes are being held on the device and not sent to the server. If an application does not reset or re-generate tags/attributes, the device will send empty tags and attributes to the system. **The applications that have been affected are those that have migrated from v7.x to <=v8.0.6 of the SDK**.

The following guide will walk through the requirements for merging data sets successfully.

## Steps

1. Upgrade the SDK to the latest version (v8.0.7)
2. Data Merge (optional)

### Upgrade SDK 

Using SPM, upgrade to the latest version of MarketingCloudSDK (v8.0.7) and SFMCSDK (v1.0.5).

### Data Merge (optional)

The merging tool offers two options for merging data (i.e. Attributes and Tags).

In some scenarios, an application developer may choose to defer or avoid merging the data sets.

The merging tool allows one to opt-out of the merge process. By not implementing the below steps, the merge tool defaults to an "opted-out" state.

If an application developer is "opted-out" (default), tags and attributes will not be merged from the v7.x data set to your current application's data set.

#### Option 1: Automatic Merging

The automatic merging option attempts to merge the old data into the current data set by merging the two, with data within the current data set taking precedence over the data within the v7.x data set.

The below tables are an illustration of the behavior of the automatic merging tool and how data will be merged:

-------

#### Attributes

| Prior Data Set 	| Current Data Set 	| Merge Result 	|
|:----------------	|:----------------	|:------------	|
| A:B            	| empty            	| A:B          	|
| empty          	| A:B              	| A:B          	|
| A:B, C:D       	| A:E              	| A:E, C:D     	|
| A:B            	| A:cleared        	| A:cleared    	|

<br>

_Note: For this example we denote Key:Value pairs by denoting ":" as the separator_

-------

#### Tags

| Prior Data Set 	| Current Data Set 	| Merge Result  	|
|----------------	|------------------	|---------------	|
| SHIRTS         	| empty            	| SHIRTS        	|
| empty          	| PANTS            	| PANTS         	|
| SHIRTS         	| PANTS            	| SHIRTS, PANTS 	|
| SHIRTS         	| SHIRTS, PANTS    	| SHIRTS, PANTS 	|

<br>

_Note: It's recommended to place the following code prior to the initialization of the SDK to ensure the completion callback (passed into setAutoMergePolicy) is set prior to initialization_

{% include tabbed_gists.html sectionId="automatic_merging_optin" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/45eff5f9d313ea752b12a7a74acd7667.js,https://gist.github.com/sfmc-mobilepushsdk/b462cec6e9a2b66dbcf64d75a0406839.js" %}

#### Option 2: Manual Merging

The manual merge option allows the application developer to receive both the prior data and the current data in a callback, giving the developer the opportunity to choose what data will ultimately end up in the data set.

It is up to the application developer to determine what attributes and tags are set in the current data set.

> _IMPORTANT_: You will be given access to the v8.x and v7.x tags and attributes _prior to_ the SDK being initialized! The developer will need to hold onto the data until the SDK had been initialized, so that you may set (for example) your tags using SFMCSdk.mp.addTags().

{% include tabbed_gists.html sectionId="manual_merging_optin" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/ecddccc7199ce27df08996014a7b623e.js,https://gist.github.com/sfmc-mobilepushsdk/8dfce5a8b9d6686eeae8c2c290cd4db8.js" %}

## Retrying

In the event the developer needs to run the merge tool again, there is the option to attempt the merge additional times.

However, **this does not rollback the current data set.** It allows the developer to regain access to the data within the old v7.x data set.

{% include tabbed_gists.html sectionId="reset_merging" names="Swift,Obj-C" gists="https://gist.github.com/sfmc-mobilepushsdk/8e8370884b1cf5ce2cd93ed27119d4ee.js,https://gist.github.com/sfmc-mobilepushsdk/aa4c4f0108ad003cf4a97e0c57365ed8.js" %}
