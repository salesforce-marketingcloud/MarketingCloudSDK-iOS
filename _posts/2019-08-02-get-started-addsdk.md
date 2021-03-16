---
layout: page
title: "3. Add the SDK"
subtitle: "Add the SDK to Your App"
category: get-started
date: 2019-08-02 12:00:00
order: 3
published: true
---

To implement the MarketingCloudSDK framework in your application, either use CocoaPods or manually set up the SDK.

#### Option 1: Implement the SDK with CocoaPods

1. Follow the [CocoaPods instructions](https://guides.cocoapods.org/using/using-cocoapods.html) using `MarketingCloudSDK` as a dependency in the podfile. See [CocoaPods - MarketingCloudSDK](https://cocoapods.org/pods/MarketingCloudSDK):

    ``` 
target 'MyApp' do
  pod 'MarketingCloudSDK', '~> {{ site.currentVersion | slice: 0, 3 }}'
end
    ```
Open the .xcworkspace created by the install process with Xcode and start using the SDK.

    > Do **NOT** open .xcodeproj. An error occurs if you open up a project file instead of a workspace.

#### Option 2: Implement the SDK manually

1. [Download the SDK](https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS).
1. Copy the MarketingCloudSDK directory from your downloads to your project directory.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure1.png" /><br/>
1. Open your application project and select the appropriate target.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure2.png" /><br/>
1. Add MarketingCloudSDK.xcframework to Linked Frameworks and Libraries in your target’s General settings.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure3.png" /><br/>
1. Add MarketingCloudSDK.bundle to Copy Bundle Resources in your target’s Build Phases settings.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure4.png" /><br/>
1. Add -ObjC to your target’s Other Linker Flags build settings.
<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/SDKConfigure5.png" /><br/>
  > Review [additional information](https://developer.apple.com/library/content/qa/qa1490/_index.html) from Apple about this linker flag.
  
### Next Steps

[Configure the SDK]({{ site.baseurl }}/get-started/get-started-configuresdk.html)
