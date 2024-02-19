// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UICollectionViewRightAlignedLayout",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UICollectionViewRightAlignedLayout",
            targets: ["UICollectionViewRightAlignedLayout"]),
    ],
    targets: [
        .target(
            name: "UICollectionViewRightAlignedLayout",
            dependencies: [],
            path: "UICollectionViewRightAlignedLayout",
            publicHeadersPath: "include"
        )
    ]
)
