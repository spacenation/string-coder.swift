// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringDecoder",
    products: [
        .library(name: "StringDecoder", targets: ["StringDecoder"])
    ],
    dependencies: [
        .package(name: "Functional", url: "git@github.com:spacenation/functional-swift.git", from: "0.3.2")
    ],
    targets: [
        .target(name: "StringDecoder", dependencies: ["Functional"]),
        .testTarget(name: "StringDecoderTests", dependencies: ["StringDecoder"])
    ]
)
