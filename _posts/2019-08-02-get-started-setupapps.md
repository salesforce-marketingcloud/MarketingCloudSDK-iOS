---
layout: page
title: "2. Setup MobilePush Apps"
subtitle: "Setup MobilePush Apps"
category: get-started
date: 2019-08-02 12:00:00
order: 2
published: true
---

### Create your apps in Marketing Cloud

Your development, test, and deployment process is best accomplished by creating **two** unique MobilePush apps

- one for development (utilizing Apple's push sandbox)
- one for production (targeting Apple's production push system).

Before starting, make sure you have provisioned your app for push notifications as outlined in our [Provision for Push]({{ site.baseurl }}/get-started/get-started-provision.html) document.

Follow these steps to create new MobilePush apps (Repeat steps to create both a development and production app):
1. Log in to [Marketing Cloud MobilePush](https://mc.exacttarget.com).
1. Highlight the Mobile Studio menu and choose MobilePush from the dropdown.
1. On the top select the Administration tab, click **Create New App** in the upper right corner.
1. Enter the name and description for the app.

    > Development app name suggestion: `[App]_DEV-APNS`.<br>Production app name suggestion: `[App]_PROD-APNS`.

### Provisioned with p8 Auth Key (Recommended):
1. Click **Choose File** and upload the icon for the MobilePush app.
1. Upload the either the .p8 Auth Key File created at the beginning of this page by clicking **Choose File** and choose the Auth Key on your computer to upload. Upload this key for both Production and Development apps.

    > Development app: Select the **Development** APNs Environment radio button.

    > Production app: Select the **Production** APNs Environment radio button.

    > Validate the correct Auth Key File is uploaded. The file should be a text file with a .p8 file extension. **This is not the signing certificate used to provision your application for AdHoc or App Store deployment.**

1. Enter in the 10-character **Key ID** field the Key (this is usually the name of the .p8 text file after it is created) or can be viewed in your [Apple Developer Account](https://developer.apple.com/account/resources/certificates/list).
1. Enter in the 10-character **Team ID** associated with this Key. The team ID can be found in the [Membership tab](https://developer.apple.com/account/#/membership/) in your Apple Developer Account.
1. Enter in the Bundle Identifier of the app you are building. 
1. Make any applicable changes to the optional settings.
1. Note and copy the `Access Token`, `App ID` and `App Endpoint`. These values will be used to configure the SDK for development testing.<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/setupConfigValues-222.png" /><br/>
1. Select your account name in the upper-right corner of the [MobilePush Administration site](https://mc.exacttarget.com/cloud/#app/MobilePush/MobilePush/) and note and copy the "MID" value (numbers only).<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/setupMidValues.png" /><br/>
1. Click **Save**.

## - OR -

### Provisioned with p12 Certificate (Requires yearly renewal):

Follow these steps to create new MobilePush apps:
1. Click **Choose file** and upload the icon for the MobilePush app.
1. To upload an APNS certificate, click **Change** and choose the certificate on your computer to upload. Enter the password for the certificate.

    > Development app: upload the **iOS Apple Push Notification service SSL (Sandbox)** .p12 file created following the directions in [Provision for Push]({{ site.baseurl }}/get-started/get-started-provision.html).

    > Production app: upload the **Apple Push Notification service SSL (Sandbox & Production)** .p12 file created following the directions in [Provision for Push]({{ site.baseurl }}/get-started/get-started-provision.html).

    > Validate correct certificate is uploaded. The certificate should be for Push Notifications (APNS), not the signing certificate used to provision your application for AdHoc or App Store deployment. Double-check to ensure that the certificate uploaded is a valid, current APNS (push) certificate, as they expire after 1 year.

1. Make any applicable changes to the optional settings.
2. Note and copy the `Access Token`, `App ID` and `App Endpoint`. These values will be used to configure the SDK for development testing.<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/setupConfigValues-222.png" /><br/>
3. Select your account name in the upper-right corner of the [MobilePush Administration site](https://mc.exacttarget.com/cloud/#app/MobilePush/MobilePush/) and node and copy the "MID" value (numbers only).<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/setupMidValues.png" /><br/>
1. Click **Save**.


Review [MobilePush documentation](https://help.salesforce.com/articleView?id=mc_mp_provisioning_info.htm&type=5) for more information.

### Next Steps

[Add the SDK]({{ site.baseurl }}/get-started/get-started-addsdk.html)
