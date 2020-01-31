// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "searchPhoto",
    products: [
        .library(name: "searchPhoto", targets: ["searchPhoto"]),
    ],
    targets: [
        .target(
            name: "searchPhoto",
            dependencies: []),
        .testTarget(
            name: "searchPhotoTests",
            dependencies: ["searchPhoto"]),
    ]
)
