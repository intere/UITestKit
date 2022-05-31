// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UITestKit",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "UITestKit",
            targets: ["UITestKit"]),
    ],
    targets: [
        .target(
            name: "UITestKit",
            dependencies: []),
        .testTarget(
            name: "UITestKitTests",
            dependencies: ["UITestKit"]),
    ]
)
