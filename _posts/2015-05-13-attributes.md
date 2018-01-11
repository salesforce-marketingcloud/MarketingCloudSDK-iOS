---
layout: page
title: "Attributes"
subtitle: "Using Attributes"
category: user-data
date: 2015-05-14 12:00:00
order: 4
---
Attributes contain information used to describe different aspects about a contact. For example, the attribute “FavoriteTeamName” can contain a string value with the name of the favorite sports team for that contact. Add any attributes you set with the SDK to your Marketing Cloud contact record in advance so Marketing Cloud can connect the values sent by the SDK to the correct contact fields. Attribute names assigned in your mobile app must maintain a 1:1 relationship with attributes stored in the Marketing Cloud to ensure segmentation and messaging activities use correct data values.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/Attributes_Step3.png" /><br/>
<br/>

{{ site.retryAndRESTdelayMessage }}

We don't allow attribute names from this list because they overlap with the names used by the contact record. Check the BOOL return value to determine if Marketing Cloud accepted your attribute to be sent.

```
addressId
alias
apId
backgroundRefreshEnabled
badge
channel
contactId
contactKey
createdBy
createdDate
customObjectKey
device
deviceId
deviceType
gcmSenderId
hardwareId
isHonorDst
lastAppOpen
lastMessageOpen
lastSend
locationEnabled
messageOpenCount
modifiedBy
modifiedDate
optInDate
optInMethodId
optInStatusId
optOutDate
optOutMethodId
optOutStatusId
platform
platformVersion
providerToken
proximityEnabled
pushAddressExtensionId
pushApplicationId
sdkVersion
sendCount
source
sourceObjectId
status
systemToken
timezone
utcOffset
```
Setting an attribute updates the value of an existing attribute on the contact record. We trim leading and trailing blanks from attribute values and names.

```
// Set an attribute
BOOL success = [[MarketingCloudSDK sharedInstance] sfmc_setAttributeNamed:@"FavoriteTeamName" value:@"favoriteTeamName"];
```
```
// Set an attribute

let success: Bool = MarketingCloudSDK.sharedInstance().sfmc_setAttributeNamed("FavoriteTeamName", value: "favoriteTeamName")
```

You cannot use the SDK to remove attributes from the contact record. However, you can stop sending the attribute to Marketing Cloud by using the clear method. This method does not remove or change the value on the contact record in Marketing Cloud.
```
// Clear an attribute
[[MarketingCloudSDK sharedInstance] sfmc_clearAttributeNamed:@"FavoriteTeamName"];
```
```
// Clear an attribute

MarketingCloudSDK.sharedInstance().sfmc_clearAttributeNamed("FavoriteTeamName")
```

The SDK does not retrieve attributes from the contact record. However, you can retrieve a list of all the attributes you saved locally using the setter.

```
// Get all attributes
// Returns a dictionary of key-value pairs (key:attribute name, value: attribute value)
NSDictionary *attributes = [[MarketingCloudSDK sharedInstance] sfmc_attributes];
```
```
// Get all attributes
// Returns a dictionary of key-value pairs (key:attribute name, value: attribute value)

let attributes = MarketingCloudSDK.sharedInstance().sfmc_attributes()
```

Find additional convenience methods to add and clear arrays of attributes in *MarketingCloudSDK+Base.h*.

> The SDK sends changes to user and device information to Marketing Cloud with a REST call one minute after the first change to any Marketing Cloud data. If the REST call fails due to lack of network or a similar reason, the SDK retries the REST call in one-minute intervals until the app is suspended. If the send is unsuccessful before the app is suspended, the data sends the next time the app is opened. Marketing Cloud can take up to 5 minutes to record this value in the contact record once the SDK makes the REST call.
