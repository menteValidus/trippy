// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TrippyUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TrippyUI",
            targets: ["TrippyUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TrippyUI",
            dependencies: [],
            resources: [.process("Assets/Colors.xcassets"),
                        .process("Assets/Images.xcassets")])
    ]
)
