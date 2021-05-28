// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
        .library(
            name: "DomainMocks",
            targets: ["DomainMocks"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Domain",
            dependencies: []),
        .target(
            name: "DomainMocks",
            dependencies: ["Domain"]),
    ]
)
