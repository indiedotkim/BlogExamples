// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SwiftCollectionMergeSort",
    products: [
        .library(
            name: "SwiftCollectionMergeSort",
            targets: ["SwiftCollectionMergeSort"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftCollectionMergeSort",
            dependencies: []),
        .testTarget(
            name: "SwiftCollectionMergeSortTests",
            dependencies: ["SwiftCollectionMergeSort"]),
    ]
)
