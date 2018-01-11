---
layout: page
title: "Troubleshoot Certificate Issues for iOS APNS"
subtitle: "Troubleshoot Certificate Issues for iOS APNS"
category: get-started
date: 2015-11-20 12:00:00
order: 4
published: false
---

MobilePush uses the Apple Push Notification Service (APNS) to deliver messages to iOS devices. The APNS relies on authentication certificates that expire after one year. You generally use two certificates:

1. One for the development version of your app
1. One for the published production version of your app.

These separate certificates may expire on different days, independent of the other certificate. Some certificates may use password protection. The Marketing Cloud cannot use password-protected certificates without the client-provided password.

## Detailed Instructions With Screenshots

[Follow these instructions to provision your development and production apps]({{ site.baseurl }}/provisioning/apple.html).

## Common Problems

* Ensure that you review and follow the instructions linked within this document.
* Do not attempt to upload a certificate ending with a .cer file extension. This certificate will not function correctly. [Follow these instructions]({{ site.baseurl }}/provisioning/apple.html).to generate a .p12 file. The process of exporting a .p12 file correctly can encounter issues at times, even with instructions. Ensure you create the .p12 file by exporting a single certificate and not multiple certificates.
* Ensure than you know whether you created an unprotected .p12 file or a password-protected .p12 file. Test this situation by double-clicking the .p12 file on your Mac. This process should import the file using the password you specifed when creating the certificate. If the process does not complete, ensure you used the correct password and try re-exporting the certificate.
* You might encounter an issue uploading a password-protected certificate with over an existing password-protected certificate. In this case, the screen will hang and the update will appear to fail. Try importing your key into your keychain and re-exporting the certificate, also with a password. This step may resolve the issue.
* If you try to upload a certificate without a password after initially using a password-protected certificate, the system could stall after upload. Ensure that the new certificate uses a password before uploading.
* Ensure you use the correct AppCenter username and password in order to continue. If necessary, you can reset the password at https://appcenter-auth.s1.marketingcloudapps.com/forgot.
