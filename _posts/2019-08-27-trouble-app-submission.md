---
layout: page
title: "App Submission"
subtitle: "Troubleshooting App Submission"
category: trouble
date: 2019-08-27 12:00:00
order: 0
---

### App Submission Errors

#### Location Purpose String

At the time of app submission, you may receive a message from Xcode or Apple's app review similar to this:

> We identified one or more issues with a recent delivery for your app, "[app name]". Your delivery was successful, but you may wish to correct the following issues in your next delivery:<br><br>Missing Purpose String in Info.plist File - Your app's code references one or more APIs that access sensitive user data. The app's Info.plist file should contain a NSLocationAlwaysUsageDescription key with a user-facing purpose string explaining clearly and completely why your app needs the data. Starting Spring 2019, all apps submitted to the App Store that access user data will be required to include a purpose string. If you're using external libraries or SDKs, they may reference APIs that require a purpose string. While your app might not use these APIs, a purpose string is still required. You can contact the developer of the library or SDK and request they release a version of their code that doesn't contain the APIs. Learn more (https://developer.apple.com/documentation/uikit/core_app/protecting_the_user_s_privacy).

You may see this message even if you are **not** using MobilePush Location Messaging. This is because the SDK itself is built with references to `CoreLocation.framework` and the automated binary scanning of app review sees references which require purpose strings.

If you are **not** using Location Messaging, simply add a purpose string to your app's Info.plist file as a placeholder:

`<key>NSLocationAlwaysUsageDescription</key>`<br>
`<string>Placeholder Purpose String</string>`

Your users **will not be** prompted for location permission if you are not using MobilePush SDK's location messaging functionality.