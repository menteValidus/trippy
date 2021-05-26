// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIUtils",
    products: [
        .library(
            name: "UIUtils",
            targets: ["UIUtils"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UIUtils",
            dependencies: []),
    ]
)
