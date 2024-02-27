// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "MarketingCloudSDK",
    defaultLocalization: "en",
    products: [
        .library(name: "MarketingCloudSDK", targets: ["MarketingCloudSDKWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/salesforce-marketingcloud/sfmc-sdk-ios", .exact("1.1.2")),
    ],
    targets: [
        .binaryTarget(
            name: "MarketingCloudSDK",
            path: "MarketingCloudSDK/MarketingCloudSDK.xcframework"
        ),
        .target(
            name: "MarketingCloudSDKWrapper",
            dependencies: [
                .target(name: "MarketingCloudSDK"),
                .product(name: "SFMCSDK", package: "sfmc-sdk-ios")
            ],
            path: "MarketingCloudSDK"
        )
    ]
)
