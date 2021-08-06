// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TestUtils",
    products: [
        .library(
            name: "TestUtils",
            targets: ["TestUtils"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TestUtils",
            dependencies: []),
    ]
)
