---
layout: page
title: "1. Provision for Push"
subtitle: "Provision for Push"
category: get-started
date: 2019-08-02 12:00:00
order: 1
published: true
---

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
