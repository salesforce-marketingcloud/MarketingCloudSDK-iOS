Pod::Spec.new do |s|
    s.name              = "JB4ASDK"
    s.version           = "4.7.0"
    s.summary           = "Salesforce Marketing Cloud Journey Builder for Apps iOS SDK"
    s.homepage          = "https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/"
    s.documentation_url = 'https://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/index.html'
    s.license           = { :type => "Salesforce Marketing Cloud Journey Builder for Apps iOS SDK License", :file => "LICENSE.md" }
    s.author            = "Salesforce Marketing Cloud"
    s.platform          = :ios, "8.1"
    s.source            = { :git => "https://github.com/salesforcefuel/JB4A-SDK-iOS.git",
                            :tag => "v#{s.version}"}
    s.source_files      = "JB4A-SDK/*.h"
    s.preserve_paths    = "*.md"
    s.requires_arc      = true
    s.vendored_library  = "JB4A-SDK/libJB4ASDK-#{s.version}*.a"
    s.frameworks        = 'WebKit', 'CoreLocation', 'UserNotifications'
end
