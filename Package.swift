// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarketingCloudSDK",
    products: [
        .library(name: "MarketingCloudSDK", targets: ["MarketingCloudSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MarketingCloudSDK",
            path: "MarketingCloudSDK/MarketingCloudSDK.xcframework"
            resources: [.copy("SFMCModel.momd"),
                        .copy("en.lproj),
                        .copy("InAppMessageUI.storyboardc"),
                        .copy("Assets.car")
            ]
        )
    ]
)
