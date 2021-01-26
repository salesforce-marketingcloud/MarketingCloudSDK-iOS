---
layout: page
title: "1. Provision for Push"
subtitle: "Provision for Push"
category: get-started
date: 2019-08-02 12:00:00
order: 1
published: true
---

### Create a .p8 Auth Key File (Recommended)

#### Following [Apple’s instructions](https://help.apple.com/developer-account/#/devcdfbb56a3), create a private .p8 Auth Key:
1. In Certificates, Identifiers & Profiles, select Keys from the sidebar, then click the Add button (+) in the upper-left corner.
1. Under Key Description, enter a unique name for the key.
1. Select the checkbox next to Apple Push Notification service, then click Continue.
1. Review the key configuration, then click Confirm.
1. click Download to generate and download the key now. The key is saved as a text file with a .p8 file extension in the Downloads folder.
MobilePush requires this information to communicate with Apple. After creation download and save the .p8 Auth Key File.
> REMEMBER: Save the resulting text file with a .p8 file extension in a secure place. **This key is not saved in your developer account and you will not be able to download it again.**


## - OR -


### Create a .p12 Certificate

#### Following [Apple’s instructions](https://help.apple.com/developer-account/#/dev82a71386a), create two iOS Push Notification certificates:
<br>

#### Development / Xcode

Create an **iOS Apple Push Notification service SSL (Sandbox)** certificate. This type of certificate is used to send pushes through Apple’s “sandbox” push environment, which allows you to receive pushes in your debugging configuration. The .p12 file resulting from this step will be used in creating and configuring your Marketing Cloud MobilePush app.

> Note: You *must* select "iOS Apple Push Notification service SSL (Sandbox)" certificate type.

#### Production / Distribution

Create an **Apple Push Notification service SSL (Sandbox & Production)** certificate. This type of certificate is used to send pushes through Apple’s production push environment, which allows you to receive pushes in your production configuration. The .p12 file resulting from this step will be used in creating and configuring your Marketing Cloud MobilePush app.

> Note: You *must* select the "Apple Push Notification service SSL (Sandbox & Production)" certificate type.

#### Save and Maintain

These push certificates are credentials containing information which uniquely secures and establishes trust from your application, through Marketing Cloud and Apple's push system, and to your customer's devices.

It is recommended that you save the .p12 files using unique and descriptive names and that access to these files is carefully controlled.

The .p12 files should be protected with a secure password.

### Next Steps

[Setup Push Apps]({{ site.baseurl }}/get-started/get-started-setupapps.html)
