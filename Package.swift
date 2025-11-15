// swift-tools-version: 5.5
// Version: 0.1.0
// Minimum iOS: 12.0
// AdMoreSdk - iOS Data Collection SDK

import PackageDescription

let package = Package(
    name: "AdMoreSdk",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "AdMoreSdk",
            targets: ["AdMoreSdk"]
        ),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "AdMoreSdk",
            path: "AdMoreSdk.xcframework"
        )
    ]
)
