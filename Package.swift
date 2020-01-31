// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "searchPhoto",
    products: [
        .library(name: "searchPhoto", targets: ["searchPhoto"]),
    ],
    targets: [
        .target(
            name: "searchPhoto",
            dependencies: [],
            path: "."),
        .testTarget(
            name: "searchPhotoTests",
            dependencies: ["searchPhoto"]),
    ]
)
