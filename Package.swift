// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MarketingCloudSDK",
    products: [
        .library(name: "MarketingCloudSDK", targets: ["MarketingCloudSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "MarketingCloudSDK",
            path: "MarketingCloudSDK/MarketingCloudSDK.xcframework"
        )
    ]
)
