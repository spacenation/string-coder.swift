// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringCoder",
    products: [
        .library(name: "StringCoder", targets: ["StringCoder"])
    ],
    dependencies: [
        .package(name: "Coder", url: "git@github.com:spacenation/coder.swift.git", from: "0.2.2")
    ],
    targets: [
        .target(name: "StringCoder", dependencies: ["Coder"]),
        .testTarget(name: "StringCoderTests", dependencies: ["StringCoder"])
    ]
)
