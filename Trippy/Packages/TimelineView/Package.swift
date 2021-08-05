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
        .package(url: "https://github.com/freshOS/Stevia", .upToNextMajor(from: .init("5.1.1"))),
        .package(path: "../TrippyUI")
    ],
    targets: [
        .target(
            name: "TimelineView",
            dependencies: [
                .product(name: "Stevia", package: "Stevia"),
                "TrippyUI"
            ]),
        .testTarget(
            name: "TimelineViewTests",
            dependencies: ["TimelineView"]),
    ]
)
