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
        .package(url: "https://git.soma.salesforce.com/MarketingCloudSdk/mobile-sfmc-sdk-ios", from: "0.8.9"),
    ],
    targets: [
        .binaryTarget(
            name: "MarketingCloudSDK",
            path: "MarketingCloudSDK/MarketingCloudSDK.xcframework"
        ),
        .target(
             name: "MarketingCloudSDKResources",
             path: "MarketingCloudSDK/",
             exclude: ["MarketingCloudSDK.BCSymbolMaps", "MarketingCloudSDK.xcframework", "MarketingCloudSDK.dSYMs"],
             resources: [
                .copy("SFMCModel.momd"),
                .copy("en.lproj"),
                .copy("InAppMessageUI.storyboardc"),
                .copy("Assets.car"),
                .copy("MarketingCloudSDK.bundle")
            ]
        )
    ]
)
