//
//  Package.swift
//  searchPhoto
//
//  Created by Nikolas Omelianov on 31.01.2020.
//  Copyright © 2020 Nikolas Omelianov. All rights reserved.
//

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
