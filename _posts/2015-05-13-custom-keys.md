---
layout: page
title: "Custom Keys"
subtitle: "Handling Custom Keys Sent with Message Payload"
category: push-notifications
date: 2015-05-14 12:00:00
order: 5
---

Use custom keys to send extra data along with a push notification. You can use custom keys to add tracking or additional functionality to your app. For example, you can define a custom key that allows a third-party application to provide custom tracking information regarding customer usage on your mobile app. This data can include an ID value used by the app to retrieve additional data or other function. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#customkeys) this feature in the Marketing Cloud application.

To implement custom key support in your application, extend your push notification handler to extract the push's userInfo dictionary and the values contained in it.

{% include tabbed_gists.html sectionId="custom_keys" names="8.x,7.x" gists="https://gist.github.com/sfmc-mobilepushsdk/c97a1b917b2ae147743266313d92d9ba.js,https://gist.github.com/69de3e0d2412e973d915d836ba6ffd7f.js" %}
