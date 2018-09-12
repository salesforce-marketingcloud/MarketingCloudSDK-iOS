---
layout: page
title: "Switch Business Units"
subtitle: "Switch Business Units"
category: sdk-implementation
date: 2018-01-10 12:00:00
order: 9
---

Switch between multiple Marketing Cloud business units using the MarketingCloudSDK. This process can be necessary for your application implementation, such as switching between production and debug tasks.

Switching business units using the AppID value used to configure the application requires you to issue sfmc_tearDown to the SDK. Follow this call with a standard configure, as typically done in applicationDidFinishLaunching... .

Any switch in business units removes any MarketingCloudSDK data from the system. If you enable the previous business unit later via the SDK, data like contactKey, tags and attributes will no longer be set.
<script src="https://gist.github.com/bc7a740e19d045af3285ce7de25017b0.js"></script>
<script src="https://gist.github.com/5cb50d2368c1fff81cedd922629bb079.js"></script>

Use a similar approach if you switch between business units for development purposes, such as using a development business unit for testing Marketing Cloud notifications and another business unit for for production releases.

Use a configuration file to contain multiple JSON dictionaries of configuration data, each with a unique appid and access token value from Marketing Cloud.
<script src="https://gist.github.com/9c9db39c75cd5f42fda172fbbb3e56e9.js"></script>
Use the index of your configuration when configuring the SDK using the configureWithURL:configuationIndex:error: method.
<script src="https://gist.github.com/afb7a3ac75241b9d6a040f7437de2bb0.js"></script>
<script src="https://gist.github.com/e381ef8d0b6555558433039ae036b0e3.js"></script>
