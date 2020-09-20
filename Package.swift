// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringCoder",
    products: [
        .library(name: "StringCoder", targets: ["StringCoder"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "StringCoder", dependencies: []),
        .testTarget(name: "StringCoderTests", dependencies: ["StringCoder"])
    ]
)
