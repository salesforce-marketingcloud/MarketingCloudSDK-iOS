// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarketingCloudSDK",
    defaultLocalization: "en",
    products: [
        .library(name: "MarketingCloudSDK", targets: ["MarketingCloudSDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/salesforce-marketingcloud/sfmc-sdk-ios", from: "1.0.3"),
    ],
    targets: [
        .binaryTarget(
            name: "MarketingCloudSDK",
            path: "MarketingCloudSDK/MarketingCloudSDK.xcframework"
        ),
        .target(
             name: "MarketingCloudSDKResources",
             resources: [.process("Resources")]
        )
    ]
)
