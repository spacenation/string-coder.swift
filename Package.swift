// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringDecoder",
    products: [
        .library(name: "StringDecoder", targets: ["StringDecoder"])
    ],
    dependencies: [
        .package(name: "Decoder", url: "git@github.com:spacenation/decoder.swift.git", from: "0.4.0")
    ],
    targets: [
        .target(name: "StringDecoder", dependencies: ["Decoder"]),
        .testTarget(name: "StringDecoderTests", dependencies: ["StringDecoder"])
    ]
)
