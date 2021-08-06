// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Controller",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Controller",
            targets: ["Controller"]),
    ],
    dependencies: [
        .package(path: "../Repository"),
        .package(path: "../Domain"),
        .package(path: "../TestUtils"),
    ],
    targets: [
        .target(
            name: "Controller",
            dependencies: ["Domain"]),
        .testTarget(
            name: "ControllerTests",
            dependencies: ["Controller",
                           "TestUtils",
                           .product(name: "RepositoryMocks",
                                    package: "Repository")]),
    ]
)
