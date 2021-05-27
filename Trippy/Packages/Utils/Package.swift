// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Utils",
            targets: ["Utils"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Utils",
            dependencies: []),
    ]
)
