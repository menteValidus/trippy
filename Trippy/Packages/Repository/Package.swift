// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Repository",
            targets: ["Repository"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Repository",
            dependencies: ["Domain"]),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository",
                           .product(name: "DomainMocks",
                                    package: "Domain")
            ]),
    ]
)
