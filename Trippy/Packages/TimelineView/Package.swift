// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TimelineView",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TimelineView",
            targets: ["TimelineView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TimelineView",
            dependencies: []),
        .testTarget(
            name: "TimelineViewTests",
            dependencies: ["TimelineView"]),
    ]
)
