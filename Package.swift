// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReusableUI",
    platforms: [
        .iOS(.v9), .macOS(.v10_13)
    ],
    products: [
        .library(name: "DataDrivenCollectionUIKit", targets: ["DataDrivenCollectionUIKit"]),
        .library(name: "ReusableUI", targets: ["ReusableUI"]),
    ],
    dependencies: [
        .package(name: "DifferenceKit", url: "https://github.com/ra1028/DifferenceKit", .upToNextMajor(from: "1.1.5"))
    ],
    targets: [
        .target(name: "ReusableUI"),
        .testTarget(name: "ReusableUITests", dependencies: ["ReusableUI"]),
        .target(name: "DataDrivenCollectionUIKit", dependencies: ["DifferenceKit", "ReusableUI"]),
        .testTarget(name: "DataDrivenCollectionUIKitTests", dependencies: ["DataDrivenCollectionUIKit"]),
    ]
)
