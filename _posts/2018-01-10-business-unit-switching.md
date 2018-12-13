---
layout: page
title: "Switch Business Units"
subtitle: "Switch Business Units"
category: sdk-implementation
date: 2018-01-10 12:00:00
order: 9
---

You can use the MarketingCloudSDK to switch between Marketing Cloud business units. For example, you can switch business units to move from production tasks to debug tasks, or you can use one business unit for testing during development and another business unit for production releases.

The following code samples walk you through switching business units. For these instructions, you need the `appid` value that you used during application configuration.

> **Caution:** Switching business units removes any MarketingCloudSDK data, such as contact key, tags, and attributes from the system. See the Preserve Configuration Information section.

1. Issue `sfmc_tearDown` to the SDK.
1. Execute a standard configure, as in `applicationDidFinishLaunching`.
1. Set the delegate, if needed.
1. Authorize the MarketingCloudSDK to use notifications.

#### Example: BU Switching
{% include gist.html sectionId="switching" names="Obj-C,Swift" gists="https://gist.github.com/bc7a740e19d045af3285ce7de25017b0.js,https://gist.github.com/5cb50d2368c1fff81cedd922629bb079.js" %}

### Preserve Configuration Information
To keep track of configuration information that would be lost during business unit switching, use a configuration file. The file, like in the following example, can contain multiple JSON dictionaries of configuration data, each with a unique `appid` and access token value from Marketing Cloud.

#### Example: Configuration File
<script src="https://gist.github.com/9c9db39c75cd5f42fda172fbbb3e56e9.js"></script>

### Handle Multiple Configurations
To select from multiple configurations, use the index of your configuration when configuring the SDK using the configureWithURL:configuationIndex:error: method.

#### Example: Select Configuration
{% include gist.html sectionId="select" names="Obj-C,Swift" gists="https://gist.github.com/afb7a3ac75241b9d6a040f7437de2bb0.js,https://gist.github.com/e381ef8d0b6555558433039ae036b0e3.js" %}
