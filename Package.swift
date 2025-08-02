// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdMoreSdk",
    platforms: [
        .iOS(.v12), // Minimum iOS version for Swift 4.2 compatibility
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdMoreSdk",
            targets: ["AddMoreSdk"]),
    ],
    targets: [
        .binaryTarget(
            name: "AddMoreSdk", 
            path: "./AddMoreSdk.xcframework"
        )
    ]
)
