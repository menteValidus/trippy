// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouteController",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "RouteController",
            targets: ["RouteController"]),
        .library(
            name: "RouteControllerMocks",
            targets: ["RouteControllerMocks"])
    ],
    dependencies: [
        .package(path: "../Repository"),
        .package(path: "../Domain"),
        .package(path: "../TestUtils"),
    ],
    targets: [
        .target(
            name: "RouteController",
            dependencies: ["Domain"]),
        .target(
            name: "RouteControllerMocks",
            dependencies: ["RouteController",
                           "Domain",
                           .product(name: "DomainMocks",
                                    package: "Domain")]),
        .testTarget(
            name: "ControllerTests",
            dependencies: ["RouteController",
                           "TestUtils",
                           .product(name: "RepositoryMocks",
                                    package: "Repository")]),
    ]
)
