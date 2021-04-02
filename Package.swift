// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringReader",
    products: [
        .library(name: "StringReader", targets: ["StringReader"])
    ],
    dependencies: [
        .package(name: "Functional", url: "git@github.com:spacenation/functional-swift.git", from: "0.3.2")
    ],
    targets: [
        .target(name: "StringReader", dependencies: ["Functional"]),
        .testTarget(name: "StringReaderTests", dependencies: ["StringReader"])
    ]
)
