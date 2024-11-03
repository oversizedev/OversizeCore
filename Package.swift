// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OversizeCore",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "OversizeCore", targets: ["OversizeCore"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "OversizeCore",
            dependencies: []
        ),
        .testTarget(
            name: "OversizeCoreTests",
            dependencies: ["OversizeCore"]
        ),
    ]
)
