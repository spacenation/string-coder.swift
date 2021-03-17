// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringCoder",
    products: [
        .library(name: "StringCoder", targets: ["StringCoder"])
    ],
    dependencies: [
        .package(name: "Decoder", url: "git@github.com:spacenation/decoder.swift.git", from: "0.3.1")
    ],
    targets: [
        .target(name: "StringCoder", dependencies: ["Decoder"]),
        .testTarget(name: "StringCoderTests", dependencies: ["StringCoder"])
    ]
)
