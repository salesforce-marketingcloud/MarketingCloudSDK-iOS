Pod::Spec.new do |s|
    s.name              = "MarketingCloudSDK"
s.version           = "5.1.1"
s.summary           = "Salesforce Marketing Cloud MobilePush iOS SDK"
    s.homepage          = "https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/"
    s.documentation_url = 'https://salesforce-marketingcloud.github.io/MarketingCloudSDK-iOS/appledoc/index.html'
    s.license           = { :type => "Salesforce Marketing Cloud iOS SDK License", :file => "LICENSE.md" }
    s.author            = "Salesforce Marketing Cloud"
s.platform          = :ios, "10.0"
s.source            = { :git => "https://github.com/salesforce-marketingcloud/MarketingCloudSDK-iOS",
:tag => "v#{s.version}"}
    s.preserve_paths    = 'MarketingCloudSDK/MarketingCloudSDK.framework'
    s.requires_arc      = true
    s.vendored_frameworks = 'MarketingCloudSDK/MarketingCloudSDK.framework'
    s.resource = 'MarketingCloudSDK/MarketingCloudSDK.bundle'
    s.frameworks        = 'CoreLocation', 'UserNotifications', 'UIKit'
    s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64' }
    s.user_target_xcconfig = { 'VALID_ARCHS' => 'arm64' }
end
